-- Drop all tables in reverse dependency order
DROP TABLE IF EXISTS UserSong;
DROP TABLE IF EXISTS ArtistSong;
DROP TABLE IF EXISTS PlaylistSong;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Songs;
DROP TABLE IF EXISTS Artists;
DROP TABLE IF EXISTS Playlists;

-- Users table
CREATE TABLE IF NOT EXISTS Users (
    userID INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    passwordHash VARCHAR(255),
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Artists table
CREATE TABLE IF NOT EXISTS Artists (
    artistID INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(100),
    debutYear YEAR
);

-- Songs table
CREATE TABLE IF NOT EXISTS Songs (
    songID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration TIME,
    releaseDate DATE,
    genre VARCHAR(100)
);

-- Playlists table
CREATE TABLE IF NOT EXISTS Playlists (
    playlistID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    userID INT,
    createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userID) REFERENCES Users(userID)
);

-- M:N: Artist <-> Song
CREATE TABLE IF NOT EXISTS ArtistSong (
    artistID INT,
    songID INT,
    PRIMARY KEY (artistID, songID),
    FOREIGN KEY (artistID) REFERENCES Artists(artistID) ON DELETE CASCADE,
    FOREIGN KEY (songID) REFERENCES Songs(songID) ON DELETE CASCADE
);

-- M:N: Playlist <-> Song
CREATE TABLE IF NOT EXISTS PlaylistSong (
    playlistID INT,
    songID INT,
    PRIMARY KEY (playlistID, songID),
    FOREIGN KEY (playlistID) REFERENCES Playlists(playlistID) ON DELETE CASCADE,
    FOREIGN KEY (songID) REFERENCES Songs(songID) ON DELETE CASCADE
);

-- M:N: User <-> Song
CREATE TABLE IF NOT EXISTS UserSong (
    userID INT,
    songID INT,
    PRIMARY KEY (userID, songID),
    FOREIGN KEY (userID) REFERENCES Users(userID) ON DELETE CASCADE,
    FOREIGN KEY (songID) REFERENCES Songs(songID) ON DELETE CASCADE
);
