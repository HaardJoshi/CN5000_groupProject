-- inserting data into Clients table
INSERT INTO Clients (Name, Type, Relationship, Contact, Emergency_Contact, Email, Address)
VALUES
('John Doe', 'Member', 'Single', '1234567890', '9876543210', 'john.doe@example.com', '123 Main St, Cityville'),
('Jane Smith', 'Guest', NULL, '2234567890', '8876543210', 'jane.smith@example.com', '456 Elm St, Townsville'),
('Alice Johnson', 'Member', 'Married', '3234567890', '7876543210', 'alice.johnson@example.com', '789 Oak St, Hamlet'),
('Bob Brown', 'Guest', NULL, '4234567890', '6876543210', 'bob.brown@example.com', '159 Pine St, Village'),
('Eve Davis', 'Member', 'Divorced', '5234567890', '5876543210', 'eve.davis@example.com', '951 Maple St, Cityburg');

-- inserting data into Memberships table
INSERT INTO Membership (Client_ID, Plan_Type, Start_Date, End_Date, Status, Price)
VALUES
(1, 'Gold', '2024-01-01', '2024-12-31', 'Active', 1200.00),
(3, 'Platinum', '2024-01-01', '2024-12-31', 'Active', 1500.00),
(5, 'Silver', '2024-02-01', '2024-12-31', 'Active', 800.00),
(1, 'Silver', '2023-01-01', '2023-12-31', 'Inactive', 700.00),
(3, 'Gold', '2023-01-01', '2023-12-31', 'Inactive', 1200.00);

-- inserting data into Staff table
INSERT INTO Staff (Name, Role, Specialization, Contact, Emergency_Contact, Salary)
VALUES
('Tom Trainer', 'Trainer', 'Strength Training', '6001234567', '7001234567', 3000.00),
('Sally Instructor', 'Instructor', 'Yoga', '6011234567', '7011234567', 2800.00),
('Rick Coach', 'Trainer', 'Cardio', '6021234567', '7021234567', 3100.00),
('Linda Admin', 'Admin', NULL, '6031234567', '7031234567', 2500.00),
('Nick Nutritionist', 'Trainer', 'Nutrition', '6041234567', '7041234567', 3200.00);

-- inserting data into Fitness_classes table
INSERT INTO Fitness_Classes (Name, Type, Schedule, Instructor_ID, Max_Capacity, Facility_ID)
VALUES
('Morning Yoga', 'Yoga', '2024-01-10 08:00:00', 2, 20, 1),
('Evening Pilates', 'Pilates', '2024-01-11 18:00:00', 2, 15, 2),
('HIIT Blast', 'HIIT', '2024-01-12 10:00:00', 3, 25, 1),
('Spinning Class', 'Spinning', '2024-01-13 09:00:00', 3, 20, 3),
('Weekend Stretch', 'Yoga', '2024-01-14 07:00:00', 2, 30, 1);

-- inserting data into Class_bookings table
INSERT INTO Class_Bookings (Class_ID, Client_ID, Status)
VALUES
(1, 1, 'Confirmed'),
(2, 3, 'Confirmed'),
(3, 5, 'Canceled'),
(4, 2, 'Waitlisted'),
(5, 1, 'Confirmed');

-- inserting data into Training table
INSERT INTO Training (Client_ID, Trainer_ID, Session_Date, Workout_Details)
VALUES
(1, 1, '2024-01-15 09:00:00', '{"exercises": ["Squats", "Deadlifts"], "duration": "1 hour"}'),
(3, 3, '2024-01-16 10:00:00', '{"exercises": ["Push-ups", "Planks"], "duration": "1 hour"}'),
(5, 1, '2024-01-17 11:00:00', '{"exercises": ["Pull-ups", "Lunges"], "duration": "1 hour"}'),
(1, 5, '2024-01-18 12:00:00', '{"diet_plan": ["High Protein", "Low Carb"]}'),
(2, 3, '2024-01-19 09:00:00', '{"exercises": ["Treadmill", "Cycling"], "duration": "1 hour"}');

-- inserting data into Health_Assessment table
INSERT INTO Health_Assessments (Client_ID, Trainer_ID, Date, Weight, BMI, Body_Fat_Percentage)
VALUES
(1, 1, '2024-01-05', 70.5, 23.1, 18.5),
(3, 3, '2024-01-06', 65.2, 22.3, 17.0),
(5, 1, '2024-01-07', 80.0, 26.0, 22.0),
(2, 3, '2024-01-08', 75.0, 24.5, 20.0),
(4, 5, '2024-01-09', 85.0, 27.2, 25.0);

-- inserting data into Gym_Attendance table
INSERT INTO Gym_Attendance (Client_ID, Date, Check_in, Check_out, Facility)
VALUES
(1, '2024-01-01', '2024-01-01 08:00:00', '2024-01-01 10:00:00', 'Main Gym'),
(3, '2024-01-02', '2024-01-02 09:00:00', '2024-01-02 11:00:00', 'Main Gym'),
(5, '2024-01-03', '2024-01-03 07:00:00', '2024-01-03 09:00:00', 'Cardio Room'),
(2, '2024-01-04', '2024-01-04 06:30:00', '2024-01-04 08:00:00', 'Yoga Room'),
(4, '2024-01-05', '2024-01-05 08:00:00', '2024-01-05 09:30:00', 'Weights Room');

-- inserting data into Billing table
INSERT INTO Billing (Client_ID, Amount, Date, Payment_Method, Discount_Applied, Discount_Amount)
VALUES
(1, 120.00, '2024-01-01', 'Credit Card', TRUE, 20.00),
(3, 200.00, '2024-01-02', 'Cash', FALSE, 0.00),
(5, 80.00, '2024-01-03', 'Debit Card', TRUE, 10.00),
(2, 150.00, '2024-01-04', 'Direct Debit', TRUE, 30.00),
(4, 100.00, '2024-01-05', 'Credit Card', FALSE, 0.00);

-- inserting data into Equipments_rental table
INSERT INTO Equipment_Rentals (Equipment_ID, Client_ID, Rental_Date, Return_Date, Maintenance_Schedule)
VALUES
(1, 1, '2024-01-01', '2024-01-05', '2024-01-10'),
(2, 3, '2024-01-02', '2024-01-06', '2024-01-15'),
(3, 5, '2024-01-03', '2024-01-07', '2024-01-20'),
(4, 2, '2024-01-04', '2024-01-08', '2024-01-25'),
(5, 4, '2024-01-05', '2024-01-09', '2024-01-30');

-- inserting data into Discounts table
INSERT INTO Discounts (Type, Code, Usage_Count, Revenue_Loss)
VALUES
('Promotion', 'NEWYEAR2024', 2, 50.00),
('Membership', 'GOLDMEMBER', 1, 20.00),
('Seasonal', 'SUMMERFUN', 0, 0.00),
('Referral', 'FRIEND50', 2, 100.00),
('Special', 'VIP30', 1, 30.00);

-- inserting data into Facilities table
INSERT INTO Facilities (Name, Location)
VALUES
('Main Gym', 'Downtown Building A'),
('Yoga Room', 'Downtown Building B'),
('Cardio Room', 'Downtown Building A'),
('Weights Room', 'Uptown Complex'),
('Spinning Studio', 'Midtown Plaza');

-- inserting data into Discount_usage table
INSERT INTO Discount_Usage (Client_ID, Discount_ID, Usage_Date)
VALUES
(1, 1, '2024-01-01'),
(3, 2, '2024-01-02'),
(5, 4, '2024-01-03'),
(2, 1, '2024-01-04'),
(4, 5, '2024-01-05');
