--STORED PROCEDURES
--Replace this with your stored procedure definitions.
CREATE OR REPLACE FUNCTION AddNewPublicUser(
	  user_id IN DECIMAL, username IN VARCHAR, first_name IN VARCHAR, last_name IN VARCHAR, 
	  user_email IN VARCHAR, pronouns IN VARCHAR, birthday IN DATE, setting IN CHAR, is_public IN BOOLEAN)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Users(user_id, username, first_name, last_name, user_email, pronouns, birthday, setting)
  VALUES(user_id, username, first_name, last_name, user_email, pronouns, birthday, 'y');

  INSERT INTO Public(user_id, is_public)
  VALUES(user_id, 'true');
END;
$proc$ LANGUAGE plpgsql


START TRANSACTION;

DO
 $$BEGIN
   EXECUTE AddNewPublicUser(1, 'allansmith123', 'Allan', 'Smith', 'allansmith123@gmail.com', 'he/him/his', '08-08-1980');
   EXECUTE AddNewPublicUser(2, 'bryanbrown123', 'Bryan', 'Brown', 'bryanbrown123@gmail.com', 'he/him/his', '08-08-1981');
   EXECUTE AddNewPublicUser(3, 'charleswilliams123', 'Charles', 'Williams', 'charleswilliams123@gmail.com', 'he/him/his', '08-08-1982');
   EXECUTE AddNewPublicUser(4, 'davidjohnson123', 'David', 'Johnson', 'davidjohnson123@gmail.com', 'he/him/his', '08-08-1983');
   EXECUTE AddNewPublicUser(5, 'helenmiller123', 'Helen', 'Miller', 'helenmiller123@gmail.com', 'she/her/hers', '08-08-1994');
END$$;

COMMIT TRANSACTION;


CREATE OR REPLACE FUNCTION AddNewPrivateUser(
	  user_id IN DECIMAL, username IN VARCHAR, first_name IN VARCHAR, last_name IN VARCHAR, 
	  user_email IN VARCHAR, pronouns IN VARCHAR, birthday IN DATE, setting IN CHAR, is_private IN BOOLEAN)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Users(user_id, username, first_name, last_name, user_email, pronouns, birthday, setting)
  VALUES(user_id, username, first_name, last_name, user_email, pronouns, birthday, 'n');

  INSERT INTO Private(user_id, is_private)
  VALUES(user_id, 'true');
END;
$proc$ LANGUAGE plpgsql

DROP FUNCTION addnewprivateuser(
	  user_id IN DECIMAL, username IN VARCHAR, first_name IN VARCHAR, last_name IN VARCHAR, 
	  user_email IN VARCHAR, pronouns IN VARCHAR, birthday IN DATE, setting IN CHAR, is_private IN BOOLEAN)


START TRANSACTION;

DO
 $$BEGIN
   EXECUTE AddNewPrivateUser(6, 'elangarcia123', 'Elan', 'Garcia', 'elangarcia123@gmail.com', 'he/him/his', '08-08-1984');
   EXECUTE AddNewPrivateUser(7, 'frankdavis123', 'Frank', 'Davis', 'frankdavis123@gmail.com', 'he/him/his', '08-08-1985');
   EXECUTE AddNewPrivateUser(8, 'jordonhernandez123', 'Jordon', 'Hernandez', 'jordonhernandez123@gmail.com', 'he/him/his', '08-08-1991');
   EXECUTE AddNewPrivateUser(9, 'kevinwilson123', 'Kevin', 'Wilson', 'kevinwilson123@gmail.com', 'he/him/his', '08-08-1993');
   EXECUTE AddNewPrivateUser(10, 'lisajackson123', 'Lisa', 'Jackson', 'lisajackson123@gmail.com', 'she/her/hers', '08-08-1992');
END$$;

COMMIT TRANSACTION;


SELECT * FROM USERS;
SELECT * FROM Public;
SELECT * FROM Private;

		 
CREATE OR REPLACE FUNCTION SelfcareJournalEntry(
	entry_id IN DECIMAL, user_id IN DECIMAL, entry_date IN DATE, journal_id IN DECIMAL, 
	feeling IN VARCHAR, activity IN VARCHAR, moment IN VARCHAR, gratitude IN VARCHAR, 
	plan IN VARCHAR, rating_id in DECIMAL, rating_scale in DECIMAL)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Entry(entry_id, user_id, entry_date)
  VALUES(entry_id, user_id, entry_date);
		 
  INSERT INTO Journal(journal_id, entry_id, feeling, activity, moment, gratitude, plan)
  VALUES(journal_id, entry_id, feeling, activity, moment, gratitude, plan);
		 
  INSERT INTO Rating(rating_id, entry_id, rating_scale)
  VALUES(rating_id, entry_id, rating_scale);
END;
$proc$ LANGUAGE plpgsql


START TRANSACTION;

DO
 $$BEGIN
EXECUTE SelfcareJournalEntry(1, 1, '06-01-2021', 1, 'I feel good today', 'I praticed yoga', 'When I feel refreshed after yoga', 'Peaceful world', 'Eat sushi tomorrow', 1, 5);
EXECUTE SelfcareJournalEntry(2, 7, '05-01-2021', 2, 'I am a bit tired today', 'Nothing much, just work', 'When I finish my work', 'Tomorrow is Friday', 'Happy hour after work', 2, 2);
EXECUTE SelfcareJournalEntry(3, 3, '05-21-2021', 3, 'Excited!!!', 'I won lottery', 'When I know I won the loterry', 'Money', 'Spend money', 3, 5);
EXECUTE SelfcareJournalEntry(4, 3, '06-12-2021', 4, 'Just so so', 'Nothing, did housework', 'When I finished the housework', 'Organized room', 'Go for grocery shopping', 4, 3);
EXECUTE SelfcareJournalEntry(5, 4, '04-08-2020', 5, 'I am okay', 'I ran', 'When I sweat', 'Being healthy', 'Running more', 5, 4);
EXECUTE SelfcareJournalEntry(6, 4, '02-20-2020', 6, 'Happy', 'I finished my homework', 'The moment I clicked submit', 'Education', 'Study for the new chapter', 6, 4);
EXECUTE SelfcareJournalEntry(7, 5, '06-10-2021', 7, 'I feel fine', 'Just work as usual', 'My lunch was really yummy', 'Foods', 'Eat more food', 7, 5);
EXECUTE SelfcareJournalEntry(8, 8, '06-06-2021', 8, 'I am sad', 'I broke up', 'Nope', 'I am still alive', 'Stay home and recharge', 8, 1);
EXECUTE SelfcareJournalEntry(9, 6, '06-08-2020', 9, 'Average', 'Just stayed home binge watching Netflix', 'When I finished the show', 'Good movie', 'Watch more tomorrow', 9, 3);
EXECUTE SelfcareJournalEntry(10, 2, '08-01-2020', 10, 'An awful day', 'I lost my wallet', 'Nothing', 'People helping me and comfort me', 'Find my wallet', 10, 1);
END$$;

COMMIT TRANSACTION;


SELECT * FROM Entry;
SELECT * FROM Journal;
SELECT * FROM Rating;


CREATE OR REPLACE FUNCTION AddNewBusiness(
	  business_id IN DECIMAL, accountname IN VARCHAR, business_name IN VARCHAR, phone_number IN DECIMAL, 
	  primary_contact IN VARCHAR, business_email IN VARCHAR, business_website IN VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Business(business_id, accountname, business_name, phone_number, primary_contact, business_email, business_website)
  VALUES(business_id, accountname, business_name, phone_number, primary_contact, business_email, business_website);
END;
$proc$ LANGUAGE plpgsql


START TRANSACTION;

DO
 $$BEGIN
 EXECUTE AddNewBusiness(1, 'saferselfcare', 'Safer Selfcare', 1234567890, 'Sarah Chen', 'saferselfcare@gmail.com', 'saferselfcare.com');
 EXECUTE AddNewBusiness(2, 'youarecountable', 'You Are Countable', 2345678901, 'Jimmy James', 'youarecountable@gmail.com', 'youarecountable.com');
 EXECUTE AddNewBusiness(3, 'lovemyself', 'Love Myself', 3456789012, 'Susan Garcia', 'lovemyself@gmail.com', 'lovemyself.com');
 EXECUTE AddNewBusiness(4, 'heartselfcare', 'Heart Selfcare', 4561237890, 'Daisy Lee', 'heartselfcare@gmail.com', 'heartselfcare.com');
 EXECUTE AddNewBusiness(5, 'sunshineup', 'Sunshine Up', 7894561230, 'Sean Perez', 'sunshineup@gmail.com', 'sunshineup.com');
 EXECUTE AddNewBusiness(6, 'smile100up', 'Smile 100 Up', 4567891230, 'Cherry Hall', 'smile100up@gmail.com', 'smile100up.com');
 EXECUTE AddNewBusiness(7, 'mentalwellness', 'Mental Wellness', 1824567390, 'Jack Walker', 'mentalwellness@gmail.com', 'mentalwellness.com');
 EXECUTE AddNewBusiness(8, 'happylocator', 'Happy Locator', 2135468790, 'Richard Lewis', 'happylocator@gmail.com', 'happylocator.com');
 EXECUTE AddNewBusiness(9, 'selfcarelab', 'Selfcare Lab', 1324657980, 'Elsa Robinson', 'selfcarelab@gmail.com', 'selfcarelab.com');
 EXECUTE AddNewBusiness(10, 'mentaltoolbox', 'Mental Toolbox', 3126457980, 'Alma Clark', 'mentaltoolbox@gmail.com', 'mentaltoolbox.com');
 END$$;

COMMIT TRANSACTION;


SELECT * FROM Business;


CREATE OR REPLACE FUNCTION AddNewAd(
	  ad_id IN DECIMAL, business_id IN DECIMAL, requested_on IN DATE, advertising_type IN VARCHAR, advertising_plan IN TEXT,
	  payment_id IN DECIMAL, payment_method IN DECIMAL, billing_address IN VARCHAR)
RETURNS VOID
AS
$proc$
BEGIN
  INSERT INTO Advertisement(ad_id, business_id, requested_on, advertising_type, advertising_plan)
  VALUES(ad_id, business_id, requested_on, advertising_type, advertising_plan);
		 
  INSERT INTO Payment(payment_id, ad_id, payment_method, billing_address)
  VALUES(payment_id, ad_id, payment_method, billing_address);
END;
$proc$ LANGUAGE plpgsql



--QUERIES
--Replace this with your queries.

--INDEXES
--Replace this with your index creations.




