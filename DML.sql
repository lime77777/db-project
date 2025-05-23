-- Data manipulation queries for Music Playlist Manager
-- Group 69: Alex Stephen and Liam Gold

-- SELECT queries for each table
SELECT * FROM Artists;
SELECT * FROM Songs;
SELECT * FROM Users;
SELECT * FROM Playlists;

-- SELECT with JOINs for junction tables
SELECT asg.artistID, a.name AS artistName, asg.songID, s.title AS songTitle
FROM ArtistSong asg
JOIN Artists a ON asg.artistID = a.artistID
JOIN Songs s ON asg.songID = s.songID;

SELECT ps.playlistID, p.title AS playlistTitle, ps.songID, s.title AS songTitle
FROM PlaylistSong ps
JOIN Playlists p ON ps.playlistID = p.playlistID
JOIN Songs s ON ps.songID = s.songID;

SELECT us.userID, u.username AS userName, us.songID, s.title AS songTitle
FROM UserSong us
JOIN Users u ON us.userID = u.userID
JOIN Songs s ON us.songID = s.songID;

-- INSERT queries
INSERT INTO Artists (name, country, debutYear)
VALUES (:nameInput, :countryInput, :debutYearInput);

INSERT INTO Songs (title, duration, releaseDate, genre0)
VALUES (:titleInput, :durationInput, :releaseDateInput, :genreInput);

INSERT INTO Users (username, email, passwordHash, createdAt)
VALUES (:usernameInput, :emailInput, :passwordHashInput, :createdAtInput);

INSERT INTO Playlists (title, description, userID, createdAt)
VALUES (:titleInput, :descriptionInput, :userIDInput, :createdAtInput);

-- INSERT into junction tables
INSERT INTO ArtistSong (artistID, songID)
VALUES (:artistIDInput, :songIDInput);

INSERT INTO PlaylistSong (playlistID, songID)
VALUES (:playlistIDInput, :songIDInput);

INSERT INTO UserSong (userID, songID)
VALUES (:userIDInput, :songIDInput);

-- DELETE queries
DELETE FROM Artists WHERE artistID = :artistIDInput;
DELETE FROM Songs WHERE songID = :songIDInput;
DELETE FROM Users WHERE userID = :userIDInput;
DELETE FROM Playlists WHERE playlistID = :playlistIDInput;

-- DELETE from junction tables
DELETE FROM ArtistSong WHERE artistID = :artistIDInput AND songID = :songIDInput;
DELETE FROM PlaylistSong WHERE playlistID = :playlistIDInput AND songID = :songIDInput;
DELETE FROM UserSong WHERE userID = :userIDInput AND songID = :songIDInput;

-- UPDATE queries
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
