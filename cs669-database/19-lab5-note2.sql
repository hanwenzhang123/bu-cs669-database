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
       


Step 6 – Correlated Subquery

Code: Products and Prices Query
SELECT Store_location.store_name, Product.product_name, Product.price_in_us_dollars
FROM  Store_location
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id

 
Code: Locations Selling Cashmere Sweaters
SELECT Store_location.store_name, Product.product_name
FROM  Store_location
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id
              AND product.product_name = 'Cashmere Sweater'
              
              
  
The EXISTS clause is useful to address use cases such as this that test for the existence of a certain item. 
the EXISTS clause only works with a subquery
An EXISTS clause is a Boolean expression that returns only true and false, true if the subquery returns any rows at all, and false if the subquery returns no rows. 
EXISTS only tests the existence of at least one row - “Is any row retrieved from this subquery?”
  
  
A correlated subquery references at least one table from the outer query, which means that conceptually, the subquery is not an independent query.
we cannot execute correlated subqueries on their own; correlated subqueries only make sense in the context of the outer query into which they are embedded
correlated subqueries are executed once for each row in the outer query and therefore retrieve one result set for each row in the outer query. 
the results of an uncorrelated subquery are fixed, and the results of a correlated subquery are relative to each row in the outer query. 

EXISTS is typically coupled with a correlated subquery to achieve meaningful results.

Code: Initial Combination Attempt -- incorrect, need correlated subquery
SELECT Store_location.store_name, 
       Product.product_name, 
       Product.price_in_us_dollars
FROM  Store_location
JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN  Product ON Product.product_id = Sells.product_id
WHERE EXISTS (SELECT Store_location.store_name, Product.product_name
              FROM  Store_location
              JOIN  Sells ON Sells.store_location_id = Store_location.store_location_id
              JOIN  Product ON Product.product_id = Sells.product_id
                            AND product.product_name = 'Cashmere Sweater')
Code: Correlated Subquery
SELECT  Store_location.store_name,
        Product.product_name,
        Product.price_in_us_dollars
FROM   Store_location
JOIN   Sells ON Sells.store_location_id = Store_location.store_location_id
JOIN   Product ON Product.product_id = Sells.product_id
WHERE  EXISTS (SELECT Cashmere_location.store_location_id, Cashmere_location.store_name
               FROM   Store_location Cashmere_location   --alias, identifier
               JOIN   Sells ON Sells.store_location_id =  Cashmere_location.store_location_id
               JOIN   Product ON Product.product_id = Sells.product_id
                              AND Product.product_name = 'Cashmere Sweater'
               WHERE  Cashmere_location.store_location_id = Store_location.store_location_id) --this line that correlates the subquery with the outer query!

Notice that the ID of Cashmere_location must equal the ID of Store_location, and it is this equality that forces the subquery into correlation. 
“Retrieve the store location found in the current row of the outer query only if that store location sells Cashmere sweaters”

coupled with the EXISTS keyword, means that if the current row in the outer query does not contain a store location that sells Cashmere sweaters, it is excluded from the result set.

Correlating the subquery involves changing it from an independent (uncorrelated) subquery to one that references at least one table introduced in the outer query



Step 7 – Using View in Query
A view is a named query that can be used as if it were a table. 



