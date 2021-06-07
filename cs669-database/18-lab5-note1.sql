Subqueries Overview
when one operation operates on a relation, and yields a new relation, we can use a second operation to operate on the result of the first operation.

SELECTlast_name=Smith(PROJECTlast_name(Person)).

SELECT * FROM (SELECT last_name from Person)
WHERE last_name = 'Glass'


Section One – Subqueries
Step 1 – Creating Table Structure
DROP TABLE Sells;
DROP TABLE Offers;
DROP TABLE Available_in;
DROP TABLE Store_location;
DROP TABLE Product;
DROP TABLE Currency;
DROP TABLE Purchase_delivery_offering;
DROP TABLE Sizes;

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
CREATE TABLE Purchase_delivery_offering ( 
  purchase_delivery_offering_id DECIMAL(12) NOT NULL PRIMARY KEY, offering VARCHAR(255) NOT NULL);
CREATE TABLE Offers (
offers_id DECIMAL(12) NOT NULL PRIMARY KEY,
store_location_id DECIMAL(12) NOT NULL,
purchase_delivery_offering_id DECIMAL(12) NOT NULL);
CREATE TABLE Sizes (
sizes_id DECIMAL(12) NOT NULL PRIMARY KEY,
size_option VARCHAR(255) NOT NULL);
CREATE TABLE Available_in (
available_in_id DECIMAL(12) NOT NULL PRIMARY KEY,
product_id DECIMAL(12) NOT NULL,
sizes_id DECIMAL(12) NOT NULL);

ALTER TABLE Store_location
ADD CONSTRAINT fk_location_to_currency FOREIGN KEY(currency_accepted_id) REFERENCES Currency(currency_id);
ALTER TABLE Sells
ADD CONSTRAINT fk_sells_to_product FOREIGN KEY(product_id) REFERENCES Product(product_id);
ALTER TABLE Sells
ADD CONSTRAINT fk_sells_to_location FOREIGN KEY(store_location_id) REFERENCES Store_location(store_location_id);
ALTER TABLE Offers
ADD CONSTRAINT fk_offers_to_location FOREIGN KEY(store_location_id) REFERENCES Store_location(store_location_id);
ALTER TABLE Offers
ADD CONSTRAINT fk_offers_to_offering FOREIGN KEY(purchase_delivery_offering_id) REFERENCES Purchase_delivery_offering(purchase_delivery_offering_id);
ALTER TABLE Available_in
ADD CONSTRAINT fk_available_to_product FOREIGN KEY(product_id) REFERENCES Product(product_id);
ALTER TABLE Available_in
ADD CONSTRAINT fk_available_to_sizes FOREIGN KEY(sizes_id)
REFERENCES Sizes(sizes_id);

INSERT INTO Currency(currency_id, currency_name, us_dollars_to_currency_ratio) 
VALUES(1, 'Britsh Pound', 0.66);
INSERT INTO Currency(currency_id, currency_name, us_dollars_to_currency_ratio) 
VALUES(2, 'Canadian Dollar', 1.33);
INSERT INTO Currency(currency_id, currency_name, us_dollars_to_currency_ratio)
VALUES(3, 'US Dollar', 1.00);
INSERT INTO Currency(currency_id, currency_name, us_dollars_to_currency_ratio)
VALUES(4, 'Euro', 0.93);
INSERT INTO Currency(currency_id, currency_name, us_dollars_to_currency_ratio)
VALUES(5, 'Mexican Peso', 16.75);
INSERT INTO Purchase_delivery_offering(purchase_delivery_offering_id, offering) 
VALUES (50, 'Purchase In Store');
INSERT INTO Purchase_delivery_offering(purchase_delivery_offering_id, offering) 
VALUES (51, 'Purchase Online, Ship to Home');
INSERT INTO Purchase_delivery_offering(purchase_delivery_offering_id, offering) 
VALUES (52, 'Purchase Online, Pickup in Store');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(1, 'Small');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(2, 'Medium');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(3, 'Large');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(4, 'Various');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(5, '2');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(6, '4');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(7, '6');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(8, '8');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(9, '10');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(10, '12');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(11, '14');
INSERT INTO Sizes(sizes_id, size_option)
VALUES(12, '16');

‐‐Cashmere Sweater
INSERT INTO Product(product_id, product_name, price_in_us_dollars)
VALUES(100, 'Cashmere Sweater', 100);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10000, 100, 1);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10001, 100, 2);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10002, 100, 3);

‐‐Designer Jeans
INSERT INTO Product(product_id, product_name, price_in_us_dollars)
VALUES(101, 'Designer Jeans', 150);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10003, 101, 4);

‐‐Flowing Skirt
INSERT INTO Product(product_id, product_name, price_in_us_dollars)
VALUES(102, 'Flowing Skirt', 125);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10004, 102, 5);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10005, 102, 6);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10006, 102, 7);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10007, 102, 8);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10008, 102, 9);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10009, 102, 10);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10010, 102, 11);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10011, 102, 12);

‐‐Silk Blouse
INSERT INTO Product(product_id, product_name, price_in_us_dollars)
VALUES(103, 'Silk Blouse', 200);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10012, 103, 1);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10013, 103, 2);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10014, 103, 3);

‐‐Wool Overcoat
INSERT INTO Product(product_id, product_name, price_in_us_dollars)
VALUES(104, 'Wool  Overcoat', 250);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10015, 104, 1);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10016, 104, 2);
INSERT INTO Available_in(available_in_id, product_id, sizes_id)
VALUES(10017, 104, 3);

‐‐Berlin Extension
INSERT INTO Store_location(store_location_id, store_name, currency_accepted_id) 
VALUES(10, 'Berlin Extension', 4);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1000, 10, 100);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1001, 10, 101);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1002, 10, 103);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1003, 10, 104);
INSERT INTO Offers(offers_id, store_location_id, purchase_delivery_offering_id) 
VALUES(150, 10, 50);

‐‐Cancun Extension
INSERT INTO Store_location(store_location_id, store_name, currency_accepted_id) 
VALUES(11, 'Cancun Extension', 5);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1004, 11, 101);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1005, 11, 102);
INSERT INTO Sells(sells_id, store_location_id, product_id)
VALUES(1006, 11, 103);
INSERT INTO Offers(offers_id, store_location_id, purchase_delivery_offering_id) 
VALUES(151, 11, 50);

‐‐London Extension
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
INSERT INTO Offers(offers_id, store_location_id, purchase_delivery_offering_id) 
VALUES(152, 12, 50);
INSERT INTO Offers(offers_id, store_location_id, purchase_delivery_offering_id) 
VALUES(153, 12, 51);
INSERT INTO Offers(offers_id, store_location_id, purchase_delivery_offering_id) 
VALUES(154, 12, 52);

‐‐New York Extension
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
INSERT INTO Offers(offers_id, store_location_id, purchase_delivery_offering_id) 
VALUES(155, 13, 50);
INSERT INTO Offers(offers_id, store_location_id, purchase_delivery_offering_id) 
VALUES(156, 13, 52);

‐‐Toronto Extension
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
INSERT INTO Offers(offers_id, store_location_id, purchase_delivery_offering_id) 
VALUES(157, 14, 50);

