Section Three – Advanced Data Expression

Step 11 – Evaluating Boolean Expressions

AND Boolean Operator
“Is condition 1 true AND condition 2 true?”
 true AND true = true
 true AND false = false
 false AND true = false
 false and false = false

OR Boolean Operator
“Is condition 1 true OR is condition 2 true?”
 true OR true = true
 true OR false = true
 false OR true = true
 false OR false = false

NOT Boolean Operator
“Is this NOT true?” 
 NOT true = false
 NOT false = true


Nesting Operations
NOT (condition1 AND condition2)
“Condition1 and Condition2 must not both be true”
NOT (first_name = ‘Bill’ AND last_name = ‘Glass’)

(condition1 AND condition2) OR (condition3 AND condition4)



Step 12 – Using Boolean Expressions in Queries
The <> operator yields true if the left‐hand value is not equal to the right‐hand value, and false otherwise
The expression last_name <> ‘Glass’ would match any row where the last name is not “Glass”.



Step 13 – Using Generated Columns 
Code: Multiply Table in Oracle and SQL Server
CREATE TABLE Multiply (
x decimal(4) NOT NULL,
y decimal(4) NOT NULL,
result AS (x * y));

 
Code: Multiply Table in Postgres
CREATE TABLE Multiply (
x decimal(4) NOT NULL,
y decimal(4) NOT NULL,
result decimal(12) GENERATED ALWAYS AS (x * y) STORED);


 
Code: Listing Eligible Products
SELECT Product.*,
       (length_inches*height_inches*width_inches)/1728 AS cubic_feet
FROM   Product
WHERE  name = 'Lightbulb' OR
       ((length_inches*height_inches*width_inches)/1728 >= 4 AND
         launch_date >= CAST('01-JAN-2021' AS DATE))
         
         
         
 
Code: Adding Flag to Product Table in Oracle/SQL Server
ALTER TABLE Product
ADD extra_charge_flag AS
(CASE
   WHEN name = 'Lightbulb' OR
        ((length_inches*height_inches*width_inches)/1728 >= 4 AND
          launch_date >= CAST('01-JAN-2021' AS DATE)) THEN 1
   ELSE 0
END);


 
Code: Adding Flag to Product Table in Postgres
ALTER TABLE Product
ADD extra_charge_flag Boolean GENERATED ALWAYS AS
(CASE
   WHEN name = 'Lightbulb' OR
        ((length_inches*height_inches*width_inches)/1728 >= 4 AND
          launch_date >= CAST('01-JAN-2021' AS DATE)) THEN true
   ELSE false
END) STORED;
