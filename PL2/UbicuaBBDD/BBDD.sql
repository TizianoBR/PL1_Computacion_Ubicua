\c postgres

DROP DATABASE IF EXISTS ubicuabbdd;
CREATE DATABASE ubicuabbdd;

BEGIN;

CREATE TABLE sensors (
    sensor_id TEXT,
    street_id CHAR(7),
    sensor_type TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    district TEXT,
    neighborhood TEXT,
    PRIMARY KEY (sensor_id)
);

CREATE TABLE meteorology (
    sensor_id TEXT,
    time timestamp,
    temperature DOUBLE PRECISION,
    humidity DOUBLE PRECISION,
    air_quality_index INTEGER,
    wind_speed DOUBLE PRECISION,
    wind_dir DOUBLE PRECISION,
    atmospheric_pressure DOUBLE PRECISION,
    uv_index INTEGER,
    PRIMARY KEY (sensor_id, time),
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
);

CREATE TABLE traffic_counter (
    sensor_id TEXT,
    time timestamp,
    vehicle_count INTEGER,
    pedestrian_count INTEGER,
    bicycle_count INTEGER,
    counter_type TEXT,
    technology TEXT,
    average_speed DOUBLE PRECISION,
    occupancy_percentage DOUBLE PRECISION,
    traffic_density TEXT,
    PRIMARY KEY (sensor_id, time),
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
);

CREATE TABLE traffic_light (
    sensor_id TEXT,
    time timestamp,
    current_state TEXT,
    cycle_position INTEGER,
    time_remaining INTEGER,
    traffic_light_type TEXT,
    circulation_dir TEXT,
    pedestrian_waiting BOOLEAN,
    pedestrian_button_pressed BOOLEAN,
    malfunction_detected BOOLEAN,
    cycle_count INTEGER,
    state_changed BOOLEAN,
    last_state_change timestamp,
    PRIMARY KEY (sensor_id, time),
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
);

CREATE TABLE info_screen (
    sensor_id TEXT,
    time timestamp,
    display_status TEXT,
    current_message TEXT,
    content_type TEXT,
    brightness_level INTEGER,
    display_type TEXT,
    display_size DOUBLE PRECISION,
    supports_color BOOLEAN,
    temperature DOUBLE PRECISION,
    energy_consumption DOUBLE PRECISION,
    last_content_update timestamp,
    PRIMARY KEY (sensor_id, time),
    FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
);


CREATE TABLE measurements(
    time timestamp,
    value INTEGER,
    PRIMARY KEY (time)
);
INSERT INTO measurements (time, value) VALUES
('2024-06-01 12:00:00', 100),
('2024-06-01 13:00:00', 150),
('2024-06-01 14:00:00', 200);

-- Inserts
INSERT INTO sensors (sensor_id, street_id, sensor_type, latitude, longitude, district, neighborhood) VALUES
('sensor_001', 'ST_1234', 'meteorology', 40.4168, -3.7038, 'Centro', 'Sol'),
('sensor_002', 'ST_5678', 'traffic_counter', 40.4170, -3.7040, 'Centro', 'Gran Via'),
('sensor_003', 'ST_9101', 'traffic_light', 40.4172, -3.7042, 'Centro', 'Calle Mayor'),
('sensor_004', 'ST_1121', 'info_screen', 40.4174, -3.7044, 'Centro', 'Plaza Mayor');

INSERT INTO meteorology (sensor_id, street_id, time, temperature, humidity, air_quality_index, wind_speed, wind_dir, atmospheric_pressure, uv_index) VALUES
('sensor_001', 'ST_1234', '2024-06-01 12:00:00', 25.5, 60.0, 42, 5.5, 180, 1013, 7);

INSERT INTO traffic_counter (sensor_id, street_id, time, vehicle_count, pedestrian_count, bicycle_count, counter_type, technology, average_speed, occupancy_percentage, traffic_density) VALUES
('sensor_002', 'ST_5678', '2024-06-01 12:05:00', 150, 30, 20, 'inductive_loop', 'magnetic', 45.0, 75.0, 'moderate');

INSERT INTO traffic_light (sensor_id, street_id, time, current_state, cycle_position, time_remaining, traffic_light_type, circulation_dir, pedestrian_waiting, pedestrian_button_pressed, malfunction_detected, cycle_count, state_changed, last_state_change) VALUES
('sensor_003', 'ST_9101', '2024-06-01 12:10:00', 'green', 3, 25, 'vehicle', 'north_south', TRUE, TRUE, FALSE, 15, TRUE, '2024-06-01 12:05:00');

INSERT INTO info_screen (sensor_id, street_id, time, display_status, current_message, content_type, brightness_level, display_type, display_size, supports_color, temperature, energy_consumption, last_content_update) VALUES
('sensor_004', 'ST_1121', '2024-06-01 12:15:00', 'operational', 'Welcome to Plaza Mayor!', 'text', 80, 'LED', 55.0, TRUE, 22.5, 150.0, '2024-06-01 11:50:00');

COMMIT;