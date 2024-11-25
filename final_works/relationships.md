# Relationships Among Tables

## 1. Clients Table
- **Referenced by:**
  - `Membership (Client_ID)`
  - `Class_Bookings (Client_ID)`
  - `Training (Client_ID)`
  - `Health_Assessments (Client_ID)`
  - `Gym_Attendance (Client_ID)`
  - `Billing (Client_ID)`
  - `Equipment_Rentals (Client_ID)`

## 2. Membership Table
- **References:**
  - `Clients (Client_ID)`

## 3. Fitness_Classes Table
- **Referenced by:**
  - `Class_Bookings (Class_ID)`

## 4. Class_Bookings Table
- **References:**
  - `Fitness_Classes (Class_ID)`
  - `Clients (Client_ID)`

## 5. Training Table
- **References:**
  - `Clients (Client_ID)`
  - `Staff (Trainer_ID)`

## 6. Health_Assessments Table
- **References:**
  - `Clients (Client_ID)`
  - `Staff (Trainer_ID)`

## 7. Gym_Attendance Table
- **References:**
  - `Clients (Client_ID)`

## 8. Billing Table
- **References:**
  - `Clients (Client_ID)`

## 9. Equipment_Rentals Table
- **References:**
  - `Clients (Client_ID)`

## 10. Staff Table
- **Referenced by:**
  - `Training (Trainer_ID)`
  - `Health_Assessments (Trainer_ID)`

## 11. Facilities Table
- **No references.**

## 12. Discounts Table
- **No references.**

## 13. Equipment_Rentals Table
- **References:**
  - `Clients (Client_ID)`
