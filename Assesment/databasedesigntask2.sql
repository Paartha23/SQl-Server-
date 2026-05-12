CREATE SCHEMA spotify;

CREATE TABLE  spotify.Users (
UserID INT PRIMARY KEY IDENTITY,
Username VARCHAR(100),
Email VARCHAR(150) UNIQUE,
PasswordHash VARCHAR(255),
Country VARCHAR(100),
SubscriptionType VARCHAR(20), 

IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME
);

CREATE TABLE Artists (
ArtistID INT PRIMARY KEY IDENTITY,
Name VARCHAR(150),
Bio TEXT,
Songs VARCHAR,

IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME
);

CREATE TABLE Albums (
AlbumID INT PRIMARY KEY IDENTITY,
Title VARCHAR(200),
ArtistID INT,
FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID),
ReleaseDate DATE,
   
IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME
);


CREATE TABLE Songs (
SongID INT PRIMARY KEY IDENTITY,
Title VARCHAR(200),
Duration INT, 
AlbumID INT,
Language VARCHAR(50),
FOREIGN KEY (AlbumID) REFERENCES Albums(AlbumID),

 IsActive BIT DEFAULT 1,
 CreatedDate DATETIME DEFAULT GETDATE(),
 ModifiedDate DATETIME
);


CREATE TABLE SongArtists (
SongArtistID INT PRIMARY KEY IDENTITY,
SongID INT,
ArtistID INT,

FOREIGN KEY (SongID) REFERENCES Songs(SongID),
FOREIGN KEY (ArtistID) REFERENCES Artists(ArtistID),

IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME
);


CREATE TABLE Playlists (
    PlaylistID INT PRIMARY KEY IDENTITY,
    UserID INT,
    Name VARCHAR(150),
    IsPublic BIT DEFAULT 1,

    FOREIGN KEY (UserID) REFERENCES Users(UserID),

    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME
);

CREATE TABLE PlaylistSongs (
    PlaylistSongID INT PRIMARY KEY IDENTITY,
    PlaylistID INT,
    SongID INT,
    AddedDate DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (PlaylistID) REFERENCES Playlists(PlaylistID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID),

    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME
);

CREATE TABLE ListeningHistory (
    HistoryID INT PRIMARY KEY IDENTITY,
    UserID INT,
    SongID INT,
    PlayedAt DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (SongID) REFERENCES Songs(SongID),

    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME
);

CREATE TABLE Subscriptions (
    SubscriptionID INT PRIMARY KEY IDENTITY,
    UserID INT,
    PlanType VARCHAR(20), 
    StartDate DATE,
    EndDate DATE,
    Status VARCHAR(20),

    FOREIGN KEY (UserID) REFERENCES Users(UserID),

    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    ModifiedDate DATETIME
);