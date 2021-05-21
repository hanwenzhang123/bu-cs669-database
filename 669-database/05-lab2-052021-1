Section One – Relating Data

Step 1 – Creating the Table Structure

ending fk is for foreign key
CONSTRAINT is for making the name of the foreign key
order matters in the reference
constraint must be valid all the time

CREATE TABLE first_letters (
first_letter_id DECIMAL(1) NOT NULL PRIMARY KEY,
first_letter CHAR(1) NOT NULL);

CREATE TABLE words (
word VARCHAR(32) NOT NULL,
first_letter_id DECIMAL(1),
CONSTRAINT first_letter_fk
FOREIGN KEY (first_letter_id)
REFERENCES first_letters(first_letter_id));



CREATE TABLE Restaurant (
restaurant_id DECIMAL(12) PRIMARY KEY,
name VARCHAR(64) NOT NULL
);

CREATE TABLE Meal (
meal_nr DECIMAL(12) NOT NULL,
description VARCHAR(255) NOT NULL,
date_served DATE NOT NULL,
restaurant_id DECIMAL(12)
);

ALTER TABLE Meal        //An ALTER TABLE command lets us modify all aspects of the structure of a table. 
ADD CONSTRAINT meal_pk      //ADD CONSTRAINT to indicate that we are specifically adding a constraint. it is the identifier that names our constraint.
PRIMARY KEY(meal_nr);

ALTER TABLE Meal
ADD CONSTRAINT meal_restaurant_fk
FOREIGN KEY(restaurant_id)    //adding is a foreign key constraint.
REFERENCES Restaurant(restaurant id);  //what follows are the table and column identities that the foreign key will reference.



Step 2 – Populating the Tables

INSERT INTO Restaurant (restaurant_id, name)
VALUES (31, 'Sunset Grill');
INSERT INTO Restaurant (restaurant_id, name)
VALUES (32, 'Oceanside Beachview');

INSERT INTO Meal (meal_nr, description, date_served, restaurant_id)
VALUES (101, 'Grilled eggplant with sides', CAST('03-Jul-2012' AS DATE), 31); 
INSERT INTO Meal (meal_nr, description, date_served, restaurant_id) 
VALUES(102, 'Delicious pizza with salad', CAST('09-Jul-2012' AS DATE), 31); 
INSERT INTO Meal (meal_nr, description, date_served, restaurant_id) 
VALUES(103, 'Five-course luxurious meal', CAST('13-Jul-2012' AS DATE), NULL);



Step 3 – Invalid Reference Attempt

INSERT INTO Meal (meal_nr, description, date_served, restaurant_id)
VALUES(104, 'Juicy entree and french fries', CAST('17-Jul-2012' AS DATE), 57);

make sure everything has exist in the table, parent must exist



JOIN
Summarize:
a. what a join is and how joins help answer questions using related data, and
b. the similarities and differences between an inner join, a left join, a right join, and a full
outer join.
Answer:
a. JOIN helps join data from two different tables together to form a single set of data. We can analyze data using the common factors associated with both tables to answer questions using related data and specific the columns.
b.
Inner Join: used to join or combine multiple tables. It will contain ONLY the matching records
from both columns and display all rows that have the keys common to both tables.
Left Join: It will contain the matching records from both columns as well as display all additional
rows from the first table since the ‘left’ table is considered the first table
Right Join: It will contain the matching records from both columns as well as display all
additional rows from the second table since the ‘right’ table is considered the second
table
Full Outer Join: It will display all common rows as well as all the uncommon rows from both the
tables.


Step 4 – Listing Pizzas and Toppings

SELECT description, date_served, name
FROM Meal
JOIN Restaurant ON Meal.restaurant_id = Restaurant.restaurant_id;   //on is boolean


//List the name of all restaurants, ordered alphabetically. If the restaurant served any meals, list the description and date served of each meal.
//ORDER BY
SELECT description, date_served, name
FROM Meal
RIGHT JOIN Restaurant ON Meal.restaurant_id = Restaurant.restaurant_id
ORDER BY name;


//a full outer join is a combination of left and right joins.
//FULL JOIN
SELECT description, date_served, name
FROM Meal
FULL JOIN Restaurant ON Meal.restaurant_id = Restaurant.restaurant_id
ORDER BY description DESC;

LEFT - first
RIGHT - second


Step 5 – Listing All Pizzas
Step 6 – Listing All Toppings
Step 7 – Listing All Pizzas and All Toppings

