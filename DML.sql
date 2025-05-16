-- Data manipulation queries for a music streaming application
-- Group 69: Alex Stephen and Liam Gold

-- scripts to populate various dropdown menus will be added here when neccessary

-- SELECT statements for listing each table's data
SELECT * FROM Artists;
SELECT * FROM Songs;
SELECT * FROM Users;
SELECT * FROM Playlists;

-- Query for all insert and delete functionality with colon : character being used to 
-- denote the variables that will have data from the backend programming language

-- insert statements for adding records to each table
INSERT INTO Artists (artistID, name, country, debutYear)
VALUES (:artistIDInput, :nameInput, :countryInput, :debutYearInput);

INSERT INTO Songs (songID, title, duration, releaseDate, genre0)
VALUES (:songIDInput, :titleInput, :durationInput, :releaseDateInput, :genreInput);

INSERT INTO Users (userID, username, email, passwordHash, createdAt)
VALUES (:userIDInput, :usernameInput, :emailInput, :passwordHashInput, :createdAtInput);

INSERT INTO Playlists (playlistID, title, description, userID, createdAt)
VALUES (:playlistIDInput, :titleInput, :descriptionInput, :userIDInput, :createdAtInput);

-- DELETE statements for removing records from each table
DELETE FROM Artists WHERE artistID = :artistIDInput;
DELETE FROM Songs WHERE songID = :songIDInput;
DELETE FROM Users WHERE userID = :userIDInput;
DELETE FROM Playlists WHERE playlistID = :playlistIDInput;

-- UPDATE statements for modifying records in each table
UPDATE Artists
SET name = :nameInput,
    country = :countryInput,
    debutYear = :debutYearInput
WHERE artistID = :artistIDInput;

UPDATE Songs
SET title = :titleInput,
    duration = :durationInput,
    releaseDate = :releaseDateInput,
    genre0 = :genreInput
WHERE songID = :songIDInput;

UPDATE Users
SET username = :usernameInput,
    email = :emailInput,
    passwordHash = :passwordHashInput,
    createdAt = :createdAtInput
WHERE userID = :userIDInput;

UPDATE Playlists
SET title = :titleInput,
    description = :descriptionInput,
    userID = :userIDInput,
    createdAt = :createdAtInput
WHERE playlistID = :playlistIDInput;