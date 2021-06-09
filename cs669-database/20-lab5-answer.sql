DROP TABLE Sells;
DROP TABLE Offers;
DROP TABLE Store_location;
DROP TABLE Alternate_name;
DROP TABLE Product;
DROP TABLE Currency;
DROP TABLE Shipping_offering;

CREATE TABLE Currency (
currency_id DECIMAL(12) NOT NULL PRIMARY KEY,
currency_name VARCHAR(255) NOT NULL,
us_dollars_to_currency_ratio DECIMAL(12,2) NOT NULL);

CREATE TABLE Store_location (
store_location_id DECIMAL(12) NOT NULL PRIMARY KEY,
store_name VARCHAR(255) NOT NULL,
currency_accepted_id DECIMAL(12) NOT NULL);

CREATE TABLE Product (
product_id DECIMAL(12) NOT NULL PRIMARY KEY,
product_name VARCHAR(255) NOT NULL,
price_in_us_dollars DECIMAL(12,2) NOT NULL);

CREATE TABLE Sells (
sells_id DECIMAL(12) NOT NULL PRIMARY KEY,
product_id DECIMAL(12) NOT NULL,
store_location_id DECIMAL(12) NOT NULL);

CREATE TABLE Shipping_offering (
shipping_offering_id DECIMAL(12) NOT NULL PRIMARY KEY,
offering VARCHAR(255) NOT NULL);

CREATE TABLE Offers (
offers_id DECIMAL(12) NOT NULL PRIMARY KEY,
store_location_id DECIMAL(12) NOT NULL,
shipping_offering_id DECIMAL(12) NOT NULL);

CREATE TABLE Alternate_name (
alternate_name_id DECIMAL(12) NOT NULL PRIMARY KEY,
name VARCHAR(255) NOT NULL,
product_id DECIMAL(12) NOT NULL);

ALTER TABLE Store_location
ADD CONSTRAINT fk_location_to_currency FOREIGN KEY(currency_accepted_id) REFERENCES Currency(currency_id);

ALTER TABLE Sells
ADD CONSTRAINT fk_sells_to_product FOREIGN KEY(product_id) REFERENCES Product(product_id);

ALTER TABLE Sells
ADD CONSTRAINT fk_sells_to_location FOREIGN KEY(store_location_id) REFERENCES Store_location(store_location_id);

ALTER TABLE Offers
ADD CONSTRAINT fk_offers_to_location FOREIGN KEY(store_location_id) REFERENCES Store_location(store_location_id);

ALTER TABLE Offers
ADD CONSTRAINT fk_offers_to_offering FOREIGN KEY(shipping_offering_id) 
REFERENCES Shipping_offering(shipping_offering_id);

ALTER TABLE Alternate_name
ADD CONSTRAINT fk_name_to_product FOREIGN KEY(product_id)
REFERENCES Product(product_id);

INSERT INTO Currency(currency_id, currency_name, us_dollars_to_currency_ratio)
VALUES(1, 'Britsh Pound', 0.67);
INSERT INTO Currency(currency_id, currency_name, us_dollars_to_currency_ratio)
VALUES(2, 'Canadian Dollar', 1.34);
INSERT INTO Currency(currency_id, currency_name, us_dollars_to_currency_ratio)
VALUES(3, 'US Dollar', 1.00);
INSERT INTO Currency(currency_id, currency_name, us_dollars_to_currency_ratio)
VALUES(4, 'Euro', 0.92);
INSERT INTO Currency(currency_id, currency_name, us_dollars_to_currency_ratio)
VALUES(5, 'Mexican Peso', 16.76);

INSERT INTO Shipping_offering(shipping_offering_id, offering)
VALUES (50, 'Same Day');
INSERT INTO Shipping_offering(shipping_offering_id, offering)
VALUES (51, 'Overnight');
INSERT INTO Shipping_offering(shipping_offering_id, offering)
VALUES (52, 'Two Day');

--Glucometer
INSERT INTO Product(product_id, product_name, price_in_us_dollars)
VALUES(100, 'Glucometer', 50);
INSERT INTO Alternate_name(alternate_name_id, name, product_id)
VALUES(10000, 'Glucose Meter', 100);
INSERT INTO Alternate_name(alternate_name_id, name, product_id)
VALUES(10001, 'Blood Glucose Meter', 100);
INSERT INTO Alternate_name(alternate_name_id, name, product_id)
VALUES(10002, 'Glucose Monitoring System', 100);

--Bag Valve Mask
INSERT INTO Product(product_id, product_name, price_in_us_dollars)
VALUES(101, 'Bag Valve Mask', 25);
INSERT INTO Alternate_name(alternate_name_id, name, product_id)
VALUES(10003, 'Ambu Bag', 101);
INSERT INTO Alternate_name(alternate_name_id, name, product_id)
VALUES(10004, 'Oxygen Bag Valve Mask', 101);

--Digital Thermometer
INSERT INTO Product(product_id, product_name, price_in_us_dollars)
VALUES(102, 'Digital Thermometer', 250);
INSERT INTO Alternate_name(alternate_name_id, name, product_id)
VALUES(10005, 'Thermometer', 102);

--Electronic Stethoscope
INSERT INTO Product(product_id, product_name, price_in_us_dollars)
VALUES(103, 'Electronic Stethoscope', 350);
INSERT INTO Alternate_name(alternate_name_id, name, product_id)
VALUES(10006, 'Cardiology Stethoscope', 103);

--Handheld Pulse Oximeter
INSERT INTO Product(product_id, product_name, price_in_us_dollars)
VALUES(104, 'Handheld Pulse Oximeter', 450);
INSERT INTO Alternate_name(alternate_name_id, name, product_id)
VALUES(10007, 'Portable Pulse Oximeter', 104);
INSERT INTO Alternate_name(alternate_name_id, name, product_id)
VALUES(10008, 'Handheld Pulse Oximeter System', 104);

--Berlin Extension
INSERT INTO Store_location(store_location_id, store_name, currency_accepted_id)
VALUES(10, 'Berlin Extension', 4);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1000, 10, 100);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1001, 10, 101);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1002, 10, 102);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1003, 10, 104);
INSERT INTO Offers(offers_id, store_location_id, shipping_offering_id)
VALUES(150, 10, 52);

--Cancun Extension
INSERT INTO Store_location(store_location_id, store_name, currency_accepted_id)
VALUES(11, 'Cancun Extension', 5);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1004, 11, 101);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1005, 11, 102);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1006, 11, 104);
INSERT INTO Offers(offers_id, store_location_id, shipping_offering_id)
VALUES(151, 11, 52);

--London Extension
INSERT INTO Store_location(store_location_id, store_name, currency_accepted_id)
VALUES(12, 'London Extension', 1);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1007, 12, 100);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1008, 12, 101);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1009, 12, 102);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1010, 12, 103);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1011, 12, 104);
INSERT INTO Offers(offers_id, store_location_id, shipping_offering_id)
VALUES(152, 12, 50);
INSERT INTO Offers(offers_id, store_location_id, shipping_offering_id)
VALUES(153, 12, 51);
INSERT INTO Offers(offers_id, store_location_id, shipping_offering_id)
VALUES(154, 12, 52);

--New York Extension
INSERT INTO Store_location(store_location_id, store_name, currency_accepted_id)
VALUES(13, 'New York Extension', 3);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1012, 13, 100);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1013, 13, 101);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1014, 13, 102);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1015, 13, 103);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1016, 13, 104);
INSERT INTO Offers(offers_id, store_location_id, shipping_offering_id)
VALUES(155, 13, 51);
INSERT INTO Offers(offers_id, store_location_id, shipping_offering_id)
VALUES(156, 13, 52);

--Toronto Extension
INSERT INTO Store_location(store_location_id, store_name, currency_accepted_id)
VALUES(14, 'Toronto Extension', 2);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1017, 14, 100);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1018, 14, 101);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1019, 14, 102);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1020, 14, 103);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1021, 14, 104);
INSERT INTO Offers(offers_id, store_location_id, shipping_offering_id)
VALUES(157, 14, 52);


SELECT to_char(price_in_us_dollars *
       (SELECT us_dollars_to_currency_ratio
        FROM   Currency
        WHERE  currency_name = 'Britsh Pound'),
		'FM£999D00') AS price_in_pounds
FROM   Product
WHERE  product_name = 'Digital Thermometer';


SELECT us_dollars_to_currency_ratio
FROM   Currency
WHERE  currency_name = 'Britsh Pound'


SELECT product_name,
       to_char(price_in_us_dollars *
       (SELECT us_dollars_to_currency_ratio
        FROM   Currency
        WHERE  currency_name = 'Euro'),
		'FM€999D00') AS price_in_euros
FROM   Product
WHERE  price_in_us_dollars *
      (SELECT us_dollars_to_currency_ratio
       FROM   Currency
       WHERE  currency_name = 'Euro') < 26
	   OR 
	   price_in_us_dollars *
	   (SELECT us_dollars_to_currency_ratio
       FROM   Currency
	   WHERE currency_name = 'Euro') > 299;

--Short List
SELECT DISTINCT Product.product_name,
       Alternate_name.name AS alternate_name,
       to_char(Product.price_in_us_dollars, 'FM$999.00') AS US_Price
FROM  Store_location
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id
JOIN  Alternate_name ON Alternate_name.product_id = Product.product_id
WHERE  Product.product_id IN 
      (SELECT Product.product_id
       FROM Product
       JOIN Sells ON Sells.product_id = Product.product_id
       GROUP BY Product.product_id
       HAVING COUNT(Sells.product_id) = (SELECT COUNT(store_location_id) FROM Store_location)); 

       
SELECT DISTINCT Product.product_name,
	Alternate_name.name AS alternate_name,
       to_char(Product.price_in_us_dollars, 'FM$999.00') AS US_Price
FROM  (SELECT Product.product_id
       FROM Product
       JOIN Sells ON Sells.product_id = Product.product_id
       GROUP BY Product.product_id
       HAVING COUNT(Sells.product_id) = (SELECT COUNT(store_location_id) FROM Store_location)) information
JOIN  Sells ON Sells.product_id = information.product_id
JOIN  Product ON Product.product_id = Sells.product_id
JOIN  Alternate_name ON Alternate_name.product_id = Product.product_id;
       

--Long List
SELECT Store_location.store_name,
       Product.product_name,
	   Alternate_name.name AS alternate_name,
       to_char(Product.price_in_us_dollars, 'FM$999.00') AS US_Price
FROM  Store_location
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id
JOIN  Alternate_name ON Alternate_name.product_id = Product.product_id
WHERE  Product.product_id IN 
      (SELECT Product.product_id
       FROM Product
       JOIN Sells ON Sells.product_id = Product.product_id
       GROUP BY Product.product_id
       HAVING COUNT(Sells.product_id) = (SELECT COUNT(store_location_id) FROM Store_location))
       ORDER BY store_name, product_name, alternate_name; 


SELECT Store_location.store_name,
	Product.product_name,
	Alternate_name.name AS alternate_name,
       to_char(Product.price_in_us_dollars, 'FM$999.00') AS US_Price
FROM  (SELECT Product.product_id
       FROM Product
       JOIN Sells ON Sells.product_id = Product.product_id
       GROUP BY Product.product_id
       HAVING COUNT(Sells.product_id) = (SELECT COUNT(store_location_id) FROM Store_location)) information
JOIN  Sells ON Sells.product_id = information.product_id
JOIN  Store_location ON store_location.store_location_id = Sells.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id
JOIN  Alternate_name ON Alternate_name.product_id = Product.product_id
ORDER BY store_name, product_name, alternate_name; 


--All Product
SELECT Store_location.store_name,
       Product.product_name,
	   Alternate_name.name AS alternate_name,
       to_char(Product.price_in_us_dollars, 'FM$999.00') AS US_Price
FROM  Store_location
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id
JOIN  Alternate_name ON Alternate_name.product_id = Product.product_id
WHERE EXISTS (SELECT Product.product_id
       		 FROM Sells Universal_sells
      		 JOIN Product ON Universal_sells.product_id = Product.product_id
			 JOIN Store_location ON Universal_sells.store_location_id = Store_location.store_location_id
			 WHERE Store_location.store_location_id = Universal_sells.store_location_id)
ORDER BY store_name, product_name, alternate_name


--Selected Product
SELECT Store_location.store_name,
       Product.product_name,
	   Alternate_name.name AS alternate_name,
       to_char(Product.price_in_us_dollars, 'FM$999.00') AS US_Price
FROM  Store_location
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id
JOIN  Alternate_name ON Alternate_name.product_id = Product.product_id
WHERE EXISTS (SELECT Universal.product_id FROM (
				        SELECT product_id, COUNT(product_id) AS Counting
				        FROM Sells
				        GROUP BY Sells.product_id
		     			) Universal
		WHERE Counting = (SELECT COUNT(store_location_id) FROM Store_location)
			AND Universal.product_id = Product.product_id)
ORDER BY store_name, product_name, alternate_name


--Query with View
CREATE OR REPLACE VIEW universal_products AS
SELECT Product.product_id
       FROM Product
       JOIN Sells ON Sells.product_id = Product.product_id
       GROUP BY Product.product_id
       HAVING COUNT(Sells.product_id) = (SELECT COUNT(store_location_id) FROM Store_location)
	   
SELECT Store_location.store_name,
	   Product.product_name,
	   Alternate_name.name AS alternate_name,
       to_char(Product.price_in_us_dollars, 'FM$999.00') AS US_Price
FROM   universal_products
JOIN   Sells ON Sells.product_id = universal_products.product_id
JOIN   Store_location ON store_location.store_location_id = Sells.store_location_id
JOIN   Product ON Product.product_id = Sells.product_id
JOIN   Alternate_name ON Alternate_name.product_id = Product.product_id
ORDER BY store_name, product_name, alternate_name; 
  
