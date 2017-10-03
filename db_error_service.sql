CREATE DATABASE error_service;
CREATE TABLE users (
    id int NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(30) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
	role VARCHAR(10) NOT NULL,
	email VARCHAR(30) NOT NULL,
    password VARCHAR(30) NOT NULL,
	PRIMARY KEY (id)
);
INSERT INTO users (last_name, first_name, role, email, password) VALUES
    ('admin','admin','admin','admin@admin.ru',123456),
	('ivan','ivanov','user','ivan@ivan.ru',654321);
	
CREATE TABLE errors (
    error_id int NOT NULL AUTO_INCREMENT,
	date_created DATE NOT NULL,
    desc_short VARCHAR(100) NOT NULL,
	desc_long VARCHAR(300) NOT NULL,
	user_id int NOT NULL,
	status VARCHAR(20) NOT NULL,
    urgency VARCHAR(20) NOT NULL,
	criticality VARCHAR(20) NOT NULL,
	PRIMARY KEY (error_id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);
INSERT INTO errors (date_created, desc_short, desc_long, user_id, status, urgency, criticality) VALUES
    (NOW(),'HTML error','caused by script',2,'open', 'urgently','important'),
	(NOW(),'CSS error','caused by script',1,'solved', 'not urgently','important'),
	(NOW(),'404 error','caused by script',2,'new', 'urgently','critical'),
	(NOW(),'Form doesnt work','caused by script',1,'closed', 'urgently','not important'),
	(NOW(),'Error in header','caused by script',2,'open', 'urgently','important'),
	(NOW(),'HTML error','caused by script',1,'open', 'urgently','important');
    