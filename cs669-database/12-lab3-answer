Section One – Aggregating Data

Step 1 – Creating Table Structure and Data

CREATE TABLE Genre (
genre_id DECIMAL(12) NOT NULL PRIMARY KEY,
genre_name VARCHAR(64) NOT NULL
);

CREATE TABLE Creator (
creator_id DECIMAL(12) NOT NULL PRIMARY KEY,
first_name VARCHAR(64) NOT NULL,
last_name VARCHAR(64) NOT NULL
);

CREATE TABLE Movie_series (
movie_series_id DECIMAL(12) NOT NULL PRIMARY KEY,
genre_id DECIMAL(12) NOT NULL,
creator_id DECIMAL(12) NOT NULL,
series_name VARCHAR(255) NOT NULL,
suggested_price DECIMAL(8,2) NULL,
FOREIGN KEY (genre_id) REFERENCES Genre(genre_id),
FOREIGN KEY (creator_id) REFERENCES Creator(creator_id)
);

CREATE TABLE Movie (
movie_id DECIMAL(12) NOT NULL PRIMARY KEY,
movie_series_id DECIMAL(12) NOT NULL,
movie_name VARCHAR(64) NOT NULL,
length_in_minutes DECIMAL(4),
FOREIGN KEY (movie_series_id) REFERENCES Movie_series(movie_series_id)
);

--Genre
INSERT INTO Genre(genre_id, genre_name)
VALUES(1, 'Fantasy');
INSERT INTO Genre(genre_id, genre_name)
VALUES(2, 'Family Film');
INSERT INTO Genre(genre_id, genre_name)
VALUES(3, 'Romance');
INSERT INTO Genre(genre_id, genre_name)
VALUES(4, 'Comedy');

--Creator
INSERT INTO Creator(creator_id, first_name, last_name)
VALUES(01, 'George', 'Lucas');
INSERT INTO Creator(creator_id, first_name, last_name)
VALUES(02, 'John', 'Lasseter');
INSERT INTO Creator(creator_id, first_name, last_name)
VALUES(03, 'John', 'Tolkien');
INSERT INTO Creator(creator_id, first_name, last_name)
VALUES(04, 'Jane', 'Doe');

--Movie_series
INSERT INTO Movie_series(movie_series_id, genre_id, creator_id, series_name, suggested_price)
VALUES(101, 1, 01, 'Star Wars', 129.99);
INSERT INTO Movie_series(movie_series_id, genre_id, creator_id, series_name, suggested_price)
VALUES(102, 2, 02, 'Toy Story', 22.13);
INSERT INTO Movie_series(movie_series_id, genre_id, creator_id, series_name, suggested_price)
VALUES(103, 1, 03, 'Lord of the Rings', null);
INSERT INTO Movie_series(movie_series_id, genre_id, creator_id, series_name, suggested_price)
VALUES(104, 3, 04, 'Love Story', 99.99);
INSERT INTO Movie_series(movie_series_id, genre_id, creator_id, series_name, suggested_price)
VALUES(105, 4, 04, 'Happy Moment', 88.88);

--Movie
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1001, 101, 'Episode I: The Phantom Menace', 136);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1002, 101, 'Episode II: Attack of the Clones', 142);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1003, 101, 'Episode III: Revenge of the Sith', 140);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1004, 101, 'Episode IV: A New Hope', 121);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1005, 102, 'Toy Story', 121);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1006, 102, 'Toy Story 2', 135);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1007, 102, 'Toy Story 3', 148);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1008, 103, 'The Lord of the Rings: The Fellowship of the Ring', 228);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1009, 103, 'The Lord of the Rings: The Two Towers', 235);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1010, 103, 'The Lord of the Rings: The Return of the King', 200);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1011, 104, 'Loving', 99);
INSERT INTO Movie(movie_id, movie_series_id, movie_name, length_in_minutes)
VALUES(1012, 105, 'Laughing', 88);


Step 2 – Counting Matches
SELECT COUNT(movie_id) AS long_movies 
FROM Movie
WHERE length_in_minutes >= 135;


Step 3 – Determining Highest and Lowest
SELECT TO_CHAR(MIN(suggested_price), '$999.99') AS least_expensive, 
TO_CHAR(MAX(suggested_price), '$999.99') AS most_expensive
FROM Movie_series;


Step 4 – Grouping Aggregate Results
SELECT series_name, COUNT(DISTINCT movie_id) AS number_of_movies
FROM   Movie_series
JOIN   Movie ON Movie.movie_series_id = Movie_series.movie_series_id
GROUP BY series_name;


Step 5 – Limiting Results by Aggregation
SELECT genre_name, COUNT (movie_id) AS  number_of_movies
FROM Movie_series
JOIN Genre ON Genre.genre_id = Movie_series.genre_id
JOIN Movie ON Movie.movie_series_id = Movie_series.movie_series_id
GROUP BY genre_name
HAVING COUNT(movie_id) >= 6;


Step 6 – Adding Up Values
SELECT series_name, SUM(length_in_minutes) AS how_long
FROM Movie_series
JOIN Movie ON Movie.movie_series_id = Movie_series.movie_series_id
GROUP BY series_name
HAVING SUM(length_in_minutes) > 540;


Step 7 – Integrating Aggregation with Other Constructs
SELECT first_name || ' ' || last_name AS creator_full_name, COUNT(Genre.genre_id) AS number_of_fantasy
FROM Creator
LEFT JOIN Movie_series ON Movie_series.creator_id = Creator.creator_id
LEFT JOIN Movie ON Movie.movie_series_id = Movie_series.movie_series_id
LEFT JOIN Genre ON Genre.genre_id = Movie_series.genre_id
			   AND Genre.genre_name = 'Fantasy'
GROUP BY first_name, last_name
ORDER BY COUNT(Genre.genre_id) DESC;

  
