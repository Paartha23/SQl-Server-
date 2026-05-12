use spotifydb

CREATE TABLE Countries (
    CountryID INT PRIMARY KEY IDENTITY(1,1),
    CountryName VARCHAR(100) NOT NULL,
    CountryCode VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE States (
    StateID INT PRIMARY KEY IDENTITY(1,1),
    CountryID INT NOT NULL,
    StateName VARCHAR(100) NOT NULL,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    DOB DATE,
    CountryID INT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE UserProfiles (
    ProfileID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT UNIQUE,
    DisplayName VARCHAR(100),
    ProfileImage VARCHAR(255),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE PlanTypes (
    PlanID INT PRIMARY KEY IDENTITY(1,1),
    PlanName VARCHAR(50),
    Price DECIMAL(10,2),
    MaxUsers INT
);

CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY IDENTITY(1,1),
    PlanID INT,
    OwnerUserID INT,
    StartDate DATE,
    EndDate DATE,
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (PlanID) REFERENCES PlanTypes(PlanID),
    FOREIGN KEY (OwnerUserID) REFERENCES Users(UserID)
);

CREATE TABLE SubscriptionUsers (
    SubscriptionID INT,
    UserID INT,
    Role VARCHAR(20),
    JoinedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (SubscriptionID, UserID),
    FOREIGN KEY (SubscriptionID) REFERENCES Subscriptions(SubscriptionID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Taxes (
    TaxID INT PRIMARY KEY IDENTITY(1,1),
    CountryID INT,
    StateID INT,
    TaxType VARCHAR(50),
    TaxPercentage DECIMAL(5,2),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID),
    FOREIGN KEY (StateID) REFERENCES States(StateID)
);

CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    SubscriptionID INT,
    Amount DECIMAL(10,2),
    TaxID INT,
    TaxAmount DECIMAL(10,2),
    TotalAmount DECIMAL(10,2),
    PaymentStatus VARCHAR(20),
    PaymentDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SubscriptionID) REFERENCES Subscriptions(SubscriptionID),
    FOREIGN KEY (TaxID) REFERENCES Taxes(TaxID)
);

CREATE TABLE Languages (
    LanguageID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50)
);

CREATE TABLE Artists (
    ArtistID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100),
    CountryID INT,
    LanguageID INT,
    Followers INT DEFAULT 0,
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID),
    FOREIGN KEY (LanguageID) REFERENCES Languages(LanguageID)
);

CREATE TABLE Albums (
    AlbumID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(150),
    ReleaseDate DATE
);

CREATE TABLE AlbumArtists (
    AlbumID INT,
    ArtistID INT,
    PRIMARY KEY (AlbumID, ArtistID),
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE Songs (
    SongID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(150),
    AlbumID INT,
    Duration INT,
    FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID)
);

CREATE TABLE SongArtists (
    SongID INT,
    ArtistID INT,
    PRIMARY KEY (SongID, ArtistID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE Genres (
    GenreID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50)
);

CREATE TABLE SongGenres (
    SongID INT,
    GenreID INT,
    PRIMARY KEY (SongID, GenreID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE Credits (
    CreditID INT PRIMARY KEY IDENTITY(1,1),
    SongID INT,
    ArtistID INT,
    Role VARCHAR(50),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE Lyrics (
    LyricsID INT PRIMARY KEY IDENTITY(1,1),
    SongID INT NOT NULL,
    Content NVARCHAR(MAX),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE Playlists (
    PlaylistID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Name VARCHAR(150),
    Description TEXT,
    IsPublic BIT DEFAULT 1,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE PlaylistSongs (
    PlaylistID INT,
    SongID INT,
    AddedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (PlaylistID, SongID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE UserLikedSongs (
    UserID INT,
    SongID INT,
    PRIMARY KEY (UserID, SongID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE UserLikedPlaylists (
    UserID INT,
    PlaylistID INT,
    PRIMARY KEY (UserID, PlaylistID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID)
);

CREATE TABLE UserFollowedArtists (
    UserID INT,
    ArtistID INT,
    PRIMARY KEY (UserID, ArtistID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE ListeningHistory (
    HistoryID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    SongID INT,
    DurationPlayed INT,
    PlayedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE UserSongStats (
    UserID INT,
    SongID INT,
    PlayCount INT,
    TotalListeningTime INT,
    LastPlayed DATETIME,
    PRIMARY KEY (UserID, SongID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE GlobalSongStats (
    SongID INT PRIMARY KEY,
    TotalPlays INT,
    TrendingScore FLOAT,
    FOREIGN KEY (SongID) REFERENCES Songs(SongID),
	LastUpdated dateTime 
);

CREATE TABLE TrendingSongs (
    SongID INT,
    CountryID INT,
    Rank INT,
    Score FLOAT,
    UpdatedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (SongID, CountryID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE Recommendations (
    RecommendationID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    SongID INT,
    Score FLOAT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE SearchHistory (
    SearchID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Query VARCHAR(255),
    SearchedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Downloads (
    UserID INT,
    SongID INT,
    DownloadedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (UserID, SongID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE Devices (
    DeviceID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    DeviceName VARCHAR(100),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE UserSessions (
    SessionID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    DeviceID INT,
    LoginAt DATETIME,
    LogoutAt DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (DeviceID) REFERENCES Devices(DeviceID)
);

CREATE TABLE GenrePlaylists (
    GenreID INT,
    PlaylistID INT,
    PRIMARY KEY (GenreID, PlaylistID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID)
);

CREATE TABLE GenreArtists (
    GenreID INT,
    ArtistID INT,
    PRIMARY KEY (GenreID, ArtistID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE GlobalPlaylistStats (
    PlaylistID INT PRIMARY KEY,
    TotalPlays INT DEFAULT 0,
    FollowersCount INT DEFAULT 0,
    TotalListeningTime BIGINT DEFAULT 0,
    TrendingScore FLOAT,
    LastUpdated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID)
);


CREATE TABLE GlobalArtistStats (
    ArtistID INT PRIMARY KEY,
    TotalPlays INT DEFAULT 0,
    TotalListeners INT DEFAULT 0,
    TotalFollowers INT DEFAULT 0,
    TrendingScore FLOAT,
    LastUpdated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE UserRepeatedSongs (
    UserID INT,
    SongID INT,
    RepeatCount INT DEFAULT 0,
    LastRepeatedAt DATETIME,
    PRIMARY KEY (UserID, SongID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID)
);

CREATE TABLE UserPlaylistStats (
    UserID INT,
    PlaylistID INT,
    PlayCount INT DEFAULT 0,
    TotalListeningTime BIGINT DEFAULT 0,
    LastPlayed DATETIME,
    PRIMARY KEY (UserID, PlaylistID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID)
);

CREATE TABLE Podcasts (
    PodcastID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    LanguageID INT,
    CreatedByArtistID INT, -- optional (podcast creator)
    CreatedAt DATETIME DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (LanguageID) REFERENCES Languages(LanguageID),
    FOREIGN KEY (CreatedByArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE PodcastEpisodes (
    EpisodeID INT PRIMARY KEY IDENTITY(1,1),
    PodcastID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    Duration INT,
    ReleaseDate DATE,
    AudioURL NVARCHAR(500),
    IsActive BIT DEFAULT 1,
    FOREIGN KEY (PodcastID) REFERENCES Podcasts(PodcastID)
);

CREATE TABLE EpisodeHosts (
    EpisodeID INT,
    ArtistID INT,
    Role VARCHAR(50), -- Host, Guest
    PRIMARY KEY (EpisodeID, ArtistID),
    FOREIGN KEY (EpisodeID) REFERENCES PodcastEpisodes(EpisodeID),
    FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID)
);

CREATE TABLE UserFollowedPodcasts (
    UserID INT,
    PodcastID INT,
    FollowedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (UserID, PodcastID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (PodcastID) REFERENCES Podcasts(PodcastID)
);

CREATE TABLE PodcastListeningHistory (
    HistoryID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    EpisodeID INT NOT NULL,
    DurationPlayed INT,
    PlayedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (EpisodeID) REFERENCES PodcastEpisodes(EpisodeID)
);

CREATE TABLE UserPodcastStats (
    UserID INT,
    EpisodeID INT,
    PlayCount INT DEFAULT 0,
    TotalListeningTime INT DEFAULT 0,
    LastPlayed DATETIME,
    PRIMARY KEY (UserID, EpisodeID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (EpisodeID) REFERENCES PodcastEpisodes(EpisodeID)
);

CREATE TABLE GlobalPodcastStats (
    PodcastID INT PRIMARY KEY,
    TotalPlays INT DEFAULT 0,
    TotalListeners INT DEFAULT 0,
    TrendingScore FLOAT,
    LastUpdated DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (PodcastID) REFERENCES Podcasts(PodcastID)
);

CREATE TABLE TrendingPodcasts (
    PodcastID INT,
    CountryID INT,
    Rank INT,
    Score FLOAT,
    UpdatedAt DATETIME DEFAULT GETDATE(),
    PRIMARY KEY (PodcastID, CountryID),
    FOREIGN KEY (PodcastID) REFERENCES Podcasts(PodcastID),
    FOREIGN KEY (CountryID) REFERENCES Countries(CountryID)
);

CREATE TABLE PodcastGenres (
    PodcastID INT,
    GenreID INT,
    PRIMARY KEY (PodcastID, GenreID),
    FOREIGN KEY (PodcastID) REFERENCES Podcasts(PodcastID),
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

CREATE TABLE PodcastSearchHistory (
    SearchID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT,
    Query NVARCHAR(255),
    SearchedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

EXEC sp_rename 'GenrePlaylists', 'PlaylistGenres';

ALTER TABLE Playlists
ALTER COLUMN Description NVARCHAR(MAX);

ALTER TABLE Users
ALTER COLUMN Username VARCHAR(50) NOT NULL;

ALTER TABLE Users
ALTER COLUMN Email VARCHAR(100) NOT NULL;

ALTER TABLE Songs
ALTER COLUMN Name VARCHAR(150) NOT NULL;

ALTER TABLE Artists
ALTER COLUMN Name VARCHAR(100) NOT NULL;

ALTER TABLE SubscriptionUsers
ADD CONSTRAINT chk_role CHECK (Role IN ('Owner','Member'));

ALTER TABLE Payments
ADD PaymentMethod VARCHAR(50);

ALTER TABLE TrendingSongs
ADD TrendDate DATE DEFAULT GETDATE();

ALTER TABLE Albums
ADD CoverImage NVARCHAR(500);

ALTER TABLE Songs
ADD AudioURL NVARCHAR(500);

CREATE TABLE UserFollowers (
    FollowerID INT,
    FollowingID INT,
    PRIMARY KEY (FollowerID, FollowingID),
    FOREIGN KEY (FollowerID) REFERENCES Users(UserID),
    FOREIGN KEY (FollowingID) REFERENCES Users(UserID)
);
ALTER TABLE Songs
ADD CreatedAt DATETIME DEFAULT GETDATE(),
    ModifiedAt DATETIME;

	ALTER TABLE Playlists
ADD CreatedAt DATETIME DEFAULT GETDATE(),
    ModifiedAt DATETIME;

ALTER TABLE Playlists
ADD FollowersCount INT DEFAULT 0;

ALTER TABLE TrendingSongs
DROP CONSTRAINT PK__TrendingSongs; -- (use actual name)

ALTER TABLE TrendingSongs
ADD PRIMARY KEY (SongID, CountryID, TrendDate);

SELECT name
FROM sys.key_constraints
WHERE parent_object_id = OBJECT_ID('TrendingSongs');

ALTER TABLE TrendingSongs
DROP CONSTRAINT PK__Trending__F3EEC0FCB8D1C50C;

ALTER TABLE TrendingSongs
ALTER COLUMN SongID INT NOT NULL;

ALTER TABLE TrendingSongs
ALTER COLUMN CountryID INT NOT NULL;

ALTER TABLE TrendingSongs
ALTER COLUMN TrendDate DATE NOT NULL;

ALTER TABLE TrendingSongs
ADD PRIMARY KEY (SongID, CountryID, TrendDate);

INSERT INTO Countries (CountryName, CountryCode) VALUES
('India','IN'),
('USA','US'),
('UK','UK');

INSERT INTO States (CountryID, StateName) VALUES
(1,'Karnataka'),
(1,'Telangana'),
(2,'California'),
(3,'London');

INSERT INTO Users (Username, Email, PasswordHash, DOB, CountryID) VALUES
('user1','u1@gmail.com','hash','2000-01-01',1),
('user2','u2@gmail.com','hash','2001-02-02',1),
('user3','u3@gmail.com','hash','2002-03-03',2),
('user4','u4@gmail.com','hash','2003-04-04',2),
('user5','u5@gmail.com','hash','2000-05-05',3),
('user6','u6@gmail.com','hash','2001-06-06',1),
('user7','u7@gmail.com','hash','2002-07-07',2),
('user8','u8@gmail.com','hash','2003-08-08',3),
('user9','u9@gmail.com','hash','2000-09-09',1),
('user10','u10@gmail.com','hash','2001-10-10',2);

INSERT INTO UserProfiles (UserID, DisplayName) VALUES
(1,'Paartha'),(2,'Rahul'),(3,'John'),(4,'Emma'),
(5,'Arjun'),(6,'Kiran'),(7,'Mike'),(8,'Sophia'),
(9,'Ravi'),(10,'David');

INSERT INTO PlanTypes (PlanName, Price, MaxUsers) VALUES
('Free',0,1),
('Premium',199,1),
('Family',499,5);

INSERT INTO Subscriptions (PlanID, OwnerUserID, StartDate) VALUES
(2,1,'2025-01-01'),
(3,2,'2025-02-01'),
(2,3,'2025-03-01');

INSERT INTO SubscriptionUsers VALUES
(2,2,'Owner'),
(2,3,'Member'),
(2,4,'Member');----qqqqqqqqqqqqqqq

INSERT INTO Artists (Name, CountryID) VALUES
('Arijit Singh',1),
('Pritam',1),
('Taylor Swift',2),
('Ed Sheeran',3),
('DSP',1);

INSERT INTO Albums (Name, ReleaseDate) VALUES
('Album A','2023-01-01'),
('Album B','2023-02-01'),
('Album C','2023-03-01');

INSERT INTO Songs (Name, AlbumID, Duration) VALUES
('Song1',1,200),
('Song2',1,210),
('Song3',2,180),
('Song4',2,220),
('Song5',3,240),
('Song6',3,260);

INSERT INTO SongArtists VALUES
(1,1),(1,2),
(2,1),
(3,3),
(4,4),
(5,5),
(6,3);

INSERT INTO Genres (Name) VALUES
('Pop'),('Rock'),('Melody');

INSERT INTO SongGenres VALUES
(1,1),(2,3),(3,2),(4,1),(5,3),(6,2);

INSERT INTO Playlists (UserID, Name) VALUES
(1,'Top Hits'),
(2,'Workout'),
(3,'Chill'),
(4,'Romantic');

INSERT INTO PlaylistSongs VALUES
(1,1),(1,2),(1,3),
(2,3),(2,4),
(3,5),(3,6),
(4,1),(4,5);---qqqqqqqqqqqqqqqqqq

INSERT INTO UserLikedSongs VALUES
(1,1),(1,2),(2,3),(3,4),(4,5);

INSERT INTO ListeningHistory (UserID, SongID, DurationPlayed) VALUES
(1,1,200),(1,1,180),(1,2,150),
(2,3,180),(2,4,200),
(3,5,240),(3,6,260),
(4,1,200),(5,2,210),
(6,3,180),(7,4,220),
(8,5,240),(9,6,260);

INSERT INTO UserSongStats VALUES
(1,1,2,380,GETDATE()),
(1,2,1,150,GETDATE()),
(2,3,1,180,GETDATE());

INSERT INTO GlobalSongStats VALUES
(1,100,0.9,GETDATE()),
(2,80,0.8,GETDATE()),
(3,70,0.7,GETDATE());

INSERT INTO TrendingSongs (SongID, CountryID, Rank, Score, TrendDate) VALUES
(1,1,1,0.95,GETDATE()),
(2,1,2,0.90,GETDATE()),
(3,2,1,0.88,GETDATE());

INSERT INTO Recommendations (UserID, SongID, Score) VALUES
(1,3,0.9),(1,4,0.8),(2,5,0.85);

INSERT INTO Downloads VALUES
(1,1),(2,2),(3,3);---qqqqqqqqqqqqqqqqq

INSERT INTO Devices (UserID, DeviceName) VALUES
(1,'Mobile'),(2,'Laptop'),(3,'Tablet');

INSERT INTO UserSessions (UserID, DeviceID, LoginAt) VALUES
(1,1,GETDATE()),
(2,2,GETDATE()),
(3,3,GETDATE());

INSERT INTO Podcasts (Title) VALUES
('Tech Talks'),
('Daily News');

INSERT INTO PodcastEpisodes (PodcastID, Title, Duration) VALUES
(1,'Episode1',1200),
(1,'Episode2',1400),
(2,'Episode1',1000);

INSERT INTO PodcastListeningHistory (UserID, EpisodeID, DurationPlayed) VALUES
(1,1,600),(2,2,700),(3,3,500);



SELECT * FROM Albums;

INSERT INTO Albums (Name, ReleaseDate) VALUES
('Album D','2023-04-01'),
('Album E','2023-05-01'),
('Album F','2023-06-01'),
('Album G','2023-07-01'),
('Album H','2023-08-01'),
('Album I','2023-09-01'),
('Album J','2023-10-01');

INSERT INTO AlbumArtists (AlbumID, ArtistID) VALUES

-- Album 1
(1,1),(1,2),(1,3),(1,4),(1,5),

-- Album 2
(2,1),(2,2),(2,3),(2,4),(2,5),

-- Album 3
(3,1),(3,2),(3,3),(3,4),(3,5),

-- Album 4
(4,1),(4,2),(4,3),(4,4),(4,5),

-- Album 5
(5,1),(5,2),(5,3),(5,4),(5,5),

-- Album 6
(6,1),(6,2),(6,3),(6,4),(6,5),

-- Album 7
(7,1),(7,2),(7,3),(7,4),(7,5),

-- Album 8
(8,1),(8,2),(8,3),(8,4),(8,5),

-- Album 9
(9,1),(9,2),(9,3),(9,4),(9,5);

SELECT COUNT(*) FROM Albums;
SELECT COUNT(*) FROM Artists;

SELECT A.Name, COUNT(AA.ArtistID) AS TotalArtists
FROM Albums A
JOIN AlbumArtists AA ON A.AlbumID = AA.AlbumID
GROUP BY A.Name;


INSERT INTO Artists (Name, CountryID, LanguageID, Followers) VALUES

-- Indian Artists (Hindi / Telugu)
('Shreya Ghoshal',1,1,9500000),
('Sonu Nigam',1,1,8700000),
('Neha Kakkar',1,1,9100000),
('Armaan Malik',1,1,7800000),
('Jubin Nautiyal',1,1,7600000),
('Badshah',1,1,8200000),
('A.R. Rahman',1,1,15000000),
('Sid Sriram',1,3,6700000),
('Anirudh Ravichander',1,3,8800000),
('Thaman S',1,3,7200000),
('Yuvan Shankar Raja',1,3,6900000),
('Devi Sri Prasad',1,3,8500000),
('Karthik',1,1,5400000),
('Sunidhi Chauhan',1,1,7300000),
('KK',1,1,6000000),

-- USA Artists (English)
('Drake',2,2,20000000),
('Billie Eilish',2,2,18000000),
('Ariana Grande',2,2,21000000),
('The Weeknd',2,2,22000000),
('Bruno Mars',2,2,19500000),
('Kanye West',2,2,17000000),
('Post Malone',2,2,16000000),
('Travis Scott',2,2,17500000),
('Dua Lipa',2,2,19000000),
('Olivia Rodrigo',2,2,14000000),
('Doja Cat',2,2,13000000),
('Khalid',2,2,12500000),

-- UK Artists (English)
('Adele',3,2,21000000),
('Sam Smith',3,2,15000000),
('Harry Styles',3,2,18000000),
('Coldplay',3,2,23000000),
('Imagine Dragons',3,2,22000000),
('Lewis Capaldi',3,2,12000000),
('Rita Ora',3,2,9000000),
('Ellie Goulding',3,2,11000000),
('George Ezra',3,2,8000000),
('Calvin Harris',3,2,17000000),
('Stormzy',3,2,10000000),
('Zayn Malik',3,2,14000000);

SELECT * FROM Languages;

INSERT INTO Languages (Name) VALUES
('Hindi'),
('English'),
('Telugu'),
('Japanese'),
('Kannada');

SELECT MIN(ArtistID), MAX(ArtistID), COUNT(*) FROM Artists;

INSERT INTO Credits (SongID, ArtistID, Role) VALUES

-- Song 1
(1,1,'Singer'),
(1,2,'Composer'),
(1,3,'Lyricist'),
(1,4,'Producer'),
(1,5,'Backing Vocalist'),

-- Song 2
(2,1,'Singer'),
(2,2,'Composer'),
(2,3,'Lyricist'),
(2,4,'Producer'),
(2,5,'Rapper'),

-- Song 3
(3,3,'Singer'),
(3,1,'Composer'),
(3,2,'Lyricist'),
(3,4,'Producer'),
(3,5,'Backing Vocalist'),

-- Song 4
(4,4,'Singer'),
(4,1,'Composer'),
(4,2,'Lyricist'),
(4,3,'Producer'),
(4,5,'Rapper'),

-- Song 5
(5,5,'Composer'),
(5,1,'Singer'),
(5,2,'Lyricist'),
(5,3,'Producer'),
(5,4,'Backing Vocalist'),

-- Song 6
(6,3,'Singer'),
(6,1,'Composer'),
(6,2,'Lyricist'),
(6,4,'Producer'),
(6,5,'Rapper');

INSERT INTO Songs (Name, AlbumID, Duration, AudioURL) VALUES

('Love Beats',1,210,NULL),
('Night Drive',1,200,NULL),
('Dreams',2,230,NULL),
('Fire Inside',2,220,NULL),
('Lost Sky',3,240,NULL),
('Echoes',3,250,NULL),

('Midnight Rain',4,210,NULL),
('Golden Days',4,205,NULL),
('Heartbeat',5,215,NULL),
('Forever Young',5,225,NULL),

('Electric Soul',6,235,NULL),
('Deep Waves',6,245,NULL),
('Skyline',7,200,NULL),
('Runaway',7,210,NULL),

('Broken Strings',8,220,NULL),
('Stay With Me',8,215,NULL),
('Feel Alive',9,230,NULL),
('Gravity',9,240,NULL),

('Rise Up',1,210,NULL),
('Dark Nights',2,220,NULL),
('Ocean Eyes',3,230,NULL),
('Faded Lights',4,240,NULL),
('Silent Love',5,250,NULL),
('Wild Fire',6,260,NULL),

('No Limits',7,200,NULL),
('Higher',8,210,NULL),
('Take Me Back',9,220,NULL),
('Infinity',1,230,NULL),

('Closer',2,240,NULL),
('Memories',3,250,NULL),
('On My Way',4,260,NULL),
('Paradise',5,200,NULL),

('Thunder',6,210,NULL),
('Believer',7,220,NULL),
('Counting Stars',8,230,NULL),
('Demons',9,240,NULL);

INSERT INTO Artists (Name, CountryID, LanguageID, Followers) VALUES

-- India (Hindi)
('Shreya Ghoshal',1,1,9500000),
('Sonu Nigam',1,1,8700000),
('Neha Kakkar',1,1,9100000),
('Armaan Malik',1,1,7800000),
('Jubin Nautiyal',1,1,7600000),
('Badshah',1,1,8200000),
('A.R. Rahman',1,1,15000000),

-- India (Telugu)
('Sid Sriram',1,3,6700000),
('Anirudh Ravichander',1,3,8800000),
('Thaman S',1,3,7200000),
('Yuvan Shankar Raja',1,3,6900000),
('Devi Sri Prasad',1,3,8500000),

-- USA
('Drake',2,2,20000000),
('Billie Eilish',2,2,18000000),
('Ariana Grande',2,2,21000000),
('The Weeknd',2,2,22000000),
('Bruno Mars',2,2,19500000),
('Post Malone',2,2,16000000),
('Travis Scott',2,2,17500000),
('Doja Cat',2,2,13000000),

-- UK
('Adele',3,2,21000000),
('Sam Smith',3,2,15000000),
('Harry Styles',3,2,18000000),
('Coldplay',3,2,23000000),
('Lewis Capaldi',3,2,12000000),
('Calvin Harris',3,2,17000000),

-- Extra mix
('Khalid',2,2,12500000),
('Olivia Rodrigo',2,2,14000000),
('Rita Ora',3,2,9000000),
('Ellie Goulding',3,2,11000000),
('Zayn Malik',3,2,14000000),
('George Ezra',3,2,8000000),
('Stormzy',3,2,10000000),
('Imagine Dragons',3,2,22000000),
('OneRepublic',2,2,18000000),
('Maroon 5',2,2,21000000),
('Linkin Park',2,2,25000000),
('Green Day',2,2,19000000),
('Twenty One Pilots',2,2,17000000),
('Chainsmokers',2,2,16000000);

SELECT MAX(ArtistID) AS MaxArtist, MAX(SongID) AS MaxSong FROM Artists, Songs;

SELECT MIN(ArtistID) AS MinID, MAX(ArtistID) AS MaxID, COUNT(*) FROM Artists;

SELECT ArtistID FROM Artists ORDER BY ArtistID;

SELECT TOP 10 ArtistID FROM Artists ORDER BY ArtistID;

select * from dbo.Credits

INSERT INTO Users (Username, Email, PasswordHash, DOB, CountryID) VALUES

-- India (CountryID = 1)
('paartha_k','paartha.k@gmail.com','hash','2000-02-15',1),
('rahul_sharma','rahul.sharma@gmail.com','hash','1999-08-21',1),
('ananya_reddy','ananya.reddy@gmail.com','hash','2001-11-12',1),
('kiran_kumar','kiran.kumar@gmail.com','hash','2000-06-30',1),
('sneha_iyer','sneha.iyer@gmail.com','hash','1998-04-18',1),
('vikram_patil','vikram.patil@gmail.com','hash','1997-09-25',1),
('meera_nair','meera.nair@gmail.com','hash','2002-01-10',1),
('arjun_verma','arjun.verma@gmail.com','hash','2000-03-05',1),
('divya_shah','divya.shah@gmail.com','hash','1999-12-22',1),
('rohit_gupta','rohit.gupta@gmail.com','hash','2001-07-14',1),
('nisha_menon','nisha.menon@gmail.com','hash','2002-02-19',1),
('amit_singh','amit.singh@gmail.com','hash','1998-10-11',1),
('pooja_jain','pooja.jain@gmail.com','hash','2000-05-09',1),
('manish_yadav','manish.yadav@gmail.com','hash','1999-03-17',1),

-- USA (CountryID = 2)
('john_smith','john.smith@gmail.com','hash','1995-06-15',2),
('emma_johnson','emma.johnson@gmail.com','hash','1996-09-20',2),
('michael_brown','michael.brown@gmail.com','hash','1994-12-11',2),
('olivia_davis','olivia.davis@gmail.com','hash','1997-07-08',2),
('william_miller','william.miller@gmail.com','hash','1993-11-25',2),
('sophia_wilson','sophia.wilson@gmail.com','hash','1998-01-30',2),
('james_moore','james.moore@gmail.com','hash','1996-04-22',2),
('isabella_taylor','isabella.taylor@gmail.com','hash','1997-02-14',2),
('benjamin_anderson','ben.anderson@gmail.com','hash','1995-05-05',2),
('mia_thomas','mia.thomas@gmail.com','hash','1999-09-09',2),
('elijah_white','elijah.white@gmail.com','hash','1994-08-18',2),
('amelia_harris','amelia.harris@gmail.com','hash','1996-03-27',2),

-- UK (CountryID = 3)
('harry_clark','harry.clark@gmail.com','hash','1995-07-12',3),
('oliver_lewis','oliver.lewis@gmail.com','hash','1996-10-03',3),
('george_hall','george.hall@gmail.com','hash','1994-01-25',3),
('jack_allen','jack.allen@gmail.com','hash','1997-06-16',3),
('charlie_young','charlie.young@gmail.com','hash','1998-12-01',3),
('thomas_king','thomas.king@gmail.com','hash','1995-09-14',3),
('freddie_scott','freddie.scott@gmail.com','hash','1996-11-21',3),
('alfie_green','alfie.green@gmail.com','hash','1997-04-09',3),
('oscar_adams','oscar.adams@gmail.com','hash','1998-02-28',3),
('leo_baker','leo.baker@gmail.com','hash','1999-05-19',3),
('archie_nelson','archie.nelson@gmail.com','hash','1996-08-07',3),
('henry_carter','henry.carter@gmail.com','hash','1995-03-13',3);

select * from dbo.Users

INSERT INTO Devices (UserID, DeviceName) VALUES

-- Mobiles (most common)
(1,'iPhone 13'),(2,'Samsung Galaxy S21'),(3,'OnePlus 11'),(4,'iPhone 12'),
(5,'Redmi Note 12'),(6,'Realme GT'),(7,'Pixel 7'),(8,'iPhone 14'),
(9,'Samsung Galaxy S22'),(10,'OnePlus Nord'),

-- Laptops
(1,'MacBook Air'),(2,'Dell XPS 13'),(3,'HP Spectre x360'),(4,'Lenovo ThinkPad'),
(5,'Asus ZenBook'),(6,'MacBook Pro'),(7,'Acer Swift'),(8,'Dell Inspiron'),
(9,'HP Pavilion'),(10,'Lenovo Yoga'),

-- Tablets
(11,'iPad Pro'),(12,'Samsung Tab S8'),(13,'iPad Air'),(14,'Lenovo Tab'),
(15,'Samsung Tab A'),(16,'iPad Mini'),(17,'Realme Pad'),(18,'Mi Pad'),
(19,'Amazon Fire'),(20,'Nokia Tab'),

-- Smart TVs
(21,'Samsung Smart TV'),(22,'LG OLED TV'),(23,'Sony Bravia'),
(24,'Mi TV'),(25,'OnePlus TV'),

-- Desktops
(26,'Windows Desktop'),(27,'Gaming PC'),(28,'iMac'),
(29,'Custom Build PC'),(30,'Office Desktop'),

-- Extra devices (multi-device users)
(1,'Apple Watch'),(2,'iPad Mini'),(3,'Surface Pro'),
(4,'Chromebook'),(5,'Smart Speaker'),
(6,'Android TV'),(7,'VR Headset'),
(8,'PlayStation 5'),(9,'Xbox Series X'),(10,'Smart Display');

SELECT UserID, COUNT(*) AS DeviceCount
FROM Devices
GROUP BY UserID
HAVING COUNT(*) > 1;

SELECT DeviceName, COUNT(*) AS UsageCount
FROM Devices
GROUP BY DeviceName
ORDER BY UsageCount DESC;

SELECT u.Username, d.DeviceName
FROM Devices d
JOIN Users u ON d.UserID = u.UserID;

INSERT INTO Downloads (UserID, SongID, DownloadedAt) VALUES

(1,1,GETDATE()),(1,2,GETDATE()),
(2,3,GETDATE()),(2,4,GETDATE()),
(3,5,GETDATE()),(3,6,GETDATE()),

(4,7,GETDATE()),(4,8,GETDATE()),
(5,9,GETDATE()),(5,10,GETDATE()),

(6,11,GETDATE()),(6,12,GETDATE()),
(7,13,GETDATE()),(7,14,GETDATE()),
(8,15,GETDATE()),(8,16,GETDATE()),

(9,17,GETDATE()),(9,18,GETDATE()),
(10,19,GETDATE()),(10,20,GETDATE()),

(11,1,GETDATE()),(12,2,GETDATE()),
(13,3,GETDATE()),(14,4,GETDATE()),
(15,5,GETDATE()),(16,6,GETDATE()),

(17,7,GETDATE()),(18,8,GETDATE()),
(19,9,GETDATE()),(20,10,GETDATE()),

(21,11,GETDATE()),(22,12,GETDATE()),
(23,13,GETDATE()),(24,14,GETDATE()),
(25,15,GETDATE()),(26,16,GETDATE()),

(27,17,GETDATE()),(28,18,GETDATE()),
(29,19,GETDATE()),(30,20,GETDATE()),

(31,2,GETDATE()),(32,4,GETDATE()),
(33,6,GETDATE()),(34,8,GETDATE()),
(35,10,GETDATE()),(36,12,GETDATE()),

(37,14,GETDATE()),(38,16,GETDATE()),
(39,18,GETDATE()),(40,20,GETDATE());

INSERT INTO EpisodeHosts (EpisodeID, ArtistID, Role) VALUES

-- Episode 1
(1,1,'Host'),
(1,2,'Guest'),
(1,3,'Guest'),
(1,4,'Host'),
(1,5,'Guest'),

-- Episode 2
(2,2,'Host'),
(2,3,'Guest'),
(2,4,'Guest'),
(2,5,'Host'),

-- Episode 3
(3,3,'Host'),
(3,4,'Guest'),
(3,5,'Guest'),

(3,7,'Guest'),

-- Extra mix
(1,7,'Guest'),
(1,8,'Guest'),
(2,8,'Guest'),
(2,9,'Guest'),
(3,9,'Guest'),

(1,10,'Host'),
(2,10,'Host'),
(3,10,'Host'),

(1,11,'Guest'),
(2,11,'Guest'),
(3,11,'Guest'),

(1,12,'Guest'),
(2,12,'Guest'),
(3,12,'Guest'),

(1,13,'Guest'),
(2,13,'Guest'),
(3,13,'Guest'),

(1,14,'Guest'),
(2,14,'Guest'),
(3,14,'Guest'),

(1,15,'Guest'),
(2,15,'Guest'),
(3,15,'Guest');

SELECT GenreID FROM Genres;
SELECT TOP 20 ArtistID FROM Artists ORDER BY ArtistID;

INSERT INTO GenreArtists (GenreID, ArtistID) VALUES

-- Pop (GenreID = 1)
(1,1),(1,2),(1,3),(1,4),(1,5),
(1,7),(1,8),(1,9),(1,10),(1,11),
(1,12),(1,13),(1,14),(1,15),(1,16),

-- Rock (GenreID = 2)
(2,3),(2,4),(2,7),(2,8),
(2,9),(2,10),(2,11),(2,12),(2,13),
(2,14),(2,15),(2,16),(2,17),(2,18),

-- Melody (GenreID = 3)
(3,1),(3,2),(3,5),(3,7),
(3,8),(3,9),(3,10),(3,11),(3,12),
(3,13),(3,14),(3,15),(3,16),(3,17);


INSERT INTO GlobalArtistStats (ArtistID, TotalPlays, TotalListeners, TotalFollowers, TrendingScore, LastUpdated) VALUES

(1,1200000,500000,200000,0.95,GETDATE()),
(2,1100000,480000,180000,0.92,GETDATE()),
(3,1500000,700000,300000,0.98,GETDATE()),
(4,1300000,600000,250000,0.96,GETDATE()),
(5,900000,400000,150000,0.88,GETDATE()),

(7,800000,350000,140000,0.85,GETDATE()),
(8,850000,360000,145000,0.87,GETDATE()),
(9,870000,370000,150000,0.89,GETDATE()),
(10,920000,390000,160000,0.90,GETDATE()),
(11,780000,340000,130000,0.84,GETDATE()),

(12,760000,330000,125000,0.83,GETDATE()),
(13,740000,320000,120000,0.82,GETDATE()),
(14,720000,310000,115000,0.81,GETDATE()),
(15,700000,300000,110000,0.80,GETDATE()),
(16,680000,290000,105000,0.79,GETDATE()),

(17,660000,280000,100000,0.78,GETDATE()),
(18,640000,270000,95000,0.77,GETDATE()),
(19,620000,260000,90000,0.76,GETDATE()),
(20,600000,250000,85000,0.75,GETDATE()),
(21,580000,240000,80000,0.74,GETDATE()),

(22,560000,230000,75000,0.73,GETDATE()),
(23,540000,220000,70000,0.72,GETDATE()),
(24,520000,210000,65000,0.71,GETDATE()),
(25,500000,200000,60000,0.70,GETDATE()),
(26,480000,190000,55000,0.69,GETDATE()),

(27,460000,180000,50000,0.68,GETDATE()),
(28,440000,170000,48000,0.67,GETDATE()),
(29,420000,160000,46000,0.66,GETDATE()),
(30,400000,150000,44000,0.65,GETDATE()),
(31,380000,140000,42000,0.64,GETDATE()),

(32,360000,130000,40000,0.63,GETDATE()),
(33,340000,120000,38000,0.62,GETDATE()),
(34,320000,110000,36000,0.61,GETDATE()),
(35,300000,100000,34000,0.60,GETDATE()),
(36,280000,90000,32000,0.59,GETDATE()),

(37,260000,85000,30000,0.58,GETDATE()),
(38,240000,80000,28000,0.57,GETDATE()),
(39,220000,75000,26000,0.56,GETDATE()),
(40,200000,70000,24000,0.55,GETDATE());


---Top trending Artists---
SELECT a.Name, g.TrendingScore
FROM GlobalArtistStats g
JOIN Artists a ON g.ArtistID = a.ArtistID
ORDER BY g.TrendingScore DESC;

---Most played artists---
SELECT a.Name, g.TotalPlays
FROM GlobalArtistStats g
JOIN Artists a ON g.ArtistID = a.ArtistID
ORDER BY g.TotalPlays DESC;

---Artists With High Engagement---
SELECT ArtistID, TotalListeners, TotalFollowers
FROM GlobalArtistStats
WHERE TotalListeners > 300000;

INSERT INTO GlobalPlaylistStats 
(PlaylistID, TotalPlays, FollowersCount, TotalListeningTime, TrendingScore, LastUpdated) VALUES

(1,5000,1200,150000,0.92,GETDATE()),
(2,4200,950,120000,0.88,GETDATE()),
(3,3800,800,100000,0.85,GETDATE()),
(4,4600,1100,130000,0.90,GETDATE());

INSERT INTO Playlists (UserID, Name, Description, IsPublic, FollowersCount) VALUES

-- User 1–10 (multiple playlists per user)
(1,'Party Mix','High energy party songs',1,120),
(2,'Gym Boost','Workout motivation tracks',1,95),
(3,'LoFi Chill','Relaxing lo-fi beats',1,150),
(4,'Love Vibes','Romantic songs collection',1,110),
(5,'Road Trip','Songs for long drives',1,130),

(6,'Focus Mode','Concentration music',1,80),
(7,'Throwback Hits','Old classics',1,140),
(8,'Dance Floor','Dance hits',1,160),
(9,'Sad Songs','Emotional tracks',1,100),
(10,'Morning Energy','Start your day fresh',1,90),

-- More variety
(11,'Indie Mix','Best indie songs',1,75),
(12,'Rock Legends','Top rock songs',1,180),
(13,'Pop Essentials','Popular hits',1,200),
(14,'Study Playlist','Deep focus music',1,85),
(15,'Evening Relax','Calm evening tracks',1,95),

(16,'Hip Hop Beats','Rap and hip-hop',1,170),
(17,'Festival Hits','Trending festival songs',1,155),
(18,'Acoustic Vibes','Soft acoustic songs',1,120),
(19,'Instrumental','No vocals music',1,60),
(20,'Sleep Sounds','Relaxing sleep audio',1,140),

-- More users
(21,'Travel Tunes','Journey playlist',1,110),
(22,'Top Global','Worldwide hits',1,210),
(23,'Chill Beats','Cool chill songs',1,130),
(24,'Motivation','Boost your mood',1,145),
(25,'Deep Focus','Productivity music',1,100),

(26,'Weekend Party','Weekend vibes',1,160),
(27,'Romantic Hindi','Hindi love songs',1,170),
(28,'English Hits','Top English songs',1,180),
(29,'Telugu Hits','Best Telugu songs',1,150),
(30,'Tamil Beats','Top Tamil songs',1,140),

-- Extra variety
(31,'Gaming Playlist','Background gaming music',1,90),
(32,'Coding Mode','Developer focus tracks',1,85),
(33,'Night Drive','Late night vibes',1,125),
(34,'Rainy Mood','Rain + music combo',1,115),
(35,'Soul Music','Deep emotional songs',1,95),

(36,'Trending Now','Currently trending',1,220),
(37,'Top India','Indian chartbusters',1,210),
(38,'Top USA','US top charts',1,200),
(39,'Top UK','UK trending songs',1,190),
(40,'Mixed Vibes','All genres mix',1,160),

(41,'Workout Hardcore','Intense gym songs',1,175),
(42,'Soft Piano','Relaxing piano',1,80),
(43,'Jazz Classics','Old jazz hits',1,95),
(44,'Electronic Mix','EDM tracks',1,180),
(45,'Daily Mix','Personalized mix',1,210);

INSERT INTO Podcasts (Title, Description, LanguageID, CreatedByArtistID, IsActive) VALUES

-- Tech / Business
('Startup Stories','Entrepreneur journeys and insights',2,3,1),
('AI Today','Latest trends in AI and tech',2,4,1),
('Business Talks','Corporate and startup discussions',2,5,1),
('Crypto World','Blockchain and crypto updates',2,7,1),
('Tech Bytes','Quick tech news',2,7,1),

-- News / Daily
('Global News','Worldwide news coverage',2,8,1),
('Morning Brief','Daily morning updates',2,9,1),
('Evening News','Daily evening recap',2,10,1),
('India Today','Indian current affairs',1,1,1),
('World Focus','Global insights',2,2,1),

-- Entertainment
('Bollywood Buzz','Bollywood news and gossip',1,1,1),
('Hollywood Insider','Hollywood updates',2,3,1),
('Music Talks','Discussions about music industry',2,4,1),
('Artist Spotlight','Interviews with artists',2,5,1),
('Behind the Music','Stories behind songs',2,4,1),

-- Education
('Learn SQL','Database and SQL tutorials',2,7,1),
('Coding 101','Programming basics',2,8,1),
('Tech Explained','Deep tech concepts',2,9,1),
('History Hour','Historical discussions',2,10,1),
('Science Daily','Science news and facts',2,11,1),

-- Lifestyle
('Fitness Talks','Health and fitness tips',2,12,1),
('Mind Matters','Mental health discussions',2,13,1),
('Travel Diaries','Travel experiences',2,14,1),
('Food Stories','Food and culture',2,15,1),
('Life Hacks','Daily productivity tips',2,16,1),

-- Regional
('Telugu Talks','Telugu discussions',3,17,1),
('Tamil Trends','Tamil entertainment',3,18,1),
('Hindi Vibes','Hindi culture talk',1,2,1),

-- Misc
('Gaming Arena','Gaming discussions',2,19,1),
('Sports Central','Sports updates',2,20,1),
('Finance Talks','Personal finance tips',2,3,1),
('Motivation Daily','Daily motivation',2,4,1),
('Story Time','Storytelling podcast',2,5,1),
('Night Talks','Late night discussions',2,4,1);

SELECT PodcastID FROM Podcasts;

SELECT COUNT(*) FROM Podcasts;

SELECT PodcastID FROM Podcasts ORDER BY PodcastID;

INSERT INTO GlobalPodcastStats 
(PodcastID, TotalPlays, TotalListeners, TrendingScore, LastUpdated) VALUES

(1,50000,20000,0.92,GETDATE()),
(2,48000,19000,0.90,GETDATE()),

(7,42000,17000,0.88,GETDATE()),
(8,43000,17500,0.89,GETDATE()),
(9,44000,18000,0.90,GETDATE()),
(10,45000,18500,0.91,GETDATE()),

(11,30000,12000,0.75,GETDATE()),
(12,32000,13000,0.76,GETDATE()),
(13,34000,14000,0.77,GETDATE()),
(14,36000,15000,0.78,GETDATE()),

(15,38000,16000,0.79,GETDATE()),
(16,40000,17000,0.80,GETDATE()),
(17,42000,17500,0.82,GETDATE()),
(18,41000,17200,0.81,GETDATE()),

(19,39000,16500,0.79,GETDATE()),
(20,37000,16000,0.78,GETDATE()),
(21,35000,15000,0.77,GETDATE()),
(22,65000,27000,0.96,GETDATE()),

(23,33000,14000,0.76,GETDATE()),
(24,36000,15500,0.79,GETDATE()),
(25,34000,14500,0.78,GETDATE()),
(26,31000,13000,0.75,GETDATE()),

(27,37000,16000,0.82,GETDATE()),
(28,39000,17000,0.84,GETDATE()),
(29,41000,18000,0.86,GETDATE()),
(30,42000,18500,0.87,GETDATE()),

(31,43000,19000,0.88,GETDATE()),
(32,44000,19500,0.89,GETDATE()),
(33,45000,20000,0.90,GETDATE()),
(34,46000,20500,0.91,GETDATE()),

(35,47000,21000,0.92,GETDATE()),
(36,48000,21500,0.93,GETDATE()),
(37,49000,22000,0.94,GETDATE()),
(38,50000,22500,0.95,GETDATE()),

(39,51000,23000,0.96,GETDATE()),
(40,52000,23500,0.97,GETDATE());

INSERT INTO GlobalSongStats (SongID, TotalPlays, TrendingScore, LastUpdated) VALUES

(4,120,0.85,GETDATE()),
(5,150,0.88,GETDATE()),
(6,180,0.90,GETDATE()),
(7,200,0.92,GETDATE()),
(8,220,0.94,GETDATE()),

(9,170,0.89,GETDATE()),
(10,160,0.87,GETDATE()),
(11,140,0.86,GETDATE()),
(12,130,0.84,GETDATE()),
(13,125,0.83,GETDATE()),

(14,135,0.85,GETDATE()),
(15,145,0.88,GETDATE()),
(16,155,0.89,GETDATE()),
(17,165,0.91,GETDATE()),
(18,175,0.92,GETDATE()),

(19,185,0.93,GETDATE()),
(20,195,0.94,GETDATE()),
(21,205,0.95,GETDATE()),
(22,215,0.96,GETDATE()),
(23,225,0.97,GETDATE()),

(24,210,0.94,GETDATE()),
(25,200,0.92,GETDATE()),
(26,190,0.90,GETDATE()),
(27,180,0.89,GETDATE()),
(28,170,0.88,GETDATE()),

(29,160,0.87,GETDATE()),
(30,150,0.86,GETDATE()),
(31,140,0.85,GETDATE()),
(32,130,0.84,GETDATE()),
(33,120,0.83,GETDATE()),

(34,110,0.82,GETDATE()),
(35,100,0.81,GETDATE()),
(36,95,0.80,GETDATE()),
(37,90,0.79,GETDATE()),
(38,85,0.78,GETDATE()),

(39,80,0.77,GETDATE()),
(40,75,0.76,GETDATE());

INSERT INTO ListeningHistory (UserID, SongID, DurationPlayed, PlayedAt) VALUES

-- Users 10–20
(10,7,200,GETDATE()),
(11,8,210,GETDATE()),
(12,9,220,GETDATE()),
(13,10,230,GETDATE()),
(14,11,240,GETDATE()),
(15,12,250,GETDATE()),
(16,13,260,GETDATE()),
(17,14,210,GETDATE()),
(18,15,220,GETDATE()),
(19,16,230,GETDATE()),
(20,17,240,GETDATE()),

-- Users 21–30
(21,18,250,GETDATE()),
(22,19,260,GETDATE()),
(23,20,210,GETDATE()),
(24,21,220,GETDATE()),
(25,22,230,GETDATE()),
(26,23,240,GETDATE()),
(27,24,250,GETDATE()),
(28,25,260,GETDATE()),
(29,26,210,GETDATE()),
(30,27,220,GETDATE()),

-- Users 31–40
(31,28,230,GETDATE()),
(32,29,240,GETDATE()),
(33,30,250,GETDATE()),
(34,31,260,GETDATE()),
(35,32,210,GETDATE()),
(36,33,220,GETDATE()),
(37,34,230,GETDATE()),
(38,35,240,GETDATE()),
(39,36,250,GETDATE()),
(40,37,260,GETDATE()),

-- Repeat listening (realistic behavior 🔥)
(1,3,180,GETDATE()),
(2,5,200,GETDATE()),
(3,1,240,GETDATE()),
(4,2,210,GETDATE()),
(5,4,220,GETDATE()),

(6,6,260,GETDATE()),
(7,7,200,GETDATE()),
(8,8,210,GETDATE()),
(9,9,220,GETDATE()),
(10,10,230,GETDATE());

INSERT INTO Lyrics (SongID, Content) VALUES

(1,'Love flows through the melody, hearts beat in harmony'),
(2,'Dancing under neon lights, lost in endless nights'),
(3,'Dreams whisper softly in the dark, leaving a glowing spark'),
(4,'Fire burns inside my soul, chasing dreams to feel whole'),
(5,'Echoes of love in the sky, never asking why'),
(6,'Lost in the rhythm of time, every note feels divine'),

(7,'Midnight rain falls on my mind, memories left behind'),
(8,'Golden days and brighter nights, shining city lights'),
(9,'Heartbeat racing through the sound, music all around'),
(10,'Forever young in every song, where we all belong'),

(11,'Electric waves across the sea, calling out to me'),
(12,'Deep within the silent tide, emotions never hide'),
(13,'Skyline glowing far away, guiding me today'),
(14,'Runaway dreams we chase tonight, under moonlight bright'),

(15,'Broken strings but still I play, finding hope each day'),
(16,'Stay with me through highs and lows, where the river flows'),
(17,'Feel alive in every beat, rhythm makes me complete'),
(18,'Gravity pulls me close to you, nothing else feels true'),

(19,'Rise up high and never fall, standing proud and tall'),
(20,'Dark nights fade into the dawn, life goes on and on'),
(21,'Ocean eyes reflect the blue, lost in thoughts of you'),
(22,'Faded lights but shining hearts, never drift apart'),

(23,'Silent love that softly grows, like a hidden rose'),
(24,'Wild fire burning deep inside, where passions collide'),
(25,'No limits to what we can be, just you and me'),
(26,'Higher we go beyond the sky, learning how to fly'),

(27,'Take me back to where it began, where we first ran'),
(28,'Infinity in every line, moments frozen in time'),
(29,'Closer now than ever before, opening every door'),
(30,'Memories that never fade, in the songs we made'),

(31,'On my way through stormy nights, guided by the lights'),
(32,'Paradise in every sound, where dreams are found'),
(33,'Thunder roars within my chest, putting me to the test'),
(34,'Believer in every sign, trusting the divine'),

(35,'Counting stars across the sky, watching time fly'),
(36,'Demons fade into the night, chasing away the fright'),
(37,'Voices calling from afar, guiding like a star'),
(38,'Shadows dancing in the light, fading out of sight'),

(39,'Moments we will always keep, memories run deep'),
(40,'Endless songs we sing again, like a timeless refrain');

INSERT INTO Taxes (CountryID, StateID, TaxType, TaxPercentage) VALUES
(1,1,'GST',18),
(2,3,'Sales Tax',8),
(3,4,'VAT',20);

INSERT INTO Payments 
(UserID, SubscriptionID, Amount, TaxID, TaxAmount, TotalAmount, PaymentStatus, PaymentMethod) VALUES

-- Subscription 1 (User 1)
(1,1,199,1,35.82,234.82,'Success','UPI'),
(1,1,199,1,35.82,234.82,'Success','Card'),
(1,1,199,1,35.82,234.82,'Success','NetBanking'),

-- Subscription 2 (User 2 - Family)
(2,2,499,1,89.82,588.82,'Success','Card'),
(2,2,499,1,89.82,588.82,'Success','UPI'),
(2,2,499,1,89.82,588.82,'Failed','Card'),

-- Subscription 3 (User 3)
(3,3,199,2,15.92,214.92,'Success','NetBanking'),
(3,3,199,2,15.92,214.92,'Pending','UPI'),
(3,3,199,2,15.92,214.92,'Success','Card'),

-- More users mapped to subscriptions
(4,1,199,1,35.82,234.82,'Success','UPI'),
(5,1,199,1,35.82,234.82,'Success','Card'),
(6,2,499,1,89.82,588.82,'Success','NetBanking'),

(7,3,199,2,15.92,214.92,'Success','UPI'),
(8,2,499,1,89.82,588.82,'Pending','Card'),
(9,1,199,1,35.82,234.82,'Success','UPI'),

(10,3,199,2,15.92,214.92,'Success','Card'),
(11,1,199,1,35.82,234.82,'Success','NetBanking'),
(12,2,499,1,89.82,588.82,'Success','UPI'),

(13,3,199,2,15.92,214.92,'Success','Card'),
(14,1,199,1,35.82,234.82,'Failed','UPI'),
(15,2,499,1,89.82,588.82,'Success','Card'),

(16,3,199,2,15.92,214.92,'Success','NetBanking'),
(17,1,199,1,35.82,234.82,'Pending','UPI'),
(18,2,499,1,89.82,588.82,'Success','Card'),

(19,3,199,2,15.92,214.92,'Success','UPI'),
(20,1,199,1,35.82,234.82,'Success','Card'),
(21,2,499,1,89.82,588.82,'Success','NetBanking'),

(22,3,199,2,15.92,214.92,'Success','UPI'),
(23,1,199,1,35.82,234.82,'Success','Card'),
(24,2,499,1,89.82,588.82,'Failed','UPI'),

(25,3,199,2,15.92,214.92,'Success','Card'),
(26,1,199,1,35.82,234.82,'Success','NetBanking'),
(27,2,499,1,89.82,588.82,'Pending','UPI'),

(28,3,199,2,15.92,214.92,'Success','Card'),
(29,1,199,1,35.82,234.82,'Success','UPI'),
(30,2,499,1,89.82,588.82,'Success','Card');


INSERT INTO PlaylistGenres (GenreID, PlaylistID) VALUES

-- Pop (1)
(1,1),(1,2),(1,3),(1,4),(1,5),
(1,6),(1,7),(1,8),(1,9),(1,10),
(1,11),(1,12),(1,13),(1,14),(1,15),

-- Rock (2)
(2,5),(2,6),(2,7),(2,8),(2,9),
(2,10),(2,11),(2,12),(2,13),(2,14),
(2,15),(2,16),(2,17),(2,18),(2,19),

-- Melody (3)
(3,1),(3,2),(3,3),(3,4),(3,5),
(3,16),(3,17),(3,18),(3,19),(3,20),
(3,21),(3,22),(3,23),(3,24),(3,25);

INSERT INTO PlaylistSongs (PlaylistID, SongID, AddedAt) VALUES

-- Playlist 1–5
(1,1,GETDATE()),(1,2,GETDATE()),(1,3,GETDATE()),(1,4,GETDATE()),
(2,3,GETDATE()),(2,4,GETDATE()),(2,5,GETDATE()),(2,6,GETDATE()),
(3,5,GETDATE()),(3,6,GETDATE()),(3,7,GETDATE()),(3,8,GETDATE()),
(4,1,GETDATE()),(4,5,GETDATE()),(4,9,GETDATE()),(4,10,GETDATE()),
(5,7,GETDATE()),(5,8,GETDATE()),(5,11,GETDATE()),(5,12,GETDATE()),

-- Playlist 6–10
(6,9,GETDATE()),(6,10,GETDATE()),(6,13,GETDATE()),(6,14,GETDATE()),
(7,11,GETDATE()),(7,12,GETDATE()),(7,15,GETDATE()),(7,16,GETDATE()),
(8,13,GETDATE()),(8,14,GETDATE()),(8,17,GETDATE()),(8,18,GETDATE()),
(9,15,GETDATE()),(9,16,GETDATE()),(9,19,GETDATE()),(9,20,GETDATE()),
(10,17,GETDATE()),(10,18,GETDATE()),(10,21,GETDATE()),(10,22,GETDATE()),

-- Playlist 11–15
(11,19,GETDATE()),(11,20,GETDATE()),(11,23,GETDATE()),(11,24,GETDATE()),
(12,21,GETDATE()),(12,22,GETDATE()),(12,25,GETDATE()),(12,26,GETDATE()),
(13,23,GETDATE()),(13,24,GETDATE()),(13,27,GETDATE()),(13,28,GETDATE()),
(14,25,GETDATE()),(14,26,GETDATE()),(14,29,GETDATE()),(14,30,GETDATE()),
(15,27,GETDATE()),(15,28,GETDATE()),(15,31,GETDATE()),(15,32,GETDATE());

INSERT INTO PodcastEpisodes 
(PodcastID, Title, Description, Duration, ReleaseDate, AudioURL, IsActive) VALUES

-- Podcast 1
(1,'AI Revolution','Discussion on AI growth',1200,'2025-01-01',NULL,1),
(1,'Future Tech','Upcoming technologies',1300,'2025-01-10',NULL,1),

-- Podcast 2
(2,'Morning Headlines','Daily news update',900,'2025-01-02',NULL,1),
(2,'Evening Recap','Summary of the day',950,'2025-01-03',NULL,1),

-- Podcast 7–10
(7,'Startup Journey','Entrepreneur stories',1100,'2025-01-05',NULL,1),
(8,'Crypto Trends','Crypto discussion',1000,'2025-01-06',NULL,1),
(9,'Global Affairs','World politics',1050,'2025-01-07',NULL,1),
(10,'Market Watch','Stock updates',980,'2025-01-08',NULL,1),

-- Podcast 11–15
(11,'Music Industry','Music insights',1150,'2025-01-09',NULL,1),
(12,'Rock Legends Talk','Rock history',1250,'2025-01-11',NULL,1),
(13,'Pop Culture','Trending topics',1100,'2025-01-12',NULL,1),
(14,'Study Tips','Student advice',900,'2025-01-13',NULL,1),
(15,'Evening Calm','Relaxation talk',950,'2025-01-14',NULL,1),

-- Podcast 16–20
(16,'Hip Hop Talk','Rap discussions',1200,'2025-01-15',NULL,1),
(17,'Festival Vibes','Festival trends',1000,'2025-01-16',NULL,1),
(18,'Acoustic Nights','Soft music talk',1050,'2025-01-17',NULL,1),
(19,'Instrumental Talk','Music without vocals',950,'2025-01-18',NULL,1),
(20,'Sleep Guide','Sleep tips',900,'2025-01-19',NULL,1),

-- Podcast 21–25
(21,'Travel Stories','Journey experiences',1100,'2025-01-20',NULL,1),
(22,'Global Hits','Top songs worldwide',1200,'2025-01-21',NULL,1),
(23,'Chill Sessions','Relax music',1000,'2025-01-22',NULL,1),
(24,'Motivation Talk','Motivation podcast',950,'2025-01-23',NULL,1),
(25,'Deep Focus','Focus tips',900,'2025-01-24',NULL,1),

-- Podcast 26–30
(26,'Weekend Party','Party songs talk',1150,'2025-01-25',NULL,1),
(27,'Hindi Special','Hindi content',1100,'2025-01-26',NULL,1),
(28,'English Mix','English content',1200,'2025-01-27',NULL,1),
(29,'Telugu Talk','Telugu topics',1000,'2025-01-28',NULL,1),
(30,'Tamil Beats','Tamil music',1050,'2025-01-29',NULL,1),

-- Podcast 31–35
(31,'Gaming Arena','Gaming talk',1100,'2025-01-30',NULL,1),
(32,'Coding Talk','Programming tips',1200,'2025-02-01',NULL,1),
(33,'Night Drive','Late night vibes',1000,'2025-02-02',NULL,1),
(34,'Rain Talks','Rain mood podcast',950,'2025-02-03',NULL,1),
(35,'Soul Talk','Deep thoughts',900,'2025-02-04',NULL,1),

-- Podcast 36–40
(36,'Trending Now','Latest trends',1200,'2025-02-05',NULL,1),
(37,'India Special','Indian trends',1100,'2025-02-06',NULL,1),
(38,'USA Trends','US topics',1150,'2025-02-07',NULL,1),
(39,'UK Talk','UK discussions',1000,'2025-02-08',NULL,1),
(40,'Mixed Topics','Various topics',1050,'2025-02-09',NULL,1);

INSERT INTO PodcastGenres (PodcastID, GenreID) VALUES

-- Podcast 1–2
(1,1),(1,3),
(2,1),(2,2),

-- Podcast 7–10
(7,1),(7,2),
(8,2),(8,3),
(9,1),(9,3),
(10,2),(10,3),

-- Podcast 11–15
(11,1),(11,2),
(12,2),(12,3),
(13,1),(13,3),
(14,3),
(15,1),(15,3),

-- Podcast 16–20
(16,2),(16,3),
(17,1),(17,2),
(18,3),
(19,2),
(20,3),

-- Podcast 21–25
(21,1),(21,3),
(22,1),
(23,3),
(24,2),
(25,3),

-- Podcast 26–30
(26,1),(26,2),
(27,3),
(28,1),
(29,3),
(30,2),

-- Podcast 31–35
(31,2),
(32,1),
(33,3),
(34,3),
(35,1),

-- Podcast 36–40
(36,1),(36,2),
(37,1),
(38,2),
(39,2),
(40,1),(40,3);

INSERT INTO PodcastListeningHistory (UserID, EpisodeID, DurationPlayed, PlayedAt) VALUES

-- Users 4–10
(4,4,650,GETDATE()),
(5,5,700,GETDATE()),
(6,6,750,GETDATE()),
(7,7,800,GETDATE()),
(8,8,600,GETDATE()),
(9,9,650,GETDATE()),
(10,10,700,GETDATE()),

-- Users 11–20
(11,11,550,GETDATE()),
(12,12,600,GETDATE()),
(13,13,650,GETDATE()),
(14,14,700,GETDATE()),
(15,15,750,GETDATE()),
(16,16,800,GETDATE()),
(17,17,600,GETDATE()),
(18,18,650,GETDATE()),
(19,19,700,GETDATE()),
(20,20,750,GETDATE()),

-- Users 21–30
(21,21,800,GETDATE()),
(22,22,650,GETDATE()),
(23,23,600,GETDATE()),
(24,24,550,GETDATE()),
(25,25,500,GETDATE()),
(26,26,750,GETDATE()),
(27,27,700,GETDATE()),
(28,28,650,GETDATE()),
(29,29,600,GETDATE()),
(30,30,550,GETDATE()),

-- Users 31–40
(31,31,800,GETDATE()),
(32,32,750,GETDATE()),
(33,33,700,GETDATE()),
(34,34,650,GETDATE()),
(35,35,600,GETDATE()),
(36,36,550,GETDATE()),
(37,37,500,GETDATE()),
(38,38,750,GETDATE()),
(39,39,700,GETDATE()),
(40,40,650,GETDATE()),

-- Repeat listening (important 🔥)
(1,5,600,GETDATE()),
(2,6,650,GETDATE()),
(3,7,700,GETDATE()),
(4,8,750,GETDATE()),
(5,9,800,GETDATE());

INSERT INTO PodcastSearchHistory (UserID, Query, SearchedAt) VALUES

-- Tech / News
(1,'AI podcasts',GETDATE()),
(2,'latest tech news',GETDATE()),
(3,'startup stories',GETDATE()),
(4,'crypto trends',GETDATE()),
(5,'global news podcast',GETDATE()),

-- Music / Entertainment
(6,'music podcasts',GETDATE()),
(7,'artist interviews',GETDATE()),
(8,'bollywood podcasts',GETDATE()),
(9,'hollywood news',GETDATE()),
(10,'music industry talk',GETDATE()),

-- Education
(11,'learn sql podcast',GETDATE()),
(12,'coding tutorials podcast',GETDATE()),
(13,'science podcasts',GETDATE()),
(14,'history podcasts',GETDATE()),
(15,'study tips podcast',GETDATE()),

-- Lifestyle
(16,'fitness podcasts',GETDATE()),
(17,'mental health podcasts',GETDATE()),
(18,'travel podcasts',GETDATE()),
(19,'food podcasts',GETDATE()),
(20,'life hacks podcast',GETDATE()),

-- Regional
(21,'hindi podcasts',GETDATE()),
(22,'telugu podcasts',GETDATE()),
(23,'tamil podcasts',GETDATE()),
(24,'english podcasts',GETDATE()),
(25,'indian podcasts',GETDATE()),

-- Mixed queries
(26,'top podcasts 2025',GETDATE()),
(27,'trending podcasts',GETDATE()),
(28,'best podcasts',GETDATE()),
(29,'daily podcasts',GETDATE()),
(30,'short podcasts',GETDATE()),

-- Repeat behavior (important 🔥)
(1,'tech podcasts',GETDATE()),
(2,'ai news',GETDATE()),
(3,'business podcasts',GETDATE()),
(4,'crypto podcasts',GETDATE()),
(5,'world news',GETDATE()),

-- More realistic searches
(31,'gaming podcasts',GETDATE()),
(32,'coding podcasts',GETDATE()),
(33,'night podcasts',GETDATE()),
(34,'relax podcasts',GETDATE()),
(35,'motivational podcasts',GETDATE()),

(36,'sports podcasts',GETDATE()),
(37,'finance podcasts',GETDATE()),
(38,'daily motivation',GETDATE()),
(39,'story podcasts',GETDATE()),
(40,'late night talk',GETDATE()),

(41,'top indian podcasts',GETDATE()),
(42,'usa podcasts',GETDATE()),
(43,'uk podcasts',GETDATE()),
(44,'mixed podcasts',GETDATE()),
(45,'podcasts for study',GETDATE());

INSERT INTO SongArtists (SongID, ArtistID) VALUES

-- Song 7–15
(7,1),(7,2),
(8,2),(8,3),
(9,3),(9,4),
(10,4),(10,5),
(11,5),(11,1),
(12,1),(12,3),
(13,2),(13,4),
(14,3),(14,5),
(15,4),(15,1),

-- Song 16–25
(16,2),(16,5),
(17,3),(17,1),
(18,4),(18,2),
(19,5),(19,3),
(20,1),(20,4),
(21,2),(21,3),
(22,3),(22,5),
(23,4),(23,1),
(24,5),(24,2),
(25,1),(25,3),

-- Song 26–35
(26,2),(26,4),
(27,3),(27,5),
(28,4),(28,1),
(29,5),(29,2),
(30,1),(30,3),
(31,2),(31,4),
(32,3),(32,5),
(33,4),(33,1),
(34,5),(34,2),
(35,1),(35,3);

INSERT INTO SongGenres (SongID, GenreID) VALUES

-- Songs 7–15
(7,1),(7,2),
(8,1),(8,3),
(9,2),(9,3),
(10,1),(10,2),
(11,3),(11,1),
(12,2),(12,3),
(13,1),(13,3),
(14,2),(14,1),
(15,3),(15,2),

-- Songs 16–25
(16,1),(16,3),
(17,2),(17,1),
(18,3),(18,2),
(19,1),(19,2),
(20,2),(20,3),
(21,1),(21,3),
(22,2),(22,1),
(23,3),(23,2),
(24,1),(24,2),
(25,2),(25,3),

-- Songs 26–35
(26,1),(26,3),
(27,2),(27,1),
(28,3),(28,2),
(29,1),(29,2),
(30,2),(30,3),
(31,1),(31,3),
(32,2),(32,1),
(33,3),(33,2),
(34,1),(34,2),
(35,2),(35,3);

INSERT INTO Subscriptions (PlanID, OwnerUserID, StartDate, EndDate, IsActive) VALUES

-- Active subscriptions
(2,4,'2025-04-01',NULL,1),
(3,5,'2025-04-05',NULL,1),
(2,6,'2025-04-10',NULL,1),
(2,7,'2025-04-12',NULL,1),
(3,8,'2025-04-15',NULL,1),
(2,9,'2025-04-18',NULL,1),
(2,10,'2025-04-20',NULL,1),

(3,11,'2025-04-22',NULL,1),
(2,12,'2025-04-25',NULL,1),
(2,13,'2025-04-28',NULL,1),
(3,14,'2025-05-01',NULL,1),
(2,15,'2025-05-03',NULL,1),
(2,16,'2025-05-05',NULL,1),

-- Expired subscriptions
(2,17,'2024-01-01','2025-01-01',0),
(3,18,'2024-02-01','2025-02-01',0),
(2,19,'2024-03-01','2025-03-01',0),
(2,20,'2024-04-01','2025-04-01',0),

(3,21,'2024-05-01','2025-05-01',0),
(2,22,'2024-06-01','2025-06-01',0),
(2,23,'2024-07-01','2025-07-01',0),
(3,24,'2024-08-01','2025-08-01',0),

-- Mixed users
(2,25,'2025-01-10',NULL,1),
(3,26,'2025-01-15',NULL,1),
(2,27,'2025-01-20',NULL,1),
(2,28,'2025-01-25',NULL,1),
(3,29,'2025-02-01',NULL,1),
(2,30,'2025-02-05',NULL,1),

(2,31,'2025-02-10',NULL,1),
(3,32,'2025-02-15',NULL,1),
(2,33,'2025-02-20',NULL,1);

INSERT INTO SubscriptionUsers (SubscriptionID, UserID, Role, JoinedAt) VALUES

-- Subscription 1 (Owner already 1)
(1,1,'Owner',GETDATE()),
(1,4,'Member',GETDATE()),
(1,5,'Member',GETDATE()),
(1,6,'Member',GETDATE()),

-- Subscription 2 (Family)
(2,2,'Owner',GETDATE()),
(2,7,'Member',GETDATE()),
(2,8,'Member',GETDATE()),
(2,9,'Member',GETDATE()),
(2,10,'Member',GETDATE()),

-- Subscription 3
(3,3,'Owner',GETDATE()),
(3,11,'Member',GETDATE()),
(3,12,'Member',GETDATE()),

-- More subscriptions
(4,4,'Owner',GETDATE()),
(4,13,'Member',GETDATE()),
(4,14,'Member',GETDATE()),

(5,5,'Owner',GETDATE()),
(5,15,'Member',GETDATE()),
(5,16,'Member',GETDATE()),
(5,17,'Member',GETDATE()),

(6,6,'Owner',GETDATE()),
(6,18,'Member',GETDATE()),
(6,19,'Member',GETDATE()),

(7,7,'Owner',GETDATE()),
(7,20,'Member',GETDATE()),
(7,21,'Member',GETDATE()),

(8,8,'Owner',GETDATE()),
(8,22,'Member',GETDATE()),
(8,23,'Member',GETDATE()),

(9,9,'Owner',GETDATE()),
(9,24,'Member',GETDATE()),
(9,25,'Member',GETDATE()),

(10,10,'Owner',GETDATE()),
(10,26,'Member',GETDATE()),
(10,27,'Member',GETDATE());

INSERT INTO TrendingPodcasts (PodcastID, CountryID, Rank, Score, UpdatedAt) VALUES

-- INDIA (CountryID = 1)
(1,1,1,0.95,GETDATE()),
(2,1,2,0.92,GETDATE()),
(7,1,3,0.90,GETDATE()),
(8,1,4,0.88,GETDATE()),
(9,1,5,0.87,GETDATE()),
(10,1,6,0.86,GETDATE()),
(11,1,7,0.85,GETDATE()),
(12,1,8,0.84,GETDATE()),
(13,1,9,0.83,GETDATE()),
(14,1,10,0.82,GETDATE()),
(15,1,11,0.81,GETDATE()),
(16,1,12,0.80,GETDATE()),
(17,1,13,0.79,GETDATE()),
(18,1,14,0.78,GETDATE()),
(19,1,15,0.77,GETDATE()),

-- USA (CountryID = 2)
(20,2,1,0.96,GETDATE()),
(21,2,2,0.94,GETDATE()),
(22,2,3,0.93,GETDATE()),
(23,2,4,0.91,GETDATE()),
(24,2,5,0.89,GETDATE()),
(25,2,6,0.88,GETDATE()),
(26,2,7,0.87,GETDATE()),
(27,2,8,0.86,GETDATE()),
(28,2,9,0.85,GETDATE()),
(29,2,10,0.84,GETDATE()),
(30,2,11,0.83,GETDATE()),
(31,2,12,0.82,GETDATE()),
(32,2,13,0.81,GETDATE()),
(33,2,14,0.80,GETDATE()),
(34,2,15,0.79,GETDATE()),

-- UK (CountryID = 3)
(35,3,1,0.97,GETDATE()),
(36,3,2,0.95,GETDATE()),
(37,3,3,0.93,GETDATE()),
(38,3,4,0.92,GETDATE()),
(39,3,5,0.90,GETDATE()),
(40,3,6,0.88,GETDATE()),
(1,3,7,0.87,GETDATE()),
(2,3,8,0.86,GETDATE()),
(7,3,9,0.85,GETDATE()),
(8,3,10,0.84,GETDATE()),
(9,3,11,0.83,GETDATE()),
(10,3,12,0.82,GETDATE()),
(11,3,13,0.81,GETDATE()),
(12,3,14,0.80,GETDATE()),
(13,3,15,0.79,GETDATE());

INSERT INTO TrendingSongs 
(SongID, CountryID, Rank, Score, UpdatedAt, TrendDate) VALUES

-- INDIA (CountryID = 1)
(4,1,3,0.89,GETDATE(),'2026-03-29'),
(5,1,4,0.87,GETDATE(),'2026-03-29'),
(6,1,5,0.86,GETDATE(),'2026-03-29'),
(7,1,6,0.85,GETDATE(),'2026-03-29'),
(8,1,7,0.84,GETDATE(),'2026-03-29'),
(9,1,8,0.83,GETDATE(),'2026-03-29'),
(10,1,9,0.82,GETDATE(),'2026-03-29'),
(11,1,10,0.81,GETDATE(),'2026-03-29'),
(12,1,11,0.80,GETDATE(),'2026-03-29'),
(13,1,12,0.79,GETDATE(),'2026-03-29'),

-- USA (CountryID = 2)
(4,2,2,0.90,GETDATE(),'2026-03-29'),
(5,2,3,0.89,GETDATE(),'2026-03-29'),
(6,2,4,0.88,GETDATE(),'2026-03-29'),
(7,2,5,0.87,GETDATE(),'2026-03-29'),
(8,2,6,0.86,GETDATE(),'2026-03-29'),
(9,2,7,0.85,GETDATE(),'2026-03-29'),
(10,2,8,0.84,GETDATE(),'2026-03-29'),
(11,2,9,0.83,GETDATE(),'2026-03-29'),
(12,2,10,0.82,GETDATE(),'2026-03-29'),
(13,2,11,0.81,GETDATE(),'2026-03-29'),

-- UK (CountryID = 3)
(14,3,1,0.96,GETDATE(),'2026-03-29'),
(15,3,2,0.94,GETDATE(),'2026-03-29'),
(16,3,3,0.92,GETDATE(),'2026-03-29'),
(17,3,4,0.91,GETDATE(),'2026-03-29'),
(18,3,5,0.90,GETDATE(),'2026-03-29'),
(19,3,6,0.89,GETDATE(),'2026-03-29'),
(20,3,7,0.88,GETDATE(),'2026-03-29'),
(21,3,8,0.87,GETDATE(),'2026-03-29'),
(22,3,9,0.86,GETDATE(),'2026-03-29'),
(23,3,10,0.85,GETDATE(),'2026-03-29'),

-- EXTRA DAY (NEW DATE 🔥)
(1,1,1,0.97,GETDATE(),'2026-03-30'),
(2,1,2,0.95,GETDATE(),'2026-03-30'),
(3,1,3,0.93,GETDATE(),'2026-03-30'),
(4,1,4,0.91,GETDATE(),'2026-03-30'),
(5,1,5,0.90,GETDATE(),'2026-03-30'),

(1,2,1,0.96,GETDATE(),'2026-03-30'),
(2,2,2,0.94,GETDATE(),'2026-03-30'),
(3,2,3,0.92,GETDATE(),'2026-03-30'),
(4,2,4,0.90,GETDATE(),'2026-03-30'),
(5,2,5,0.89,GETDATE(),'2026-03-30');

INSERT INTO UserFollowedArtists (UserID, ArtistID) VALUES

-- Users 1–10
(1,1),(1,2),(1,3),
(2,2),(2,3),(2,4),
(3,3),(3,4),(3,5),
(4,1),(4,5),(4,7),
(5,2),(5,6),(5,8),
(7,4),(7,8),(7,10),
(8,5),(8,9),(8,11),
(9,6),(9,10),(9,12),
(10,7),(10,11),(10,13),

-- Users 11–20
(11,1),(11,3),
(12,2),(12,4),
(13,3),(13,5),
(14,4),(14,6),
(15,5),(15,7),
(16,6),(16,8),
(17,7),(17,9),
(18,8),(18,10),
(19,9),(19,11),
(20,10),(20,12);

SELECT ArtistID FROM Artists ORDER BY ArtistID;

INSERT INTO UserFollowedArtists (UserID, ArtistID)
SELECT TOP 50
    u.UserID,
    a.ArtistID
FROM Users u
CROSS JOIN (
    SELECT TOP 10 ArtistID FROM Artists ORDER BY ArtistID
) a;

INSERT INTO UserFollowedPodcasts (UserID, PodcastID, FollowedAt) VALUES

-- Users 1–10
(1,1,GETDATE()),(1,2,GETDATE()),(1,7,GETDATE()),
(2,2,GETDATE()),(2,7,GETDATE()),(2,8,GETDATE()),
(3,7,GETDATE()),(3,8,GETDATE()),(3,9,GETDATE()),
(4,1,GETDATE()),(4,9,GETDATE()),(4,10,GETDATE()),
(5,2,GETDATE()),(5,10,GETDATE()),(5,11,GETDATE()),
(6,7,GETDATE()),(6,11,GETDATE()),(6,12,GETDATE()),
(7,8,GETDATE()),(7,12,GETDATE()),(7,13,GETDATE()),
(8,9,GETDATE()),(8,13,GETDATE()),(8,14,GETDATE()),
(9,10,GETDATE()),(9,14,GETDATE()),(9,15,GETDATE()),
(10,11,GETDATE()),(10,15,GETDATE()),(10,16,GETDATE());

INSERT INTO UserFollowers (FollowerID, FollowingID) VALUES

-- Basic follows
(1,2),(1,3),(1,4),
(2,1),(2,3),(2,5),
(3,1),(3,2),(3,6),
(4,2),(4,5),(4,6),
(5,1),(5,3),(5,7),

-- More users
(6,2),(6,4),(6,8),
(7,3),(7,5),(7,9),
(8,1),(8,6),(8,10),
(9,2),(9,7),(9,11),
(10,3),(10,8),(10,12),

-- Users 11–20
(11,1),(11,2),(11,3),
(12,4),(12,5),(12,6),
(13,7),(13,8),(13,9),
(14,10),(14,11),(14,12),
(15,1),(15,5),(15,10),

-- More spread
(16,2),(16,6),(16,11),
(17,3),(17,7),(17,12),
(18,4),(18,8),(18,13),
(19,5),(19,9),(19,14),
(20,6),(20,10),(20,15);

INSERT INTO UserLikedPlaylists (UserID, PlaylistID) VALUES

-- Users 1–10
(1,1),(1,2),(1,3),
(2,2),(2,3),(2,4),
(3,3),(3,4),(3,5),
(4,1),(4,5),(4,6),
(5,2),(5,6),(5,7),
(6,3),(6,7),(6,8),
(7,4),(7,8),(7,9),
(8,5),(8,9),(8,10),
(9,6),(9,10),(9,11),
(10,7),(10,11),(10,12),

-- Users 11–20
(11,1),(11,5),
(12,2),(12,6),
(13,3),(13,7),
(14,4),(14,8),
(15,5),(15,9),
(16,6),(16,10),
(17,7),(17,11),
(18,8),(18,12),
(19,9),(19,13),
(20,10),(20,14);

INSERT INTO UserPlaylistStats 
(UserID, PlaylistID, PlayCount, TotalListeningTime, LastPlayed) VALUES

-- Users 1–10
(1,1,25,5000,GETDATE()),
(1,2,15,3000,GETDATE()),
(2,2,20,4000,GETDATE()),
(2,3,18,3500,GETDATE()),
(3,3,22,4200,GETDATE()),
(3,4,10,2000,GETDATE()),
(4,1,30,6000,GETDATE()),
(4,5,12,2500,GETDATE()),
(5,2,17,3400,GETDATE()),
(5,6,9,1800,GETDATE()),

(6,3,14,2800,GETDATE()),
(6,7,16,3200,GETDATE()),
(7,4,20,4000,GETDATE()),
(7,8,11,2200,GETDATE()),
(8,5,19,3800,GETDATE()),
(8,9,13,2600,GETDATE()),
(9,6,21,4200,GETDATE()),
(9,10,15,3000,GETDATE()),
(10,7,18,3600,GETDATE()),
(10,11,14,2800,GETDATE()),

-- Users 11–20
(11,1,10,2000,GETDATE()),
(11,5,8,1600,GETDATE()),
(12,2,12,2400,GETDATE()),
(12,6,14,2800,GETDATE()),
(13,3,16,3200,GETDATE()),
(13,7,9,1800,GETDATE()),
(14,4,11,2200,GETDATE()),
(14,8,13,2600,GETDATE()),
(15,5,15,3000,GETDATE()),
(15,9,17,3400,GETDATE()),

(16,6,18,3600,GETDATE()),
(16,10,10,2000,GETDATE()),
(17,7,20,4000,GETDATE()),
(17,11,12,2400,GETDATE()),
(18,8,14,2800,GETDATE()),
(18,12,16,3200,GETDATE()),
(19,9,19,3800,GETDATE()),
(19,13,11,2200,GETDATE()),
(20,10,13,2600,GETDATE()),
(20,14,15,3000,GETDATE()),

-- Extra variety
(21,1,22,4400,GETDATE()),
(22,2,24,4800,GETDATE()),
(23,3,26,5200,GETDATE()),
(24,4,28,5600,GETDATE()),
(25,5,30,6000,GETDATE());

INSERT INTO UserProfiles (UserID, DisplayName, ProfileImage)
SELECT 
    u.UserID,
    CONCAT('User_', u.UserID),
    NULL
FROM Users u
WHERE u.UserID NOT IN (
    SELECT UserID FROM UserProfiles
);

select * from UserProfiles

INSERT INTO UserSessions (UserID, DeviceID, LoginAt, LogoutAt) VALUES

(4,4,GETDATE(),NULL),
(5,5,GETDATE(),GETDATE()),
(6,6,GETDATE(),NULL),
(7,7,GETDATE(),GETDATE()),
(8,8,GETDATE(),NULL),

(9,9,GETDATE(),GETDATE()),
(10,10,GETDATE(),NULL),
(11,11,GETDATE(),GETDATE()),
(12,12,GETDATE(),NULL),
(13,13,GETDATE(),GETDATE());

---Active users---
SELECT COUNT(*) AS ActiveUsers
FROM UserSessions
WHERE LogoutAt IS NULL;

---Sessions Per user---
SELECT UserID, COUNT(*) AS TotalSessions
FROM UserSessions
GROUP BY UserID;

---User name and profile names ----
SELECT u.Username, p.DisplayName
FROM Users u
JOIN UserProfiles p ON u.UserID = p.UserID;

---search username ---
SELECT DisplayName
FROM UserProfiles
WHERE DisplayName LIKE '%rah%';

---Most played Playlists---
SELECT PlaylistID, SUM(PlayCount) AS TotalPlays
FROM UserPlaylistStats
GROUP BY PlaylistID
ORDER BY TotalPlays DESC;

---Most active users---
SELECT UserID, SUM(PlayCount) AS TotalPlays
FROM UserPlaylistStats
GROUP BY UserID
ORDER BY TotalPlays DESC;

---Total listening time per playlisy---
SELECT PlaylistID, SUM(TotalListeningTime) AS TotalTime
FROM UserPlaylistStats
GROUP BY PlaylistID;

---With playlist names and userplaycounts ---
SELECT u.Username, p.Name, ups.PlayCount
FROM UserPlaylistStats ups
JOIN Users u ON ups.UserID = u.UserID
JOIN Playlists p ON ups.PlaylistID = p.PlaylistID;

---Most liked playlists---
SELECT PlaylistID, COUNT(*) AS Likes
FROM UserLikedPlaylists
GROUP BY PlaylistID
ORDER BY Likes DESC;

---Most Followed podcasts---
SELECT PodcastID, COUNT(*) AS Followers
FROM UserFollowedPodcasts
GROUP BY PodcastID
ORDER BY Followers DESC;

---Most Followed Artists---
SELECT  ArtistID, COUNT(*) AS Followers
FROM UserFollowedArtists
GROUP BY ArtistID
ORDER BY Followers DESC;

select Name,Followers
from Artists
order by Followers Desc


---Songs greater than 200 seconds---
SELECT Name, Duration
FROM Songs
WHERE Duration > 200;

---Public Playlists---
SELECT Name
FROM Playlists
WHERE IsPublic = 1;

---Successful Payments---
SELECT *
FROM Payments
WHERE PaymentStatus = 'Success';

---Username With profiles---
SELECT u.Username, p.DisplayName
FROM Users u
JOIN UserProfiles p ON u.UserID = p.UserID;

---Songs with artists names ----
SELECT s.SongID,s.Name AS Song, a.Name AS Artist
FROM SongArtists sa
JOIN Songs s ON sa.SongID = s.SongID
JOIN Artists a ON sa.ArtistID = a.ArtistID;

---Playlists Created by User----
SELECT u.UserID,u.Username, p.Name
FROM Playlists p
JOIN Users u ON p.UserID = u.UserID;

---Songs in a playlist---
SELECT p.PlaylistID,p.Name, s.Name
FROM PlaylistSongs ps
JOIN Playlists p ON ps.PlaylistID = p.PlaylistID
JOIN Songs s ON ps.SongID = s.SongID;

---Users per Country---
SELECT CountryID, COUNT(*) AS TotalUsers
FROM Users
GROUP BY CountryID;

---Total Plays per song---
SELECT SongID, COUNT(*) AS Plays
FROM ListeningHistory
GROUP BY SongID
ORDER BY Plays DESC;

---Total Listening Time Per User---

select * from users
select * from ListeningHistory


SELECT users.UserID,Users.Username, SUM(DurationPlayed) AS TotalTime
FROM ListeningHistory
join Users
on ListeningHistory.UserID = Users.UserID
group by Users.Username,Users.UserID

---Top Trending songs ---
SELECT TOP 5 s.Name, t.Score
FROM TrendingSongs t
JOIN Songs s ON t.SongID = s.SongID
ORDER BY t.Score DESC;


---Revenue---
SELECT SUM(TotalAmount) AS TotalRevenue,Payments.PaymentID
FROM Payments
WHERE PaymentStatus = 'Success'
group by PaymentID


select * from Users
select * from Payments

SELECT  Users.Username,    SUM(TotalAmount) AS TotalRevenue,Payments.PaymentID,Payments.UserID
FROM Payments
join users
on payments.UserID = Users.UserID
WHERE PaymentStatus = 'Success'
group by PaymentID,Users.Username,Payments.UserID


---Top  3 most played songs per user ---
SELECT 
    Users.UserID,
    Users.Username,
    Songs.SongID,
    Songs.Name AS SongName,
    COUNT(*) AS PlayCount
FROM ListeningHistory
JOIN Users 
    ON ListeningHistory.UserID = Users.UserID
JOIN Songs 
    ON ListeningHistory.SongID = Songs.SongID
GROUP BY 
    Users.UserID,
    Users.Username,
    Songs.SongID,
    Songs.Name
HAVING COUNT(*) > 1;


---Songs with thier album names----
select * from Songs
select * from Albums

select Songs.Name as Songname , Albums.Name as AlbumName 
from Songs
join Albums
on Songs.SongID =  Albums.AlbumID

---Songs with artist names----
select * from Songs
select * from SongArtists
select * from Artists

select songs.SongID,Songs.Name,Artists.Name
from songs
join SongArtists
on Songs.SongID = SongArtists.SongID
join Artists
on Artists.ArtistID = SongArtists.ArtistID

---Playlists along with the user who created them ---
select * from Playlists
select * from Users

Select Playlists.Name as PlaylistName ,Users.Username as NameOfTheUserWhoCreatedPlaylist
from Playlists
join  Users
on Playlists.UserID = Users.UserID

Select Playlists.Name as PlaylistName ,Users.Username as NameOfTheUserWhoCreatedPlaylist
from Playlists
left join  Users ---used when to include playlists even if user is missing---
on Playlists.UserID = Users.UserID

---Devices used by each user---

select * from Devices
select * from Users

select Users.Username as Username ,Devices.DeviceName as DeviceUsedByUser 
from Devices
join Users
on Devices.UserID = Users.UserID

---Playlist Name with all songs inside it ---
select * from Playlists
select * from PlaylistSongs
select * from Songs

select Playlists.Name as PlaylistName , songs.Name as SongsInPlaylist 
from Playlists
join PlaylistSongs
on Playlists.PlaylistID = PlaylistSongs.PlaylistID
join Songs
on PlaylistSongs.SongID = Songs.SongID


---Artist Name with thier Albums---

Select * from Artists
select * from AlbumArtists
select * from Albums

select Artists.Name as ArtistName,Albums.Name 
from Artists
join AlbumArtists
on Artists.ArtistID = AlbumArtists.ArtistID
join Albums
on Albums.AlbumID = AlbumArtists.AlbumID

select Artists.Name as ArtistName ,
STRING_AGG(Albums.Name, ' , ') As Albums 
from Artists
join AlbumArtists
on Artists.ArtistID = AlbumArtists.ArtistID
join Albums
on Albums.AlbumID = AlbumArtists.AlbumID
Group by Artists.Name

---Total albums released by artists---
SELECT 
    Artists.Name AS ArtistName,
    COUNT(Albums.AlbumID) AS TotalAlbums
FROM Artists
JOIN AlbumArtists
    ON Artists.ArtistID = AlbumArtists.ArtistID
JOIN Albums
    ON Albums.AlbumID = AlbumArtists.AlbumID
GROUP BY Artists.Name;

---Song name and its genres---
select * from Songs
select * from SongGenres
select * from Genres

select Songs.SongID,Songs.Name as SongsName , Genres.Name as SongGenres
from Songs
join SongGenres
on Songs.SongID = SongGenres.SongID
join Genres
on SongGenres.GenreID = Genres.GenreID

---User and thier subscription plan name ---
select * from Users
select * from Subscriptions
select * from PlanTypes

select Users.UserID,Users.Username as Username ,PlanTypes.PlanName as Planname
from users
join Subscriptions
on Users.UserID = Subscriptions.OwnerUserID
join PlanTypes
on Subscriptions.PlanID = PlanTypes.PlanID

---location---
select * from Countries
select * from States

---entities---
select * from Users
select * from Languages
select * from Genres
select * from PlanTypes

---user ecosystem---
select * from Users
SELECT * from UserProfiles
select * from Devices
select * from UserSessions

---subscriptions and payments---
select * from Users
select * from Subscriptions
select * from PlanTypes
select * from Payments
select * from Taxes


---music---
select * from Artists
select * from Albums
select * from AlbumArtists
select * from Songs
select * from SongArtists
select * from SongGenres

---playlists---
select * from UserLikedPlaylists
select * from Playlists
select * from PlaylistSongs
select * from PlaylistGenres

---User interaction---
select * from UserFollowedArtists
select * from UserFollowedPodcasts
select * from UserLikedPlaylists
select * from UserLikedSongs
select * from UserPlaylistStats
select * from UserPodcastStats
select * from UserRepeatedSongs
select * from UserSongStats
select * from UserSessions

---Analytics----
select * from ListeningHistory
select * from TrendingPodcasts
select * from TrendingSongs

---Podcast---
select * from GlobalPodcastStats
select * from PodcastEpisodes
select * from PodcastGenres
select * from PodcastListeningHistory
select * from Podcasts
select * from TrendingPodcasts
select * from PodcastSearchHistory
select * from UserFollowedPodcasts
select * from UserPodcastStats


---Payment details along with username ---
select * from Payments
select * from Users

select Payments.PaymentID,Payments.PaymentDate,Payments.PaymentMethod,Payments.PaymentMethod,Users.Username as Username
from Payments
join Users
on Payments.UserID = Users.UserID

---Username and songs they liked ---
select * from Users
select * from UserLikedSongs
select * from Songs

select users.Username AS username,Songs.Name as UserLikedSongs
from Users
join UserLikedSongs
on Users.UserID = UserLikedSongs.UserID
join Songs
on UserLikedSongs.SongID = Songs.SongID

---username and playlists they liked---
select * from Users
select * from UserLikedPlaylists
select * from Playlists

select users.UserID,Users.Username,STRING_AGG(Playlists.Name,' ,') as PlaylistName 
from Users
join UserLikedPlaylists
on Users.UserID = UserLikedPlaylists.UserID
join Playlists
on UserLikedPlaylists.PlaylistID = Playlists.PlaylistID
group by Users.UserID,Users.Username