Section One – Subqueries
Step 2 – Subquery in Column List

two queries independently gives us the results we want, but forces us to manually hardcode one value (may change overtime) into another. 
The first would find out the proper conversion ratio. The second would hardcode that value to obtain the price in Euros. 
 
--Obtain the Dollar to Euro ratio, which gives us 0.93.
SELECT us_dollars_to_currency_ratio
FROM   Currency
WHERE  currency_name = 'Euro';

--Hardcode 0.93 in another query to get the price.
SELECT price_in_us_dollars * 0.93 AS price_in_euros
FROM   Product
WHERE  product_name = 'Cashmere Sweater';


The embedded query is termed a subquery because it resides inside of another query. 

--Single Query for Cashmere Sweater
SELECT price_in_us_dollars *
       (SELECT us_dollars_to_currency_ratio
        FROM   Currency
        WHERE  currency_name = 'Euro') AS price_in_euros
FROM   Product
WHERE  product_name = 'Cashmere Sweater'


Placing a subquery in the column list of a SELECT statement gives us the ability to directly manipulate values from every row returned in the outer query. 

The principle is that the result of a subquery placed in the column list is used for every row returned from the outer query.

uncorrelated subquery:
which is subquery does not reference a table or value in the outer query, and that its results can be retrieved with or without the existence of the outer query
An uncorrelated subquery can always be extracted and executed as a query in its own right.
The SQL engine executes an uncorrelated subquery independently of the outer query, before it needs the subquery’s results.


FM€99D99
The “FM” in the format string instructs the SQL engine to display only as many digits are as necessary
FM suppresses padding so the symbol used is next to the numeric value and D is used as the decimal point and pulled from the local setting.

--Formatted with Euro
SELECT to_char(price_in_us_dollars *
       (SELECT us_dollars_to_currency_ratio
        FROM   Currency
        WHERE  currency_name = 'Euro'),
        'FM€99D99') AS price_in_euros
FROM   Product
WHERE  product_name = 'Cashmere Sweater' 


Step 3 – Subquery in WHERE Clause
The new skill you need to address this step is to filter rows based off the results of the subquery. 
 
  
Code: All Products’ Prices in Pesos
SELECT product_name,
       price_in_us_dollars *
       (SELECT us_dollars_to_currency_ratio
        FROM   Currency
        WHERE  currency_name = 'Mexican Peso') AS price_in_pesos
FROM Product
 
 
 --more than one subquery can be embedded in a single query
  the first subquery is used to retrieve the price in Mexican Pesos
  the second subquery is to restrict the products retrieved. 
  Each subquery has a useful purpose, and the use of one does not preclude the use of another.
 
Code: Products Less Than Mex$2,750
SELECT product_name,
       price_in_us_dollars *
      (SELECT us_dollars_to_currency_ratio
       FROM Currency
       WHERE  currency_name = 'Mexican Peso') AS price_in_pesos
--That subquery is executed before its result must be used in the WHERE clause, and the subquery’s result takes the place of a literal value. 
FROM   Product
WHERE  price_in_us_dollars *
      (SELECT us_dollars_to_currency_ratio
       FROM   Currency
       WHERE  currency_name = 'Mexican Peso') < 2750
--contain the same subquery used but restrict (filter) rows in the result, because it is located in the WHERE clause.
--products whose prices are not less than Mex$2,750 are excluded, greater than or equal to Mex$2,750 are excluded. 

 
Step 4 – Using the IN Clause with a Subquery
deciding how many values to retrieve in the subquery
we decide the maximum number of rows and columns it may retrieve. 
If a subquery retrieves one column, then we have the option to retrieve a single value by ensuring the subquery always retrieves exactly one row, and we have the option to retrieve a list of values by allowing it to retrieve as many rows as are needed. 


SELECT last_name FROM Person WHERE person_id = 5  --a single primary key value

SELECT last_name FROM Person WHERE weight_in_pounds < 130 --retrieve a list of values

“WHERE X IN (5, 10, 20)”. The IN operator tests whether a single value is found in a list of values.
If X is 5 or 10 or 20, then “X IN (5, 10, 20)” is true; otherwise, it is false.

A good way to craft a query to address a more complex use case is to create one independent query for each distinct part, then put them together.

 
Code: Store Locations Query
SELECT Store_location.store_location_id, Store_location.store_name
FROM   Store_location
JOIN   Offers ON Offers.store_location_id = Store_location.store_location_id
GROUP BY Store_location.store_location_id, Store_location.store_name
HAVING   COUNT(Offers.purchase_delivery_offering_id) > 1  --limits the results returned to those stores with more than one purchase and delivery option.

 
Code: Products and Prices Query
SELECT Store_location.store_name, Product.product_name, Product.price_in_us_dollars
FROM  Store_location
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id


 
Code: Full Query
SELECT Store_location.store_name,
       Product.product_name,
       to_char(Product.price_in_us_dollars, 'FML999.00') AS US_Price
FROM  Store_location
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id
WHERE  Store_location.store_location_id IN  --sets up the condition that the store_location_id must be in the list of values
       (SELECT   Store_location.store_location_id
       FROM   Store_location
       JOIN Offers
       ON Offers.store_location_id = Store_location.store_location_id
       GROUP BY Store_location.store_location_id
       HAVING   COUNT(Offers.purchase_delivery_offering_id) > 1);



Step 5 – Subquery in FROM Clause
no restrictions on the number of rows or columns when tabular results are expected, since the results are by definition tabular. 
the FROM clause always expects tabular elements, so a subquery can be used in the FROM clause without regard to the number of columns and rows it retrieves. 


Full Query with WHERE Clause Subquery

SELECT Store_location.store_name,
       Product.product_name,
       to_char(Product.price_in_us_dollars, 'FML999.00') AS US_Price
FROM  Store_location
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id
WHERE  Store_location.store_location_id IN  --sets up the condition that the store_location_id must be in the list of values
       (SELECT   Store_location.store_location_id
       FROM   Store_location
       JOIN Offers
       ON Offers.store_location_id = Store_location.store_location_id
       GROUP BY Store_location.store_location_id
       HAVING   COUNT(Offers.purchase_delivery_offering_id) > 1);


Code: Subquery in FROM Clause
SELECT Store_location.store_name,
       Product.product_name,
       to_char(Product.price_in_us_dollars, 'FML999.00') AS US_Price
FROM   (SELECT   Store_location.store_location_id,
                 Store_location.store_name
       FROM   Store_location
       JOIN Offers
            ON Offers.store_location_id = Store_location.store_location_id
       GROUP BY Store_location.store_location_id, Store_location.store_name
       HAVING   COUNT(Offers.purchase_delivery_offering_id) > 1) locations --an alias which provides a name for the subquery’s results
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id;


filtering has been achieved in the FROM clause rather than the WHERE clause.
       we can successfully filter rows by using a subquery in the FROM clause
       
       
       
