/*
-Andrew Peacock
-Christopher Marshall
-WorkoutPal DB
-MySQL 
-Created 24 December 2016
-Last Update 2 February 2017 at 15:47 EST
*/

/* Table Structure Drop in reverse order as listed */

CREATE TABLE comments
(
  commentID integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  commentMessage VARCHAR(400) NOT NULL
);

CREATE TABLE lifts
(
  liftID integer PRIMARY KEY NOT NULL AUTO_INCREMENT,
  liftName varchar(80) NOT NULL UNIQUE,
  liftWeight integer NOT NULL,
  liftReps integer NOT NULL,
  liftSets integer NOT NULL,
  liftCommentsID integer NOT NULL,
  CONSTRAINT fk_comments FOREIGN KEY (liftCommentsID) REFERENCES comments(commentID)
);

CREATE TABLE movements
(
  moveID integer PRIMARY KEY NOT NULL,
  moveName VARCHAR(80) NOT NULL UNIQUE,
  moveRounds INTEGER NOT NULL,
  moveReps INTEGER NOT NULL,
  moveCommentsID integer NOT NULL,
  CONSTRAINT fk_moveComments FOREIGN KEY (moveCommentsID) REFERENCES comments(commentID)
);

CREATE TABLE metcons
(
  metconID INTEGER PRIMARY KEY NOT NULL AUTO_INCREMENT,
  metName VARCHAR(80) NOT NULL UNIQUE,
  metTime TIME NOT NULL,
  metRX BOOLEAN NOT NULL,
  metMovementsID integer NOT NULL,
  CONSTRAINT fk_metMovements FOREIGN KEY (metMovementsID) REFERENCES movements(moveID),
  metCommentsID integer NOT NULL,
  CONSTRAINT fk_metComments FOREIGN KEY (metCommentsID) REFERENCES comments(commentID)
);

/* could use a trigger to set datecreated = sysdate on insert of new workout or default to the sysdate*/
CREATE TABLE workouts
(
  workID INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  workName VARCHAR(80) NOT NULL UNIQUE,
  DateCreated DATETIME,
  liftID integer NOT NULL,
  CONSTRAINT fk_workLift FOREIGN KEY (liftID) REFERENCES lifts(liftID),
  metconID INTEGER NOT NULL,
  CONSTRAINT fk_workMetcon FOREIGN KEY (metconID) REFERENCES metcons(metconID)
);

/* could use a trigger to set datecreated = sysdate on insert of a new row user */
CREATE TABLE users
(
  userID INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
  userEmail VARCHAR(254) NOT NULL,
  uFirstName VARCHAR(50) NOT NULL,
  uLastName VARCHAR(50) NOT NULL,
  userDateCreated DATETIME NOT NULL,
  userIsBanned BOOLEAN,
  workoutID INTEGER NOT NULL,
  CONSTRAINT fk_userWorkout FOREIGN KEY (workoutID) REFERENCES workouts(workID)
);


--TEST Data uncomment this section if you wish to load it in to the DB for testing
/*
INSERT INTO comments(commentID, commentMessage) 
    VALUES (1, 'This comment is a test');

INSERT INTO lifts (liftID, liftName, liftWeight, liftReps, liftSets, liftCommentsID)
    VALUES(1, 'TestLift', 9001, 9001, 9001, 1);

INSERT INTO movements (moveID, moveName, moveRounds, moveReps, moveCommentsID)
    VALUES (1, 'TestMove', 1, 12, 1);

--The metconID is intentionally left blank here to test the autoincrement feature

INSERT INTO metcons (metName, metTime, metRX, metMovementsID, metCommentsID)
    VALUES ('TestMet', '00:12:30', 1, 1, 1);

INSERT INTO workouts (workID, workName, DateCreated, liftID, metconID)
    VALUES (1, 'testWorkName', SYSDATE(), 1, 1);

--A 0 in the userIsBanned field indicated that the user is not banned, a 1 means they are
INSERT INTO users (userEmail, uFirstName, uLastName, userDateCreated, userIsBanned, workoutID)
    VALUES ('test@genericemail.com', 'Test', 'Testerson', SYSDATE(), 0, 1);

--To Delete these entries after testing be sure to remove these in reverse order of the way I have added them above to avoid conflicts with key references

DELETE FROM users WHERE userID = 1;
DELETE FROM workouts WHERE workID = 1;
DELETE FROM metcons WHERE metconID = 1;
DELETE FROM movements WHERE moveID = 1;
DELETE FROM lifts WHERE liftID = 1;
DELETE FROM comments WHERE commentID = 1;
*/
