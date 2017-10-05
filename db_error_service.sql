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

CREATE TABLE errors_history (
	history_id int NOT NULL AUTO_INCREMENT,
    error_id int NOT NULL,
	date_created DATE NOT NULL,
    desc_short VARCHAR(100) NOT NULL,
	desc_long VARCHAR(300) NOT NULL,
	user_id int NOT NULL,
	status VARCHAR(20) NOT NULL,
    urgency VARCHAR(20) NOT NULL,
	criticality VARCHAR(20) NOT NULL,
	PRIMARY KEY (history_id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (error_id) REFERENCES errors(error_id)
);

CREATE TABLE status_list (
    id TINYINT NOT NULL AUTO_INCREMENT,
	status VARCHAR(10) NOT NULL,
	st_new TINYINT(1),
	st_opened TINYINT(1),
	st_solved TINYINT(1),
	st_closed TINYINT(1),
	PRIMARY KEY (id)
);
INSERT INTO status_list (status, st_new, st_opened, st_solved, st_closed) VALUES
	('New',1,0,0,0),('Opened',1,1,1,0),('Solved',0,1,1,0),('Closed',0,0,1,1);

CREATE TABLE urgency_list (
    id TINYINT NOT NULL AUTO_INCREMENT,
	urgency VARCHAR(20) NOT NULL,
	PRIMARY KEY (id)
);
INSERT INTO urgency_list (urgency) VALUES ('Very urgent'),('Urgent'),('Not urgent'),('Easy pace');

CREATE TABLE critical_list (
    id TINYINT NOT NULL AUTO_INCREMENT,
	criticality VARCHAR(20) NOT NULL,
	PRIMARY KEY (id)
);
INSERT INTO critical_list (criticality) VALUES ('Emergency'),('Crucial'),('Not crucial'),('Changes requested');





















