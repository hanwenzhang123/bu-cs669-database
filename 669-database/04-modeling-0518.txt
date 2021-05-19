Modeling is a collection of information that is organized, so data can be easily stored, managed, updated and retrieved. 

Modeling like a blueprint - allows to visualize, analyze before establish

the relationship model - row in same and different relations can be related


Operations on relations
the relational model has a math basis in set theory. Therefore, many set operation can be applied to relation.

SELECT Operation - generate to a new relation
PROJECT Operation - only one column
PRODUCT - comebine the column of two relations
JOIN - relate tables together, something in common then join together, like join city to the state


Integrity constraint
primary key - unique and not null, like person_id
foreign key - any reference that is valid, check if equal, adress_id in address and in employee table
not null - must be with value
unique - does not require the column be not null, like ssn can be null like someone does not have a ssn
check - boolean, true or false, any column in the table, hourly rate or salary rate, both can not be filled in same time
    e.g. CHECK (hourly-rate IS NOT NULL OR salary IS NOT NULL)) AND NOT (hourly-rate IS NOT NULL AND salary IS NOT NULL)

  
The fundamentals you define in your structural database rules – significant entities, relationships, and constraints 
– determines the structure of your database throughout all phases of development. 
