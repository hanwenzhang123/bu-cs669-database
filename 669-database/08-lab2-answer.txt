CREATE TABLE Pizza (
pizza_id DECIMAL(12) PRIMARY KEY,
name VARCHAR(32) NOT NULL,
date_available DATE NOT NULL,
price DECIMAL(4, 2) NOT NULL);

CREATE TABLE Topping (
topping_id DECIMAL(12) PRIMARY KEY,
topping_name VARCHAR(64) NOT NULL,
pizza_id DECIMAL(12));

ALTER TABLE Topping
ADD CONSTRAINT topping_pizza_fk
FOREIGN KEY(pizza_id)
REFERENCES Pizza(pizza_id);

INSERT INTO Pizza (pizza_id, name, date_available, price)
VALUES (1, 'Plain', CAST('13-Jun-2020' AS DATE), 9.89);
INSERT INTO Pizza (pizza_id, name, date_available, price)
VALUES (2, 'Downtown Masterpiece', CAST('23-SEP-2020' AS DATE), 10.79);
INSERT INTO Pizza (pizza_id, name, date_available, price)
VALUES (3, 'Meat Lover', CAST('21-MAY-2021' AS DATE), 12.99);
INSERT INTO Pizza (pizza_id, name, date_available, price)
VALUES (4, 'Hawaiiaan', CAST('20-MAY-2021' AS DATE), 11.89);

INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (101, 'Tomatoes', 2);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (102, 'Spanich', 2);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (103, 'Pineapple', 4);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (104, 'Ham', 4);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (105, 'Onion', 3);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (106, 'Pepperoni', 3);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (107, 'Sausage', 3);
INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (108, 'Chicken', NULL);

SELECT * FROM Pizza;

SELECT * FROM Topping;

INSERT INTO Topping (topping_id, topping_name, pizza_id)
VALUES (109, 'Steak', 5);

SELECT name, topping_name
FROM Pizza
JOIN Topping on Topping.pizza_id = Pizza.pizza_id

SELECT name, date_available, topping_name
FROM Pizza
LEFT JOIN Topping on Topping.pizza_id = Pizza.pizza_id
ORDER BY date_available;

SELECT name, date_available, topping_name
FROM Topping
RIGHT JOIN Pizza on Topping.pizza_id = Pizza.pizza_id
ORDER BY date_available;

SELECT topping_name, name
FROM Topping
LEFT JOIN Pizza on Topping.pizza_id = Pizza.pizza_id
ORDER BY topping_name DESC;

SELECT topping_name, name
FROM Pizza
RIGHT JOIN Topping on Topping.pizza_id = Pizza.pizza_id
ORDER BY topping_name DESC;

SELECT name, topping_name
FROM Pizza
FULL JOIN Topping on Topping.pizza_id = Pizza.pizza_id
ORDER BY name;

SELECT name, topping_name
FROM Pizza
FULL JOIN Topping on Topping.pizza_id = Pizza.pizza_id
ORDER BY topping_name;
  
 

SELECT name, to_char(price, '$999.99') AS price
FROM Pizza;

SELECT name, to_char(price - 1.75, '$999.99') AS discounted_price
FROM Pizza;

DELETE FROM Topping
WHERE topping_name = 'Chicken';

SELECT topping_name || ' ( ' || name || ' - ' || to_char(price - 1.75, '$999.99') || ' ) ' AS discounted_price_advanced_formatting
FROM Topping
LEFT JOIN Pizza on Topping.pizza_id = Pizza.pizza_id
ORDER BY topping_name;


SELECT name, price
FROM Pizza
WHERE date_available >= CAST('01-MAY-2020' AS DATE)
AND price >= 9.55
AND NOT name = 'Plain'

INSERT INTO Pizza (pizza_id, name, date_available, price)
VALUES (5, 'Cheesy Lover', CAST('22-MAY-2021' AS DATE), 10);

SELECT name, price
FROM Pizza
WHERE date_available >= CAST('01-JAN-2021' AS DATE)
AND price <= 10


ALTER TABLE Pizza
ADD special_price decimal(4, 2) GENERATED ALWAYS AS (price / 2) STORED;

SELECT * FROM Pizza;


ALTER TABLE Pizza
ADD is_signature BOOLEAN GENERATED ALWAYS AS (date_available >= CAST('01-MAY-2020' AS DATE)
AND price >= 9.55
AND NOT name = 'Plain')
STORED;

SELECT * 
FROM Pizza
WHERE is_signature=true;
 
