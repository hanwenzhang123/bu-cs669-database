Aggregating Data
data aggregation - reports, grouping, summary, data analysis, etc
a single value across all rows or across groups of rows


Order of WHERE
- after the SELECT and FROM because they run first


max and min
AS - naming that colomn for the result
MAX() AS __, MIN() AS __


Grouping - group by the value
- aggregate function
group them then run by group
find all the unique value for that column

Do the from and group by first 


HAVING limites the results of aggregating data
WHERE only works rows by rows

Grouping first then filter down by the HAVING


Order of operation summary
FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY



Normalization

A functional dependency as A->B
Once you have A, You can figure out B, A determines B

What column determines what column



1NF - basic

if you know date, then you know todays topics

once you know the photographer id then you know the name
once you know date and tripod tag name then you know tripod model


Step 2: identify functional dependencies

Step 3 - we must identify all candidate key

Step 4 - identify partial dependencies

partial dependency
AB - CD
B - C

Step 5 -Removing dependent tables

2NF 

Identify transitive dependencies

3NF

know how to explain BCNF

every determinant must be a candidate key


