-- pl.sql
-- CS340 Project Step 4 - Stored Procedures
-- Project Group 69
-- This file contains PL/SQL stored procedures used in our project.
-- We currently include one procedure to demonstrate a CUD operation for the RESET button.

-- Procedure to delete a song by its ID
DELIMITER $$

CREATE PROCEDURE delete_song(IN songID INT)
BEGIN
    DELETE FROM Songs WHERE song_id = songID;
END$$

DELIMITER ;

-- If more procedures are added later, include them below with comments.
