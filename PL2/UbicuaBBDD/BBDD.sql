\c postgres

DROP DATABASE IF EXISTS UbicuaBBDD;
CREATE DATABASE UbicuaBBDD;
\c UbicuaBBDD
BEGIN;
CREATE TABLE sensors(
    sensor_id TEXT PRIMARY KEY,
    street_id CHAR(7) PRIMARY KEY,
    sensor_type TEXT,
    latitude FLOAT,
    longitude FLOAT,
    district TEXT,
    neighborhood TEXT
);

CREATE TABLE meteorology(
    sensor_id TEXT PRIMARY KEY,
    street_id CHAR(7) PRIMARY KEY,
    timestamp TIMESTAMP PRIMARY KEY,
    temperature FLOAT,
    humidity FLOAT,
    air_quality_index INTEGER,
    wind_speed FLOAT,
    wind_dir FLOAT,
    atmospheric_pressure FLOAT,
    uv_index INTEGER
)
FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
FOREIGN KEY (street_id) REFERENCES sensors(street_id);

CREATE TABLE traffic_counter(
    sensor_id TEXT PRIMARY KEY,
    street_id CHAR(7) PRIMARY KEY,
    timestamp TIMESTAMP PRIMARY KEY,
    vehicle_count INTEGER,
    pedesstrian_count INTEGER,
    bycicle_count INTEGER,
    counter_type TEXT,
    technology TEXT,
    average_speed FLOAT,
    occupancy_percentage FLOAT,
    traffic_density TEXT
)
FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
FOREIGN KEY (street_id) REFERENCES sensors(street_id);

CREATE TABLE traffic_light(
    sensor_id TEXT PRIMARY KEY,
    street_id CHAR(7) PRIMARY KEY,
    timestamp TIMESTAMP PRIMARY KEY,
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
    last_state_change TIMESTAMP
)
FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
FOREIGN KEY (street_id) REFERENCES sensors(street_id);

CREATE TABLE info_screen(
    sensor_id TEXT PRIMARY KEY,
    street_id CHAR(7) PRIMARY KEY,
    timestamp TIMESTAMP PRIMARY KEY,
    display_status TEXT,
    current_message TEXT,
    content_type TEXT,
    brightness_level INTEGER,
    display_type TEXT,
    display_size FLOAT,
    supporrts_color BOOLEAN,
    temperature FLOAT,
    energy_consumption FLOAT,
    last_content_update TIMESTAMP
)
FOREIGN KEY (sensor_id) REFERENCES sensors(sensor_id)
FOREIGN KEY (street_id) REFERENCES sensors(street_id);

INPUT VALUES(
    'sensor_001', 'ST_1234', 'wheather', 40.4168, -3.7038, 'Centro', 'Sol'
) INTO sensors;
INPUT VALUES(
    'sensor_002', 'ST_5678', 'traffic_counter', 40.4170, -3.7040, 'Centro', 'Gran Via'
) INTO sensors;
INPUT VALUES(
    'sensor_003', 'ST_9101', 'traffic_light', 40.4172, -3.7042, 'Centro', 'Calle Mayor'
) INTO sensors;
INPUT VALUES(
    'sensor_004', 'ST_1121', 'info_screen', 40.4174, -3.7044, 'Centro', 'Plaza Mayor'
) INTO sensors;

INPUT VALUES('sensor_001', 'ST_1234', '2024-06-01 12:00:00', 25.5, 60.0, 42, 5.5, 180, 1013, 7) INTO meteorology;
INPUT VALUES('sensor_002', 'ST_5678', '2024-06-01 12:05:00', 150, 30, 20, 'inductive_loop', 'magnetic', 45.0, 75.0, 'moderate') INTO traffic_counter;
INPUT VALUES('sensor_003', 'ST_9101', '2024-06-01 12:10:00', 'green', 3, 25, 'vehicle', 'north_south', TRUE, TRUE, FALSE, 15, TRUE, '2024-06-01 12:05:00') INTO traffic_light;
INPUT VALUES('sensor_004', 'ST_1121', '2024-06-01 12:15:00', 'operational', 'Welcome to Plaza Mayor!', 'text', 80, 'LED', 55.0, TRUE, 22.5, 150.0, '2024-06-01 11:50:00') INTO info_screen;

COMMIT;