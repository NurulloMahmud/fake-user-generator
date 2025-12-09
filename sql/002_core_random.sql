CREATE OR REPLACE FUNCTION faker_hash_seed(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS BIGINT AS $$
DECLARE
    v_input TEXT;
    v_hash TEXT;
BEGIN
    v_input := p_seed::TEXT || ':' || p_batch::TEXT || ':' || p_row::TEXT || ':' || p_salt;
    v_hash := md5(v_input);
    RETURN abs(('x' || substring(v_hash from 1 for 15))::bit(60)::bigint);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- faker_random_float: Returns a float in [0, 1)
CREATE OR REPLACE FUNCTION faker_random_float(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS DOUBLE PRECISION AS $$
BEGIN
    RETURN faker_hash_seed(p_seed, p_batch, p_row, p_salt)::DOUBLE PRECISION 
           / 1152921504606846975::DOUBLE PRECISION;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION faker_random_int(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_min INTEGER,
    p_max INTEGER,
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS INTEGER AS $$
BEGIN
    RETURN p_min + floor(faker_random_float(p_seed, p_batch, p_row, p_salt) 
                         * (p_max - p_min + 1))::INTEGER;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION faker_random_boolean(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_probability DOUBLE PRECISION DEFAULT 0.5,
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS BOOLEAN AS $$
BEGIN
    RETURN faker_random_float(p_seed, p_batch, p_row, p_salt) < p_probability;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION faker_random_normal(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_mean DOUBLE PRECISION DEFAULT 0.0,
    p_stddev DOUBLE PRECISION DEFAULT 1.0,
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS DOUBLE PRECISION AS $$
DECLARE
    v_u1 DOUBLE PRECISION;
    v_u2 DOUBLE PRECISION;
    v_z DOUBLE PRECISION;
BEGIN
    v_u1 := GREATEST(faker_random_float(p_seed, p_batch, p_row, p_salt || '_n1'), 0.0000001);
    v_u2 := faker_random_float(p_seed, p_batch, p_row, p_salt || '_n2');
    v_z := sqrt(-2.0 * ln(v_u1)) * cos(2.0 * 3.14159265358979 * v_u2);
    RETURN p_mean + v_z * p_stddev;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION faker_random_normal_bounded(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_mean DOUBLE PRECISION,
    p_stddev DOUBLE PRECISION,
    p_min DOUBLE PRECISION,
    p_max DOUBLE PRECISION,
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS DOUBLE PRECISION AS $$
DECLARE
    v_value DOUBLE PRECISION;
BEGIN
    v_value := faker_random_normal(p_seed, p_batch, p_row, p_mean, p_stddev, p_salt);
    RETURN GREATEST(p_min, LEAST(p_max, v_value));
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION faker_random_latitude(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS DOUBLE PRECISION AS $$
DECLARE
    v_u DOUBLE PRECISION;
BEGIN
    v_u := faker_random_float(p_seed, p_batch, p_row, p_salt || '_lat');
    RETURN degrees(asin(2.0 * v_u - 1.0));
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION faker_random_longitude(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS DOUBLE PRECISION AS $$
BEGIN
    RETURN faker_random_float(p_seed, p_batch, p_row, p_salt || '_lon') * 360.0 - 180.0;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION faker_random_element(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_array TEXT[],
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS TEXT AS $$
BEGIN
    IF array_length(p_array, 1) IS NULL THEN RETURN NULL; END IF;
    RETURN p_array[faker_random_int(p_seed, p_batch, p_row, 1, array_length(p_array, 1), p_salt)];
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION faker_weighted_random(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_values TEXT[],
    p_weights INTEGER[],
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS TEXT AS $$
DECLARE
    v_total INTEGER := 0;
    v_target INTEGER;
    v_cumulative INTEGER := 0;
    v_i INTEGER;
BEGIN
    FOR v_i IN 1..array_length(p_weights, 1) LOOP
        v_total := v_total + p_weights[v_i];
    END LOOP;
    
    v_target := faker_random_int(p_seed, p_batch, p_row, 1, v_total, p_salt);
    
    FOR v_i IN 1..array_length(p_weights, 1) LOOP
        v_cumulative := v_cumulative + p_weights[v_i];
        IF v_target <= v_cumulative THEN
            RETURN p_values[v_i];
        END IF;
    END LOOP;
    
    RETURN p_values[array_length(p_values, 1)];
END;
$$ LANGUAGE plpgsql IMMUTABLE;