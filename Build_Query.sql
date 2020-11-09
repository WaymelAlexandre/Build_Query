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

INSERT INTO Client VALUES 
    (1, 'Price',    'Taylor',   'M'),
    (2, 'Gamble',   'Ellyse',   'F'),
    (3, 'Tan',      'Tilly',    'F'),
    (4, 'Waymel',   'Alexandre', 'M');


INSERT INTO [Event] VALUES 
    ('North',   'Jan', 9,   2016, 200),
    ('North',   'Feb', 13,  2016, 225),
    ('South',   'Jan', 9,   2016, 200),
    ('South',   'Jan', 16,  2016, 200),
    ('West',    'Jan', 29,  2016, 225);

INSERT INTO Booking (ClientID, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES
    (1, 'North',   'Jan', 9,  2016,   200,    '2015-12-10'),
    (2, 'North',   'Jan', 9,  2016,   200,    '2015-12-16'),
    (1, 'North',   'Feb', 13, 2016,   225,    '2016-01-08'),
    (2, 'North',   'Feb', 13, 2016,   125,    '2016-01-14'),
    (3, 'North',   'Feb', 13, 2016,   225,    '2016-02-03'),
    (1, 'South',   'Jan', 9,  2016,   200,    '2015-12-10'),
    (2, 'South',   'Jan', 16, 2016,   200,    '2015-12-18'),
    (3, 'South',   'Jan', 16, 2016,   200,    '2016-01-09'),
    (2, 'West' ,   'Jan', 29, 2016,   225,    '2015-12-17'),
    (3, 'West' ,   'Jan', 29, 2016,   200,    '2015-12-18');

            --task4
--1

SELECT C.GivenName, C.Surname, T.TourName, T.DESCRIPTION, E.EventYear, E.EventMonth,E.EventDay,E.Fee, B.DateBooked, B.Payment
FROM Booking AS B 

INNER JOIN Client AS C
ON B.ClientID = C.ClientID

INNER JOIN Event AS E 
ON B.TourName = E.TourName AND B.EventYear = E.EventYear AND B.EventMonth = E.EventMonth AND B.EventDay = E.EventDay

INNER JOIN Tour AS T 
ON E.TourName = T.TourName;


--2
SELECT EventMonth, TourName , COUNT(*) AS 'Num Bookings'
FROM Booking
GROUP BY EventMonth, TourName;




--3

SELECT *
FROM Booking
where Payment > 
    (
        SELECT AVG(Payment) FROM booking
    );

                --task 5
GO
CREATE VIEW [Task4View] AS

    SELECT C.GivenName, C.Surname, T.TourName, T.Description, E.EventYear, E.EventMonth, E.EventDay,E.Fee, B.DateBooked, B.Payment
    FROM Booking AS B 

    INNER JOIN Client AS C
    ON B.ClientID = C.ClientID

    INNER JOIN Event AS E 
    ON B.TourName = E.TourName AND B.EventYear = E.EventYear AND B.EventMonth = E.EventMonth AND B.EventDay = E.EventDay

    INNER JOIN Tour AS T 
    ON E.TourName = T.TourName;
GO



                --Task 6


--test client 
select * from Client             -- 4 client created
select count(*) from Client      -- 4 return rows

--test booking 
select * from booking           --  10 rows created 
select count(*) from booking    --  return 10 rows as well

--test Event
SELECT * FROM Event             -- 5 row created
select count(*) from Event      -- numbre 5 return 

select * FROM Tour                 --2 row created
select count(*) from tour          --2 rows return 


select * FROm [Task4View]; -- 10 rows are retruned with the view 


        -- test Q1

        SELECT * 
        FROM [Task4View]; -- 10 coloms are return missing the clientID , and gender because not required on task 4

        SELECT count(*) AS 'Total'
        FROM [Task4View]; -- the numbre 10 are return


        -- test Q2

--check with the view 
SELECT TourName 
    FROM [Task4View]
    -- only North, South, West as a tourname. I will calcul the totla of the 3
    WHERE TourName = 'North' OR TourName = 'South' or TourName = 'West'; -- 10 rows return  like the numbre of booking 
 


        -- test Q3

    -- the query 3 RETURN 3 rows with greater average payment 

    --I check the AVR manually
    --Average Numbre: 200 + 225 + 200 + 200 + 200 + 225 + 125 + 225 + 200 + 200 = 2000 
    -- 2000 / 10 booking  ===   Average of 200
    -- and I do use the view created for task 5, to check all the data with one table

    SELECT *
    FROM [Task4View]
    WHERE Payment > 200;
    