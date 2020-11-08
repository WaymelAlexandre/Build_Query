-- -Alexandre Waymel 103083020



-- - TASK 1 -

/*
    Tour(TourName, Description)
    PRIMARY KEY (TourName)

    Client(ClientID, Surname, GivenName, Gender)
    PRIMARY KEY(ClientID)

    Event(TourName,EventYear,EventMonth,EventDay,Fee)
    PRIMARY KEY(TourName,EventYear,EventMonth,EventDay)
    FOREIGN KEY(TourName) REFERENCES Tour

    Booking(ClientID,TourName,EventYear,EventMonth,EventDay,DateBooked,Payment)
    PRIMARY KEY(ClientID,TourName,EventYear,EventMonth,EventDay)
    FOREIGN KEY(ClientID) REFERENCES Client
    FOREIGN KEY(TourName,EventYear,EventMonth,EventDay) REFERENCES Event
*/
-- create DATABASE QUERY;

use QUERY;

DROP TABLE IF EXISTS Tour;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Booking; 

CREATE TABLE Tour(
    TourName    NVARCHAR(100),
    Description NVARCHAR(500),

    PRIMARY KEY (TourName));

CREATE TABLE Client(
    ClientID     INT,
    Surname      NVARCHAR(100) NOT NULL,
    GivenName    NVARCHAR(100) NOT NULL,
    Gender       NVARCHAR(1) CHECK (Gender IN ('M','F','I')) NULL,

    PRIMARY KEY(ClientID));

CREATE TABLE Event(
TourName    NVARCHAR(100),
EventMonth  NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
EventDay    INT CHECK (EventDay >= 1 AND EventDay <= 31),
EventYear   INT CHECK (len(EventYear) = 4),
Fee         MONEY CHECK (Fee > 0) NOT NULL,

PRIMARY KEY(TourName,EventYear,EventMonth,EventDay),
FOREIGN KEY(TourName) REFERENCES Tour);

CREATE TABLE Booking(
ClientID    INT,
TourName    NVARCHAR(100),
EventYear   INT CHECK (len(EventYear) = 4),
EventMonth  NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
EventDay    INT CHECK (EventDay >=1 AND EventDay <=31),
DateBooked  DATE NOT NULL,
Payment     MONEY CHECK (Payment > 0) NOT NULL,

PRIMARY KEY(ClientID,TourName,EventYear,EventMonth,EventDay),
FOREIGN KEY(ClientID) REFERENCES Client,
FOREIGN KEY(TourName,EventYear,EventMonth,EventDay) REFERENCES Event);

INSERT INTO Tour VALUES 
    ('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region'), 
    ('South', 'Tour of wineries and outlets of Mornington Penisula'),
    ('West',  'Tour of wineries and outlets of the Geelong and Otways region');

SELECT * from Tour;

INSERT INTO Client VALUES 
    (1, 'Price',    'Taylor',   'M'),
    (2, 'Gamble',   'Ellyse',   'F'),
    (3, 'Tan',      'Tilly',    'F');


INSERT INTO [Event] VALUES 
    ('North',   'Jan', 9,   2016, 200),
    ('North',   'Feb', 13,  2016, 225),
    ('South',   'Jan', 9,   2016, 200),
    ('South',   'Jan', 16,  2016, 200),
    ('West',    'Jan', 29,  2016, 225);

insert INTO Booking VALUES
('1', 'North',  'Jan',  9,  2016,   200,    '10-12-2015'),
('2', 'North',  'Jan',  9,  2016,   200,    '16-12-2015'),
('1', 'North',  'Feb',  13, 2016,   225,    '8-01-2016'),
('2', 'North',  'Feb',  13, 2016,   125,    '14-01-2016'),
('3', 'North',  'Feb',  13, 2016,   225,    '3-02-2016'),
('1', 'South',  'Jan',  9,  2016,   200,    '10-12-2015'),
('2', 'South',  'Jan',  16, 2016,   200,    '18-12-2015'),
('3', 'South',  'Jan',  16, 2016,   200,    '9-01-2016'),
('2', 'West',   'Jan',  29, 2016,   225,    '17-12-2015'),
('3', 'West',   'Jan',  29, 2016,   200,    '18-12-2015');






