CREATE OR REPLACE FUNCTION PriceChangeFunction() 
RETURNS TRIGGER LANGUAGE plpgsql
AS $trigfunc$   
  BEGIN    
  INSERT INTO PriceChange(PriceChangeID, OldPrice, NewPrice, CarID, ChangeDate)   
  VALUES(nextval('PriceChangeSeq'),           
    OLD.Price,           
    NEW.Price,           
    New.CarID,           
    current_date);               
   RETURN NEW;   
   END; 
$trigfunc$;             

CREATE TRIGGER PriceChangeTrigger 
BEFORE UPDATE OF Price ON Car 
FOR EACH ROW  
EXECUTE PROCEDURE PriceChangeFunction();
