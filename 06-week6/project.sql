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
price DECIMAL (7, 2) NOT NULL,
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

CREATE TABLE Transaction(
ad_id DECIMAL(12) NOT NULL,
user_id DECIMAL(12) NOT NULL,
FOREIGN KEY (ad_id) REFERENCES Advertisement,
FOREIGN KEY (user_id) REFERENCES Users
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


--INDEXES
--Replace this with your index creations.
CREATE INDEX AdRequest
ON Advertisement(business_id);

CREATE INDEX DateEntry
ON Entry(entry_date);

CREATE INDEX AdType
ON Advertisement(advertising_type);

CREATE INDEX AdReqOn
ON Advertisement(requested_on);


--STORED PROCEDURES
--Replace this with your stored procedure definitions.
CREATE OR REPLACE FUNCTION AddNewPublicUser(
	  user_id IN DECIMAL, username IN VARCHAR, first_name IN VARCHAR, last_name IN VARCHAR, 
	  user_email IN VARCHAR, pronouns IN VARCHAR, birthday IN DATE, setting IN CHAR, is_public IN BOOLEAN)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Users(user_id, username, first_name, last_name, user_email, pronouns, birthday, setting)
  VALUES(nextval('user_seq'), username, first_name, last_name, user_email, pronouns, birthday, 'y');

  INSERT INTO Public(user_id, is_public)
  VALUES(currval('user_seq'), 'true');
END;
$proc$ LANGUAGE plpgsql


START TRANSACTION;

DO
 $$BEGIN
   EXECUTE AddNewPublicUser(nextval('user_seq'), 'allansmith123', 'Allan', 'Smith', 'allansmith123@gmail.com', 'he/him/his', '08-08-1980');
   EXECUTE AddNewPublicUser(nextval('user_seq'), 'bryanbrown123', 'Bryan', 'Brown', 'bryanbrown123@gmail.com', 'he/him/his', '08-08-1981');
   EXECUTE AddNewPublicUser(nextval('user_seq'), 'charleswilliams123', 'Charles', 'Williams', 'charleswilliams123@gmail.com', 'he/him/his', '08-08-1982');
   EXECUTE AddNewPublicUser(nextval('user_seq'), 'davidjohnson123', 'David', 'Johnson', 'davidjohnson123@gmail.com', 'he/him/his', '08-08-1983');
   EXECUTE AddNewPublicUser(nextval('user_seq'), 'helenmiller123', 'Helen', 'Miller', 'helenmiller123@gmail.com', 'she/her/hers', '08-08-1994');
END$$;

COMMIT TRANSACTION;


CREATE OR REPLACE FUNCTION AddNewPrivateUser(
	  user_id IN DECIMAL, username IN VARCHAR, first_name IN VARCHAR, last_name IN VARCHAR, 
	  user_email IN VARCHAR, pronouns IN VARCHAR, birthday IN DATE, setting IN CHAR, is_private IN BOOLEAN)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Users(user_id, username, first_name, last_name, user_email, pronouns, birthday, setting)
  VALUES(nextval('user_seq'), username, first_name, last_name, user_email, pronouns, birthday, 'n');

  INSERT INTO Private(user_id, is_private)
  VALUES(currval('user_seq'), 'true');
END;
$proc$ LANGUAGE plpgsql


START TRANSACTION;

DO
 $$BEGIN
   EXECUTE AddNewPrivateUser(nextval('user_seq'), 'elangarcia123', 'Elan', 'Garcia', 'elangarcia123@gmail.com', 'he/him/his', '08-08-1984');
   EXECUTE AddNewPrivateUser(nextval('user_seq'), 'frankdavis123', 'Frank', 'Davis', 'frankdavis123@gmail.com', 'he/him/his', '08-08-1985');
   EXECUTE AddNewPrivateUser(nextval('user_seq'), 'jordonhernandez123', 'Jordon', 'Hernandez', 'jordonhernandez123@gmail.com', 'he/him/his', '08-08-1991');
   EXECUTE AddNewPrivateUser(nextval('user_seq'), 'kevinwilson123', 'Kevin', 'Wilson', 'kevinwilson123@gmail.com', 'he/him/his', '08-08-1993');
   EXECUTE AddNewPrivateUser(nextval('user_seq'), 'lisajackson123', 'Lisa', 'Jackson', 'lisajackson123@gmail.com', 'she/her/hers', '08-08-1992');
END$$;

COMMIT TRANSACTION;


SELECT * FROM USERS;
SELECT * FROM Public;
SELECT * FROM Private;

		 
CREATE OR REPLACE FUNCTION SelfcareJournalEntry(
	entry_id IN DECIMAL, user_id IN DECIMAL, entry_date IN DATE, journal_id IN DECIMAL, 
	feeling IN VARCHAR, activity IN VARCHAR, moment IN VARCHAR, gratitude IN VARCHAR, 
	plan IN VARCHAR, rating_id in DECIMAL, rating_scale in DECIMAL)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Entry(entry_id, user_id, entry_date)
  VALUES(nextval('entry_seq'), currval('user_seq'), entry_date);
		 
  INSERT INTO Journal(journal_id, entry_id, feeling, activity, moment, gratitude, plan)
  VALUES(nextval('journal_seq'), currval('entry_seq'), feeling, activity, moment, gratitude, plan);
		 
  INSERT INTO Rating(rating_id, entry_id, rating_scale)
  VALUES(nextval('rating_seq'), currval('entry_seq'), rating_scale);
END;
$proc$ LANGUAGE plpgsql


START TRANSACTION;

DO
 $$BEGIN
EXECUTE SelfcareJournalEntry(nextval('entry_seq'), currval('user_seq'), '06-01-2021', nextval('journal_seq'), 'I feel good today', 'I praticed yoga', 'When I feel refreshed after yoga', 'Peaceful world', 'Eat sushi tomorrow', 1, 5);
EXECUTE SelfcareJournalEntry(nextval('entry_seq'), currval('user_seq'), '05-01-2021', nextval('journal_seq'), 'I am a bit tired today', 'Nothing much, just work', 'When I finish my work', 'Tomorrow is Friday', 'Happy hour after work', 2, 2);
EXECUTE SelfcareJournalEntry(nextval('entry_seq'), currval('user_seq'), '05-21-2021', nextval('journal_seq'), 'Excited!!!', 'I won lottery', 'When I know I won the loterry', 'Money', 'Spend money', 3, 5);
EXECUTE SelfcareJournalEntry(nextval('entry_seq'), currval('user_seq'), '06-12-2021', nextval('journal_seq'), 'Just so so', 'Nothing, did housework', 'When I finished the housework', 'Organized room', 'Go for grocery shopping', 4, 3);
EXECUTE SelfcareJournalEntry(nextval('entry_seq'), currval('user_seq'), '04-08-2020', nextval('journal_seq'), 'I am okay', 'I ran', 'When I sweat', 'Being healthy', 'Running more', 5, 4);
EXECUTE SelfcareJournalEntry(nextval('entry_seq'), currval('user_seq'), '02-20-2020', nextval('journal_seq'), 'Happy', 'I finished my homework', 'The moment I clicked submit', 'Education', 'Study for the new chapter', 6, 4);
EXECUTE SelfcareJournalEntry(nextval('entry_seq'), currval('user_seq'), '06-10-2021', nextval('journal_seq'), 'I feel fine', 'Just work as usual', 'My lunch was really yummy', 'Foods', 'Eat more food', 7, 5);
EXECUTE SelfcareJournalEntry(nextval('entry_seq'), currval('user_seq'), '06-06-2021', nextval('journal_seq'), 'I am sad', 'I broke up', 'Nope', 'I am still alive', 'Stay home and recharge', 8, 1);
EXECUTE SelfcareJournalEntry(nextval('entry_seq'), currval('user_seq'), '06-08-2020', nextval('journal_seq'), 'Average', 'Just stayed home binge watching Netflix', 'When I finished the show', 'Good movie', 'Watch more tomorrow', 9, 3);
EXECUTE SelfcareJournalEntry(nextval('entry_seq'), currval('user_seq'), '08-01-2020', nextval('journal_seq'), 'An awful day', 'I lost my wallet', 'Nothing', 'People helping me and comfort me', 'Find my wallet', 10, 1);
END$$;

COMMIT TRANSACTION;


SELECT * FROM Entry;
SELECT * FROM Journal;
SELECT * FROM Rating;


CREATE OR REPLACE FUNCTION AddNewBusiness(
	business_id IN DECIMAL, accountname IN VARCHAR, business_name IN VARCHAR, phone_number IN DECIMAL, 
	primary_contact IN VARCHAR, business_email IN VARCHAR, business_website IN VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Business(business_id, accountname, business_name, phone_number, primary_contact, business_email, business_website)
  VALUES(nextval('business_seq'), accountname, business_name, phone_number, primary_contact, business_email, business_website);
END;
$proc$ LANGUAGE plpgsql


START TRANSACTION;

DO
 $$BEGIN
 EXECUTE AddNewBusiness(nextval('business_seq'), 'saferselfcare', 'Safer Selfcare', 1234567890, 'Sarah Chen', 'saferselfcare@gmail.com', 'saferselfcare.com');
 EXECUTE AddNewBusiness(nextval('business_seq'), 'youarecountable', 'You Are Countable', 2345678901, 'Jimmy James', 'youarecountable@gmail.com', 'youarecountable.com');
 EXECUTE AddNewBusiness(nextval('business_seq'), 'lovemyself', 'Love Myself', 3456789012, 'Susan Garcia', 'lovemyself@gmail.com', 'lovemyself.com');
 EXECUTE AddNewBusiness(nextval('business_seq'), 'heartselfcare', 'Heart Selfcare', 4561237890, 'Daisy Lee', 'heartselfcare@gmail.com', 'heartselfcare.com');
 EXECUTE AddNewBusiness(nextval('business_seq'), 'sunshineup', 'Sunshine Up', 7894561230, 'Sean Perez', 'sunshineup@gmail.com', 'sunshineup.com');
 EXECUTE AddNewBusiness(nextval('business_seq'), 'smile100up', 'Smile 100 Up', 4567891230, 'Cherry Hall', 'smile100up@gmail.com', 'smile100up.com');
 EXECUTE AddNewBusiness(nextval('business_seq'), 'mentalwellness', 'Mental Wellness', 1824567390, 'Jack Walker', 'mentalwellness@gmail.com', 'mentalwellness.com');
 EXECUTE AddNewBusiness(nextval('business_seq'), 'happylocator', 'Happy Locator', 2135468790, 'Richard Lewis', 'happylocator@gmail.com', 'happylocator.com');
 EXECUTE AddNewBusiness(nextval('business_seq'), 'selfcarelab', 'Selfcare Lab', 1324657980, 'Elsa Robinson', 'selfcarelab@gmail.com', 'selfcarelab.com');
 EXECUTE AddNewBusiness(nextval('business_seq'), 'mentaltoolbox', 'Mental Toolbox', 3126457980, 'Alma Clark', 'mentaltoolbox@gmail.com', 'mentaltoolbox.com');
 END$$;

COMMIT TRANSACTION;


SELECT * FROM Business;


CREATE OR REPLACE FUNCTION AddNewAd(
	  ad_id IN DECIMAL, business_id IN DECIMAL, requested_on IN DATE, price IN DECIMAL, advertising_type IN VARCHAR, advertising_plan IN TEXT,
	  payment_id IN DECIMAL, payment_method IN DECIMAL, billing_address IN VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Advertisement(ad_id, business_id, requested_on, price, advertising_type, advertising_plan)
  VALUES(nextval('advertisement_seq'), business_id, requested_on, price, advertising_type, advertising_plan);
		 
  INSERT INTO Payment(payment_id, ad_id, payment_method, billing_address)
  VALUES(nextval('payment_seq'), currval('advertisement_seq'), payment_method, billing_address);
END;
$proc$ LANGUAGE plpgsql


START TRANSACTION;

DO
 $$BEGIN
 	EXECUTE AddNewAd(nextval('advertisement_seq'), 2, '06-06-2020', '100', 'counseling services', 'sending my counseling service to the user daily including my personal link, contact information and occasional promotions',
	 	nextval('payment_seq'), 123456789012345, '123 main street, New York, NY 10001');
	EXECUTE AddNewAd(nextval('advertisement_seq'), 10, '09-06-2020', '50', 'e-commerce', 'distributing my product links twice a day',
		nextval('payment_seq'), 234567890123456, '123 main street, Los Angeles, CA 90001');
	EXECUTE AddNewAd(nextval('advertisement_seq'), 7, '08-06-2020', '29', 'counseling services', 'sending my personal link, contact information and occasional promotions',
		nextval('payment_seq'), 345678901234567, '123 main street, El Paso, TX 79936');
	EXECUTE AddNewAd(nextval('advertisement_seq'), 9, '10-06-2020', '88', 'education', 'daily institional news and study tips to current users',
		nextval('payment_seq'), 456789012345678, '123 main street, Chicago, IL 60629');
	EXECUTE AddNewAd(nextval('advertisement_seq'), 4, '02-06-2021', '64', 'counseling services', 'I will be the best therapy for you, please contact me',
		nextval('payment_seq'), 567890123456789, '123 main street, Brooklyn, NY 90011');
	EXECUTE AddNewAd(nextval('advertisement_seq'), 1, '03-06-2021', '73', 'counseling services', 'Going through a difficult time, I have been there, let is talk',
		nextval('payment_seq'), 678901234567890, '123 main street, Portland, OR 97035');
	EXECUTE AddNewAd(nextval('advertisement_seq'), 8, '05-06-2021', '20', 'counseling services', 'Trying to find your lost happiness? I get it for you',
		nextval('payment_seq'), 246801357901234, '123 main street, Savannah, GA 31302');
	EXECUTE AddNewAd(nextval('advertisement_seq'), 3, '06-06-2021', '99', 'e-commerce', 'All you need for your wellness is this massage gun that make you stress free',
		nextval('payment_seq'), 135792468012345, '123 main street, Miami, FL 33101');
	EXECUTE AddNewAd(nextval('advertisement_seq'), 5, '04-06-2021', '61', 'education', 'sharing the knowledge that anxiety and stress are big issues for those suffering',
		nextval('payment_seq'), 567890987654321, '123 main street, Pittsburgh, PA 15106');
	EXECUTE AddNewAd(nextval('advertisement_seq'), 2, '07-06-2020', '38', 'e-commerce', 'I designed this pillow is dedicated for your comfort and sleep quality',
		nextval('payment_seq'), 123456789012345, '123 main street, New York, NY 10001');
 END$$;

COMMIT TRANSACTION;


SELECT * FROM Advertisement;
SELECT * FROM Payment;


INSERT INTO Transaction(ad_id, user_id)
VALUES(1, 1);
INSERT INTO Transaction(ad_id, user_id)
VALUES(1, 2);
INSERT INTO Transaction(ad_id, user_id)
VALUES(1, 3);
INSERT INTO Transaction(ad_id, user_id)
VALUES(1, 4);
INSERT INTO Transaction(ad_id, user_id)
VALUES(1, 5);
INSERT INTO Transaction(ad_id, user_id)
VALUES(2, 6);
INSERT INTO Transaction(ad_id, user_id)
VALUES(2, 7);
INSERT INTO Transaction(ad_id, user_id)
VALUES(2, 8);
INSERT INTO Transaction(ad_id, user_id)
VALUES(2, 9);
INSERT INTO Transaction(ad_id, user_id)
VALUES(2, 10);
INSERT INTO Transaction(ad_id, user_id)
VALUES(3, 1);
INSERT INTO Transaction(ad_id, user_id)
VALUES(3, 2);
INSERT INTO Transaction(ad_id, user_id)
VALUES(3, 3);
INSERT INTO Transaction(ad_id, user_id)
VALUES(3, 4);
INSERT INTO Transaction(ad_id, user_id)
VALUES(3, 5);
INSERT INTO Transaction(ad_id, user_id)
VALUES(4, 1);
INSERT INTO Transaction(ad_id, user_id)
VALUES(4, 2);
INSERT INTO Transaction(ad_id, user_id)
VALUES(4, 3);
INSERT INTO Transaction(ad_id, user_id)
VALUES(4, 4);
INSERT INTO Transaction(ad_id, user_id)
VALUES(4, 5);
INSERT INTO Transaction(ad_id, user_id)
VALUES(6, 1);
INSERT INTO Transaction(ad_id, user_id)
VALUES(6, 2);
INSERT INTO Transaction(ad_id, user_id)
VALUES(6, 3);
INSERT INTO Transaction(ad_id, user_id)
VALUES(6, 4);
INSERT INTO Transaction(ad_id, user_id)
VALUES(6, 5);
INSERT INTO Transaction(ad_id, user_id)
VALUES(5, 6);
INSERT INTO Transaction(ad_id, user_id)
VALUES(5, 7);
INSERT INTO Transaction(ad_id, user_id)
VALUES(5, 8);
INSERT INTO Transaction(ad_id, user_id)
VALUES(5, 9);
INSERT INTO Transaction(ad_id, user_id)
VALUES(5, 10);
INSERT INTO Transaction(ad_id, user_id)
VALUES(7, 6);
INSERT INTO Transaction(ad_id, user_id)
VALUES(7, 7);
INSERT INTO Transaction(ad_id, user_id)
VALUES(7, 8);
INSERT INTO Transaction(ad_id, user_id)
VALUES(7, 9);
INSERT INTO Transaction(ad_id, user_id)
VALUES(7, 10);
INSERT INTO Transaction(ad_id, user_id)
VALUES(10, 6);
INSERT INTO Transaction(ad_id, user_id)
VALUES(10, 7);
INSERT INTO Transaction(ad_id, user_id)
VALUES(10, 8);
INSERT INTO Transaction(ad_id, user_id)
VALUES(10, 9);
INSERT INTO Transaction(ad_id, user_id)
VALUES(10, 10);
INSERT INTO Transaction(ad_id, user_id)
VALUES(8, 3);
INSERT INTO Transaction(ad_id, user_id)
VALUES(8, 4);
INSERT INTO Transaction(ad_id, user_id)
VALUES(8, 5);
INSERT INTO Transaction(ad_id, user_id)
VALUES(8, 6);
INSERT INTO Transaction(ad_id, user_id)
VALUES(8, 7);
INSERT INTO Transaction(ad_id, user_id)
VALUES(9, 9);
INSERT INTO Transaction(ad_id, user_id)
VALUES(9, 10);
INSERT INTO Transaction(ad_id, user_id)
VALUES(9, 5);
INSERT INTO Transaction(ad_id, user_id)
VALUES(9, 1);
INSERT INTO Transaction(ad_id, user_id)
VALUES(9, 2);

SELECT * FROM Transaction;	--50 entries


--QUERIES
--Replace this with your queries (including any queries used for data visualizations).
SELECT Business.accountname AS Business, Users.username AS User
FROM Advertisement
JOIN Business ON Business.business_id = Advertisement.business_id
			AND Advertisement.advertising_type = 'e-commerce'
JOIN Transaction ON Transaction.ad_id = Advertisement.ad_id
JOIN Users ON Users.user_id = Transaction.user_id;


SELECT DISTINCT Users.username AS User
FROM Users
JOIN Public ON Users.user_id = Public.user_id
			AND Public.is_public = 'true'
JOIN Entry ON Users.user_id = Entry.user_id
			AND Entry.entry_date > CURRENT_DATE - INTERVAL '6 months'

				
SELECT COUNT(DISTINCT Users.user_id) AS high_functional_user_count
FROM Users
JOIN Entry ON Users.user_id = Entry.user_id
JOIN Rating ON Entry.entry_id = Rating.entry_id
			AND Rating.rating_scale >= 4
			AND Entry.entry_date > CURRENT_DATE - INTERVAL '3 months'
WHERE Users.user_id IN 
	(SELECT Users.user_id
	FROM Users
	JOIN Transaction ON Transaction.user_id = Users.user_id
	JOIN Advertisement on Advertisement.ad_id = Transaction.ad_id
				AND Advertisement.advertising_type = 'education'
				AND Advertisement.requested_on > CURRENT_DATE - INTERVAL '6 months');
				
				
--TRIGGERS
--Replace this with your history table trigger.
CREATE TABLE RequestHistory(
history_id DECIMAL(12) NOT NULL,
ad_id DECIMAL(12) NOT NULL,
last_request_date DATE NOT NULL,
new_request_date DATE NOT NULL,
last_price DECIMAL(7, 2) NOT NULL,
new_price DECIMAL(7, 2) NOT NULL,
PRIMARY KEY (history_id),
FOREIGN KEY (ad_id) REFERENCES Advertisement
);

CREATE SEQUENCE history_seq START WITH 1;


CREATE OR REPLACE FUNCTION RequestChangeFunction()
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$
  BEGIN
   INSERT INTO RequestHistory(history_id, ad_id, last_request_date, new_request_date, last_price, new_price)
   VALUES(nextval('history_seq'),
		  NEW.ad_id,
          OLD.requested_on,
          current_date,
          OLD.price,
		  NEW.price);
RETURN NEW;
  END;
$trigfunc$;
CREATE TRIGGER RequestChange
BEFORE UPDATE OF price ON Advertisement
FOR EACH ROW
EXECUTE PROCEDURE RequestChangeFunction();

SELECT * FROM Advertisement;


UPDATE Advertisement
SET price = 95
WHERE ad_id = 1;

UPDATE Advertisement
SET price = 77
WHERE ad_id = 2;

UPDATE Advertisement
SET price = 47
WHERE ad_id = 3;

UPDATE Advertisement
SET price = 65
WHERE ad_id = 4;

UPDATE Advertisement
SET price = 88
WHERE ad_id = 5;

SELECT * FROM RequestHistory;


--Data Visualizations
--story 1
SELECT business_name, to_char(Advertisement.price, '$999.99') AS price
FROM Business
JOIN Advertisement on Advertisement.business_id = Business.business_id
ORDER BY Advertisement.price DESC;

--story2
SELECT
	CASE 
		WHEN Advertisement.price >= 20 AND Advertisement.price < 40 THEN '$20-$39'
		WHEN Advertisement.price >= 40 AND Advertisement.price < 60 THEN '$40-$59'
		WHEN Advertisement.price >= 60 AND Advertisement.price < 80 THEN '$60-$79'
		WHEN Advertisement.price >= 80 AND Advertisement.price < 100 THEN '$80-$99'
		ELSE '$100+'
	END As Category,
	COUNT (*) as Numbers
FROM Business
JOIN Advertisement on Advertisement.business_id = Business.business_id
GROUP BY 	CASE 
		WHEN Advertisement.price >= 20 AND Advertisement.price < 40 THEN '$20-$39'
		WHEN Advertisement.price >= 40 AND Advertisement.price < 60 THEN '$40-$59'
		WHEN Advertisement.price >= 60 AND Advertisement.price < 80 THEN '$60-$79'
		WHEN Advertisement.price >= 80 AND Advertisement.price < 100 THEN '$80-$99'
		ELSE '$100+'
	END
ORDER BY category;