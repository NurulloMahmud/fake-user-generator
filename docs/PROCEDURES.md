# Fake User Generator - SQL Stored Procedures Documentation

A PostgreSQL-based library for generating deterministic, reproducible fake user data entirely through SQL stored procedures.

## Table of Contents

1. [Overview](#overview)
2. [Core Concepts](#core-concepts)
3. [Core Random Functions](#core-random-functions)
4. [Data Generator Functions](#data-generator-functions)
5. [Main Generator Functions](#main-generator-functions)
6. [Usage Examples](#usage-examples)
7. [Algorithms Explained](#algorithms-explained)

---

## Overview

This library implements fake data generation **exclusively in SQL** using PostgreSQL stored procedures. All randomness is deterministic - the same inputs always produce the same outputs.

### Key Features

- **Deterministic**: Same seed + batch + row = same data, always
- **Locale Support**: English (US) and German (Germany)
- **Extensible**: Single tables with locale field instead of separate tables per locale
- **Statistical Distributions**: Normal distribution for physical attributes, uniform distribution on sphere for coordinates

---

## Core Concepts

### Seed-Based Reproducibility

Every function accepts these parameters for reproducibility:

| Parameter | Type | Description |
|-----------|------|-------------|
| `p_seed` | BIGINT | Base seed value provided by user |
| `p_batch` | INTEGER | Batch/page index (0-based) |
| `p_row` | INTEGER | Row index within batch (0-based) |
| `p_salt` | VARCHAR | Additional string to create different random sequences |

**Example**: `faker_random_int(12345, 0, 5, 1, 100, 'age')` will **always** return the same number.

### How Determinism Works

```
seed + batch + row + salt → MD5 hash → numeric value → scaled to range
```

The combination of all inputs creates a unique hash that's converted to the desired output type.

---

## Core Random Functions

### `faker_hash_seed`

Creates a deterministic hash from seed components.

```sql 
faker_hash_seed(
    p_seed BIGINT,      -- Base seed
    p_batch INTEGER,    -- Batch index
    p_row INTEGER,      -- Row index
    p_salt VARCHAR(50)  -- Optional salt (default: '')
) RETURNS BIGINT
```

**Algorithm**: Concatenates inputs, applies MD5 hash, extracts 60 bits as BIGINT.

**Example**:
```sql
SELECT faker_hash_seed(12345, 0, 0, 'test');
-- Returns: 847293847293847 (consistent every time)
```

---

### `faker_random_float`

Generates a deterministic float in range [0, 1).

```sql
faker_random_float(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_salt VARCHAR(50)
) RETURNS DOUBLE PRECISION
```

**Algorithm**: `hash_value / (2^60 - 1)`

**Example**:
```sql
SELECT faker_random_float(12345, 0, 0, '');
-- Returns: 0.7342... (always the same)
```

---

### `faker_random_int`

Generates a deterministic integer in range [min, max] (inclusive).

```sql
faker_random_int(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_min INTEGER,      -- Minimum value (inclusive)
    p_max INTEGER,      -- Maximum value (inclusive)
    p_salt VARCHAR(50)
) RETURNS INTEGER
```

**Algorithm**: `min + floor(random_float * (max - min + 1))`

**Example**:
```sql
SELECT faker_random_int(12345, 0, 0, 1, 100, 'age');
-- Returns: 73 (always the same)
```

---

### `faker_random_boolean`

Generates a deterministic boolean with configurable probability.

```sql
faker_random_boolean(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_probability DOUBLE PRECISION,  -- Probability of TRUE (default: 0.5)
    p_salt VARCHAR(50)
) RETURNS BOOLEAN
```

**Algorithm**: `random_float < probability`

**Example**:
```sql
SELECT faker_random_boolean(12345, 0, 0, 0.3, 'has_title');
-- Returns: TRUE 30% of the time (deterministically)
```

---

### `faker_random_normal`

Generates normally distributed values using **Box-Muller Transform**.

```sql
faker_random_normal(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_mean DOUBLE PRECISION,    -- Mean (default: 0.0)
    p_stddev DOUBLE PRECISION,  -- Standard deviation (default: 1.0)
    p_salt VARCHAR(50)
) RETURNS DOUBLE PRECISION
```

**Algorithm (Box-Muller Transform)**:
```
Given two uniform random values u1, u2 in (0, 1]:
z = sqrt(-2 * ln(u1)) * cos(2 * π * u2)
result = mean + z * stddev
```

**Example**:
```sql
SELECT faker_random_normal(12345, 0, 0, 170, 10, 'height');
-- Returns: ~175.3 (from normal distribution with mean=170, stddev=10)
```

---

### `faker_random_normal_bounded`

Normal distribution clamped to [min, max] bounds.

```sql
faker_random_normal_bounded(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_mean DOUBLE PRECISION,
    p_stddev DOUBLE PRECISION,
    p_min DOUBLE PRECISION,     -- Minimum bound (clamp)
    p_max DOUBLE PRECISION,     -- Maximum bound (clamp)
    p_salt VARCHAR(50)
) RETURNS DOUBLE PRECISION
```

**Example**:
```sql
SELECT faker_random_normal_bounded(12345, 0, 0, 170, 10, 150, 200, 'height');
-- Returns: value between 150 and 200, normally distributed around 170
```

---

### `faker_random_latitude`

Generates latitude **uniformly distributed on a sphere surface**.

```sql
faker_random_latitude(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_salt VARCHAR(50)
) RETURNS DOUBLE PRECISION  -- Degrees: [-90, 90]
```

**Algorithm (Inverse Transform Method)**:
```
For uniform distribution on a sphere, latitude is NOT simply uniform!

1. Generate uniform u in [0, 1]
2. z = 2u - 1 (uniform in [-1, 1])
3. latitude = arcsin(z)

This ensures constant probability density per unit AREA on the sphere.
```

**Why not just `random * 180 - 90`?**

Simple uniform latitude would concentrate points near the poles. The arcsin transformation ensures points are evenly distributed across the sphere's surface.

**Example**:
```sql
SELECT faker_random_latitude(12345, 0, 0, 'geo');
-- Returns: 23.456789 (uniformly distributed on sphere)
```

---

### `faker_random_longitude`

Generates longitude uniformly in [-180, 180].

```sql
faker_random_longitude(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_salt VARCHAR(50)
) RETURNS DOUBLE PRECISION  -- Degrees: [-180, 180]
```

**Algorithm**: `random_float * 360 - 180`

Longitude IS uniform (unlike latitude) because all meridians have equal length.

---

### `faker_random_element`

Picks a random element from an array.

```sql
faker_random_element(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_array TEXT[],         -- Array of choices
    p_salt VARCHAR(50)
) RETURNS TEXT
```

**Example**:
```sql
SELECT faker_random_element(12345, 0, 0, ARRAY['red','blue','green'], 'color');
-- Returns: 'blue' (deterministic)
```

---

### `faker_weighted_random`

Picks an element with weighted probability.

```sql
faker_weighted_random(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_values TEXT[],        -- Array of values
    p_weights INTEGER[],    -- Array of weights (must match values length)
    p_salt VARCHAR(50)
) RETURNS TEXT
```

**Algorithm**:
1. Sum all weights to get total
2. Generate random number in [1, total]
3. Iterate through weights, accumulating until we exceed the random number

**Example**:
```sql
SELECT faker_weighted_random(
    12345, 0, 0,
    ARRAY['Brown', 'Blue', 'Green', 'Hazel', 'Gray'],
    ARRAY[55, 27, 8, 7, 3],
    'eye_color'
);
-- Returns: 'Brown' ~55% of the time, 'Blue' ~27%, etc.
```

---

## Data Generator Functions

### `faker_generate_gender`

```sql
faker_generate_gender(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_male_prob DOUBLE PRECISION  -- Default: 0.5
) RETURNS VARCHAR  -- 'male' or 'female'
```

---

### `faker_get_name`

Retrieves a random name from the database by type.

```sql
faker_get_name(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER,
    p_name_type VARCHAR(20),  -- 'first_male', 'first_female', 'last', 'middle_male', 'middle_female'
    p_salt VARCHAR(50)
) RETURNS VARCHAR
```

---

### `faker_generate_full_name`

Generates a complete name with variations.

```sql
faker_generate_full_name(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER,
    p_gender VARCHAR  -- Optional, generated if NULL
) RETURNS JSONB
```

**Returns**:
```json
{
    "gender": "male",
    "title": "Mr.",
    "first_name": "John",
    "middle_name": "Michael",
    "last_name": "Smith",
    "full_name": "Mr. John M. Smith"
}
```

**Variations applied**:
- 20% chance of including title (Mr., Mrs., Dr., etc.)
- 40% chance of including middle name
- 50% chance middle name is initial only (J. vs John)

---

### `faker_generate_street_address`

```sql
faker_generate_street_address(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER
) RETURNS VARCHAR
```

**Format by locale**:
- **US**: "123 Oak Street" or "456 Main Avenue Apt 7"
- **German**: "Hauptstraße 42" or "Berlinerweg 15, Wohnung 3"

---

### `faker_generate_city_state_postal`

```sql
faker_generate_city_state_postal(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER
) RETURNS JSONB
```

**Returns**:
```json
{
    "city": "New York",
    "state": "New York",
    "state_abbr": "NY",
    "postal_code": "10023"
}
```

**Postal code formats**:
- **US**: 5 digits, 30% chance of +4 extension (e.g., "90210-1234")
- **German**: 5 digits (e.g., "10115")

---

### `faker_generate_full_address`

```sql
faker_generate_full_address(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER
) RETURNS JSONB
```

**Returns**:
```json
{
    "street_address": "123 Oak Street",
    "city": "New York",
    "state": "New York",
    "state_abbr": "NY",
    "postal_code": "10023",
    "full_address": "123 Oak Street, New York, NY 10023"
}
```

---

### `faker_generate_phone`

```sql
faker_generate_phone(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER
) RETURNS VARCHAR
```

**US formats** (randomly selected):
- `(555) 123-4567`
- `555-123-4567`
- `+1 555 123 4567`
- `1-555-123-4567`

**German formats**:
- `+49 30 1234567`
- `030 1234567`
- `+49301234567`
- `030/1234567`

---

### `faker_generate_email`

```sql
faker_generate_email(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_first_name VARCHAR,
    p_last_name VARCHAR,
    p_locale_id INTEGER
) RETURNS VARCHAR
```

**Email formats** (randomly selected):
- `john.smith@gmail.com`
- `johnsmith@yahoo.com`
- `jsmith@hotmail.com`
- `john_smith@outlook.com`
- `smith.john@mail.com`
- `john123@gmail.com`

**Domain selection by locale**:
- **US**: gmail.com, yahoo.com, hotmail.com, outlook.com, aol.com, icloud.com
- **German**: gmail.com, web.de, gmx.de, yahoo.de, t-online.de, freenet.de

**German umlaut handling**: ä→ae, ö→oe, ü→ue, ß→ss

---

### `faker_generate_physical`

Generates physical attributes using normal distribution.

```sql
faker_generate_physical(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_gender VARCHAR,
    p_locale_id INTEGER
) RETURNS JSONB
```

**Returns**:
```json
{
    "height_cm": 175.3,
    "height_ft_in": "5'9\"",
    "weight_kg": 72.5,
    "weight_lbs": 159.8,
    "bmi": 23.6,
    "eye_color": "Brown"
}
```

**Statistical parameters**:

| Attribute | Gender | Locale | Mean | StdDev | Bounds |
|-----------|--------|--------|------|--------|--------|
| Height | Male | US | 177 cm | 7 cm | 140-210 cm |
| Height | Male | DE | 180 cm | 7 cm | 140-210 cm |
| Height | Female | US | 163 cm | 7 cm | 140-210 cm |
| Height | Female | DE | 166 cm | 7 cm | 140-210 cm |
| Weight | Male | US | 90 kg | 12 kg | 40-150 kg |
| Weight | Male | DE | 85 kg | 12 kg | 40-150 kg |
| Weight | Female | US | 77 kg | 12 kg | 40-150 kg |
| Weight | Female | DE | 68 kg | 12 kg | 40-150 kg |

**Eye color distribution** (weighted random):
- Brown: 55%
- Blue: 27%
- Green: 8%
- Hazel: 7%
- Gray: 3%

---

### `faker_generate_coordinates`

```sql
faker_generate_coordinates(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER
) RETURNS JSONB
```

**Returns**:
```json
{
    "latitude": 45.123456,
    "longitude": -93.654321
}
```

---

## Main Generator Functions

### `faker_generate_user`

Generates a single complete fake user.

```sql
faker_generate_user(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER
) RETURNS fake_user  -- Custom type
```

---

### `faker_generate_users`

**Main function** - generates a batch of fake users.

```sql
faker_generate_users(
    p_seed BIGINT,
    p_batch INTEGER DEFAULT 0,
    p_count INTEGER DEFAULT 10,
    p_locale_code VARCHAR DEFAULT 'en_US'
) RETURNS SETOF fake_user
```

**Example**:
```sql
SELECT * FROM faker_generate_users(12345, 0, 10, 'en_US');
```

---

### `faker_generate_users_json`

Returns users as JSON array (for APIs).

```sql
faker_generate_users_json(
    p_seed BIGINT,
    p_batch INTEGER DEFAULT 0,
    p_count INTEGER DEFAULT 10,
    p_locale_code VARCHAR DEFAULT 'en_US'
) RETURNS JSONB
```

---

### `faker_get_locales`

Lists available locales.

```sql
faker_get_locales() RETURNS TABLE(code VARCHAR, name VARCHAR)
```

---

### `faker_benchmark`

Measures generation performance.

```sql
faker_benchmark(
    p_count INTEGER DEFAULT 1000,
    p_locale_code VARCHAR DEFAULT 'en_US'
) RETURNS JSONB
```

**Returns**:
```json
{
    "users_generated": 1000,
    "locale": "en_US",
    "duration_ms": 245.67,
    "users_per_second": 4070.52
}
```

---

## Usage Examples

### Generate 10 US users
```sql
SELECT full_name, email, phone 
FROM faker_generate_users(12345, 0, 10, 'en_US');
```

### Generate 20 German users (page 2)
```sql
SELECT * FROM faker_generate_users(12345, 1, 20, 'de_DE');
```

### Verify reproducibility
```sql
-- Run twice - should return identical results
SELECT full_name FROM faker_generate_users(99999, 0, 5, 'en_US');
SELECT full_name FROM faker_generate_users(99999, 0, 5, 'en_US');
```

### Get JSON for API
```sql
SELECT faker_generate_users_json(12345, 0, 10, 'en_US');
```

### Run benchmark
```sql
SELECT faker_benchmark(10000, 'en_US');
```

### Use individual generators
```sql
-- Random normally distributed height
SELECT faker_random_normal(12345, 0, 0, 170, 10, 'height');

-- Random point on sphere
SELECT 
    faker_random_latitude(12345, 0, 0, 'geo') as lat,
    faker_random_longitude(12345, 0, 0, 'geo') as lon;

-- Weighted random eye color
SELECT faker_weighted_random(
    12345, 0, 0,
    ARRAY['Brown', 'Blue', 'Green'],
    ARRAY[55, 30, 15],
    'eye'
);
```

---

## Algorithms Explained

### 1. Deterministic Random Number Generation

We use **MD5 hashing** instead of a traditional PRNG (like Linear Congruential Generator) because:
- MD5 produces excellent distribution
- Easy to create multiple independent streams using different salts
- Built into PostgreSQL

```
Input: "12345:0:0:height"
       ↓ MD5
Hash:  "a1b2c3d4e5f6..."
       ↓ Extract 60 bits
Value: 847293847293847
       ↓ Normalize
Float: 0.7342...
```

### 2. Box-Muller Transform (Normal Distribution)

Converts two uniform random values into normally distributed values:

```
u1, u2 ~ Uniform(0, 1)

z0 = √(-2·ln(u1)) · cos(2π·u2)
z1 = √(-2·ln(u1)) · sin(2π·u2)

z0, z1 ~ Normal(0, 1)
```

We use `z0` and scale it: `result = mean + z0 * stddev`

### 3. Uniform Points on Sphere

**Problem**: Simply using `lat = random * 180 - 90` would concentrate points near poles.

**Solution**: Use the inverse transform method:

```
u ~ Uniform(0, 1)
z = 2u - 1        # z is uniform in [-1, 1]
lat = arcsin(z)   # lat has correct spherical distribution
lon = 360u - 180  # lon is simply uniform
```

This works because the surface area element `dA = R² · cos(lat) · dlat · dlon` becomes uniform when we substitute `z = sin(lat)`.

---

## Database Schema

### Extensible Design

All lookup tables use a `locale_id` field instead of separate tables per locale:

```sql
-- Instead of: english_names, german_names
-- We use:
CREATE TABLE names (
    id SERIAL PRIMARY KEY,
    locale_id INTEGER REFERENCES locales(id),
    name_type VARCHAR(20),  -- 'first_male', 'first_female', 'last', etc.
    value VARCHAR(100)
);
```

**Benefits**:
- Easy to add new locales
- Single query structure for all locales
- Simpler maintenance

### Adding a New Locale

```sql
-- 1. Add locale
INSERT INTO locales (code, name, country_code, language_code)
VALUES ('fr_FR', 'French (France)', 'FR', 'fr');

-- 2. Add names (get the new locale_id)
INSERT INTO names (locale_id, name_type, value)
VALUES 
(3, 'first_male', 'Jean'),
(3, 'first_male', 'Pierre'),
(3, 'first_female', 'Marie'),
...

-- 3. Add cities, streets, etc.
```

---

## Performance

Typical benchmark results:

| Users | Time | Rate |
|-------|------|------|
| 1,000 | ~250ms | ~4,000/sec |
| 10,000 | ~2.5s | ~4,000/sec |
| 100,000 | ~25s | ~4,000/sec |

Performance is linear and consistent regardless of batch position (page 1 vs page 10,000).
