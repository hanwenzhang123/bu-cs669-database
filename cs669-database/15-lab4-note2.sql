Section Two – Triggers  - database automatically calls it
Step 7 – Single Table Validation Trigger

all triggers are associated to an event that determines when its code is executed.
specific event is defined as part of the overall definition of the trigger when it is created. 
The database then automatically invokes the trigger when the defined event occurs. 


within a single table (that is, the validation can be performed by using columns in the table being modified).


create a trigger that prevents the customer balance from being negative. 
 
Code: No Negative Balance Validation Trigger

CREATE OR REPLACE FUNCTION no_neg_bal_func()
 RETURNS TRIGGER LANGUAGE plpgsql
 AS $trigfunc$
 BEGIN
   RAISE EXCEPTION USING MESSAGE = 'Customer balance cannot be negative.',
   ERRCODE = 22000;
 END;
$trigfunc$;
CREATE TRIGGER no_neg_bal_trg
BEFORE UPDATE OR INSERT ON Customer
FOR EACH ROW WHEN(NEW.customer_total < 0)
EXECUTE PROCEDURE no_neg_bal_func();



Step 8 – Cross-Table Validation Trigger
cross-table validation (that is, the validation needs columns from at least one table external to the table being updated).


validate the fact that the line price for a line item actually equals the quantity times the item price. 

 
Code: Correct Line Price Validation Trigger

CREATE OR REPLACE FUNCTION line_price_func()
RETURNS TRIGGER LANGUAGE plpgsql
AS $$
DECLARE
  v_correct_line_price DECIMAL(12,2);
BEGIN
   SELECT NEW.item_quantity * Item.price
   INTO   v_correct_line_price
   FROM   Item
   WHERE  item.item_id = NEW.item_id;
   IF NEW.line_price <> v_correct_line_price THEN
     RAISE EXCEPTION USING MESSAGE = 'The line price is incorrect.',
     ERRCODE = 22000;
END IF;
   RETURN NEW;
END;
$$;

CREATE TRIGGER line_price_trg
BEFORE UPDATE OR INSERT ON Line_item
FOR EACH ROW
EXECUTE PROCEDURE line_price_func();


Step 9 – History Trigger
maintain a history of values as they change.

 
Code: Create the Item_price_history Table
CREATE TABLE Item_price_history (
item_id DECIMAL(12) NOT NULL,
old_price DECIMAL(10,2) NOT NULL,
new_price DECIMAL(10,2) NOT NULL,
change_date DATE NOT NULL,
FOREIGN KEY (item_id) REFERENCES Item(item_id));


 
Code: The Item_price_history Trigger
CREATE OR REPLACE FUNCTION item_history_func()
RETURNS TRIGGER LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.price <> NEW.price THEN
        INSERT INTO Item_price_history(item_id, old_price, new_price, change_date)
        VALUES(NEW.item_id, OLD.price, NEW.price, CURRENT_DATE);
END IF;
    RETURN NEW;
END;
$$;
CREATE TRIGGER item_history_trg
BEFORE UPDATE ON Item
FOR EACH ROW
EXECUTE PROCEDURE item_history_func();



Section Three – Concurrency

client database - connects to each other
a session in between, transaction between it

Atomicity - all or nothing, all transaction or none, no middle ground
consistency - has to be consistent, all the constraint must be satisfied, data is consistent
isolation - change made by incomplete, uncommited
durability - effects of a comitted transaction are permanent and must not be lost because of later failure of the platform
serializability - each transaction the database behaves as if this were the only transaction  A->B->C


what if it happens?

A lost update is when results from one transaction are overwritten by a simultaneously executing transaction

Step 10 – Issues with No Concurrency Control



Step 11 – Issues with Locking and Multiversioning



