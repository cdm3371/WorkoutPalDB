/*
-Andrew Peacock
-Christopher Marshall
-WorkoutPal DB
-MySQL 
-Created 24 December 2016
-Last Update 24 December 2016 at 16:18 EST
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

/* could use a trigger to set datecreated = sysdate on insert of new workout */
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

/* Will add Triggers soon, need extra prviliges to create and test them */


	