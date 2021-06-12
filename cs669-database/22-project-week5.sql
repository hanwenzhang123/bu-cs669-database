--STORED PROCEDURES
--Replace this with your stored procedure definitions.
CREATE OR REPLACE FUNCTION AddNewBusinessWithAd(
	  business_id IN DECIMAL, accountname IN VARCHAR, business_name IN VARCHAR, primary_contact IN VARCHAR, 
	  phone_number IN DECIMAL, business_email IN VARCHAR, business_website IN VARCHAR, 
	  ad_id IN DECIMAL, requested_on IN DATE, advertising_type IN VARCHAR, advertising_plan IN TEXT,
	  payment_id IN DECIMAL, payment_method IN DECIMAL, billing_address IN VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Business(business_id, accountname, business_name, primary_contact, phone_number, business_email, business_website)
  VALUES(nextval('business_seq'), accountname, business_name, primary_contact, phone_number, business_email, business_website);
		 
  INSERT INTO Advertisement(ad_id, business_id, requested_on, advertising_type, advertising_plan)
  VALUES(nextval('advertisement_seq'), currval('business_seq'), requested_on, advertising_type, advertising_plan);
		 
  INSERT INTO Payment(payment_id, ad_id, payment_method, billing_address)
  VALUES(nextval('payment_seq'),currval('advertisement_seq'), payment_method, billing_address);
END;
$proc$ LANGUAGE plpgsql


CREATE OR REPLACE FUNCTION AddNewBusiness(
	  business_id IN DECIMAL, accountname IN VARCHAR, business_name IN VARCHAR, primary_contact IN VARCHAR, 
	  phone_number IN DECIMAL, business_email IN VARCHAR, business_website IN VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Business(business_id, accountname, business_name, primary_contact, phone_number, business_email, business_website)
  VALUES(nextval('business_seq'), accountname, business_name, primary_contact, phone_number, business_email, business_website);
END;
$proc$ LANGUAGE plpgsql


CREATE OR REPLACE FUNCTION AddNewAd(
	  ad_id IN DECIMAL, business_id IN DECIMAL, requested_on IN DATE, advertising_type IN VARCHAR, advertising_plan IN TEXT,
	  payment_id IN DECIMAL, payment_method IN DECIMAL, billing_address IN VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Advertisement(ad_id, business_id, requested_on, advertising_type, advertising_plan)
  VALUES(nextval('advertisement_seq'), business_id, requested_on, advertising_type, advertising_plan);
		 
  INSERT INTO Payment(payment_id, ad_id, payment_method, billing_address)
  VALUES(nextval('payment_seq'),currval('advertisement_seq'), payment_method, billing_address);
END;
$proc$ LANGUAGE plpgsql


CREATE OR REPLACE FUNCTION AddNewPublicUser(
	  user_id IN DECIMAL, username IN VARCHAR, first_name IN VARCHAR, last_name IN VARCHAR, 
	  user_email IN DECIMAL, pronouns IN VARCHAR, birthday IN DATE, setting IN CHAR, is_public IN BOOLEAN)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Users(user_id, username, first_name, last_name, user_email, pronouns, birthday, setting)
  VALUES(nextval('user_seq'), username, first_name, last_name, user_email, pronouns, birthday, 'y');

  INSERT INTO Public(user_id, is_public)
  VALUES(currval('user_id'), 'true');

END;
$proc$ LANGUAGE plpgsql


CREATE OR REPLACE FUNCTION AddNewPrivateUser(
	  user_id IN DECIMAL, username IN VARCHAR, first_name IN VARCHAR, last_name IN VARCHAR, 
	  user_email IN DECIMAL, pronouns IN VARCHAR, birthday IN DATE, setting IN CHAR, is_public IN BOOLEAN)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Users(user_id, username, first_name, last_name, user_email, pronouns, birthday, setting)
  VALUES(nextval('user_seq'), username, first_name, last_name, user_email, pronouns, birthday, 'n');

  INSERT INTO Public(user_id, is_private)
  VALUES(currval('user_id'), 'true');

END;
$proc$ LANGUAGE plpgsql

		 
CREATE OR REPLACE FUNCTION SelfcareJournalEntry(
	entry_id IN DECIMAL, user_id IN DECIMAL, entry_date IN DATE, journal_id IN DECIMAL, 
	feeling IN VARCHAR, activity IN VARCHAR, moment IN VARCHAR, gratitude IN VARCHAR, 
	plan IN VARCHAR, rating_id in DECIMAL, rating_scale in DECIMAL)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Entry(entry_id, user_id, entry_date)
  VALUES(nextval('entry_id'), user_id, entry_date);
		 
  INSERT INTO Journal(journal_id, entry_id, feeling, activity, moment, gratitude, plan)
  VALUES(nextval('journal_id'), currval('entry_id'), feeling, activity, moment, gratitude, plan);
		 
  INSERT INTO Rating(rating_id, entry_id, rating_scale)
  VALUES(nextval('rating_id'),currval('entry_id'), rating_scale);
END;
$proc$ LANGUAGE plpgsql

--QUERIES
--Replace this with your queries.

--INDEXES
--Replace this with your index creations.



