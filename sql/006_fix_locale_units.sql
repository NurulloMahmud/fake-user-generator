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
    v_height_display VARCHAR(20);
    v_weight_display VARCHAR(20);
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
    
    v_height := faker_random_normal_bounded(p_seed, p_batch, p_row, v_height_mean, 7.0, 140.0, 210.0, 'ht');
    v_weight := faker_random_normal_bounded(p_seed, p_batch, p_row, v_weight_mean, 12.0, 40.0, 150.0, 'wt');
    v_bmi := v_weight / ((v_height/100.0) * (v_height/100.0));
    
    SELECT COUNT(*) INTO v_count FROM eye_colors WHERE locale_id = p_locale_id;
    IF v_count > 0 THEN
        v_offset := faker_random_int(p_seed, p_batch, p_row, 0, v_count - 1, 'eye');
        SELECT value INTO v_eye FROM eye_colors WHERE locale_id = p_locale_id ORDER BY id LIMIT 1 OFFSET v_offset;
    ELSE
        v_eye := faker_weighted_random(p_seed, p_batch, p_row,
            ARRAY['Brown','Blue','Green','Hazel','Gray'],
            ARRAY[55, 27, 8, 7, 3], 'eye');
    END IF;
    
    IF v_locale_code LIKE 'de_%' THEN
        v_height_display := round(v_height::numeric, 0)::text || ' cm';
        v_weight_display := round(v_weight::numeric, 1)::text || ' kg';
    ELSE
        -- US: Use imperial system (ft/in, lbs)
        v_height_display := floor(v_height/30.48)::text || '''' || round((v_height/2.54 - floor(v_height/30.48)*12)::numeric)::text || '"';
        v_weight_display := round((v_weight * 2.205)::numeric, 1)::text || ' lbs';
    END IF;
    
    RETURN jsonb_build_object(
        'height_cm', round(v_height::numeric, 1),
        'height_ft_in', floor(v_height/30.48)::text || '''' || round((v_height/2.54 - floor(v_height/30.48)*12)::numeric)::text || '"',
        'weight_kg', round(v_weight::numeric, 1),
        'weight_lbs', round((v_weight * 2.205)::numeric, 1),
        'bmi', round(v_bmi::numeric, 1),
        'eye_color', v_eye,
        'height_display', v_height_display,
        'weight_display', v_weight_display
    );
END;
$$ LANGUAGE plpgsql STABLE;

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
    
    v_name := faker_generate_full_name(p_seed, p_batch, p_row, p_locale_id);
    v_user.gender := v_name->>'gender';
    v_user.title := v_name->>'title';
    v_user.first_name := v_name->>'first_name';
    v_user.middle_name := v_name->>'middle_name';
    v_user.last_name := v_name->>'last_name';
    v_user.full_name := v_name->>'full_name';
    
    v_addr := faker_generate_full_address(p_seed, p_batch, p_row, p_locale_id);
    v_user.street_address := v_addr->>'street_address';
    v_user.city := v_addr->>'city';
    v_user.state := v_addr->>'state';
    v_user.state_abbr := v_addr->>'state_abbr';
    v_user.postal_code := v_addr->>'postal_code';
    v_user.full_address := v_addr->>'full_address';
    
    v_user.phone := faker_generate_phone(p_seed, p_batch, p_row, p_locale_id);
    v_user.email := faker_generate_email(p_seed, p_batch, p_row, v_user.first_name, v_user.last_name, p_locale_id);
    
    v_coords := faker_generate_coordinates(p_seed, p_batch, p_row);
    v_user.latitude := (v_coords->>'latitude')::DOUBLE PRECISION;
    v_user.longitude := (v_coords->>'longitude')::DOUBLE PRECISION;
    
    v_phys := faker_generate_physical(p_seed, p_batch, p_row, v_user.gender, p_locale_id);
    v_user.height_cm := (v_phys->>'height_cm')::DOUBLE PRECISION;
    v_user.height_display := v_phys->>'height_display';  
    v_user.weight_kg := (v_phys->>'weight_kg')::DOUBLE PRECISION;
    v_user.weight_display := v_phys->>'weight_display'; 
    v_user.bmi := (v_phys->>'bmi')::DOUBLE PRECISION;
    v_user.eye_color := v_phys->>'eye_color';
    
    RETURN v_user;
END;
$$ LANGUAGE plpgsql STABLE;
