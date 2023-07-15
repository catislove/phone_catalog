CREATE TABLE IF NOT EXISTS phone_catalog (
    id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    middle_name VARCHAR(255),
    gender VARCHAR(255),
    birthdate DATE DEFAULT null,
    phone_number VARCHAR(255),
    mail VARCHAR(255),
    address TEXT DEFAULT '',
    termination_date TIMESTAMP WITH TIME ZONE DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    login VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255),
    email VARCHAR(255),
    remote_id VARCHAR(255) NOT NULL UNIQUE
);

CREATE DATABASE keycloak;