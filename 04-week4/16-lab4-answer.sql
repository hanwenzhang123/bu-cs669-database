Section One – Stored Procedures
Step 1 – Create Table Structure 
 
CREATE TABLE Person(
person_id DECIMAL(12) NOT NULL,
first_name VARCHAR(32) NOT NULL,
last_name VARCHAR(32) NOT NULL,
username VARCHAR(20) NOT NULL,
PRIMARY KEY (person_id));

CREATE TABLE Post(
post_id DECIMAL(12) NOT NULL,
person_id DECIMAL(12) NOT NULL,
content VARCHAR(255) NOT NULL,
created_on DATE NOT NULL,
summary VARCHAR(15) NOT NULL,
PRIMARY KEY (post_id),
FOREIGN KEY (person_id) REFERENCES Person);

CREATE TABLE Likes(
likes_id DECIMAL(12) NOT NULL,
person_id DECIMAL(12) NOT NULL,
post_id DECIMAL(12) NOT NULL,
liked_on DATE,
PRIMARY KEY (likes_id),
FOREIGN KEY (person_id) REFERENCES Person,
FOREIGN KEY (post_id) REFERENCES Post);

CREATE SEQUENCE person_seq START WITH 1;
CREATE SEQUENCE post_seq START WITH 1;
CREATE SEQUENCE likes_seq START WITH 1;


Step 2 – Populate Tables

INSERT INTO Person
VALUES(nextval('person_seq'), 'Allan', 'Smith', 'allansmith123');
INSERT INTO Person
VALUES(nextval('person_seq'), 'Bryan', 'Brown', 'bryanbrown123');
INSERT INTO Person
VALUES(nextval('person_seq'), 'Charles', 'Williams', 'charleswilliams123');
INSERT INTO Person
VALUES(nextval('person_seq'), 'David', 'Johnson', 'davidjohnson123');
INSERT INTO Person
VALUES(nextval('person_seq'), 'Edison', 'Miller', 'edisonmiller123');

SELECT * FROM Person;



DELETE FROM Post
WHERE post_id IN (1, 2, 3, 4, 5);

ALTER SEQUENCE post_seq RESTART


INSERT INTO Post
VALUES(nextval('post_seq'), (SELECT person_id FROM Person WHERE username='davidjohnson123'), 'Eating pizza in my backyard.', '08-01-2020', (SUBSTR('Eating pizza in my backyard.', 1, 12) || '...'));
INSERT INTO Post
VALUES(nextval('post_seq'), (SELECT person_id FROM Person WHERE username='charleswilliams123'), 'I love Miami beach YAY!!!', '02-01-2021', (SUBSTR('I love Miami beach YAY!!!', 1, 12) || '...'));
INSERT INTO Post 
VALUES(nextval('post_seq'), (SELECT person_id FROM Person WHERE username='bryanbrown123'), 'Check out my social media accounts.', '04-01-2020', (SUBSTR('Check out my social media accounts.', 1, 12) || '...'));
INSERT INTO Post
VALUES(nextval('post_seq'), (SELECT person_id FROM Person WHERE username='allansmith123'), 'Too much work and too little pay.', '04-01-2021', (SUBSTR('Too much work and too little pay.', 1, 12) || '...'));
INSERT INTO Post
VALUES(nextval('post_seq'), (SELECT person_id FROM Person WHERE username='bryanbrown123'), 'Take a look at these new pics.', '05-01-2020', (SUBSTR('Take a look at these new pics.', 1, 12) || '...'));
INSERT INTO Post
VALUES(nextval('post_seq'), (SELECT person_id FROM Person WHERE username='edisonmiller123'), 'Just arrived in the New York!', '10-01-2020', (SUBSTR('Just arrived in the New York!', 1, 12) || '...'));
INSERT INTO Post
VALUES(nextval('post_seq'), (SELECT person_id FROM Person WHERE username='davidjohnson123'), 'Happy Friday with Happy hours.', '07-01-2020', (SUBSTR('Happy Friday with Happy hours.', 1, 12) || '...'));
INSERT INTO Post
VALUES(nextval('post_seq'), (SELECT person_id FROM Person WHERE username='charleswilliams123'), 'I am having a Monday Syndrome.', '01-01-2021', (SUBSTR('I am having a Monday Syndrome.', 1, 12) || '...'));

SELECT * from Post




DELETE FROM Likes
WHERE likes_id IN (1, 2, 3, 4, 5, 6, 7, 8);

ALTER SEQUENCE likes_seq RESTART


INSERT INTO Likes (likes_id, person_id, post_id, liked_on)
VALUES(nextval('likes_seq'), (SELECT person_id FROM Person WHERE person_id = 3), (SELECT post_id FROM Post WHERE post_id = 8), '06-01-2021');
INSERT INTO Likes (likes_id, person_id, post_id, liked_on)
VALUES(nextval('likes_seq'), (SELECT person_id FROM Person WHERE person_id = 2), (SELECT post_id FROM Post WHERE post_id = 1), '06-02-2021');
INSERT INTO Likes (likes_id, person_id, post_id, liked_on)
VALUES(nextval('likes_seq'), (SELECT person_id FROM Person WHERE person_id = 1), (SELECT post_id FROM Post WHERE post_id = 4), '06-03-2021');
INSERT INTO Likes (likes_id, person_id, post_id, liked_on)
VALUES(nextval('likes_seq'), (SELECT person_id FROM Person WHERE person_id = 5), (SELECT post_id FROM Post WHERE post_id = 7), '06-04-2021');

SELECT * from Likes



--Get all posts details
SELECT Person.username, content, created_on, Likes.liked_on
FROM Post
LEFT JOIN Person ON Post.person_id = Person.person_id
LEFT JOIN Likes ON Post.post_id = Likes.post_id
ORDER BY username;


--Get all posts details
SELECT ('The user: ' || Person.username || ' posted \"' || content || '\" on ' || created_on || ' and received ' || COUNT(Likes.liked_on) || ' likes!!!') AS posting_details
FROM Post
LEFT JOIN Person ON Post.person_id = Person.person_id
LEFT JOIN Likes ON Post.post_id = Likes.post_id
GROUP BY Person.username, content, created_on, Likes.liked_on
ORDER BY username;



Step 3 – Create Hardcoded Procedure

--Create a stored procedure
CREATE OR REPLACE PROCEDURE add_michelle_stella()
AS
$proc$
      BEGIN
        INSERT INTO Person
        VALUES (nextval('person_seq'), 'Michelle', 'Stella', 'michellestella123');
      END;
$proc$ LANGUAGE plpgsql;

CALL add_michelle_stella();

SELECT * FROM Person;




Step 4 – Create Reusable Procedure

--Create Reusable Procedure
CREATE OR REPLACE PROCEDURE add_person(
   first_name_arg IN VARCHAR,
   last_name_arg IN VARCHAR,
   username_arg IN VARCHAR)
   LANGUAGE plpgsql
AS
$resuableproc$
BEGIN
   INSERT INTO Person(person_id, first_name, last_name, username)
   VALUES(nextval('person_seq'), first_name_arg, last_name_arg, username_arg);
END;
$resuableproc$;

CALL add_person('Frank', 'Davis', 'frankdavis123');

SELECT * FROM Person;



Step 5 – Create Deriving Procedure

DELETE FROM Post
WHERE post_id IN (9, 10, 11, 12, 13);

ALTER SEQUENCE post_seq RESTART WITH 8;


--Create Deriving Procedure 
CREATE OR REPLACE PROCEDURE add_post(
  p_person_is IN DECIMAL
  p_content IN VARCHAR,
  p_created_on IN DATE)
  LANGUAGE plpgsql
AS
$$ DECLARE
  v_summary VARCHAR;
BEGIN
   v_summary := SUBSTRING(p_content FROM 1 FOR 11) || '...';
   INSERT INTO POST (post_id, person_id, content, created_on, summary)
   VALUES(nextval('post_seq'), p_person_id, p_content, p_created_on, v_summary);
END;
$$;

CALL add_post(4, 'I just had 3 big slices pizza for dinner.', '06-02-2021');

SELECT * FROM Post;



Step 6 – Create Lookup Procedure

--Create Lookup Procedure
CREATE OR REPLACE PROCEDURE add_like(
  p_post_id IN DECIMAL,
  p_username IN VARCHAR,
  p_liked_on IN DATE)
  LANGUAGE plpgsql
AS $$ 
DECLARE
v_person_id DECIMAL(12);
BEGIN
   SELECT person_id
   INTO v_person_id
   FROM Person
   WHERE username = p_username;
   --Insert the new line item.
   INSERT INTO LIKES(likes_id, post_id, person_id, liked_on)
   VALUES(nextval('likes_seq'), p_post_id, v_person_id, p_liked_on);
END; $$;

CALL add_like(1, 'charleswilliams123', '06-03-2021');

SELECT * FROM Likes;



Section Two – Triggers
Step 7 – Single Table Validation Trigger

-- Single Table Validation Trigger
CREATE OR REPLACE FUNCTION valid_summary()
 RETURNS TRIGGER LANGUAGE plpgsql
 AS $trigfunc$
 BEGIN
   RAISE EXCEPTION USING MESSAGE = 'Summary format is incorrect!!!',
   ERRCODE = 22000;
 END;
$trigfunc$;

CREATE TRIGGER valid_summary
BEFORE UPDATE OR INSERT ON Post
FOR EACH ROW WHEN(New.summary != substring(New.content FROM 1 FOR 11) || '...')

EXECUTE PROCEDURE valid_summary();


--incorrect
INSERT INTO Post
VALUES(nextval('post_seq'), 
	   (SELECT person_id FROM Person WHERE username='frankdavis123'), 
	   'I am very tired today.', 
	   '01-01-2021', 
	   (SUBSTR('I am very tired today.', 1, 4) || '...'));


--correct
INSERT INTO Post
VALUES(nextval('post_seq'), 
	   (SELECT person_id FROM Person WHERE username='frankdavis123'), 
	   'Good night world, I am going to sleep soon.', 
	   '01-01-2021', 
	   (SUBSTR(new.content, 1, 11) || '...'));


Step 8 – Cross-Table Validation Trigger

--Cross-Table Validation Trigger
CREATE OR REPLACE FUNCTION block_like_func()
RETURNS TRIGGER LANGUAGE plpgsql
AS $$
DECLARE 
    v_created_on DATE;

BEGIN
   SELECT Post.created_on
   INTO v_created_on
   FROM Post
   JOIN Likes ON Post.post_id = Likes.post_id;

   IF NEW.liked_on < v_created_on THEN
     RAISE EXCEPTION USING MESSAGE = 'You can only like a picture if the date is after the post created.',
     ERRCODE = 22000;
END IF;
   RETURN NEW;
END;
$$;

CREATE TRIGGER check_liked_trg
BEFORE UPDATE OR INSERT ON LIKES
FOR EACH ROW
EXECUTE PROCEDURE block_like_func();


INSERT INTO Likes
VALUES(nextval('likes_seq'), 6, 2, '06-04-2018');

INSERT INTO Likes
VALUES(nextval('likes_seq'), 4, 1, '06-04-2021');

SELECT * FROM Likes;


DROP TRIGGER check_liked_trg on LIKES;

DELETE FROM Likes
WHERE likes_id IN (16, 17, 18, 19, 20);

ALTER SEQUENCE likes_seq RESTART WITH 6;


Step 9 – History Trigger

--Creating Table

CREATE TABLE post_content_history  (
post_id DECIMAL(12) NOT NULL,
old_post VARCHAR(255) NOT NULL,
new_post VARCHAR(255) NOT NULL,
change_date DATE NOT NULL,
summary VARCHAR(15) NOT NULL,
FOREIGN KEY (post_id) REFERENCES Post(post_id));

DROP TABLE post_content_history;


--History Trigger 
CREATE OR REPLACE FUNCTION content_history_func()
RETURNS TRIGGER LANGUAGE plpgsql
AS $$
BEGIN
    IF OLD.content <> NEW.content THEN
        INSERT INTO post_content_history (post_id, old_post, new_post, change_date, summary)
        VALUES(New.post_id, OLD.content, NEW.content, CURRENT_DATE, SUBSTR(NEW.content, 1, 11) || '...');
END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER content_history_trg
AFTER INSERT OR UPDATE ON Post
FOR EACH ROW
EXECUTE PROCEDURE content_history_func();


DROP TRIGGER content_history_trg ON Post;

DROP TRIGGER valid_summary ON Post;


UPDATE Post
SET content = 'I am doing my homework right now.'
WHERE post_id = 5;

UPDATE Post
SET content = 'Good night, I am going to sleep now.'
WHERE post_id = 10;

SELECT * FROM post_content_history;

 
