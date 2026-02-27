create database cinema;
use cinema;

CREATE TABLE Movie (
    mID INT PRIMARY KEY,
    Title VARCHAR(50),
    Year INT,
    Director VARCHAR(50)
);
Insert into Movie Values(101,'Top Gun',1986,'Tony Scott');
Insert into Movie Values(102,'Titanic',1997,'James Cameron');
Insert into Movie Values(103,'The Lion King',1994,'Rob Minkoff');
Insert into Movie Values(104,'Gravity',2013,'Alfonso Cuaron');
Insert into Movie Values(105,'Harry Potter',2001,NULL);
Insert into Movie Values(106,'Cast Away',2000,'Robert Zemeckis');
Insert into Movie Values(107,'Spider Man',2002,'Sam Raimi');
Insert into Movie Values(108,'The Godfather',1972,'Francis Coppoia');

CREATE TABLE Rating (
    uID INT,
    mID INT,
    Rating INT,
    ratingDate DATE,
    FOREIGN KEY (mID) REFERENCES Movie(mID)
);
INSERT INTO Rating VALUES (201, 101, 2, '2014-03-09');
INSERT INTO Rating VALUES (201, 101, 4, '2014-03-02');
INSERT INTO Rating VALUES (202, 104, 4, NULL);
INSERT INTO Rating VALUES (203, 107, 2, '2014-03-24');
INSERT INTO Rating VALUES (204, 103, 4, '2014-03-17');
INSERT INTO Rating VALUES (204, 104, 2, '2014-03-13');
INSERT INTO Rating VALUES (205, 108, 3, '2014-03-24');
INSERT INTO Rating VALUES (206, 102, 3, '2014-03-02');
INSERT INTO Rating VALUES (207, 104, 5, NULL);
INSERT INTO Rating VALUES (207, 106, 4, '2014-03-07');
INSERT INTO Rating VALUES (207, 102, 5, '2014-03-26');

select*from Movie;
select * from Rating;

#q find the title and year of movies that were created after the year 2000.
SELECT Title, Year
FROM Movie
WHERE Year > 2000;

# Q2 Find the title, MID and Rating of movies that were created before the year 2000, and Rating >2
SELECT Movie.Title, Movie.mID, Rating.Rating
FROM Movie
JOIN Rating ON Movie.mID = Rating.mID
WHERE Movie.Year < 2000
AND Rating.Rating > 2;

#q3 Sort all of the movies by descending Rating.
SELECT Movie.Title, Rating.Rating
FROM Movie
JOIN Rating ON Movie.mID = Rating.mID
ORDER BY Rating.Rating DESC;

#q4 Find all movies that have the exact same Rating.
Select Movie.Title, Rating.Rating
FROM Movie
JOIN Rating ON Movie.mID = Rating.mID
WHERE Rating.Rating IN (
    SELECT Rating
    FROM Rating
    GROUP BY Rating
    HAVING COUNT(*) > 1
)
ORDER BY Rating.Rating;

#Q5 Create a query that looks for a movie's ID, title, and director, but only if it has a rating above 4.
SELECT DISTINCT Movie.mID, Movie.Title, Movie.Director
FROM Movie
JOIN Rating ON Movie.mID = Rating.mID
WHERE Rating.Rating > 4;
