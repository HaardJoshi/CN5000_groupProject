-- Add foreign key constraints for Class_Bookings
ALTER TABLE Class_Bookings
ADD CONSTRAINT FK_ClassBookings_Class FOREIGN KEY (Class_ID) REFERENCES Fitness_Classes(Class_ID);

ALTER TABLE Class_Bookings
ADD CONSTRAINT FK_ClassBookings_Client FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID);

-- Add foreign key constraints for Training
ALTER TABLE Training
ADD CONSTRAINT FK_Training_Client FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID);

ALTER TABLE Training
ADD CONSTRAINT FK_Training_Trainer FOREIGN KEY (Trainer_ID) REFERENCES Staff(Staff_ID);

-- Add foreign key constraints for Health_Assessments
ALTER TABLE Health_Assessments
ADD CONSTRAINT FK_HealthAssessments_Client FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID);

ALTER TABLE Health_Assessments
ADD CONSTRAINT FK_HealthAssessments_Trainer FOREIGN KEY (Trainer_ID) REFERENCES Staff(Staff_ID);

-- Add foreign key constraint for Membership
ALTER TABLE Membership
ADD CONSTRAINT FK_Membership_Client FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID);

-- Add foreign key constraint for Gym_Attendance
ALTER TABLE Gym_Attendance
ADD CONSTRAINT FK_GymAttendance_Client FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID);

-- Add foreign key constraint for Billing
ALTER TABLE Billing
ADD CONSTRAINT FK_Billing_Client FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID);

-- Add foreign key constraint for Equipment_Rentals
ALTER TABLE Equipment_Rentals
ADD CONSTRAINT FK_EquipmentRentals_Client FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID);

-- Modifications and Additions for Optimizations

-- Step 1: Alter Fitness_Classes to add Facility_ID
-- Purpose: Track the facility where each fitness class is held.
ALTER TABLE Fitness_Classes
ADD COLUMN Facility_ID INT;

-- Step 2: Add foreign key constraint for Facility_ID in Fitness_Classes
ALTER TABLE Fitness_Classes
ADD CONSTRAINT FK_FitnessClasses_Facility FOREIGN KEY (Facility_ID)
REFERENCES Facilities(Facility_ID);

-- Step 3: Alter Gym_Attendance to add Facility_ID
-- Purpose: Track which facility was attended by the client.
ALTER TABLE Gym_Attendance
ADD COLUMN Facility_ID INT;

-- Step 4: Add foreign key constraint for Facility_ID in Gym_Attendance
ALTER TABLE Gym_Attendance
ADD CONSTRAINT FK_GymAttendance_Facility FOREIGN KEY (Facility_ID)
REFERENCES Facilities(Facility_ID);

-- Step 5: Alter Billing to add Discount_ID
-- Purpose: Link billing records to specific discounts applied during payment.
ALTER TABLE Billing
ADD COLUMN Discount_ID INT;

-- Step 6: Add foreign key constraint for Discount_ID in Billing
ALTER TABLE Billing
ADD CONSTRAINT FK_Billing_Discount FOREIGN KEY (Discount_ID)
REFERENCES Discounts(Discount_ID);
