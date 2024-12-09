-- Name : oussama errahili
-- EMAIL : oussamaerrahili124@gmail.com

-- create database test_movies

CREATE DATABASE test_movies;

-- use the database

USE test_movies;

-- create tables subscription

CREATE TABLE subscription(
	subscriptionID INT AUTO_INCREMENT PRIMARY KEY, (ALTER TABLE subscription ADD CONSTRAINT subscriptionBasicPrumieur CHECK(subscriptionType = 'basic' OR subscriptionType = 'premium');)
    subscriptionType VARCHAR(50),
    monthlyFee decimal(10,2)
);

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
