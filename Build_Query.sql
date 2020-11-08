--Alexandre Waymel 103083020



---------------------------- TASK 1 ----------------------------

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