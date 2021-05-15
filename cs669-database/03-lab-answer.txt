Session1:
CREATE TABLE PetStore(
Name VARCHAR(64),
Breed VARCHAR(32),
BirthDate DATE,
Price DECIMAL(6,2)
);

INSERT INTO PetStore (Name, Breed, BirthDate, Price)
VALUES('Angel', 'Golden Retriever', '01-MAR-2019', 89.99);

Select * FROM PetStore;

UPDATE PetStore
SET Price = 99.99;

DELETE FROM PetStore;

DROP TABLE PetStore;



Session2:
CREATE TABLE Vacation( 
VacationId DECIMAL(12) PRIMARY KEY,
Location VARCHAR(64) NOT NULL,
Description VARCHAR(1024) NULL,
StartedOn DATE NOT NULL,
EndedOn DATE NOT NULL
);

INSERT INTO Vacation (VacationId, Location, Description, StartedOn, EndedOn)
VALUES(1, 'Costa Rica', 'Relaxing Hot Springs',  CAST('13-JAN-2019' AS DATE),  CAST('21-JAN-2019' AS DATE));
INSERT INTO Vacation (VacationId, Location, Description, StartedOn, EndedOn)
VALUES(2, 'Bora Rica', 'Exciting Snorkeling',  CAST('5-MAR-2019' AS DATE),  CAST('15-MAR-2019' AS DATE));
INSERT INTO Vacation (VacationId, Location, Description, StartedOn, EndedOn)
VALUES(3, 'Jamaica', Null,  CAST('10-DEC-2018' AS DATE),  CAST('28-DEC-2018' AS DATE));

SELECT * FROM Vacation;

INSERT INTO Vacation (VacationId, Location, Description, StartedOn, EndedOn)
VALUES(4, Null,  'Experience the Netherlands No Other Way', CAST('1-JAN-2020' AS DATE),  CAST('10-JAN-2020' AS DATE));

INSERT INTO Vacation (VacationId, Location, Description, StartedOn, EndedOn)
VALUES(4, 'Netherlands',  'Experience the Netherlands No Other Way', CAST('1-JAN-2020' AS DATE),  CAST('10-JAN-2020' AS DATE));

SELECT location, description
FROM Vacation
WHERE VacationId = 2; 

UPDATE Vacation
SET description = 'Aquatic Wonders'
WHERE location = 'Jamaica'; 

SELECT * FROM Vacation;

UPDATE Vacation
SET description = null
WHERE location = 'Jamaica'; 

SELECT * FROM Vacation;

DELETE FROM Vacation
WHERE  startedon > '01-JUN-2019';

SELECT * FROM Vacation;



Session3:
CREATE TABLE Products( 
order_id DECIMAL (12) NOT NULL PRIMARY KEY,
order_date DATE NOT NULL,
product_name VARCHAR(64) NOT NULL,
quantity DECIMAL(3) NOT NULL,
unit_price DECIMAL(8,2) NOT NULL,
total_price DECIMAL(8,2) NOT NULL
);

INSERT INTO Products(order_id, order_date, product_name, quantity, unit_price, total_price)
VALUES(1, CAST('13-MAY-2021'AS DATE), 'cup', 10, 12, 120);
INSERT INTO Products(order_id, order_date, product_name, quantity, unit_price, total_price)
VALUES(2, CAST('14-MAY-2021'AS DATE), 'mug', 30, 8, 240);
INSERT INTO Products(order_id, order_date, product_name, quantity, unit_price, total_price)
VALUES(3, CAST('15-MAY-2021'AS DATE), 'cup', 10, 10, 100);
INSERT INTO Products(order_id, order_date, product_name, quantity, unit_price, total_price)
VALUES(4, CAST('15-MAY-2021'AS DATE), 'bottle', 20, 11, 220);

SELECT * FROM Products;

SELECT product_name, quantity, unit_price, total_price
FROM Products
WHERE product_name = 'cup';


DELETE FROM Products
WHERE product_name = 'mug';  

SELECT * FROM Products;
 
