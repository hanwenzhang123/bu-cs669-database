Data normalization is a database design technique that aims to reduce redundant (repetitive, useless) data and eliminate anomalies like insertion, update and deletion. All stored data logically makes sense.

1NF (First Normal Form) which ensures the table is valid, there must be only one value in each cell (no repeating groups).
All rows must be unique (no duplicate rows) - we can add ID
Each cell must only contain a single value (not a list) - we can move to seperate tables
Each value should be non divisible (can not be split down further)

2NF (Second Normal Form) which eliminates partial dependencies.
All the requirements in 1NF must be met. 
The table must contain no partial dependencies. - we can use foreign keys to reference the primary key of another table that helps connect tables.
Partial dependency is when B depends on A which is a part of the candidate keys, so B depends on A as its primary key rather than depends on the whole candidate key. 

3NF (Third Normal Form) which eliminates transitive dependencies.
All the requirements in 2NF must be met. 
The table must not have transitive dependencies. - we can again divide our tables and created a new table, and move the transitive dependencies to a different separate table
Transitive dependency is something that depends on something that is not a part of the primary key, both are non-prime attributes. 

BCNF (Boyce-Codd Normal Form)
All the requirements in 3NF must be met. 
BCNF does not allow when a non-prime attribute drives a prime attribute. 
For each dependency ( X => Y ), X should be a super key but vice versa is not true. - still there would be anomalies resulting if it has more than one candidate key, we can identify the non-candidate keys and move them until only if every determinant is a candidate key.
Super key uniquely identifies each record in the table with all possible sets of keys. Candidate key is a minimal set of super keys that can uniquely identify the data in the table.
