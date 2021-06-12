--TABLES
--Replace this with your table creations.
CREATE TABLE Users(			--User in project
user_id DECIMAL(12) PRIMARY KEY,
username VARCHAR(24) UNIQUE NOT NULL,
first_name VARCHAR(24) NOT NULL,
last_name VARCHAR(24) NOT NULL,
user_email VARCHAR(64) NOT NULL,
pronouns VARCHAR(24) NOT NULL,
birthday DATE,
setting CHAR(1)
);

CREATE TABLE Business(
business_id DECIMAL(12) PRIMARY KEY,
accountname VARCHAR(24) UNIQUE NOT NULL,
business_name VARCHAR(64) NOT NULL,
primary_contact VARCHAR(64) NOT NULL,
phone_number DECIMAL(24) NOT NULL,
business_email VARCHAR(64) NOT NULL,
business_website VARCHAR(255) NOT NULL
);

CREATE TABLE Advertisement(
ad_id DECIMAL(12) NOT NULL,
business_id DECIMAL(12) NOT NULL,
requested_on DATE NOT NULL,
advertising_type VARCHAR(24) NOT NULL,
advertising_plan TEXT NOT NULL,
PRIMARY KEY (ad_id),
FOREIGN KEY (business_id) REFERENCES Business,
FOREIGN KEY (user_id) REFERENCES Users
);

CREATE TABLE Payment(
payment_id DECIMAL(12) NOT NULL,	
ad_id DECIMAL(12) NOT NULL,
payment_method DECIMAL(15) NOT NULL,
billing_address VARCHAR(255) NOT NULL,
FOREIGN KEY (ad_id) REFERENCES Advertisement
);

CREATE TABLE Service(
ad_id DECIMAL(12) NOT NULL,
service_url VARCHAR(255) NOT NULL,
PRIMARY KEY (ad_id),
FOREIGN KEY (ad_id) REFERENCES Advertisement
);

CREATE TABLE Product(
ad_id DECIMAL(12) NOT NULL,
product_url VARCHAR(255) NOT NULL,
PRIMARY KEY (ad_id),
FOREIGN KEY (ad_id) REFERENCES Advertisement
);

CREATE TABLE Education(
ad_id DECIMAL(12) NOT NULL,
education_url VARCHAR(255) NOT NULL,
PRIMARY KEY (ad_id),
FOREIGN KEY (ad_id) REFERENCES Advertisement
);

CREATE TABLE Public(
user_id DECIMAL(12) NOT NULL,
is_public BOOLEAN NOT NULL,
PRIMARY KEY (user_id),
FOREIGN KEY (user_id) REFERENCES Users
);

CREATE TABLE Private(
user_id DECIMAL(12) NOT NULL,
is_private BOOLEAN NOT NULL,
PRIMARY KEY (user_id),
FOREIGN KEY (user_id) REFERENCES Users
);

CREATE TABLE Entry(
entry_id DECIMAL(12) NOT NULL,
user_id DECIMAL(12) NOT NULL,
entry_date DATE,
PRIMARY KEY (entry_id),
FOREIGN KEY (user_id) REFERENCES Users
);

CREATE TABLE Journal(
journal_id DECIMAL(12) NOT NULL,
entry_id DECIMAL(12) NOT NULL,
feeling VARCHAR(255) NOT NULL,
activity VARCHAR(255) NOT NULL,
moment VARCHAR(255) NOT NULL,
gratitude VARCHAR(255) NOT NULL,
plan VARCHAR(255) NOT NULL,
PRIMARY KEY (journal_id),
FOREIGN KEY (entry_id) REFERENCES Entry
);

CREATE TABLE Rating(
rating_id DECIMAL(12) NOT NULL,
entry_id DECIMAL(12) NOT NULL,
rating_scale DECIMAL (1) CHECK (rating_scale BETWEEN 1 AND 5) NOT NULL,
PRIMARY KEY (rating_id),
FOREIGN KEY (entry_id) REFERENCES Entry
);

--SEQUENCES
--Replace this with your sequence creations.
CREATE SEQUENCE users_seq START WITH 1;
CREATE SEQUENCE business_seq START WITH 1;
CREATE SEQUENCE advertisement_seq START WITH 1;
CREATE SEQUENCE payment_seq START WITH 1;
CREATE SEQUENCE service_seq START WITH 1;
CREATE SEQUENCE product_seq START WITH 1;
CREATE SEQUENCE education_seq START WITH 1;
CREATE SEQUENCE public_seq START WITH 1;
CREATE SEQUENCE private_seq START WITH 1;
CREATE SEQUENCE entry_seq START WITH 1;
CREATE SEQUENCE journal_seq START WITH 1;
CREATE SEQUENCE rating_seq START WITH 1;
   
