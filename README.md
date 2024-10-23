# CN5000_groupProject
# Gym Management System (GMS)

## Description
This repository contains the design and implementation of a **Gym Management System (GMS)**, developed as part of a group coursework for the **CN5000 Database Systems** module. The project aims to create a comprehensive database system to manage various aspects of a large fitness center, including membership plans, fitness classes, personal training sessions, health assessments, equipment rentals, billing, and staff management.

## Features
The GMS is designed to handle multiple functionalities:
- **Membership Management**: Track member details, membership plans (e.g., Monthly, Yearly), and membership statuses (Active, Inactive). Manage membership renewals, benefits, and discounts.
- **Guest Tracking**: Allow members to bring guests and keep records of their basic information, including contact details and relationships with the member.
- **Fitness Classes**: Manage various types of fitness classes (e.g., Yoga, Pilates, HIIT), class schedules, instructors, and member bookings. Track class statuses such as Confirmed, Canceled, and Waitlisted.
- **Personal Training Sessions**: Allow members to book training sessions with trainers who specialize in different areas (e.g., Cardio, Weight Training). Track session schedules, trainers, and workout plans.
- **Facility and Equipment Management**: Organize information about multiple gym facilities (e.g., Weight Room, Cardio Area, Swimming Pool) and associated equipment (e.g., Treadmills, Free Weights). Track equipment models, serial numbers, maintenance schedules, and locations.
- **Health Assessments**: Provide members with periodic health assessments conducted by trainers, recording metrics like Weight, BMI, Body Fat Percentage, and Fitness Goals. Track progress against set goals.
- **Attendance and Check-ins**: Monitor member and guest check-ins and check-outs, linking attendance to specific facilities or classes.
- **Billing and Payments**: Generate invoices for memberships, class bookings, personal training sessions, and other services. Track payment methods (Credit Card, Debit, Cash, Direct Debit) and statuses (Paid, Unpaid).
- **Promotions and Discounts**: Implement discount codes and track their usage across different services. Offer promotions such as percentage discounts on annual memberships or free classes for referrals.

## Components
1. **ERD and Database Design**: The Entity Relationship Diagram (ERD) and normalized database schema, with tables for members, guests, classes, trainers, payments, and more.
2. **DDL Scripts**: SQL scripts to create and populate tables, set up primary and foreign keys, and define constraints to ensure data integrity.
3. **SQL Queries**: Example queries to retrieve information from the database, such as member lists, class schedules, revenue calculations, and more.
4. **Triggers & Stored Procedures**: SQL triggers to automate certain operations (e.g., marking memberships as inactive after expiration) and stored procedures for complex operations.
5. **Use Case Diagrams**: Visual representation of the system's use cases, detailing interactions between users and the system.
6. **Gantt Chart**: A project timeline showing the development phases and group involvement in the project.

## Technologies Used
- **Database**: Oracle SQL
- **Diagram Tools**: draw.io, Lucidchart
- **Development Language**: SQL, PL/SQL

## How to Use
1. Clone the repository and navigate to the project folder.
2. Import the DDL scripts to set up the database.
3. Run the SQL queries to test functionalities.
4. Customize triggers and stored procedures as needed.

## Contribution
This project was developed by a group of four students. Each member contributed to different aspects of the system, including design, development, and testing. For details on each member's contribution, refer to the project report included in this repository.

