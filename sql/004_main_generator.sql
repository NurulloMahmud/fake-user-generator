DROP TYPE IF EXISTS fake_user CASCADE;
CREATE TYPE fake_user AS (
    row_index INTEGER,
    gender VARCHAR(10),
    title VARCHAR(50),
    first_name VARCHAR(100),
    middle_name VARCHAR(100),
    last_name VARCHAR(100),
    full_name VARCHAR(500),
    street_address VARCHAR(200),
    city VARCHAR(100),
    state VARCHAR(100),
    state_abbr VARCHAR(10),
    postal_code VARCHAR(20),
    full_address VARCHAR(500),
    phone VARCHAR(50),
    email VARCHAR(200),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    height_cm DOUBLE PRECISION,
    height_display VARCHAR(20),
    weight_kg DOUBLE PRECISION,
    weight_display VARCHAR(20),
    bmi DOUBLE PRECISION,
    eye_color VARCHAR(50)
);

CREATE OR REPLACE FUNCTION faker_generate_user(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER
) RETURNS fake_user AS $$
DECLARE
    v_user fake_user;
    v_name JSONB;
    v_addr JSONB;
    v_phys JSONB;
    v_coords JSONB;
BEGIN
    v_user.row_index := p_row;
    
    -- Name
    v_name := faker_generate_full_name(p_seed, p_batch, p_row, p_locale_id);
    v_user.gender := v_name->>'gender';
    v_user.title := v_name->>'title';
    v_user.first_name := v_name->>'first_name';
    v_user.middle_name := v_name->>'middle_name';
    v_user.last_name := v_name->>'last_name';
    v_user.full_name := v_name->>'full_name';
    
    -- Address
    v_addr := faker_generate_full_address(p_seed, p_batch, p_row, p_locale_id);
    v_user.street_address := v_addr->>'street_address';
    v_user.city := v_addr->>'city';
    v_user.state := v_addr->>'state';
    v_user.state_abbr := v_addr->>'state_abbr';
    v_user.postal_code := v_addr->>'postal_code';
    v_user.full_address := v_addr->>'full_address';
    
    -- Phone & Email
    v_user.phone := faker_generate_phone(p_seed, p_batch, p_row, p_locale_id);
    v_user.email := faker_generate_email(p_seed, p_batch, p_row, v_user.first_name, v_user.last_name, p_locale_id);
    
    -- Coordinates
    v_coords := faker_generate_coordinates(p_seed, p_batch, p_row);
    v_user.latitude := (v_coords->>'latitude')::DOUBLE PRECISION;
    v_user.longitude := (v_coords->>'longitude')::DOUBLE PRECISION;
    
    -- Physical attributes
    v_phys := faker_generate_physical(p_seed, p_batch, p_row, v_user.gender, p_locale_id);
    v_user.height_cm := (v_phys->>'height_cm')::DOUBLE PRECISION;
    v_user.height_display := v_phys->>'height_ft_in';
    v_user.weight_kg := (v_phys->>'weight_kg')::DOUBLE PRECISION;
    v_user.weight_display := (v_phys->>'weight_lbs')::text || ' lbs';
    v_user.bmi := (v_phys->>'bmi')::DOUBLE PRECISION;
    v_user.eye_color := v_phys->>'eye_color';
    
    RETURN v_user;
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_generate_users(
    p_seed BIGINT,
    p_batch INTEGER DEFAULT 0,
    p_count INTEGER DEFAULT 10,
    p_locale_code VARCHAR DEFAULT 'en_US'
) RETURNS SETOF fake_user AS $$
DECLARE
    v_locale_id INTEGER;
    v_row INTEGER;
BEGIN
    SELECT id INTO v_locale_id FROM locales WHERE code = p_locale_code;
    
    IF v_locale_id IS NULL THEN
        RAISE EXCEPTION 'Unknown locale: %', p_locale_code;
    END IF;
    
    FOR v_row IN 0..(p_count - 1) LOOP
        RETURN NEXT faker_generate_user(p_seed, p_batch, v_row, v_locale_id);
    END LOOP;
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_generate_users_json(
    p_seed BIGINT,
    p_batch INTEGER DEFAULT 0,
    p_count INTEGER DEFAULT 10,
    p_locale_code VARCHAR DEFAULT 'en_US'
) RETURNS JSONB AS $$
BEGIN
    RETURN (
        SELECT COALESCE(jsonb_agg(
            jsonb_build_object(
                'index', u.row_index,
                'name', jsonb_build_object(
                    'gender', u.gender,
                    'title', u.title,
                    'first', u.first_name,
                    'middle', u.middle_name,
                    'last', u.last_name,
                    'full', u.full_name
                ),
                'address', jsonb_build_object(
                    'street', u.street_address,
                    'city', u.city,
                    'state', u.state,
                    'state_abbr', u.state_abbr,
                    'postal_code', u.postal_code,
                    'full', u.full_address
                ),
                'contact', jsonb_build_object(
                    'phone', u.phone,
                    'email', u.email
                ),
                'location', jsonb_build_object(
                    'latitude', u.latitude,
                    'longitude', u.longitude
                ),
                'physical', jsonb_build_object(
                    'height_cm', u.height_cm,
                    'height_display', u.height_display,
                    'weight_kg', u.weight_kg,
                    'weight_display', u.weight_display,
                    'bmi', u.bmi,
                    'eye_color', u.eye_color
                )
            )
        ), '[]'::jsonb)
        FROM faker_generate_users(p_seed, p_batch, p_count, p_locale_code) u
    );
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_get_locales()
RETURNS TABLE (code VARCHAR, name VARCHAR) AS $$
BEGIN
    RETURN QUERY SELECT l.code, l.name FROM locales l ORDER BY l.code;
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_benchmark(
    p_count INTEGER DEFAULT 1000,
    p_locale_code VARCHAR DEFAULT 'en_US'
) RETURNS JSONB AS $$
DECLARE
    v_start TIMESTAMP;
    v_end TIMESTAMP;
    v_ms DOUBLE PRECISION;
    v_per_sec DOUBLE PRECISION;
BEGIN
    v_start := clock_timestamp();
    PERFORM * FROM faker_generate_users(12345, 0, p_count, p_locale_code);
    v_end := clock_timestamp();
    
    v_ms := EXTRACT(EPOCH FROM (v_end - v_start)) * 1000;
    v_per_sec := CASE WHEN v_ms > 0 THEN (p_count::DOUBLE PRECISION / v_ms) * 1000 ELSE 0 END;
    
    RETURN jsonb_build_object(
        'users_generated', p_count,
        'locale', p_locale_code,
        'duration_ms', round(v_ms::numeric, 2),
        'users_per_second', round(v_per_sec::numeric, 2)
    );
END;
$$ LANGUAGE plpgsql VOLATILE;