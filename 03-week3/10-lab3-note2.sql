Section Two – Normalization and Data Visualization
Step 8 – Creating Normalized Table Structure

1NF
1NF ensures the table is valid.
- All rows must be unique (no duplicate rows) - we can add ID
- each cell must only contain a single value (not a list) - move to seperate tables
- each value should be non divisible (can not be split down further)

There must be only one value in each cell (no repeating groups).
Identify Functional Dependencies
Identify Candidate Keys
Identify Partial Dependencies
Removing Partial Dependencies


A - > BCD


2NF eliminates partial dependencies.
The table must contain no partial dependencies.

B depends on A, but not entirely


BC - > AD




3NF eliminates transitive dependencies.
The column depends on another column which is not a primary key
we can put the data to a new table 
The table must not have transitive dependencies.


Identify Transitive Dependencies
Remove Transitive Dependencies - move to a different seperate table


D -> B




BCNF eliminates every problematic single-valued dependency.
It is not mandatory to go through 2NF and 3NF to move to BCNF.
Simply apply the rule “every determinant must be a candidate key” repeatedly, extracting items to a new table, until the normalization is complete.
This rule will also eliminate partial and transitive dependencies.

Identify Non-Candidate Determinants
Remove Non-Candidate Determinants

Candidate key - unique and non-null identify a row like student_id in student table
there are can be more than one candidate key in the table like student_id and student_phone


X - Y

X is a super key

A candidate key is a super key but vice versa is not true



Step 9 – Visualizing Data with One or Two Measures


Step 10 – Another Data Visualization
