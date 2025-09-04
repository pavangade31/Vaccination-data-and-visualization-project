DROP TABLE IF EXISTS vaccine_schedule;
DROP TABLE IF EXISTS vaccine_introduction;
DROP TABLE IF EXISTS reported_cases;
DROP TABLE IF EXISTS incidence;
DROP TABLE IF EXISTS coverage;
DROP TABLE IF EXISTS disease;
DROP TABLE IF EXISTS antigen;
DROP TABLE IF EXISTS country;
-- Countries table
CREATE TABLE country (
    iso_code CHAR(100) PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Antigens (vaccines) table
CREATE TABLE antigen (
    antigen_id VARCHAR(50) PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);
-- Diseases table
CREATE TABLE disease (
    disease_code VARCHAR(50) PRIMARY KEY,
    description VARCHAR(255) NOT NULL
);

-- Vaccination coverage data
CREATE TABLE coverage (
    id SERIAL PRIMARY KEY,
    country_code CHAR(100) NOT NULL,
    year INT NOT NULL,
    antigen_id VARCHAR(50) NOT NULL,
    antigen_description VARCHAR(100),
    coverage_category VARCHAR(100),
    coverage_category_description VARCHAR(255),
    coverage FLOAT NOT NULL,
    FOREIGN KEY (country_code) REFERENCES country(iso_code),
    FOREIGN KEY (antigen_id) REFERENCES antigen(antigen_id)
);

-- Disease incidence data
CREATE TABLE incidence (
    id SERIAL PRIMARY KEY,
    country_code CHAR(100) NOT NULL,
    year INT NOT NULL,
    disease_code VARCHAR(50) NOT NULL,
    disease_description VARCHAR(100),
    denominator VARCHAR(100),
    incidence_rate FLOAT,
    FOREIGN KEY (country_code) REFERENCES country(iso_code),
    FOREIGN KEY (disease_code) REFERENCES disease(disease_code)
);

-- Reported disease cases
CREATE TABLE reported_cases (
    id SERIAL PRIMARY KEY,
    country_code CHAR(100) NOT NULL,
    year INT NOT NULL,
    disease_code VARCHAR(50) NOT NULL,
    disease_description VARCHAR(100),
    cases BIGINT,
    FOREIGN KEY (country_code) REFERENCES country(iso_code),
    FOREIGN KEY (disease_code) REFERENCES disease(disease_code)
);

-- Vaccine introduction data
CREATE TABLE vaccine_introduction (
    id SERIAL PRIMARY KEY,
    country_code CHAR(100) NOT NULL,
    who_region VARCHAR(100),
    year INT NOT NULL,
    description VARCHAR(255),
    introduced BOOLEAN,
    FOREIGN KEY (country_code) REFERENCES country(iso_code)
);

-- Vaccine schedule data
CREATE TABLE vaccine_schedule (
    id SERIAL PRIMARY KEY,
    country_code CHAR(100) NOT NULL,
    who_region VARCHAR(100),
    year INT NOT NULL,
    vaccine_code VARCHAR(50),
    vaccine_description VARCHAR(255),
    schedule_rounds INT,
    target_population_description VARCHAR(255),
    geoarea VARCHAR(100),
    age_administered VARCHAR(100),
    source_comment TEXT,
    FOREIGN KEY (country_code) REFERENCES country(iso_code)
);