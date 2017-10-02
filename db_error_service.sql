CREATE DATABASE error_service;
CREATE TABLE users (
    id int NOT NULL UNIQUE,
    last_name VARCHAR(30) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
	role VARCHAR(10) NOT NULL,
	email VARCHAR(30) NOT NULL,
    password VARCHAR(30) NOT NULL
);
INSERT INTO users VALUES (1,'admin','admin','admin','admin@admin.ru',123456);
INSERT INTO users VALUES (2,'ivan','ivanov','user','ivan@ivan.ru',654321);