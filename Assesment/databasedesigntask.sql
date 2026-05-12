create table users (
UserID INT PRIMARY KEY IDENTITY,
Name VARCHAR(100),
Email VARCHAR(100) UNIQUE,
Phone VARCHAR(15),
PasswordHash VARCHAR(255),
Role VARCHAR(20),
IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME,
 );

create table  Movies (
MovieID INT PRIMARY KEY IDENTITY,
Title VARCHAR(200),
Genre VARCHAR(100),
Duration INT, 
Language VARCHAR(50),
ReleaseDate DATE,
Certification VARCHAR(10),

IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME,
);


CREATE TABLE Theatres (
TheatreID INT PRIMARY KEY IDENTITY,
Name VARCHAR(150),
Location VARCHAR(255),
City VARCHAR(100),
State VARCHAR(100),

IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME,

);

CREATE TABLE Screen (
ScreenID INT PRIMARY KEY IDENTITY,
TheatreID INT,
ScreenName VARCHAR(50),
ScreenNumber INT,
TotalSeats INT,

FOREIGN KEY (TheatreID) REFERENCES Theatres(TheatreID),

IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME,   
);

CREATE TABLE Seats (
SeatID INT PRIMARY KEY IDENTITY,
ScreenID INT,
SeatNumber VARCHAR(10),
SeatType VARCHAR(20),
Price DECIMAL(10,2),

FOREIGN KEY (ScreenID) REFERENCES Screens(ScreenID),

IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME,
 
);

CREATE TABLE Shows (
ShowID INT PRIMARY KEY IDENTITY,
MovieID INT,
ScreenID INT,
ShowDate DATE,
StartTime TIME,
EndTime TIME,

FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
FOREIGN KEY (ScreenID) REFERENCES Screens(ScreenID),

IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME,  
);

CREATE TABLE Bookings (
BookingID INT PRIMARY KEY IDENTITY,
UserID INT,
FOREIGN KEY (UserID) REFERENCES Users(UserID),
ShowID INT,
FOREIGN KEY (ShowID) REFERENCES Shows(ShowID),
BookingDate DATETIME DEFAULT GETDATE(),
TotalAmount DECIMAL(10,2),
Status VARCHAR(20),
IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME,
    
);


CREATE TABLE BookingSeats (
BookingSeatID INT PRIMARY KEY IDENTITY,
BookingID INT,
FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
SeatID INT,
FOREIGN KEY (SeatID) REFERENCES Seats(SeatID),
Price DECIMAL(10,2),

IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME,

);

CREATE TABLE Payments (
PaymentID INT PRIMARY KEY IDENTITY,
BookingID INT,
PaymentMethod VARCHAR(50), 
PaymentStatus VARCHAR(20), 
Amount DECIMAL(10,2),
TransactionDate DATETIME,

FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),

IsActive BIT DEFAULT 1,
CreatedDate DATETIME DEFAULT GETDATE(),
ModifiedDate DATETIME,

);

INSERT INTO Users (Name, Email, Phone, PasswordHash, Role)
VALUES
('Amit Sharma', 'amit@gmail.com', '9876543210', 'hash1', 'Customer'),
('Priya Reddy', 'priya@gmail.com', '9123456780', 'hash2', 'Customer'),
('Rahul Verma', 'rahul@gmail.com', '9988776655', 'hash3', 'Admin'),
('Sneha Iyer', 'sneha@gmail.com', '9012345678', 'hash4', 'Customer'),
('Kiran Das', 'kiran@gmail.com', '9090909090', 'hash5', 'Customer');

select * from users

INSERT INTO Movies (Title, Genre, Duration, Language, ReleaseDate, Certification)
VALUES
('Leo', 'Action', 160, 'Tamil', '2023-10-19', 'U/A'),
('Jawan', 'Action', 170, 'Hindi', '2023-09-07', 'U/A'),
('KGF Chapter 2', 'Action', 168, 'Kannada', '2022-04-14', 'U/A'),
('RRR', 'Drama', 182, 'Telugu', '2022-03-25', 'U/A'),
('Inception', 'Sci-Fi', 148, 'English', '2010-07-16', 'U/A');

INSERT INTO Theatres (Name, Location, City, State)
VALUES
('PVR Orion', 'Rajajinagar', 'Bangalore', 'Karnataka'),
('INOX Garuda Mall', 'MG Road', 'Bangalore', 'Karnataka'),
('Cinepolis Forum', 'Whitefield', 'Bangalore', 'Karnataka'),
('Urvashi Theatre', 'Lalbagh Road', 'Bangalore', 'Karnataka'),
('Gopalan Cinemas', 'Bannerghatta Road', 'Bangalore', 'Karnataka');

INSERT INTO Screen (TheatreID, ScreenName, ScreenNumber, TotalSeats)
VALUES
(1, 'Screen 1', 1, 150),
(1, 'Screen 2', 2, 120),
(2, 'Screen 1', 1, 180),
(3, 'Screen 1', 1, 200),
(4, 'Screen 1', 1, 100);

INSERT INTO Seats (ScreenID, SeatNumber, SeatType, Price)
VALUES
(1, 'A1', 'Regular', 150),
(1, 'A2', 'Regular', 150),
(1, 'B1', 'Premium', 250),
(2, 'A1', 'Regular', 140),
(3, 'C1', 'VIP', 300),
(4, 'D1', 'Premium', 220);