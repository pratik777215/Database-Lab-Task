DROP DATABASE AspireFitness;
CREATE DATABASE AspireFitness;

USE AspireFitness;

CREATE TABLE Member ( Member_ID INT PRIMARY KEY AUTO_INCREMENT, 
First_Name VARCHAR(50) NOT NULL,
Middle_Name VARCHAR(50), 
Last_Name VARCHAR(50) NOT NULL, 
Address VARCHAR(255), 
Phone_Number VARCHAR(15), 
Email VARCHAR(100), 
Date_of_Birth DATE, 
Medical_Condition VARCHAR(255), 
Join_Date DATE NOT NULL
 );
 describe Member;
 
CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Middle_Name VARCHAR(50),
    Last_Name VARCHAR(50) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Phone_Number VARCHAR(15),
    Email VARCHAR(100),
    Hire_Date DATE
);
describe Staff;

CREATE TABLE Facility (
    Facility_ID INT PRIMARY KEY AUTO_INCREMENT,
    Facility_Name VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Capacity INT,
    Facility_Type VARCHAR(50)
);
describe Facility;

CREATE TABLE Class (
    Class_ID INT PRIMARY KEY AUTO_INCREMENT,
    Class_Name VARCHAR(100) NOT NULL,
    Description VARCHAR(255),
    Difficulty_Level VARCHAR(20),
    Duration_Minutes INT
);
describe Class;

CREATE TABLE MembershipPlan (
    Plan_ID INT PRIMARY KEY AUTO_INCREMENT,
    Plan_Name VARCHAR(50) NOT NULL,
    Weekly_Subscription DECIMAL(10,2) NOT NULL,
    Free_Class_Limit INT NOT NULL,
    Extra_Class_Price DECIMAL(10,2) NOT NULL,
    Description VARCHAR(255)
);
describe MembershipPlan;

CREATE TABLE Membership (
    Membership_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT,
    Plan_ID INT,
    Start_Date DATE NOT NULL,
    End_Date DATE,
    Status VARCHAR(20),

    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID),
    FOREIGN KEY (Plan_ID) REFERENCES MembershipPlan(Plan_ID)
);
describe Membership;
CREATE TABLE ClassSchedule (
    Schedule_ID INT PRIMARY KEY AUTO_INCREMENT,
    Class_ID INT,
    Staff_ID INT,
    Facility_ID INT,
    Day_of_Week VARCHAR(15),
    Start_Time TIME,
    End_Time TIME,
    Max_Class_Size INT,

    FOREIGN KEY (Class_ID) REFERENCES Class(Class_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Facility_ID) REFERENCES Facility(Facility_ID)
);
describe ClassSchedule;

CREATE TABLE ClassBooking (
    ClassBooking_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT,
    Schedule_ID INT,
    Booking_Date DATE,
    Booking_Status VARCHAR(20),

    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID),
    FOREIGN KEY (Schedule_ID) REFERENCES ClassSchedule(Schedule_ID)
);
describe ClassBooking;

CREATE TABLE FacilityBooking (
    FacilityBooking_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT,
    Facility_ID INT,
    Activity_Type VARCHAR(50),
    Booking_Date DATE,
    Start_Time TIME,
    End_Time TIME,
    Duration INT,

    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID),
    FOREIGN KEY (Facility_ID) REFERENCES Facility(Facility_ID)
);
describe FacilityBooking;

CREATE TABLE Payment (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT,
    Membership_ID INT,
    Amount DECIMAL(10,2),
    Payment_Date DATE,
    Payment_Method VARCHAR(20),

    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID),
    FOREIGN KEY (Membership_ID) REFERENCES Membership(Membership_ID)
);
describe Payment;

CREATE TABLE Attendance (
    Attendance_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT,
    Schedule_ID INT,
    Attendance_Date DATE,
    Status VARCHAR(20),

    FOREIGN KEY (Member_ID) REFERENCES Member(Member_ID),
    FOREIGN KEY (Schedule_ID) REFERENCES ClassSchedule(Schedule_ID)
);
describe Attendance;

INSERT INTO Member (First_Name, Middle_Name, Last_Name, Address, Phone_Number, Email, Date_of_Birth, Medical_Condition, Join_Date)
VALUES
('John', NULL, 'Smith', 'Kathmandu', '9800001111', 'john@gmail.com', '1995-05-10', NULL, '2025-01-05'),
('Sara', 'M', 'Thapa', 'Lalitpur', '9800002222', 'sara@gmail.com', '1998-07-21', 'Asthma', '2025-02-10'),
('Ramesh', NULL, 'Karki', 'Bhaktapur', '9800003333', 'ramesh@gmail.com', '1992-09-14', NULL, '2025-03-01'),
('Anita', NULL, 'Sharma', 'Kathmandu', '9800004444', 'anita@gmail.com', '2000-01-12', NULL, '2025-03-15'),
('David', NULL, 'Lee', 'Kathmandu', '9800005555', 'david@gmail.com', '1997-11-20', NULL, '2025-04-01'),
('Amit', NULL, 'Shrestha', 'Kathmandu', '9801111111', 'amit@gmail.com', '1996-03-10', NULL, '2025-04-02'),
('Priya', NULL, 'Koirala', 'Pokhara', '9801111112', 'priya@gmail.com', '1999-05-22', NULL, '2025-04-03'),
('Suman', NULL, 'Rai', 'Biratnagar', '9801111113', 'suman@gmail.com', '1994-11-12', NULL, '2025-04-04'),
('Kiran', NULL, 'Gurung', 'Lalitpur', '9801111114', 'kiran@gmail.com', '1993-07-30', NULL, '2025-04-05'),
('Nisha', NULL, 'Lama', 'Kathmandu', '9801111115', 'nisha@gmail.com', '2001-02-18', NULL, '2025-04-06'),
('Rohit', NULL, 'Bhandari', 'Bhaktapur', '9801111116', 'rohit@gmail.com', '1997-09-09', NULL, '2025-04-07');
select * from Member;

INSERT INTO Staff (First_Name, Middle_Name, Last_Name, Role, Phone_Number, Email, Hire_Date)
VALUES
('Michael', NULL, 'Brown', 'Trainer', '9811111111', 'michael@aspire.com', '2023-05-01'),
('Emily', NULL, 'Johnson', 'Yoga Instructor', '9811112222', 'emily@aspire.com', '2023-08-10'),
('Raj', NULL, 'Adhikari', 'Gym Manager', '9811113333', 'raj@aspire.com', '2022-03-15'),
('Anna', NULL, 'Taylor', 'Zumba Instructor', '9812222221', 'anna@aspire.com', '2023-11-01'),
('James', NULL, 'Wilson', 'Trainer', '9812222222', 'james@aspire.com', '2024-01-15'),
('Sita', NULL, 'Thapa', 'Receptionist', '9812222223', 'sita@aspire.com', '2024-02-01'),
('Hari', NULL, 'KC', 'Trainer', '9812222224', 'hari@aspire.com', '2024-03-10'),
('Sophia', NULL, 'White', 'Pilates Instructor', '9812222225', 'sophia@aspire.com', '2024-04-05');
select * from Staff;

INSERT INTO Facility (Facility_Name, Location, Capacity, Facility_Type)
VALUES
('Main Gym Hall', 'Ground Floor', 50, 'Gym'),
('Yoga Room', 'First Floor', 20, 'Yoga Studio'),
('Swimming Pool', 'Outdoor Area', 30, 'Pool'),
('Cardio Room', 'Second Floor', 25, 'Cardio'),
('Strength Room', 'Ground Floor', 30, 'Weight Training'),
('Aerobics Hall', 'First Floor', 40, 'Aerobics'),
('Indoor Cycling Room', 'Second Floor', 20, 'Cycling'),
('CrossFit Zone', 'Outdoor', 25, 'CrossFit'),
('Meditation Room', 'Third Floor', 15, 'Meditation');
select * from Facility;

INSERT INTO Class (Class_Name, Description, Difficulty_Level, Duration_Minutes)
VALUES
('Yoga', 'Relaxing yoga session', 'Beginner', 60),
('HIIT Training', 'High intensity interval training', 'Advanced', 45),
('Zumba', 'Dance fitness class', 'Intermediate', 50),
('Pilates', 'Core strength training', 'Intermediate', 60),
('CrossFit', 'Strength and conditioning workout', 'Advanced', 50),
('Aerobics', 'Cardio exercise with music', 'Beginner', 45),
('Spin Class', 'Indoor cycling workout', 'Intermediate', 40),
('Strength Training', 'Muscle building workout', 'Advanced', 60),
('Stretching', 'Flexibility and recovery session', 'Beginner', 30);
select * from Class;

INSERT INTO MembershipPlan (Plan_Name, Weekly_Subscription, Free_Class_Limit, Extra_Class_Price, Description)
VALUES
('Basic Plan', 10.00, 2, 5.00, 'Basic access to gym with limited classes'),
('Standard Plan', 15.00, 5, 3.00, 'Access to gym and multiple classes'),
('Premium Plan', 25.00, 10, 0.00, 'Unlimited classes and full facility access'),
('Student Plan', 8.00, 2, 4.00, 'Discounted plan for students'),
('Weekend Plan', 12.00, 3, 4.00, 'Access only on weekends'),
('Family Plan', 30.00, 12, 0.00, 'Family access with unlimited classes'),
('Athlete Plan', 35.00, 15, 0.00, 'Advanced training program'),
('Yoga Plan', 18.00, 6, 2.00, 'Unlimited yoga classes'),
('Swimming Plan', 20.00, 5, 3.00, 'Pool and swimming training'),
('Cardio Plan', 14.00, 4, 3.00, 'Access to cardio facilities');
select * from MembershipPlan;

INSERT INTO Membership (Member_ID, Plan_ID, Start_Date, End_Date, Status)
VALUES
(1, 1, '2025-01-05', '2025-04-05', 'Active'),
(2, 2, '2025-02-10', '2025-05-10', 'Active'),
(3, 2, '2025-03-01', '2025-06-01', 'Active'),
(4, 3, '2025-03-15', '2025-06-15', 'Active'),
(5, 1, '2025-04-01', '2025-07-01', 'Active'),
(6, 2, '2025-04-05', '2025-07-05', 'Active'),
(7, 3, '2025-04-12', '2025-07-12', 'Active'),
(8, 1, '2025-04-18', '2025-07-18', 'Active'),
(9, 2, '2025-04-20', '2025-07-20', 'Active'),
(10, 3, '2025-04-25', '2025-07-25', 'Active');
select * from Membership;

INSERT INTO ClassSchedule (Class_ID, Staff_ID, Facility_ID, Day_of_Week, Start_Time, End_Time, Max_Class_Size)
VALUES
(1, 2, 2, 'Monday', '08:00:00', '09:00:00', 20),
(2, 1, 1, 'Tuesday', '18:00:00', '18:45:00', 25),
(3, 1, 1, 'Wednesday', '17:00:00', '17:50:00', 25),
(4, 2, 2, 'Thursday', '09:00:00', '10:00:00', 20),
(5, 1, 1, 'Friday', '07:00:00', '07:50:00', 20),
(6, 2, 2, 'Saturday', '09:00:00', '09:45:00', 25),
(7, 1, 1, 'Sunday', '18:00:00', '18:40:00', 25),
(8, 2, 2, 'Monday', '10:00:00', '11:00:00', 20),
(9, 1, 1, 'Wednesday', '16:00:00', '17:00:00', 30);
select * from ClassSchedule;

INSERT INTO ClassBooking (Member_ID, Schedule_ID, Booking_Date, Booking_Status)
VALUES
(1, 1, '2025-04-10', 'Confirmed'),
(2, 2, '2025-04-10', 'Confirmed'),
(3, 3, '2025-04-11', 'Confirmed'),
(4, 1, '2025-04-12', 'Pending'),
(5, 4, '2025-04-12', 'Confirmed'),
(6, 5, '2025-04-13', 'Confirmed'),
(7, 6, '2025-04-13', 'Confirmed'),
(8, 7, '2025-04-14', 'Pending'),
(9, 8, '2025-04-14', 'Confirmed'),
(10, 9, '2025-04-15', 'Confirmed');
select * from ClassBooking;

INSERT INTO FacilityBooking (Member_ID, Facility_ID, Activity_Type, Booking_Date, Start_Time, End_Time, Duration)
VALUES
(1, 1, 'Workout', '2025-04-10', '10:00:00', '11:00:00', 60),
(2, 3, 'Swimming', '2025-04-10', '10:00:00', '11:00:00', 60),
(3, 4, 'Cardio Exercise', '2025-04-11', '12:00:00', '13:00:00', 60),
(4, 2, 'Yoga Practice', '2025-04-12', '08:00:00', '09:00:00', 60),
(5, 3, 'Swimming', '2025-04-10', '10:00:00', '11:00:00', 60),
(6, 4, 'Cardio Exercise', '2025-04-13', '11:00:00', '12:00:00', 60),
(7, 1, 'Weight Training', '2025-04-14', '10:00:00', '11:00:00', 60),
(8, 2, 'Pilates Practice', '2025-04-15', '09:00:00', '10:00:00', 60);
select * from FacilityBooking;

INSERT INTO Payment (Member_ID, Membership_ID, Amount, Payment_Date, Payment_Method)
VALUES
(1, 1, 40.00, '2025-01-05', 'Cash'),
(2, 2, 60.00, '2025-02-10', 'Card'),
(3, 3, 60.00, '2025-03-01', 'Online'),
(4, 4, 100.00, '2025-03-15', 'Card'),
(5, 5, 40.00, '2025-04-01', 'Cash'),
(6, 6, 60.00, '2025-04-05', 'Online'),
(7, 7, 100.00, '2025-04-12', 'Card'),
(8, 8, 40.00, '2025-04-18', 'Cash'),
(9, 9, 60.00, '2025-04-20', 'Online'),
(10, 10, 100.00, '2025-04-25', 'Card');
select * from Payment;

INSERT INTO Attendance (Member_ID, Schedule_ID, Attendance_Date, Status)
VALUES
(1, 1, '2025-04-14', 'Present'),
(2, 2, '2025-04-15', 'Present'),
(3, 3, '2025-04-16', 'Absent'),
(4, 1, '2025-04-17', 'Present'),
(5, 4, '2025-04-18', 'Present'),
(6, 5, '2025-04-19', 'Present'),
(7, 6, '2025-04-20', 'Present'),
(8, 7, '2025-04-21', 'Absent'),
(9, 8, '2025-04-22', 'Present'),
(10, 9, '2025-04-23', 'Present');
select * from Attendance;

select First_Name, Last_Name, Join_Date
From Member
WHERE Join_Date > '2025-01-01';

SELECT Plan_Name, Weekly_Subscription, Free_Class_Limit
FROM MembershipPlan;

SELECT 
Member.First_Name,
Member.Last_Name,
MembershipPlan.Plan_Name,
Membership.Start_Date,
Membership.End_Date
FROM Membership
JOIN Member ON Membership.Member_ID = Member.Member_ID
JOIN MembershipPlan ON Membership.Plan_ID = MembershipPlan.Plan_ID;

SELECT 
Staff.First_Name,
Staff.Last_Name,
Class.Class_Name
FROM ClassSchedule
JOIN Staff ON ClassSchedule.Staff_ID = Staff.Staff_ID
JOIN Class ON ClassSchedule.Class_ID = Class.Class_ID;


SELECT 
Class.Class_Name,
ClassSchedule.Day_of_Week,
ClassSchedule.Start_Time,
ClassSchedule.End_Time
FROM ClassSchedule
JOIN Class ON ClassSchedule.Class_ID = Class.Class_ID;

SELECT 
Member.First_Name,
Member.Last_Name,
'ClassBooking' AS Booking_Type,
Class.Class_Name AS Activity,
ClassBooking.Booking_Date
FROM ClassBooking
JOIN Member ON ClassBooking.Member_ID = Member.Member_ID
JOIN ClassSchedule ON ClassBooking.Schedule_ID = ClassSchedule.Schedule_ID
JOIN Class ON ClassSchedule.Class_ID = Class.Class_ID

UNION

SELECT 
Member.First_Name,
Member.Last_Name,
'FacilityBooking' AS Booking_Type,
Facility.Facility_Name AS Activity,
FacilityBooking.Booking_Date
FROM FacilityBooking
JOIN Member ON FacilityBooking.Member_ID = Member.Member_ID
JOIN Facility ON FacilityBooking.Facility_ID = Facility.Facility_ID

order by Booking_Date;

SELECT COUNT(*) AS Total_Members
FROM Member;

SELECT SUM(Amount) AS Total_Revenue
FROM Payment;

SELECT 
Member.First_Name,
Member.Last_Name,
Payment.Amount,
Payment.Payment_Date
FROM Payment
JOIN Member ON Payment.Member_ID = Member.Member_ID;

SELECT 
Member.First_Name,
Member.Last_Name,
Attendance.Attendance_Date,
Attendance.Status
FROM Attendance
JOIN Member ON Attendance.Member_ID = Member.Member_ID;

SELECT 
Class.Class_Name,
ClassSchedule.Max_Class_Size
FROM ClassSchedule
JOIN Class ON ClassSchedule.Class_ID = Class.Class_ID;

SELECT DISTINCT
Member.First_Name,
Member.Last_Name
FROM ClassBooking
JOIN Member ON ClassBooking.Member_ID = Member.Member_ID;

SELECT First_Name, Last_Name, Role
FROM Staff
ORDER BY Role;

SELECT Plan_ID, COUNT(Member_ID) AS Total_Members
FROM Membership
GROUP BY Plan_ID;

SELECT Plan_ID, COUNT(Member_ID) AS Total_Members
FROM Membership
GROUP BY Plan_ID
HAVING COUNT(Member_ID) > 2;

SELECT First_Name, Last_Name
FROM Member
WHERE Member_ID IN (
    SELECT Member_ID
    FROM Payment
    WHERE Amount > (SELECT AVG(Amount) FROM Payment)
);

UPDATE Member
SET Address = 'Pokhara'
WHERE Member_ID = 1;

DELETE FROM FacilityBooking
WHERE FacilityBooking_ID = 8;

CREATE INDEX idx_member_lastname
ON Member(Last_Name);

# Checking if two bookings overlap in the same facility.
SELECT
    f.Facility_Name,
    fb1.Booking_Date,
    fb1.Start_Time AS Booking1_Start,
    fb1.End_Time AS Booking1_End,
    fb2.Start_Time AS Booking2_Start,
    fb2.End_Time AS Booking2_End
FROM FacilityBooking fb1
JOIN FacilityBooking fb2
    ON fb1.Facility_ID = fb2.Facility_ID
    AND fb1.Booking_Date = fb2.Booking_Date
    AND fb1.FacilityBooking_ID <> fb2.FacilityBooking_ID
    AND fb1.Start_Time < fb2.End_Time
    AND fb1.End_Time > fb2.Start_Time
JOIN Facility f
    ON fb1.Facility_ID = f.Facility_ID;

# Checks if a member booked two classes at the same time.
SELECT 
    m.First_Name,
    m.Last_Name,
    cb1.Booking_Date,
    cs1.Start_Time,
    cs1.End_Time,
    cs2.Start_Time,
    cs2.End_Time
FROM ClassBooking cb1
JOIN ClassBooking cb2 
    ON cb1.Member_ID = cb2.Member_ID
    AND cb1.ClassBooking_ID <> cb2.ClassBooking_ID
JOIN ClassSchedule cs1 ON cb1.Schedule_ID = cs1.Schedule_ID
JOIN ClassSchedule cs2 ON cb2.Schedule_ID = cs2.Schedule_ID
JOIN Member m ON cb1.Member_ID = m.Member_ID
WHERE cs1.Start_Time < cs2.End_Time
AND cs1.End_Time > cs2.Start_Time;

# Calculate if member booked more classes than allowed.
SELECT 
m.First_Name,
m.Last_Name,
mp.Plan_Name,
COUNT(cb.ClassBooking_ID) AS Classes_Booked,
mp.Free_Class_Limit
FROM ClassBooking cb
JOIN Member m ON cb.Member_ID = m.Member_ID
JOIN Membership ms ON m.Member_ID = ms.Member_ID
JOIN MembershipPlan mp ON ms.Plan_ID = mp.Plan_ID
GROUP BY 
m.Member_ID,
m.First_Name,
m.Last_Name,
mp.Plan_Name,
mp.Free_Class_Limit
HAVING COUNT(cb.ClassBooking_ID) > mp.Free_Class_Limit;

# Stored procedure for Facility Booking
DELIMITER $$

CREATE PROCEDURE BookFacility(
    IN p_member_id INT,
    IN p_facility_id INT,
    IN p_activity VARCHAR(50),
    IN p_booking_date DATE,
    IN p_start_time TIME,
    IN p_end_time TIME
)
BEGIN

IF EXISTS (
    SELECT 1
    FROM FacilityBooking
    WHERE Facility_ID = p_facility_id
    AND Booking_Date = p_booking_date
    AND p_start_time < End_Time
    AND p_end_time > Start_Time
)
THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Facility already booked for this time';
    
ELSE

INSERT INTO FacilityBooking
(Member_ID, Facility_ID, Activity_Type, Booking_Date, Start_Time, End_Time, Duration)
VALUES
(p_member_id, p_facility_id, p_activity, p_booking_date, p_start_time, p_end_time,
TIMESTAMPDIFF(MINUTE, p_start_time, p_end_time));

END IF;

END $$

DELIMITER ;
CALL BookFacility(1,1,'Workout','2025-05-01','10:00:00','11:00:00');
CALL BookFacility(2,3,'Swimming','2025-05-02','14:00:00','15:00:00');
CALL BookFacility(3,4,'Cardio Exercise','2025-05-03','12:00:00','13:00:00');

select * from facilitybooking;
SHOW PROCEDURE STATUS WHERE Db = 'aspirefitness';

# Finding the most popular class based on number of bookings
SELECT 
Class.Class_Name,
COUNT(ClassBooking.ClassBooking_ID) AS Total_Bookings
FROM ClassBooking
JOIN ClassSchedule ON ClassBooking.Schedule_ID = ClassSchedule.Schedule_ID
JOIN Class ON ClassSchedule.Class_ID = Class.Class_ID
GROUP BY Class.Class_Name
ORDER BY Total_Bookings DESC;

# Calculate total payment made by each member
SELECT 
Member.First_Name,
Member.Last_Name,
SUM(Payment.Amount) AS Total_Paid
FROM Payment
JOIN Member ON Payment.Member_ID = Member.Member_ID
GROUP BY Member.Member_ID;

# Show trainers who handle the most classes
SELECT 
Staff.First_Name,
Staff.Last_Name,
COUNT(ClassSchedule.Schedule_ID) AS Classes_Conducted
FROM ClassSchedule
JOIN Staff ON ClassSchedule.Staff_ID = Staff.Staff_ID
GROUP BY Staff.Staff_ID
ORDER BY Classes_Conducted DESC;

# Finding most frequently booked facilities
SELECT 
Facility.Facility_Name,
COUNT(FacilityBooking.FacilityBooking_ID) AS Total_Usage
FROM FacilityBooking
JOIN Facility ON FacilityBooking.Facility_ID = Facility.Facility_ID
GROUP BY Facility.Facility_Name
ORDER BY Total_Usage DESC;

# Display members with active membership
SELECT 
Member.First_Name,
Member.Last_Name,
Membership.Status
FROM Membership
JOIN Member ON Membership.Member_ID = Member.Member_ID
WHERE Membership.Status = 'Active';

# Find the average membership payment
SELECT 
AVG(Amount) AS Average_Payment
FROM Payment;

CREATE VIEW MemberMembershipDetails AS
SELECT 
Member.First_Name,
Member.Last_Name,
MembershipPlan.Plan_Name
FROM Membership
JOIN Member ON Membership.Member_ID = Member.Member_ID
JOIN MembershipPlan ON Membership.Plan_ID = MembershipPlan.Plan_ID;

SELECT * FROM MemberMembershipDetails;