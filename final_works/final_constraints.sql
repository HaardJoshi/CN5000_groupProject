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
