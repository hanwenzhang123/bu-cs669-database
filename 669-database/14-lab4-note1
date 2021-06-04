Section One – Stored Procedures - something you can call later, a named block
SQL is declarative, handles morstly by SQL, can invoke the procedural language in form of functions, constrained by relational model, called SQL

procedural language is imperative(more specifically, procedural), handle by a seperate engine, can contain SQL CRUD, allows list nested tables etc, PL SQL

Step 1 – Create Table Structure 

A sequence is a database object capable of generating unique primary key values, and is the preferred mechanism for doing so. 
Sequences generate unique whole numbers, starting with the first, and incrementing to the next number each time a new value is needed. 
The database guarantees a sequence will not generate the same number twice, thus making the values unique and suitable for primary keys.


CREATE TABLE Customer(
customer_id    DECIMAL(12) NOT NULL,
customer_first VARCHAR(32),
customer_last  VARCHAR(32),
customer_total DECIMAL(12, 2),
PRIMARY KEY (customer_ID));

CREATE TABLE Item(
item_id
description
price
item_code
PRIMARY KEY (item_id));
DECIMAL(12) NOT NULL,
 VARCHAR(64) NOT NULL,
DECIMAL(10, 2) NOT NULL,
VARCHAR(4) NOT NULL,

CREATE TABLE Customer_order (
order_id    DECIMAL(12) NOT NULL,
customer_id DECIMAL(12) NOT NULL,
order_total DECIMAL(12,2) NOT NULL,
order_date  DATE NOT NULL,
PRIMARY KEY (ORDER_ID),
FOREIGN KEY (CUSTOMER_ID) REFERENCES customer);

CREATE TABLE Line_item(
order_id      DECIMAL(12) NOT NULL,
item_id       DECIMAL(12) NOT NULL,
item_quantity DECIMAL(10) NOT NULL,
line_price    DECIMAL(12,2) NOT NULL,
PRIMARY KEY (ORDER_ID, ITEM_ID),
FOREIGN KEY (ORDER_ID) REFERENCES customer_order,
FOREIGN KEY (ITEM_ID) REFERENCES item);


The SQL syntax for creating a basic sequence is straightforward: 
CREATE SEQUENCE <sequencename> START WITH 1

For example, if we had a Person table and that table needed a sequence, 
we would name the sequence “person_seq”.

CREATE SEQUENCE customer_seq START WITH 1;
CREATE SEQUENCE item_seq START WITH 1;
CREATE SEQUENCE customer_order_seq START WITH 1;



Step 2 – Populate Tables

// sequence’s current value - automatically generates the key
external object - sequence - better performance

--Insert first customer and order - it is important to only insert one at‐a‐time
 we can control the order of inserts, and we insert the referencing values immediately after the referenced values
INSERT INTO customer VALUES(nextval('customer_seq'),'John','Smith',0);
INSERT INTO customer_order VALUES(nextval('customer_order_seq'),currval('customer_seq'), 506,CAST('18-DEC-2005' AS DATE));


nextval(‘customer_seq’) is used to retrieve the next unique value for the primary key from customer_seq, next value
currval('customer_seq') to retrieve the current value of customer_seq. most likely for foreign key, current value
 Getting the current value does not advance the sequence; rather, it retrieves the last unique value retrieved. 
combination of nextval and currval 
 customer_order_id primary key value is retrieved with one sequence
 the customer_id foreign key is retrieved with another sequence



//subquery lookup

Code: Inserting All Items
INSERT INTO item VALUES(nextval('item_seq'),'Plate',10, 'P001');
INSERT INTO item VALUES(nextval('item_seq'),'Bowl',11, 'B002');
INSERT INTO item VALUES(nextval('item_seq'),'Knife',5, 'K003');
INSERT INTO item VALUES(nextval('item_seq'),'Fork',5, 'F004');
INSERT INTO item VALUES(nextval('item_seq'),'Spoon',5, 'S005');
INSERT INTO item VALUES(nextval('item_seq'),'Cup',12, 'C006');

 
Code: Inserting Line Items for First Order - using a subquery lookup
--Create the line items for the first order.
INSERT INTO line_item
VALUES(currval('customer_order_seq'),(SELECT item_id FROM item WHERE description='Plate'),10,100);
INSERT INTO line_item
VALUES(currval('customer_order_seq'),(SELECT item_id FROM item WHERE description='Spoon'),2,10);
INSERT INTO line_item
VALUES(currval('customer_order_seq'),(SELECT item_id FROM item WHERE description='Bowl'),36,396);


For retrieving the primary key of each item, 
we use the subquery (SELECT item_id FROM item WHERE description=<item_description>). instead of hardcoding a single value
 
 
Code: Viewing First Order
--Get the first order details.
SELECT customer_first, customer_last, description, item_quantity
FROM   Customer
JOIN   Customer_order ON customer_order.customer_id = Customer.customer_id
JOIN   Line_item ON line_item.order_id = customer_order.order_id
JOIN   Item ON item.item_id = line_item.item_id;

 
Code: Viewing All Orders
--Get all order details.
SELECT customer_first, customer_last, order_date, description, item_quantity,
line_price
FROM   Customer
JOIN   Customer_order ON customer_order.customer_id = Customer.customer_id
JOIN   Line_item ON line_item.order_id = customer_order.order_id
JOIN   Item ON item.item_id = line_item.item_id
ORDER BY customer_first, customer_last, order_date, description;




Step 3 – Create Hardcoded Procedure
 
Code: Creating add_customer_harry Procedure

CREATE OR REPLACE PROCEDURE ADD_CUSTOMER_HARRY()
AS
$proc$ //start a string iterale and give it a name, can be anything
      BEGIN
        INSERT INTO Customer (customer_id,customer_first,customer_last, customer_total)
        VALUES (nextval('customer_seq'), 'Harry', 'Joker', 0);
      END;
$proc$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE
- A stored procedure is to be created, and that the creation replaces any existing definition of a function with the same name. 

The ADD_CUSTOMER_HARRY() word is the name of the procedure. 
This name is an identifier, which means that the language allows us to define our own name.

AS is a SQL keyword that is required by the language to define a function, but otherwise has no significant meaning.

$proc$
the procedural language always exists within a block within SQL.
This block is simply a string literal from the prospective of the CREATE OR REPLACE PROCEDURE command is concerned. 
we use dollar quoting, denoted by the characters “$$”, to write the procedure body instead of using single quotes.
The “proc” in between the dollar signs is a label that adds to readability and is optional.


The BEGIN keyword is part of the opening definition of a block, and is always accompanied with an END keyword which closes the block. 

why is this SQL statement inside of the procedural language block? 
Because certain SQL commands can be embedded inside of the procedural language in the right context.

$proc$ LANGUAGE plpgsql
procedure body is actually a quoted literal, and this second set of “$$” characters ends the quoted block.



Code: Executing add_customer_harry Procedure
CALL ADD_CUSTOMER_HARRY();
 
The CALL keyword is used to execute the stored procedure we have created. 



Step 4 – Create Reusable Procedure
 
Code: Creating add_customer Procedure

CREATE OR REPLACE PROCEDURE ADD_CUSTOMER( -- Create a new customer
   first_name_arg IN VARCHAR, -- The new customer’s first name
   last_name_arg IN VARCHAR) -- The new customer’s last name
   LANGUAGE plpgsql
AS -- Required by the syntax, but it doesn’t do anything in particular
$resuableproc$ --opens the $$ quotation for the block
BEGIN
   INSERT INTO CUSTOMER(customer_id,customer_first,customer_last,customer_total)
   VALUES(nextval('customer_seq'),first_name_arg,last_name_arg,0);
    -- We start the customer with zero balance.
END;
$resuableproc$; -- closes the $$ quotation for the block


 Code: Executing add_customer Procedure
 CALL ADD_CUSTOMER('Mary', 'Smith');
 
 

Step 5 – Create Deriving Procedure 

using a variable is the new skill for this step.
A variable is a named placeholder that can store a value, and can later be referenced by name to retrieve the stored value.

Pseudocode for Basic Variable Use
1: Declare variable v_item_code as a character string
2: Calculate a unique value and store it in the v_item_code variable
3: Insert whatever value is in the v_item_code variable into the item table

 
Code: Creating add_item Procedure

CREATE OR REPLACE PROCEDURE ADD_ITEM(
  p_description IN VARCHAR, -- The item's description
  p_price IN DECIMAL), -- The item's price
  LANGUAGE plpgsql
AS
$$ DECLARE
  v_item_code VARCHAR(4);     --Declare a variable to hold an item_code value.
BEGIN
   --Calculate the item_code value and put it into the variable.
   v_item_code := SUBSTRING(p_description FROM 1 FOR 1) || FLOOR(RANDOM() * 1000);
   --Insert a row with the combined values of the parameters and the variable.
   INSERT INTO ITEM (item_id, description, price, item_code)
   VALUES(nextval('item_seq'), p_description, p_price, v_item_code);
END;
$$; (NEXT VALUE FOR item_seq, @p_description, @p_price, @v_item_code);
END;



Step 6 – Create Lookup Procedure

setting the value of a variable based upon the results of a query. 
Rather than the executor specifying the item_id, the stored procedure will take the item_code as a parameter, then lookup the item_id.
 
Code: ADD_LINE_ITEM procedure

CREATE OR REPLACE PROCEDURE ADD_LINE_ITEM(
  p_item_code IN VARCHAR,
  p_order_id IN DECIMAL,
  p_quantity IN DECIMAL)
  LANGUAGE plpgsql
AS $$ 
DECLARE
v_item_id DECIMAL(12);
v_line_price DECIMAL(12,2);
BEGIN
   --Get the item_id based upon the item_code, as well as the line total.
   SELECT item_id, price * p_quantity
   INTO   v_item_id, v_line_price
   FROM   Item
   WHERE  item_code = p_item_code;
   --Insert the new line item.
   INSERT INTO LINE_ITEM(item_id, order_id, item_quantity, line_price)
   VALUES(v_item_id, p_order_id, p_quantity, v_line_price);
END; $$;
