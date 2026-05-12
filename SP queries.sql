use spotifydb

---Get all users---
CREATE PROCEDURE sp_GetAllUsers
AS
BEGIN
    -- Returns all users
    SELECT * FROM Users;
END;

EXEC sp_GetAllUsers;
EXECUTE sp_GetAllUsers;

CREATE PROCEDURE sp_GetAllSongs
AS
BEGIN
    -- Returns all songs
    SELECT * FROM Songs;
END;

CREATE PROCEDURE sp_GetAllPlaylists
AS
BEGIN
    -- Returns all playlists
    SELECT * FROM Playlists;
END;

CREATE PROCEDURE sp_GetSongsByDuration
    @Duration INT
AS
BEGIN
    -- Returns songs longer than given duration
    SELECT Name, Duration
    FROM Songs
    WHERE Duration > @Duration;
END;


CREATE PROCEDURE sp_GetPublicPlaylists
AS
BEGIN
    -- Returns only public playlists
    SELECT Name
    FROM Playlists
    WHERE IsPublic = 1;
END;


CREATE PROCEDURE sp_GetUsersByCountry
    @CountryID INT
AS
BEGIN
    -- Returns users from a specific country
    SELECT *
    FROM Users
    WHERE CountryID = @CountryID;
END;





CREATE PROCEDURE sp_GetAllArtists
AS
BEGIN
    -- Returns all artists
    SELECT * FROM Artists;
END;



CREATE PROCEDURE sp_GetSongsByAlbum
    @AlbumID INT
AS
BEGIN
    -- Returns songs of a specific album
    SELECT *
    FROM Songs
    WHERE AlbumID = @AlbumID;
END;



CREATE PROCEDURE sp_GetSuccessfulPayments
AS
BEGIN
    -- Returns only successful payments
    SELECT *
    FROM Payments
    WHERE PaymentStatus = 'Success';
END;


CREATE PROCEDURE sp_GetUserDevices
    @UserID INT
AS
BEGIN
    -- Returns all devices used by a user
    SELECT DeviceName
    FROM Devices
    WHERE UserID = @UserID;
END;

CREATE PROCEDURE sp_GetUserProfiles
AS
BEGIN
    -- Returns username with display name
    SELECT Users.Username, UserProfiles.DisplayName
    FROM Users
    JOIN UserProfiles ON Users.UserID = UserProfiles.UserID;
END;


CREATE PROCEDURE sp_GetSongsWithArtists
AS
BEGIN
    -- Returns songs with artist names
    SELECT Songs.Name AS SongName, Artists.Name AS ArtistName
    FROM Songs
    JOIN SongArtists ON Songs.SongID = SongArtists.SongID
    JOIN Artists ON SongArtists.ArtistID = Artists.ArtistID;
END;


CREATE PROCEDURE sp_GetPlaylistSongs
    @PlaylistID INT
AS
BEGIN
    -- Returns all songs in a playlist
    SELECT Playlists.Name, Songs.Name
    FROM PlaylistSongs
    JOIN Playlists ON PlaylistSongs.PlaylistID = Playlists.PlaylistID
    JOIN Songs ON PlaylistSongs.SongID = Songs.SongID
    WHERE Playlists.PlaylistID = @PlaylistID;
END;


CREATE PROCEDURE sp_GetUserLikedSongs
AS
BEGIN
    -- Returns users and songs they liked
    SELECT Users.Username, Songs.Name
    FROM Users
    JOIN UserLikedSongs ON Users.UserID = UserLikedSongs.UserID
    JOIN Songs ON UserLikedSongs.SongID = Songs.SongID;
END;


CREATE PROCEDURE sp_GetUserPlaylists
AS
BEGIN
    -- Returns users and their playlists
    SELECT Users.Username, Playlists.Name
    FROM Users
    JOIN Playlists ON Users.UserID = Playlists.UserID;
END;


CREATE PROCEDURE sp_GetSongsWithGenres
AS
BEGIN
    -- Returns songs and their genres
    SELECT Songs.Name, Genres.Name
    FROM Songs
    JOIN SongGenres ON Songs.SongID = SongGenres.SongID
    JOIN Genres ON SongGenres.GenreID = Genres.GenreID;
END;


CREATE PROCEDURE sp_GetArtistAlbums
AS
BEGIN
    -- Returns artist with albums
    SELECT Artists.Name, Albums.Name
    FROM Artists
    JOIN AlbumArtists ON Artists.ArtistID = AlbumArtists.ArtistID
    JOIN Albums ON Albums.AlbumID = AlbumArtists.AlbumID;
END;


CREATE PROCEDURE sp_GetPaymentsWithUsers
AS
BEGIN
    -- Returns payments with username
    SELECT Users.Username, Payments.TotalAmount
    FROM Payments
    JOIN Users ON Payments.UserID = Users.UserID;
END;


CREATE PROCEDURE sp_GetUserSubscriptions
AS
BEGIN
    -- Returns user and plan name
    SELECT Users.Username, PlanTypes.PlanName
    FROM Users
    JOIN Subscriptions ON Users.UserID = Subscriptions.OwnerUserID
    JOIN PlanTypes ON Subscriptions.PlanID = PlanTypes.PlanID;
END;


CREATE PROCEDURE sp_GetDevicesPerUser
AS
BEGIN
    -- Returns device count per user
    SELECT UserID, COUNT(*) AS DeviceCount
    FROM Devices
    GROUP BY UserID;
END;


CREATE PROCEDURE sp_TotalPlaysPerSong
AS
BEGIN
    -- Returns total play count per song
    SELECT SongID, COUNT(*) AS Plays
    FROM ListeningHistory
    GROUP BY SongID;
END;

CREATE PROCEDURE sp_TotalListeningTimePerUser
AS
BEGIN
    -- Returns total listening time per user
    SELECT Users.Username, SUM(DurationPlayed) AS TotalTime
    FROM ListeningHistory
    JOIN Users ON ListeningHistory.UserID = Users.UserID
    GROUP BY Users.Username;
END;

CREATE PROCEDURE sp_TopTrendingSongs
AS
BEGIN
    -- Returns top 5 trending songs
    SELECT TOP 5 Songs.Name, TrendingSongs.Score
    FROM TrendingSongs
    JOIN Songs ON TrendingSongs.SongID = Songs.SongID
    ORDER BY TrendingSongs.Score DESC;
END;


CREATE PROCEDURE sp_MostLikedPlaylists
AS
BEGIN
    -- Returns playlists with most likes
    SELECT PlaylistID, COUNT(*) AS Likes
    FROM UserLikedPlaylists
    GROUP BY PlaylistID
    ORDER BY Likes DESC;
END;


CREATE PROCEDURE sp_MostFollowedArtists
AS
BEGIN
    -- Returns most followed artists
    SELECT ArtistID, COUNT(*) AS Followers
    FROM UserFollowedArtists
    GROUP BY ArtistID
    ORDER BY Followers DESC;
END;


CREATE PROCEDURE sp_ActiveUsers
AS
BEGIN
    -- Returns active users (no logout)
    SELECT COUNT(*) AS ActiveUsers
    FROM UserSessions
    WHERE LogoutAt IS NULL;
END;


CREATE PROCEDURE sp_TotalRevenue
AS
BEGIN
    -- Returns total successful revenue
    SELECT SUM(TotalAmount) AS TotalRevenue
    FROM Payments
    WHERE PaymentStatus = 'Success';
END;


CREATE PROCEDURE sp_PlaylistTotalPlays
AS
BEGIN
    -- Returns total plays per playlist
    SELECT PlaylistID, SUM(PlayCount) AS TotalPlays
    FROM UserPlaylistStats
    GROUP BY PlaylistID;
END;



CREATE PROCEDURE sp_MostActiveUsers
AS
BEGIN
    -- Returns users with highest activity
    SELECT UserID, SUM(PlayCount) AS TotalPlays
    FROM UserPlaylistStats
    GROUP BY UserID
    ORDER BY TotalPlays DESC;
END;


CREATE PROCEDURE sp_MostDownloadedSongs
AS
BEGIN
    -- Returns most downloaded songs
    SELECT SongID, COUNT(*) AS Downloads
    FROM Downloads
    GROUP BY SongID
    ORDER BY Downloads DESC;
END;

CREATE PROCEDURE sp_CheckUserExists
    @UserID INT
AS
BEGIN
    -- Returns 1 if user exists else 0
    IF EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
        RETURN 1;
    RETURN 0;
END;


CREATE PROCEDURE sp_GetUserCount
    @TotalUsers INT OUTPUT
AS
BEGIN
    -- Returns total user count
    SELECT @TotalUsers = COUNT(*) FROM Users;
END;

CREATE PROCEDURE sp_AddPlaylist
    @UserID INT,
    @Name VARCHAR(150)
AS
BEGIN
    -- Inserts new playlist
    INSERT INTO Playlists(UserID, Name)
    VALUES(@UserID, @Name);
END;

CREATE PROCEDURE sp_AddSongToPlaylist
    @PlaylistID INT,
    @SongID INT
AS
BEGIN
    -- Adds song to playlist
    INSERT INTO PlaylistSongs(PlaylistID, SongID)
    VALUES(@PlaylistID, @SongID);
END;

CREATE PROCEDURE sp_DeletePlaylist
    @PlaylistID INT
AS
BEGIN
    -- Deletes a playlist
    DELETE FROM Playlists
    WHERE PlaylistID = @PlaylistID;
END;


CREATE PROCEDURE sp_UpdateUserEmail
    @UserID INT,
    @Email VARCHAR(100)
AS
BEGIN
    -- Updates user email
    UPDATE Users
    SET Email = @Email
    WHERE UserID = @UserID;
END;


CREATE PROCEDURE sp_CreatePlaylistWithSongs
    @UserID INT,
    @Name VARCHAR(150),
    @SongID INT
AS
BEGIN
    -- Creates playlist and adds song using transaction
    BEGIN TRANSACTION;

    DECLARE @NewPlaylistID INT;

    INSERT INTO Playlists(UserID, Name)
    VALUES(@UserID, @Name);

    SET @NewPlaylistID = SCOPE_IDENTITY();

    INSERT INTO PlaylistSongs(PlaylistID, SongID)
    VALUES(@NewPlaylistID, @SongID);

    COMMIT;
END;

CREATE PROCEDURE sp_SafeInsertUser
    @Username VARCHAR(50),
    @Email VARCHAR(100)
AS
BEGIN
    -- Safely inserts user with error handling
    BEGIN TRY
        INSERT INTO Users(Username, Email, PasswordHash)
        VALUES(@Username, @Email, 'hash');
    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;


CREATE PROCEDURE sp_TopSongsPerUser
AS
BEGIN
    -- Returns songs played more than once
    SELECT Users.Username, Songs.Name, COUNT(*) AS PlayCount
    FROM ListeningHistory
    JOIN Users ON ListeningHistory.UserID = Users.UserID
    JOIN Songs ON ListeningHistory.SongID = Songs.SongID
    GROUP BY Users.Username, Songs.Name
    HAVING COUNT(*) > 1;
END;


CREATE PROCEDURE sp_GetUserRecommendations
    @UserID INT
AS
BEGIN
    -- Returns recommended songs for user
    SELECT Songs.Name, Recommendations.Score
    FROM Recommendations
    JOIN Songs ON Recommendations.SongID = Songs.SongID
    WHERE Recommendations.UserID = @UserID
    ORDER BY Recommendations.Score DESC;
END;

