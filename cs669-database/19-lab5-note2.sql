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
