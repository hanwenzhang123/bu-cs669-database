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
VALUES(nextval('profile_seq'), 'Allan', 'Smith', 'allansmith123', '08-08-1980', 0001);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Bryan', 'Brown', 'bryanbrown123', '08-08-1981', 0002);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Charles', 'Williams', 'charleswilliams123', '08-08-1982', 0003);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'David', 'Johnson', 'davidjohnson123', '08-08-1983', 0004);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Elan', 'Garcia', 'bryanbrown123', '08-08-1984', 0005);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Frank', 'Davis', 'frankdavis123', '08-08-1985', 0006);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Giorgio', 'Rodriguez', 'frankdavis123', '08-08-1986', 0007);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Helen', 'Miller', 'frankdavis123', '08-08-1987', 0008);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Ivy', 'Jones', 'frankdavis123', '08-08-1988', 0009);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Jordon', 'Hernandez', 'frankdavis123', '08-08-1989', 0010);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Kevin', 'Wilson', 'frankdavis123', '08-08-1990', 0011);
INSERT INTO Profile
VALUES(nextval('profile_seq'), 'Lisa', 'Jackson', 'frankdavis123', '08-08-1992', 0012);

SELECT * FROM Profile;

DROP SEQUENCE profile_seq;
ALTER SEQUENCE profile_seq RESTART WITH 1;

DROP TABLE Profile;
