# Database Relationships Documentation

This document outlines the relationships between the tables in the database, explaining how each entity is related to others.

## 1. Clients
- **Primary Key:** `Client_ID`
- **Related Tables:**
  - **Membership**: One-to-many (One client can have many memberships)
  - **Class_Bookings**: One-to-many (One client can book many classes)
  - **Training**: One-to-many (One client can have many training sessions)
  - **Health_Assessments**: One-to-many (One client can undergo many health assessments)
  - **Gym_Attendance**: One-to-many (One client can have many attendance records)
  - **Billing**: One-to-many (One client can have many bills)
  - **Equipment_Rentals**: One-to-many (One client can rent many pieces of equipment)
  - **Discount_Usage**: One-to-many (One client can use many discounts)

## 2. Membership
- **Primary Key:** `Membership_ID`
- **Foreign Key:** `Client_ID`
- **Relationship:** Many-to-one (Many memberships can belong to one client)

## 3. Fitness Classes
- **Primary Key:** `Class_ID`
- **Related Tables:**
  - **Class_Bookings**: One-to-many (One class can have many bookings)
  - **Gym_Attendance**: One-to-many (One class can be attended by many clients)
- **Foreign Key:** `Facility_ID`
  - **Facilities**: Many-to-one (Many classes can be hosted in one facility)

## 4. Class Bookings
- **Primary Key:** `Booking_ID`
- **Foreign Key:** `Class_ID`, `Client_ID`
- **Relationship:** Many-to-one (Many bookings can be made for one class, and many bookings can be made by one client)

## 5. Training
- **Primary Key:** `Training_ID`
- **Foreign Key:** `Client_ID`, `Trainer_ID` (from Staff table)
- **Relationship:** Many-to-one (One client can have many training sessions conducted by one trainer)

## 6. Health Assessments
- **Primary Key:** `Assessment_ID`
- **Foreign Key:** `Client_ID`, `Trainer_ID` (from Staff table)
- **Relationship:** Many-to-one (One client can undergo many assessments by a trainer)

## 7. Gym Attendance
- **Primary Key:** `Attendance_ID`
- **Foreign Key:** `Client_ID`, `Facility_ID`
- **Relationship:** Many-to-one (Many attendance records can be associated with one client and one facility)

## 8. Billing
- **Primary Key:** `Billing_ID`
- **Foreign Key:** `Client_ID`, `Discount_ID`
  - **Discount_Usage**: One-to-many (One billing record can have many discount usages)
- **Relationship:** One-to-many (One client can have many bills, and one discount can be applied to many bills)

## 9. Discounts
- **Primary Key:** `Discount_ID`
- **Foreign Key:** None
- **Related Tables:**
  - **Discount_Usage**: One-to-many (One discount can be used many times)
  - **Billing**: Many-to-one (Many bills can have one discount applied)

## 10. Discount Usage
- **Primary Key:** `Usage_ID`
- **Foreign Key:** `Discount_ID`, `Billing_ID`, `Client_ID`
- **Relationship:** Many-to-one (Many usage records can be created for one discount, one billing, and one client)

## 11. Equipment Rentals
- **Primary Key:** `Rental_ID`
- **Foreign Key:** `Client_ID`
- **Relationship:** Many-to-one (One client can rent many pieces of equipment)

## 12. Staff
- **Primary Key:** `Staff_ID`
- **Related Tables:**
  - **Training**: One-to-many (One trainer can conduct many training sessions)
  - **Health_Assessments**: One-to-many (One trainer can conduct many health assessments)

## 13. Facilities
- **Primary Key:** `Facility_ID`
- **Related Tables:**
  - **Fitness_Classes**: One-to-many (One facility can host many fitness classes)
  - **Gym_Attendance**: One-to-many (One facility can have many gym attendance records)

---

## Table Relationship Summary
1. **Clients to Membership:** One-to-many
2. **Clients to Class Bookings:** One-to-many
3. **Clients to Training:** One-to-many
4. **Clients to Health Assessments:** One-to-many
5. **Clients to Gym Attendance:** One-to-many
6. **Clients to Billing:** One-to-many
7. **Clients to Equipment Rentals:** One-to-many
8. **Clients to Discount_Usage:** One-to-many

9. **Fitness Classes to Class Bookings:** One-to-many
10. **Fitness Classes to Gym Attendance:** One-to-many
11. **Fitness Classes to Facilities:** Many-to-one

12. **Class Bookings to Fitness Classes:** Many-to-one
13. **Class Bookings to Clients:** Many-to-one

14. **Training to Clients:** Many-to-one
15. **Training to Staff:** Many-to-one

16. **Health Assessments to Clients:** Many-to-one
17. **Health Assessments to Staff:** Many-to-one

18. **Gym Attendance to Clients:** Many-to-one
19. **Gym Attendance to Facilities:** Many-to-one

20. **Billing to Clients:** Many-to-one
21. **Billing to Discounts:** Many-to-one
22. **Billing to Discount_Usage:** One-to-many

23. **Discounts to Discount_Usage:** One-to-many

24. **Equipment Rentals to Clients:** Many-to-one

25. **Staff to Training:** One-to-many
26. **Staff to Health Assessments:** One-to-many

27. **Facilities to Fitness Classes:** One-to-many
28. **Facilities to Gym Attendance:** One-to-many
