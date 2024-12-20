-- Name : oussama errahili
-- EMAIL : oussamaerrahili124@gmail.com

-- create database test_movies

CREATE DATABASE test_movies;

-- use the database

USE test_movies;

-- create tables subscription

CREATE TABLE subscription(
	subscriptionID INT AUTO_INCREMENT PRIMARY KEY, 
    subscriptionType VARCHAR(50),
    monthlyFee decimal(10,2)
);
ALTER TABLE subscription ADD CONSTRAINT subscriptionBasicPrumieur CHECK(subscriptionType = 'basic' OR subscriptionType = 'premium');

-- create table users

CREATE TABLE users(
	UserId INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    RegistrationDate DATE,
    subscriptionID INT,
    CONSTRAINT UserSubscription FOREIGN KEY (subscriptionID) REFERENCES subscription(subscriptionID)
);

-- CREATE TABLE MOVIE

CREATE TABLE movie(
	MovieID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    ReleaseYear INT NOT NULL,
    Duration INT NOT NULL,
    Rating VARCHAR(10) NOT NULL
);

-- create table review

CREATE TABLE review( 
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    UserId INT,
    FOREIGN KEY (UserId) REFERENCES users(UserId), 
    MovieID INT, 
    FOREIGN KEY (MovieID) REFERENCES movie(MovieID), 
    Rating INT NOT NULL, 
    ReviewText TEXT NOT NULL, 
    ReviewDate DATE NOT NULL 
);

-- CREATE TABLE WatchHistory

CREATE TABLE watch_history( 
    WatchHistoryID INT AUTO_INCREMENT PRIMARY KEY, 
    UserId INT, 
    FOREIGN KEY (UserId) REFERENCES users(UserId), 
    MovieID INT, 
    FOREIGN KEY (MovieID) REFERENCES movie(MovieID), 
    WatchDate DATE NOT NULL, 
    CompletionPercentage INT NOT NULL
);

-- Insert new movie

INSERT INTO movie(Title, Genre, ReleaseYear, Duration, Rating) 
VALUES ('g2a','Documentary','2022','150','PG-5');

-- Rechercher des films

SELECT * 
FROM movie 
WHERE Genre = 'Comedy' AND ReleaseYear > '2020';

-- Mise à jour des abonnements

UPDATE users 
SET subscriptionID = 2 ;

-- Afficher les abonnements

SELECT FirstName, LastName, subscriptionType 
FROM users, subscription 
WHERE users.subscriptionID = subscription.subscriptionID;

-- Filtrer les visionnages  

SELECT users.FirstName,users.LastName,watch_history.CompletionPercentage,movie.Title 
FROM watch_history
JOIN users ON users.UserId = watch_history.UserId 
JOIN movie ON movie.MovieID = watch_history.MovieID
WHERE watch_history.CompletionPercentage = 100;

-- Trier et limiter 

SELECT *
FROM movie
ORDER BY Duration DESC 
LIMIT 5;

-- Agrégation 

SELECT movie.Title, AVG(watch_history.CompletionPercentage) 
FROM watch_history
RIGHT JOIN movie ON  movie.MovieID = watch_history.MovieID
GROUP BY movie.Title;

-- group by

SELECT count(FirstName),subscriptionType 
FROM subscription
JOIN users ON users.subscriptionID = subscription.subscriptionID
GROUP BY subscriptionType;


