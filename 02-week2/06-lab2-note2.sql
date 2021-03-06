Section Two – Expressing Data

Step 8 – Formatting as Money

DROP TABLE Meal;
DROP TABLE Restaurant;

CREATE TABLE Restaurant (
restaurant_id DECIMAL(12) PRIMARY KEY,
name VARCHAR(64) NOT NULL
);

CREATE TABLE Meal (
meal_nr DECIMAL(12) NOT NULL,
description VARCHAR(255) NOT NULL,
date_served DATE NOT NULL,
price_paid DECIMAL(8,2) NOT NULL,
restaurant_id DECIMAL(12)
);

ALTER TABLE Meal
ADD CONSTRAINT meal_pk
PRIMARY KEY(meal_nr);

ALTER TABLE Meal
ADD CONSTRAINT meal_restaurant_fk
FOREIGN KEY(restaurant_id)
REFERENCES Restaurant(restaurant_id);

INSERT INTO Restaurant (restaurant_id, name)
VALUES (31, 'Sunset Grill');
INSERT INTO Restaurant (restaurant_id, name)
VALUES (32, 'Oceanside Beachview');

INSERT INTO Meal (meal_nr, description, date_served, price_paid, restaurant_id)
VALUES (101, 'Grilled eggplant with sides', CAST('03‐Jul‐2012' AS DATE), 20.99, 31);
INSERT INTO Meal (meal_nr, description, date_served, price_paid, restaurant_id)
VALUES(102, 'Delicious pizza with salad', CAST('09‐Jul‐2012' AS DATE), 14.50, 31);
INSERT INTO Meal (meal_nr, description, date_served, price_paid, restaurant_id)
VALUES(103, 'Five‐course luxurious meal', CAST('13‐Jul‐2012' AS DATE), 65.00, NULL);


Component 1: Raw Values


Component 2: Manipulations on the Value

CREATE TABLE Example100 (num DECIMAL(3));
INSERT INTO Example100 (num) VALUES (100);

SELECT Example100.num * 10.001
FROM   Example100;


Component 3: Formatting Constructs
//the first argument to format is the number and the second argument is a series of characters that describes how we want to format the number

//Oracle/Postgres - to_char()
SELECT to_char(100, $999.99);   //the initial three “9” digits indicate three digits to the left of the decimal point; last two “9” digits indicate we want to display two digits to the right of the decimal point.
//SQL Server  - format()
SELECT format(100, $.00);


Component 4: SQL Client Choices


Step 9 – Using Expressions
  
  
Step 10 – Advanced Formatting
the expression “1 || ‘ at a time’” in oracle will produce a result of “1 at a time”, as shown below.  
  
