Horizontal fragments divide the table by row; 
vertical fragments divide the table by column; 
mixed fragments divide the table by row and column.

CREATE TABLE Profile(
person_id DECIMAL(12) NOT NULL,
first_name VARCHAR(32) NOT NULL,
last_name VARCHAR(32) NOT NULL,
username VARCHAR(20) NOT NULL,
birthday DATE NOT NULL,
four_digit_pin	DECIMAL(4) NOT NULL,
PRIMARY KEY (person_id));

CREATE SEQUENCE profile_seq START WITH 1;

INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Allan', 'Smith', 'allansmith123', '08-08-1980', 1234);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Bryan', 'Brown', 'bryanbrown123', '08-08-1981', 5678);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Charles', 'Williams', 'charleswilliams123', '08-08-1982', 2345);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'David', 'Johnson', 'davidjohnson123', '08-08-1983', 6789);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Elan', 'Garcia', 'bryanbrown123', '08-08-1984', 3456);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Frank', 'Davis', 'frankdavis123', '08-08-1985', 4567);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Giorgio', 'Rodriguez', 'giorgiorodriguez123', '08-08-1986', 7890);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Helen', 'Miller', 'helenmiller123', '08-08-1994', 1123);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Ivy', 'Jones', 'ivyjones123', '08-08-1988', 2468);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Jordon', 'Hernandez', 'jordonhernandez123', '08-08-1991', 1357);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Kevin', 'Wilson', 'kevinwilson123', '08-08-1993', 3579);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Lisa', 'Jackson', 'lisajackson123', '08-08-1992', 4680);

SELECT * FROM Profile;


DROP TABLE Profile;
DROP SEQUENCE profile_seq;
ALTER SEQUENCE profile_seq RESTART WITH 1;

DROP VIEW born_in_80s;
DROP VIEW born_in_90s;


CREATE OR REPLACE VIEW born_in_80s AS
SELECT * 
FROM Profile
WHERE birthday < '01-01-1990';

SELECT * FROM born_in_80s;


CREATE OR REPLACE VIEW born_in_90s AS
SELECT * 
FROM Profile
WHERE birthday > '01-01-1990';

SELECT * FROM born_in_90s;


CREATE OR REPLACE VIEW pin_0000_5000 AS
SELECT * 
FROM Profile
WHERE four_digit_pin <= 5000;

SELECT * FROM pin_0000_5000;


SELECT * FROM born_in_80s
UNION
SELECT * FROM born_in_90s
UNION
SELECT * FROM pin_0000_5000;


CREATE OR REPLACE VIEW fullname_birthday AS
SELECT last_name || ', ' || first_name AS full_name, birthday
FROM Profile;

SELECT * FROM fullname_birthday;


CREATE OR REPLACE VIEW name_birthday AS
SELECT first_name, last_name, birthday
FROM Profile;

SELECT * FROM name_birthday;


CREATE OR REPLACE VIEW username_pin AS
SELECT username, four_digit_pin
FROM Profile;

SELECT * FROM username_pin;


CREATE OR REPLACE VIEW fullname AS
SELECT first_name, last_name
FROM Profile;

SELECT * FROM fullname;


CREATE OR REPLACE VIEW username_all AS
SELECT first_name, username
FROM Profile;

SELECT * FROM username_all;


SELECT * FROM name_birthday
UNION ALL
SELECT * FROM username_pin;
