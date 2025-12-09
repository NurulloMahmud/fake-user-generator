CREATE OR REPLACE FUNCTION faker_generate_gender(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_male_prob DOUBLE PRECISION DEFAULT 0.5
) RETURNS VARCHAR AS $$
BEGIN
    IF faker_random_boolean(p_seed, p_batch, p_row, p_male_prob, 'gender') THEN
        RETURN 'male';
    ELSE
        RETURN 'female';
    END IF;
END;
$$ LANGUAGE plpgsql IMMUTABLE;

CREATE OR REPLACE FUNCTION faker_get_name(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER,
    p_name_type VARCHAR(20),
    p_salt VARCHAR(50) DEFAULT ''
) RETURNS VARCHAR AS $$
DECLARE
    v_count INTEGER;
    v_offset INTEGER;
    v_result VARCHAR(100);
BEGIN
    SELECT COUNT(*) INTO v_count FROM names 
    WHERE locale_id = p_locale_id AND name_type = p_name_type;
    
    IF v_count = 0 THEN RETURN 'Unknown'; END IF;
    
    v_offset := faker_random_int(p_seed, p_batch, p_row, 0, v_count - 1, p_salt);
    
    SELECT value INTO v_result FROM names
    WHERE locale_id = p_locale_id AND name_type = p_name_type
    ORDER BY id LIMIT 1 OFFSET v_offset;
    
    RETURN COALESCE(v_result, 'Unknown');
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_generate_full_name(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER,
    p_gender VARCHAR DEFAULT NULL
) RETURNS JSONB AS $$
DECLARE
    v_gender VARCHAR(10);
    v_first_name VARCHAR(100);
    v_middle_name VARCHAR(100);
    v_last_name VARCHAR(100);
    v_title VARCHAR(50) := NULL;
    v_full_name VARCHAR(500);
    v_include_title BOOLEAN;
    v_include_middle BOOLEAN;
    v_middle_initial_only BOOLEAN;
    v_first_type VARCHAR(20);
    v_middle_type VARCHAR(20);
    v_title_count INTEGER;
    v_title_offset INTEGER;
BEGIN
    v_gender := COALESCE(p_gender, faker_generate_gender(p_seed, p_batch, p_row));
    
    IF v_gender = 'male' THEN
        v_first_type := 'first_male';
        v_middle_type := 'middle_male';
    ELSE
        v_first_type := 'first_female';
        v_middle_type := 'middle_female';
    END IF;
    
    v_first_name := faker_get_name(p_seed, p_batch, p_row, p_locale_id, v_first_type, 'first');
    v_middle_name := faker_get_name(p_seed, p_batch, p_row, p_locale_id, v_middle_type, 'middle');
    v_last_name := faker_get_name(p_seed, p_batch, p_row, p_locale_id, 'last', 'last');
    
    v_include_title := faker_random_boolean(p_seed, p_batch, p_row, 0.2, 'inc_title');
    v_include_middle := faker_random_boolean(p_seed, p_batch, p_row, 0.4, 'inc_middle');
    v_middle_initial_only := faker_random_boolean(p_seed, p_batch, p_row, 0.5, 'mid_init');
    
    IF v_include_title THEN
        SELECT COUNT(*) INTO v_title_count FROM titles 
        WHERE locale_id = p_locale_id AND (gender = v_gender OR gender = 'neutral');
        
        IF v_title_count > 0 THEN
            v_title_offset := faker_random_int(p_seed, p_batch, p_row, 0, v_title_count - 1, 'title');
            SELECT value INTO v_title FROM titles
            WHERE locale_id = p_locale_id AND (gender = v_gender OR gender = 'neutral')
            ORDER BY id LIMIT 1 OFFSET v_title_offset;
        END IF;
    END IF;
    
    v_full_name := '';
    IF v_title IS NOT NULL THEN
        v_full_name := v_title || ' ';
    END IF;
    
    v_full_name := v_full_name || v_first_name;
    
    IF v_include_middle THEN
        IF v_middle_initial_only THEN
            v_full_name := v_full_name || ' ' || substring(v_middle_name from 1 for 1) || '.';
        ELSE
            v_full_name := v_full_name || ' ' || v_middle_name;
        END IF;
    END IF;
    
    v_full_name := v_full_name || ' ' || v_last_name;
    
    RETURN jsonb_build_object(
        'gender', v_gender,
        'title', v_title,
        'first_name', v_first_name,
        'middle_name', CASE WHEN v_include_middle THEN v_middle_name ELSE NULL END,
        'last_name', v_last_name,
        'full_name', v_full_name
    );
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_generate_street_address(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER
) RETURNS VARCHAR AS $$
DECLARE
    v_street_num INTEGER;
    v_street_name VARCHAR(100);
    v_street_suffix VARCHAR(50);
    v_count INTEGER;
    v_offset INTEGER;
    v_locale_code VARCHAR(10);
    v_result VARCHAR(200);
BEGIN
    SELECT code INTO v_locale_code FROM locales WHERE id = p_locale_id;
    
    IF v_locale_code LIKE 'de_%' THEN
        v_street_num := faker_random_int(p_seed, p_batch, p_row, 1, 150, 'st_num');
    ELSE
        v_street_num := faker_random_int(p_seed, p_batch, p_row, 1, 9999, 'st_num');
    END IF;
    
    SELECT COUNT(*) INTO v_count FROM streets WHERE locale_id = p_locale_id;
    IF v_count > 0 THEN
        v_offset := faker_random_int(p_seed, p_batch, p_row, 0, v_count - 1, 'street');
        SELECT value INTO v_street_name FROM streets 
        WHERE locale_id = p_locale_id ORDER BY id LIMIT 1 OFFSET v_offset;
    ELSE
        v_street_name := 'Main';
    END IF;
    
    SELECT COUNT(*) INTO v_count FROM street_suffixes WHERE locale_id = p_locale_id;
    IF v_count > 0 THEN
        v_offset := faker_random_int(p_seed, p_batch, p_row, 0, v_count - 1, 'suffix');
        SELECT value INTO v_street_suffix FROM street_suffixes
        WHERE locale_id = p_locale_id ORDER BY id LIMIT 1 OFFSET v_offset;
    ELSE
        v_street_suffix := 'Street';
    END IF;
    
    IF v_locale_code LIKE 'de_%' THEN
        v_result := v_street_name || v_street_suffix || ' ' || v_street_num;
    ELSE
        v_result := v_street_num || ' ' || v_street_name || ' ' || v_street_suffix;
    END IF;
    
    IF faker_random_boolean(p_seed, p_batch, p_row, 0.2, 'has_apt') THEN
        IF v_locale_code LIKE 'de_%' THEN
            v_result := v_result || ', Wohnung ' || faker_random_int(p_seed, p_batch, p_row, 1, 50, 'apt');
        ELSE
            v_result := v_result || ' Apt ' || faker_random_int(p_seed, p_batch, p_row, 1, 999, 'apt');
        END IF;
    END IF;
    
    RETURN v_result;
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_generate_city_state_postal(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER
) RETURNS JSONB AS $$
DECLARE
    v_count INTEGER;
    v_offset INTEGER;
    v_city VARCHAR(100);
    v_state VARCHAR(100);
    v_state_abbr VARCHAR(10);
    v_postal_prefix VARCHAR(10);
    v_postal VARCHAR(20);
    v_locale_code VARCHAR(10);
BEGIN
    SELECT code INTO v_locale_code FROM locales WHERE id = p_locale_id;
    
    SELECT COUNT(*) INTO v_count FROM cities WHERE locale_id = p_locale_id;
    IF v_count > 0 THEN
        v_offset := faker_random_int(p_seed, p_batch, p_row, 0, v_count - 1, 'city');
        SELECT c.name, c.postal_code_prefix, s.name, s.abbreviation
        INTO v_city, v_postal_prefix, v_state, v_state_abbr
        FROM cities c LEFT JOIN states s ON c.state_id = s.id
        WHERE c.locale_id = p_locale_id
        ORDER BY c.id LIMIT 1 OFFSET v_offset;
    ELSE
        v_city := 'Springfield';
        v_state := 'State';
        v_state_abbr := 'ST';
    END IF;
    
    IF v_locale_code LIKE 'de_%' THEN
        v_postal := lpad(faker_random_int(p_seed, p_batch, p_row, 10000, 99999, 'postal')::text, 5, '0');
    ELSE
        v_postal := lpad(faker_random_int(p_seed, p_batch, p_row, 10000, 99999, 'postal')::text, 5, '0');
        IF faker_random_boolean(p_seed, p_batch, p_row, 0.3, 'zip4') THEN
            v_postal := v_postal || '-' || lpad(faker_random_int(p_seed, p_batch, p_row, 1, 9999, 'postal4')::text, 4, '0');
        END IF;
    END IF;
    
    RETURN jsonb_build_object(
        'city', v_city,
        'state', v_state,
        'state_abbr', v_state_abbr,
        'postal_code', v_postal
    );
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_generate_full_address(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER
) RETURNS JSONB AS $$
DECLARE
    v_street VARCHAR(200);
    v_city_data JSONB;
    v_full VARCHAR(500);
    v_locale_code VARCHAR(10);
BEGIN
    SELECT code INTO v_locale_code FROM locales WHERE id = p_locale_id;
    
    v_street := faker_generate_street_address(p_seed, p_batch, p_row, p_locale_id);
    v_city_data := faker_generate_city_state_postal(p_seed, p_batch, p_row, p_locale_id);
    
    -- Format by locale
    IF v_locale_code LIKE 'de_%' THEN
        v_full := v_street || ', ' || (v_city_data->>'postal_code') || ' ' || (v_city_data->>'city');
    ELSE
        v_full := v_street || ', ' || (v_city_data->>'city') || ', ' ||
                  COALESCE(v_city_data->>'state_abbr', v_city_data->>'state') || ' ' ||
                  (v_city_data->>'postal_code');
    END IF;
    
    RETURN jsonb_build_object(
        'street_address', v_street,
        'city', v_city_data->>'city',
        'state', v_city_data->>'state',
        'state_abbr', v_city_data->>'state_abbr',
        'postal_code', v_city_data->>'postal_code',
        'full_address', v_full
    );
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_generate_phone(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_locale_id INTEGER
) RETURNS VARCHAR AS $$
DECLARE
    v_locale_code VARCHAR(10);
    v_fmt INTEGER;
    v_area INTEGER;
    v_exch INTEGER;
    v_sub INTEGER;
    v_phone VARCHAR(50);
BEGIN
    SELECT code INTO v_locale_code FROM locales WHERE id = p_locale_id;
    v_fmt := faker_random_int(p_seed, p_batch, p_row, 1, 4, 'ph_fmt');
    
    IF v_locale_code LIKE 'de_%' THEN
        v_area := faker_random_int(p_seed, p_batch, p_row, 30, 89, 'ph_area');
        v_exch := faker_random_int(p_seed, p_batch, p_row, 100000, 9999999, 'ph_exch');
        CASE v_fmt
            WHEN 1 THEN v_phone := '+49 ' || v_area || ' ' || v_exch;
            WHEN 2 THEN v_phone := '0' || v_area || ' ' || v_exch;
            WHEN 3 THEN v_phone := '+49' || v_area || v_exch;
            ELSE v_phone := '0' || v_area || '/' || v_exch;
        END CASE;
    ELSE
        v_area := faker_random_int(p_seed, p_batch, p_row, 200, 999, 'ph_area');
        v_exch := faker_random_int(p_seed, p_batch, p_row, 200, 999, 'ph_exch');
        v_sub := faker_random_int(p_seed, p_batch, p_row, 1000, 9999, 'ph_sub');
        CASE v_fmt
            WHEN 1 THEN v_phone := '(' || v_area || ') ' || v_exch || '-' || v_sub;
            WHEN 2 THEN v_phone := v_area || '-' || v_exch || '-' || v_sub;
            WHEN 3 THEN v_phone := '+1 ' || v_area || ' ' || v_exch || ' ' || v_sub;
            ELSE v_phone := '1-' || v_area || '-' || v_exch || '-' || v_sub;
        END CASE;
    END IF;
    
    RETURN v_phone;
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_generate_email(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_first_name VARCHAR,
    p_last_name VARCHAR,
    p_locale_id INTEGER
) RETURNS VARCHAR AS $$
DECLARE
    v_locale_code VARCHAR(10);
    v_domains_us TEXT[] := ARRAY['gmail.com','yahoo.com','hotmail.com','outlook.com','aol.com','icloud.com','mail.com','protonmail.com'];
    v_domains_de TEXT[] := ARRAY['gmail.com','web.de','gmx.de','yahoo.de','t-online.de','freenet.de','outlook.de','mail.de'];
    v_domains TEXT[];
    v_domain VARCHAR(100);
    v_fmt INTEGER;
    v_first VARCHAR(100);
    v_last VARCHAR(100);
    v_num VARCHAR(10) := '';
    v_email VARCHAR(200);
BEGIN
    SELECT code INTO v_locale_code FROM locales WHERE id = p_locale_id;
    
    IF v_locale_code LIKE 'de_%' THEN
        v_domains := v_domains_de;
    ELSE
        v_domains := v_domains_us;
    END IF;
    
    v_domain := faker_random_element(p_seed, p_batch, p_row, v_domains, 'em_dom');
    
    -- Clean names
    v_first := lower(regexp_replace(p_first_name, '[^a-zA-Z]', '', 'g'));
    v_last := lower(regexp_replace(p_last_name, '[^a-zA-Z]', '', 'g'));
    -- Handle German umlauts
    v_first := replace(replace(replace(replace(v_first, 'ä', 'ae'), 'ö', 'oe'), 'ü', 'ue'), 'ß', 'ss');
    v_last := replace(replace(replace(replace(v_last, 'ä', 'ae'), 'ö', 'oe'), 'ü', 'ue'), 'ß', 'ss');
    
    v_fmt := faker_random_int(p_seed, p_batch, p_row, 1, 6, 'em_fmt');
    
    -- 40% chance of number suffix
    IF faker_random_boolean(p_seed, p_batch, p_row, 0.4, 'em_num') THEN
        v_num := faker_random_int(p_seed, p_batch, p_row, 1, 999, 'em_n')::text;
    END IF;
    
    CASE v_fmt
        WHEN 1 THEN v_email := v_first || '.' || v_last || v_num;
        WHEN 2 THEN v_email := v_first || v_last || v_num;
        WHEN 3 THEN v_email := substring(v_first from 1 for 1) || v_last || v_num;
        WHEN 4 THEN v_email := v_first || '_' || v_last || v_num;
        WHEN 5 THEN v_email := v_last || '.' || v_first || v_num;
        ELSE v_email := v_first || v_num;
    END CASE;
    
    RETURN v_email || '@' || v_domain;
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_generate_physical(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER,
    p_gender VARCHAR,
    p_locale_id INTEGER
) RETURNS JSONB AS $$
DECLARE
    v_locale_code VARCHAR(10);
    v_height_mean DOUBLE PRECISION;
    v_weight_mean DOUBLE PRECISION;
    v_height DOUBLE PRECISION;
    v_weight DOUBLE PRECISION;
    v_bmi DOUBLE PRECISION;
    v_eye VARCHAR(50);
    v_count INTEGER;
    v_offset INTEGER;
BEGIN
    SELECT code INTO v_locale_code FROM locales WHERE id = p_locale_id;
    
    IF p_gender = 'male' THEN
        IF v_locale_code LIKE 'de_%' THEN
            v_height_mean := 180.0; v_weight_mean := 85.0;
        ELSE
            v_height_mean := 177.0; v_weight_mean := 90.0;
        END IF;
    ELSE
        IF v_locale_code LIKE 'de_%' THEN
            v_height_mean := 166.0; v_weight_mean := 68.0;
        ELSE
            v_height_mean := 163.0; v_weight_mean := 77.0;
        END IF;
    END IF;
    
    -- Generate with normal distribution
    v_height := faker_random_normal_bounded(p_seed, p_batch, p_row, v_height_mean, 7.0, 140.0, 210.0, 'ht');
    v_weight := faker_random_normal_bounded(p_seed, p_batch, p_row, v_weight_mean, 12.0, 40.0, 150.0, 'wt');
    v_bmi := v_weight / ((v_height/100.0) * (v_height/100.0));
    
    -- Eye color
    SELECT COUNT(*) INTO v_count FROM eye_colors WHERE locale_id = p_locale_id;
    IF v_count > 0 THEN
        v_offset := faker_random_int(p_seed, p_batch, p_row, 0, v_count - 1, 'eye');
        SELECT value INTO v_eye FROM eye_colors WHERE locale_id = p_locale_id ORDER BY id LIMIT 1 OFFSET v_offset;
    ELSE
        v_eye := faker_weighted_random(p_seed, p_batch, p_row,
            ARRAY['Brown','Blue','Green','Hazel','Gray'],
            ARRAY[55, 27, 8, 7, 3], 'eye');
    END IF;
    
    RETURN jsonb_build_object(
        'height_cm', round(v_height::numeric, 1),
        'height_ft_in', floor(v_height/30.48)::text || '''' || round((v_height/2.54 - floor(v_height/30.48)*12)::numeric)::text || '"',
        'weight_kg', round(v_weight::numeric, 1),
        'weight_lbs', round((v_weight * 2.205)::numeric, 1),
        'bmi', round(v_bmi::numeric, 1),
        'eye_color', v_eye
    );
END;
$$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION faker_generate_coordinates(
    p_seed BIGINT,
    p_batch INTEGER,
    p_row INTEGER
) RETURNS JSONB AS $$
BEGIN
    RETURN jsonb_build_object(
        'latitude', round(faker_random_latitude(p_seed, p_batch, p_row, 'geo')::numeric, 6),
        'longitude', round(faker_random_longitude(p_seed, p_batch, p_row, 'geo')::numeric, 6)
    );
END;
$$ LANGUAGE plpgsql IMMUTABLE;