-- Supported locales
CREATE TABLE IF NOT EXISTS locales (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    country_code VARCHAR(2) NOT NULL,
    language_code VARCHAR(2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Names table (first names, last names, middle names - all in one table)
CREATE TABLE IF NOT EXISTS names (
    id SERIAL PRIMARY KEY,
    locale_id INTEGER REFERENCES locales(id) ON DELETE CASCADE,
    name_type VARCHAR(20) NOT NULL CHECK (name_type IN ('first_male', 'first_female', 'last', 'middle_male', 'middle_female')),
    value VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Titles (Mr., Mrs., Dr., etc.)
CREATE TABLE IF NOT EXISTS titles (
    id SERIAL PRIMARY KEY,
    locale_id INTEGER REFERENCES locales(id) ON DELETE CASCADE,
    gender VARCHAR(10) CHECK (gender IN ('male', 'female', 'neutral')),
    value VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- States/Regions
CREATE TABLE IF NOT EXISTS states (
    id SERIAL PRIMARY KEY,
    locale_id INTEGER REFERENCES locales(id) ON DELETE CASCADE,
    name VARCHAR(100) NOT NULL,
    abbreviation VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Cities
CREATE TABLE IF NOT EXISTS cities (
    id SERIAL PRIMARY KEY,
    locale_id INTEGER REFERENCES locales(id) ON DELETE CASCADE,
    state_id INTEGER REFERENCES states(id) ON DELETE SET NULL,
    name VARCHAR(100) NOT NULL,
    postal_code_prefix VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Street names
CREATE TABLE IF NOT EXISTS streets (
    id SERIAL PRIMARY KEY,
    locale_id INTEGER REFERENCES locales(id) ON DELETE CASCADE,
    value VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Street suffixes (Street, Avenue, Straße, etc.)
CREATE TABLE IF NOT EXISTS street_suffixes (
    id SERIAL PRIMARY KEY,
    locale_id INTEGER REFERENCES locales(id) ON DELETE CASCADE,
    value VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Eye colors
CREATE TABLE IF NOT EXISTS eye_colors (
    id SERIAL PRIMARY KEY,
    locale_id INTEGER REFERENCES locales(id) ON DELETE CASCADE,
    value VARCHAR(50) NOT NULL,
    frequency INTEGER DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_names_locale_type ON names(locale_id, name_type);
CREATE INDEX IF NOT EXISTS idx_cities_locale ON cities(locale_id);
CREATE INDEX IF NOT EXISTS idx_streets_locale ON streets(locale_id);
CREATE INDEX IF NOT EXISTS idx_states_locale ON states(locale_id);