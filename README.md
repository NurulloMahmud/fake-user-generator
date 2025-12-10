# Fake User Generator

A web application that generates realistic fake user data using **SQL stored procedures**. All data generation logic is implemented exclusively in PostgreSQL, making this a unique "Faker in SQL" library.

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![FastAPI](https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white)

## Features

- **100% SQL-Based Generation** - All fake data is generated through PostgreSQL stored procedures
- **Deterministic & Reproducible** - Same seed always produces the same data
- **Multi-Locale Support** - English (US) and German (Germany)
- **Realistic Data Distribution**:
  - Normal distribution for height/weight (Box-Muller transform)
  - Uniform distribution on sphere for coordinates
  - Weighted random for eye colors
- **Rich User Profiles**:
  - Full name with variations (title, middle name, initials)
  - Complete address (street, city, state, postal code)
  - Phone number (multiple formats per locale)
  - Email address (generated from name)
  - Geographic coordinates
  - Physical attributes (height, weight, BMI, eye color)

## Screenshot

<img width="1377" height="879" alt="Screenshot 2025-12-10 at 9 34 51 AM" src="https://github.com/user-attachments/assets/cc07d0ff-7679-43b1-980d-1628b4d70388" />


## Quick Start

### Prerequisites

- PostgreSQL 12+
- Python 3.9+

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/NurulloMahmud/fake-user-generator.git
   cd fake-user-generator
   ```

2. **Create virtual environment**
   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Create PostgreSQL database**
   ```bash
   psql postgres -c "CREATE DATABASE fake_users;"
   ```

5. **Configure environment**
   ```bash
   cp .env.example .env
   # Edit .env with your database credentials
   ```

6. **Run SQL migrations**
   ```bash
   psql fake_users -f sql/001_schema.sql
   psql fake_users -f sql/002_core_random.sql
   psql fake_users -f sql/003_generators.sql
   psql fake_users -f sql/004_main_generator.sql
   psql fake_users -f sql/005_seed_data.sql
   ```

7. **Start the application**
   ```bash
   cd app
   uvicorn main:app --reload
   ```

8. **Open browser**
   ```
   http://localhost:8000
   ```

## Documentation

### Stored Procedures Documentation

** [Full SQL Procedures Documentation](docs/PROCEDURES.md)**

The documentation includes:
- All function signatures and parameters
- Algorithm explanations (Box-Muller, uniform sphere distribution)
- Usage examples
- Database schema design

### Quick SQL Examples

```sql
-- Generate 10 US users
SELECT * FROM faker_generate_users(12345, 0, 10, 'en_US');

-- Generate 20 German users (page 2)
SELECT * FROM faker_generate_users(12345, 1, 20, 'de_DE');

-- Get JSON output for API
SELECT faker_generate_users_json(12345, 0, 10, 'en_US');

-- Run benchmark
SELECT faker_benchmark(1000, 'en_US');

-- Verify reproducibility (run twice - same results!)
SELECT full_name FROM faker_generate_users(99999, 0, 5, 'en_US');
SELECT full_name FROM faker_generate_users(99999, 0, 5, 'en_US');
```

## Project Structure

```
fake-user-generator/
├── app/
│   ├── main.py              # FastAPI application
│   ├── database.py          # Database connection
│   └── templates/
│       └── index.html       # Web interface
├── sql/
│   ├── 001_schema.sql       # Database tables
│   ├── 002_core_random.sql  # Core random functions
│   ├── 003_generators.sql   # Data generators
│   ├── 004_main_generator.sql # Main user generator
│   └── 005_seed_data.sql    # Seed data (names, cities, etc.)
├── docs/
│   └── PROCEDURES.md        # SQL procedures documentation
├── requirements.txt
├── .env.example
└── README.md
```

## API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/` | GET | Web interface |
| `/api/generate` | GET | Generate users (JSON) |
| `/api/locales` | GET | List available locales |
| `/api/benchmark` | GET | Run performance benchmark |
| `/health` | GET | Health check |

### Generate Users API

```
GET /api/generate?seed=12345&batch=0&count=10&locale=en_US
```

**Parameters:**
- `seed` (required): Integer seed for reproducibility
- `batch` (default: 0): Page index (0-based)
- `count` (default: 10): Users per page (1-100)
- `locale` (default: en_US): Locale code

**Response:**
```json
{
  "success": true,
  "seed": 12345,
  "batch": 0,
  "count": 10,
  "locale": "en_US",
  "users": [
    {
      "index": 0,
      "name": {
        "gender": "male",
        "title": "Mr.",
        "first": "Antonio",
        "middle": "James",
        "last": "Henderson",
        "full": "Mr. Antonio J. Henderson"
      },
      "address": {
        "street": "312 Oak Street",
        "city": "Chicago",
        "state": "Illinois",
        "state_abbr": "IL",
        "postal_code": "60601",
        "full": "312 Oak Street, Chicago, IL 60601"
      },
      "contact": {
        "phone": "(312) 369-9178",
        "email": "antonio.henderson@gmail.com"
      },
      "location": {
        "latitude": 23.456789,
        "longitude": -98.765432
      },
      "physical": {
        "height_cm": 175.3,
        "height_display": "5'9\"",
        "weight_kg": 78.2,
        "weight_display": "172.4 lbs",
        "bmi": 25.4,
        "eye_color": "Brown"
      }
    }
  ]
}
```

## Benchmark Results

Run the benchmark to measure generation speed:

```sql
SELECT faker_benchmark(10000, 'en_US');
```

**Typical results:**

| Users | Duration | Rate |
|-------|----------|------|
| 1,000 | ~250ms | ~4,000 users/sec |
| 10,000 | ~2.5s | ~4,000 users/sec |
| 100,000 | ~25s | ~4,000 users/sec |

Performance is consistent regardless of page position.

## Supported Locales

| Code | Name | Features |
|------|------|----------|
| `en_US` | English (United States) | US names, addresses, phone formats |
| `de_DE` | German (Germany) | German names, addresses, phone formats |

### Adding New Locales

The database schema is designed for extensibility. See [PROCEDURES.md](docs/PROCEDURES.md#adding-a-new-locale) for instructions.

## Algorithms

### Deterministic Random Generation
Uses MD5 hashing of `seed:batch:row:salt` for reproducible randomness.

### Normal Distribution (Box-Muller Transform)
```
z = √(-2·ln(u1)) · cos(2π·u2)
result = mean + z · stddev
```
Used for height and weight generation.

### Uniform Sphere Distribution
```
latitude = arcsin(2u - 1)    # NOT simply uniform!
longitude = 360u - 180       # Uniform is correct for longitude
```
Ensures points are evenly distributed on Earth's surface.

## Development

### Running Tests

```bash
# Test SQL functions directly
psql fake_users -c "SELECT * FROM faker_generate_users(12345, 0, 3, 'en_US');"

# Verify reproducibility
psql fake_users -c "SELECT full_name FROM faker_generate_users(12345, 0, 3, 'en_US');"
# Run again - should be identical
psql fake_users -c "SELECT full_name FROM faker_generate_users(12345, 0, 3, 'en_US');"
```

### Environment Variables

Create a `.env` file:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=fake_users
DB_USER=your_username
DB_PASSWORD=your_password
```
