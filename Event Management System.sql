/*
Task 3
Project: Event Management System using PostgreSQL
Objective: To develop the application that allows users to create and manage events, track attendees, and handle event registrations efficiently.
*/


-- Create the Events table
CREATE TABLE Events (
    Event_Id SERIAL PRIMARY KEY,
    Event_Name VARCHAR(255) NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Location VARCHAR(255) NOT NULL,
    Event_Description TEXT
);

-- Create the Attendees table
CREATE TABLE Attendees (
    Attendee_Id SERIAL PRIMARY KEY,
    Attendee_Name VARCHAR(255) NOT NULL,
    Attendee_Phone VARCHAR(15),
    Attendee_Email VARCHAR(255) UNIQUE,
    Attendee_City VARCHAR(255)
);

-- Create the Registrations table
CREATE TABLE Registrations (
    Registration_Id SERIAL PRIMARY KEY,
    Event_Id INT NOT NULL,
    Attendee_Id INT NOT NULL,
    Registration_Date DATE NOT NULL,
    Registration_Amount DECIMAL(10, 2),
    FOREIGN KEY (Event_Id) REFERENCES Events(Event_Id),
    FOREIGN KEY (Attendee_Id) REFERENCES Attendees(Attendee_Id)
);

-- Query to display data from Events, Attendees, and Registrations tables
select * from Events;
select * from Registrations;
select * from Attendees;


/* 2. Data Creation
Insert some sample data for Events, Attendees, and Registrations tables with respective fields.
*/

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
('Global Innovators Summit 2024', '2024-10-15', 'Tech Park, Mumbai', 'A summit for the brightest minds in technology and innovation.'),
('Melody in the Park', '2024-11-20', 'Central Park, Delhi', 'A live concert featuring top musicians.'),
('Sculpture Display', '2024-12-05', 'Art Gallery, Hyderabad', 'An exhibition showcasing modern sculptures from renowned artists.');

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES
('John Doe', '9876543210', 'john.doe@gmail.com', 'Mumbai'),
('Jane Smith', '8765432109', 'jane.smith@yahoo.com', 'Delhi'),
('Robert Brown', '7654321098', 'robert.brown@aol.com', 'Hyderabad'),
('Emily Davis', '6543210987', 'emily.davis@hotmail.com', 'Mumbai');

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES
(2, 1, '2024-09-01', 3000.00),  -- John registers for Melody in the Park
(2, 2, '2024-09-02', 3000.00),  -- Jane registers for Melody in the Park
(1, 3, '2024-10-01', 2500.00),  -- Robert registers for Global Innovators Summit 2024
(3, 4, '2024-11-01', 1500.00);  -- Emily registers for Sculpture Display


-- Query to display data from the Events table
select * from Events;


/* 3. Manage Event Details
a) Inserting a new event.
*/

INSERT INTO Events (Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
('Corporate Gala 2024', '2024-12-15', 'JW Marriott, Bangalore', 'An annual gala for top business leaders.');

select * from Events;

-- b) Updating an event's information.

UPDATE Events
SET Event_Location = 'Convention Center, Mumbai',
    Event_Description = 'A summit focusing on breakthrough innovations and cutting-edge technology.'
WHERE Event_Id = 1;

SELECT * FROM Events
WHERE Event_Id = 1;

-- c) Deleting an event.

SELECT * FROM Registrations WHERE Event_Id = 3; -- Check for registered attendees for event ID 3
DELETE FROM Registrations WHERE Event_Id = 3;  -- Delete registration entries for event ID 3
DELETE FROM Events WHERE Event_Id = 3;         -- Delete the event itself

SELECT * FROM Registrations;


/* 4) Manage Track Attendees & Handle Events
a) Inserting a new attendee.
*/

INSERT INTO Attendees (Attendee_Name, Attendee_Phone, Attendee_Email, Attendee_City)
VALUES ('David Wilson', '9123456789', 'david.wilson@xyz.com', 'Chennai');

SELECT * FROM Attendees;

-- b) Registering an attendee for an event.

INSERT INTO Registrations (Event_Id, Attendee_Id, Registration_Date, Registration_Amount)
VALUES (2, 5, '2024-09-15', 3000.00);

-- Query to display the added event.
SELECT
    a.Attendee_Name,
    e.Event_Id,
    e.Event_Name,
    e.Event_Date,
    a.Attendee_Id,
    r.Registration_Amount
FROM
    Registrations r
JOIN
    Events e ON r.Event_Id = e.Event_Id
JOIN
    Attendees a ON r.Attendee_Id = a.Attendee_Id
WHERE
    r.Event_Id = 2 AND r.Attendee_Id = 5;


/* 5. Develop queries to retrieve event information, generate attendee lists, and calculate event attendance statistics.
*/

-- Retrieve event information and total number of attendees for each event
SELECT
    e.Event_Id,
    e.Event_Name,
    COUNT(r.Attendee_Id) AS Total_Attendees
FROM
    Events e
LEFT JOIN
    Registrations r ON e.Event_Id = r.Event_Id
GROUP BY
    e.Event_Id, e.Event_Name;
