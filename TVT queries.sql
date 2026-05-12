--Trigger 1: Auto update ModifiedAt when song is updated
use spotifydb

CREATE TRIGGER trg_UpdateSongModifiedAt
ON Songs
AFTER UPDATE
AS
BEGIN
    -- Automatically updates ModifiedAt when a song is updated
    UPDATE Songs
    SET ModifiedAt = GETDATE()
    FROM Songs s
    JOIN inserted i ON s.SongID = i.SongID;
END;

--Trigger 2: Prevent deleting users

CREATE TRIGGER trg_PreventUserDelete
ON Users
INSTEAD OF DELETE
AS
BEGIN
    -- Prevents deletion of users
    PRINT 'User deletion is not allowed!';
END;

--Trigger 3: Update playlist followers count

CREATE TRIGGER trg_UpdatePlaylistFollowers
ON UserLikedPlaylists
AFTER INSERT
AS
BEGIN
    -- Increases FollowersCount when a playlist is liked
    UPDATE Playlists
    SET FollowersCount = FollowersCount + 1
    FROM Playlists p
    JOIN inserted i ON p.PlaylistID = i.PlaylistID;
END;

--Transaction 1: Insert user + profile

BEGIN TRANSACTION;

-- Creates user and profile together
DECLARE @UserID INT;

INSERT INTO Users(Username, Email, PasswordHash)
VALUES('test_user', 'test@gmail.com', 'hash');

SET @UserID = SCOPE_IDENTITY();

INSERT INTO UserProfiles(UserID, DisplayName)
VALUES(@UserID, 'Test User');

COMMIT;


--Transaction 2: Add playlist + multiple songs

BEGIN TRANSACTION;

-- Creates playlist and adds songs
DECLARE @PlaylistID INT;

INSERT INTO Playlists(UserID, Name)
VALUES(1, 'New Playlist');

SET @PlaylistID = SCOPE_IDENTITY();

INSERT INTO PlaylistSongs VALUES(@PlaylistID, 1);
INSERT INTO PlaylistSongs VALUES(@PlaylistID, 2);

COMMIT;


--Transaction 3: Payment with rollback


BEGIN TRANSACTION;

BEGIN TRY
    -- Inserts payment safely
    INSERT INTO Payments(UserID, Amount, PaymentStatus)
    VALUES(1, 200, 'Success');

    COMMIT;
END TRY
BEGIN CATCH
    -- Rollback if error occurs
    ROLLBACK;
    PRINT 'Transaction Failed';
END CATCH;


--View 1: Songs with artists

CREATE VIEW vw_SongsWithArtists AS
-- Shows songs with artist names
SELECT Songs.Name AS SongName, Artists.Name AS ArtistName
FROM Songs
JOIN SongArtists ON Songs.SongID = SongArtists.SongID
JOIN Artists ON SongArtists.ArtistID = Artists.ArtistID;

SELECT * FROM vw_SongsWithArtists;

--View 2: User playlists with usernames

CREATE VIEW vw_UserPlaylists AS
-- Shows playlists with user names
SELECT Users.Username, Playlists.Name AS PlaylistName
FROM Users
JOIN Playlists ON Users.UserID = Playlists.UserID;


--View 3: Top trending songs

CREATE VIEW vw_TrendingSongs AS
-- Shows trending songs with score
SELECT Songs.Name, TrendingSongs.Score
FROM TrendingSongs
JOIN Songs ON TrendingSongs.SongID = Songs.SongID;