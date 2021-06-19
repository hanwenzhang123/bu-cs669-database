CREATE TABLE Party (
party_id DECIMAL(12) NOT NULL PRIMARY KEY,
number_in_party DECIMAL(3) NOT NULL,
party_name VARCHAR(64));

CREATE TABLE Meal_date (
meal_date_id DECIMAL(12) NOT NULL PRIMARY KEY,
meal_date DATE NOT NULL,
year DECIMAL(4) NOT NULL,
month DECIMAL(2) NOT NULL,
day_of_month DECIMAL(2) NOT NULL);

CREATE TABLE Menu_item (
menu_item_id DECIMAL(12) NOT NULL PRIMARY KEY,
item_category VARCHAR(32) NOT NULL,
item_name VARCHAR(32) NOT NULL,
item_price DECIMAL(6,2));

CREATE TABLE Menu_item_selection (
party_id DECIMAL(12) NOT NULL,
meal_date_id DECIMAL(12) NOT NULL,
menu_item_id DECIMAL(12) NOT NULL,
FOREIGN KEY (party_id) REFERENCES Party(party_id),
FOREIGN KEY (meal_date_id) REFERENCES Meal_date(meal_date_id),
FOREIGN KEY (menu_item_id) REFERENCES Menu_item(menu_item_id));


CREATE TABLE Restaurant(
restaurant_id DECIMAL(12),
restaurant_name VARCHAR(64),
location VARCHAR(64),
address VARCHAR(128),
PRIMARY KEY (restaurant_id));

ALTER TABLE Party
ADD restaurant_id DECIMAL(12),
ADD CONSTRAINT restaurant_id_fk
FOREIGN KEY (restaurant_id) 
REFERENCES Restaurant(restaurant_id);


ALTER TABLE Party
ADD satisfaction DECIMAL(1) CHECK (satisfaction BETWEEN 1 AND 5);

ALTER TABLE Restaurant
DROP CONSTRAINT FK_party_id;

ALTER TABLE Party
DROP CONSTRAINT restaurant_id_fk;

DROP TABLE Restaurant

SELECT * From Party;

SELECT * From Restaurant;


CREATE SEQUENCE party_seq START WITH 1;
CREATE SEQUENCE restaurant_seq START WITH 1;

CREATE OR REPLACE FUNCTION AddInformation(
	  party_id IN DECIMAL, restaurant_id IN DECIMAL, number_in_party IN DECIMAL, party_name IN VARCHAR, 
	satisfaction IN DECIMAL, restaurant_name IN VARCHAR, location IN VARCHAR, address IN VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Restaurant(restaurant_id, restaurant_name, location, address)
  VALUES(nextval('restaurant_seq'), restaurant_name, location, address);
  
  INSERT INTO Party(party_id, restaurant_id, number_in_party, party_name, satisfaction)
  VALUES(nextval('party_seq'), currval('restaurant_seq'), number_in_party, party_name, satisfaction);		 
END;
$proc$ LANGUAGE plpgsql


START TRANSACTION;
DO
 $$BEGIN
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 2, 'Amy', 5, 'Yummy Town', 'Miami', '123 main street, FL 33101');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 1, 'Bryan', 3, 'Ramen House', 'Pittsburgh', '123 main street, PA 15106');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 3, 'Charles', 5, 'Pizza Lover', 'New York', '123 main street, NY, 10001');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 2, 'David', 4, 'Happy Food', 'New York', '123 main street, NY, 10001');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 4, 'Edison', 3, 'Food Town', 'Los Angeles', '123 main street, CA 90001');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 2, 'Frank', 2, 'Food Mall', 'El Paso', '123 main street, TX 79936');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 3, 'Giorgio', 1, 'Yummy Happy', 'Los Angeles', '123 main street, CA 90001');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 3, 'Helen', 5, 'Chicken Lover', 'New York', '123 main street, NY, 10001');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 5, 'Ivy', 1, 'Burger Place', 'Los Angeles', '123 main street, CA 90001');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 4, 'Jason', 3, 'Delicious', 'Chicago', '123 main street, IL 60629');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 2, 'Kevin', 4, 'Happy Meal', 'Miami', '123 main street, FL 33101');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 3, 'Lisa', 5, 'Food Lover', 'New York', '123 main street, NY, 10001');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 1, 'Mary', 1, 'Food House', 'Savannah', '123 main street, GA 31302');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 5, 'Nancy', 2, 'Yummy Food', 'Portland', '123 main street, OR 97035');
EXECUTE AddInformation(nextval('party_seq'), nextval('restaurant_seq'), 2, 'Peter', 3, 'Hot Dog Stand', 'Chicago', '123 main street, IL 60629');
END$$;
COMMIT TRANSACTION;

SELECT * FROM Restaurant;
SELECT * FROM Party;

DELETE FROM Party;
DELETE FROM Restaurant;

ALTER SEQUENCE party_seq RESTART WITH 1;
ALTER SEQUENCE restaurant_seq RESTART WITH 1;


SELECT   Restaurant.location, SUM(satisfaction) AS total_satisfaction
FROM     Party
JOIN     Restaurant ON Restaurant.restaurant_id = Party.restaurant_id
GROUP BY ROLLUP(satisfaction), Restaurant.location
ORDER BY total_satisfaction DESC;
