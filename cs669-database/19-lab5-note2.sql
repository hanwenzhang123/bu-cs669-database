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
