Section One – Aggregating Data
data aggregation - reports, grouping, summary, data analysis, etc
a single value across all rows or across groups of rows

Step 1 – Creating Table Structure and Data

CREATE TABLE Resort_type (
resort_type_id DECIMAL(12) NOT NULL PRIMARY KEY,
resort_type VARCHAR(64) NOT NULL);

CREATE TABLE Resort (
resort_id DECIMAL(12) NOT NULL PRIMARY KEY,
resort_type_id DECIMAL(12) NOT NULL,
name VARCHAR(255) NOT NULL,
FOREIGN KEY (resort_type_id) REFERENCES Resort_type(resort_type_id));

CREATE TABLE Accommodations (
accommodations_id DECIMAL(12) NOT NULL PRIMARY KEY,
resort_id DECIMAL(12) NOT NULL,
description VARCHAR(255) NOT NULL,
cost_per_night DECIMAL(8,2) NULL,
FOREIGN KEY (resort_id) REFERENCES Resort(resort_id));



--Resort types.
INSERT INTO Resort_type(resort_type_id, resort_type)
VALUES(1, 'Ocean');
INSERT INTO Resort_type(resort_type_id, resort_type)
VALUES(2, 'Lakeside');
INSERT INTO Resort_type(resort_type_id, resort_type)
VALUES(3, 'Mountaintop');
INSERT INTO Resort_type(resort_type_id, resort_type)
VALUES(4, 'Country');

--Resorts.
INSERT INTO Resort(resort_id, name, resort_type_id)
VALUES(101, 'Light of the Ocean', 1); --Ocean resort type
INSERT INTO Resort(resort_id, name, resort_type_id)
VALUES(102, 'Breathtaking Bahamas', 1); --Ocean resort type
INSERT INTO Resort(resort_id, name, resort_type_id)
VALUES(103, 'Mountainous Mexico', 3); --Mountaintop resort type
INSERT INTO Resort(resort_id, name, resort_type_id)
VALUES(104, 'Greater Lakes', 2); --Lakeside resort type

--Accommodations
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1001, 'Bungalow 1', 289, 101); --Accommodation for Light of the Ocean resort.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1002, 'Bungalow 2', 289, 101); --Accommodation for Light of the Ocean resort.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1003, 'Bungalow 3', 325, 101); --Accommodation for Light of the Ocean resort.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1004, 'Suite 101', 199, 102); --Accommodation for Breathtaking Bahamas.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1005, 'Suite 102', 199, 102); --Accommodation for Breathtaking Bahamas.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1006, 'Suite 201', 250, 102); --Accommodation for Breathtaking Bahamas.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1007, 'Suite 202', 250, 102); --Accommodation for Breathtaking Bahamas.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1008, 'Room 10', 150, 103); --Accommodation for Mountainous Mexico.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1009, 'Room 20', null, 103); --Accommodation for Mountainous Mexico.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1010, 'Cabin A', 300, 104); --Accommodation for Greater Lakes.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1011, 'Cabin B', null, 104); --Accommodation for Greater Lakes.
INSERT INTO Accommodations(accommodations_id, description, cost_per_night, resort_id)
VALUES(1012, 'Cabin C', 350, 104); --Accommodation for Greater Lakes.



Step 2 – Counting Matches
the MAX function returns the highest numerical value across multiple rows, 
the MIN function returns the smallest numerical value across multiple rows.
the COUNT function counts the number of rows in the table.

--Count the number of accommodations in the table.
SELECT COUNT(*) AS nr_accommodations
FROM Accommodations;    //12


1. Retrieve the rows and columns specified in the SELECT/FROM/WHERE clause. 
2. Apply the aggregate function to these rows and columns.



you can use the name of a column instead of “*” when instructing COUNT what to count. 
When the name of a column is used, COUNT counts the number of rows where the value is not null for that column.

--Count the number of non-null costs in the table.
SELECT COUNT(cost_per_night) AS nr_accommodations
FROM Accommodations;    //10



instruct COUNT to count distinct values instead of all values.

--Count the number of non-distinct and distinct foreign key references.
SELECT COUNT(resort_id) AS nr_non_distinct,     //12
       COUNT(DISTINCT resort_id) AS nr_distinct       //4
FROM Accommodations;

This command counts the resort_id column twice, the first counting all values, and the second only counting distinct values. 


Note that you can also use add a WHERE clause to a query with an aggregate function. 
When a WHERE clause is included, the results are filtered by the WHERE clause condition before the aggregate function is applied. 
For example, if there are 10 rows in a table, and the WHERE clause limits the results to 5 of those rows, the COUNT aggregate function would return 5 instead of 10.



Step 3 – Determining Highest and Lowest

--Obtain the least expensive price.
SELECT MIN(cost_per_night) AS least_expensive
FROM Accommodations;

The MIN function returns the value that is the lowest for the column indicated in parentheses. 

additionally format the value as a currency for optimal human‐readable representation.

//Oracle, PostgreSQL
SELECT TO_CHAR(MIN(cost_per_night), '$999.99') AS least_expensive
FROM Accommodations;

//MSSQL
SELECT FORMAT(MIN(cost_per_night), '$.00') AS least_expensive
FROM Accommodations;

Accommodations that have no cost per night are not taken into account, because the MIN function thus ignores null values. 
multiple aggregate functions can be included in the same query, separated by a comma 


SELECT series_name, 
TO_CHAR(MIN(suggested_price), '$999.99') AS least_expensive, 
TO_CHAR(MAX(suggested_price), '$999.99') AS most_expensive
FROM Movie_series
GROUP BY series_name;

column "movie_series.series_name" must appear in the GROUP BY clause or be used in an aggregate function
In database management, an aggregate function or aggregation function is a function where the values of multiple rows are grouped together to form a single summary value. 
Common aggregate functions include: Average (i.e., arithmetic mean) Count.



Step 4 – Grouping Aggregate Results

Code: Obtaining the Smallest Price (No Group)
--Obtain the least expensive price.
SELECT MIN(cost_per_night) AS least_expensive
FROM Accommodations;

 
Code: Obtaining the Smallest Price Per Resort
--Obtain the least expensive price per resort.
SELECT resort_id, MIN(cost_per_night) AS least_expensive
FROM   Accommodations
GROUP BY resort_id;

run once per unique resort_id, rather than once for the entire result set.


--Obtain the least expensive price per resort, with resort name.
SELECT name, MIN(cost_per_night) AS least_expensive
FROM   Accommodations
JOIN   Resort ON Resort.resort_id = Accommodations.resort_id
GROUP BY Resort.resort_id, name;

The GROUP BY statement is often used with aggregate functions (COUNT(), MAX(), MIN(), SUM(), AVG()) to group the result-set by one or more columns.


Step 5 – Limiting Results by Aggregation
the ability to limit the result set by aggregated values (rather than values coming directly from a table).

WHERE clause limits the result set based upon values in individual rows
HAVING clause limits the result set based upon aggregate results. 


Code: Cheapest Price Per Resort Less Than $225
--Obtain the least expensive price per resort, less then $225.
SELECT name, MIN(cost_per_night) AS least_expensive
FROM   Accommodations
JOIN   Resort ON Resort.resort_id = Accommodations.resort_id
GROUP BY Resort.resort_id, name
HAVING  MIN(cost_per_night) < 225;




Step 6 – Adding Up Values
 
Code: Resorts Bringing at Least $800 Revenue Per Night
--Show resorts that bring in at least $800 revenue per night.
SELECT name, SUM(cost_per_night) AS total_revenue
FROM   Accommodations
JOIN   Resort ON Resort.resort_id = Accommodations.resort_id
GROUP BY Resort.resort_id, Resort.name
HAVING SUM(cost_per_night) >= 800;



Step 7 – Integrating Aggregation with Other Constructs

 
Code: Intermediate Result with no Aggregation
--Show all accommodations along with their resorts and types, that cost more than $200.
SELECT     *
FROM       Resort
JOIN       Accommodations ON  Accommodations.resort_id = Resort.resort_id
                          AND Accommodations.cost_per_night >= 200
RIGHT JOIN Resort_type ON Resort_type.resort_type_id = Resort.resort_type_id;

  
 
Code: All Resort Types along with Number Over 200
--Show all resort types and the number of accommodations costing over $200, ordered least to greatest.
SELECT     Resort_type.resort_type, COUNT(Accommodations.accommodations_id) AS nr_over_200
FROM       Resort
JOIN       Accommodations ON  Accommodations.resort_id = Resort.resort_id
                          AND Accommodations.cost_per_night >= 200
RIGHT JOIN Resort_type ON Resort_type.resort_type_id = Resort.resort_type_id
GROUP BY   Resort_type.resort_type_id, Resort_type.resort_type
ORDER BY   nr_over_200;
