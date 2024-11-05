-- Table for members information
CREATE TABLE MEMBERS (
    MEMBER_ID NUMBER(9) PRIMARY KEY NOT NULL,               -- Unique ID for each member
    FNAME VARCHAR2(25) NOT NULL,                            -- Member's first name
    LNAME VARCHAR2(25) NOT NULL,                            -- Member's last name
    ADDRESS VARCHAR2(80),                                   -- Member's address
    SEX CHAR(1),                                            -- Gender (M/F)
    EMAIL VARCHAR2(320) NOT NULL,                           -- Email address
    CONTACT NUMBER(11),                                     -- Contact number
    EMERGENCY_CONTACT NUMBER(11)                            -- Emergency contact number
);

-- Table for health assessments
CREATE TABLE HEALTH_ASSESSMENTS (
    ASSESSMENT_ID NUMBER(9) PRIMARY KEY NOT NULL,           -- Unique ID for assessment
    WEIGHT NUMBER(4,2),                                     -- Weight in kg
    ASSESSMENT_DATE DATE,                                   -- Date of assessment
    BMI NUMBER(4,2),                                        -- Body Mass Index
    MEMBER_ID NUMBER(9)                                     -- Member ID for assessment
);

-- Table for equipment rental details
CREATE TABLE EQUIPMENT_RENTAL (
    EQUIPMENT_ID NUMBER(9) PRIMARY KEY NOT NULL,            -- Unique ID for equipment
    EQ_MODEL VARCHAR2(30),                                  -- Equipment model
    SERIAL_NUMBER NUMBER(9),                                -- Equipment serial number
    MAINTENANCE_SCHEDULE VARCHAR2(30)                       -- Maintenance schedule details
);

-- Table for guests linked to members
CREATE TABLE CLIENTS_GUESTS (
    GUEST_ID NUMBER(9) PRIMARY KEY NOT NULL,                -- Unique ID for each guest
    MEMBER_ID NUMBER(9) NOT NULL,                           -- ID of the member who invited the guest
    F_NAME VARCHAR2(25) NOT NULL,                           -- Guest's first name
    L_NAME VARCHAR2(25),                                    -- Guest's last name
    ADDRESS VARCHAR2(80),                                   -- Guest's address
    RELATION VARCHAR2(25) NOT NULL,                         -- Relation to member
    CONTACT_NO NUMBER(10)                                   -- Guest's contact number
);

-- Table to track gym attendance
CREATE TABLE GYM_ATTENDENCE (
    MEMBER_ID NUMBER(9) NOT NULL,                           -- Member ID for attendance
    CHECK_IN DATE NOT NULL,                                 -- Check-in date and time
    CHECK_OUT DATE,                                         -- Check-out date and time
    CENTRE_ID NUMBER(9),                                    -- Fitness center ID
    GUEST_ID NUMBER(9),                                     -- Guest ID if a guest attended with member
    PRIMARY KEY (MEMBER_ID, CHECK_IN)
);

-- Table to store payment details
CREATE TABLE PAYMENTS (
    PAYMENT_ID NUMBER(9) PRIMARY KEY NOT NULL,              -- Unique ID for payment
    MEMBER_ID NUMBER(9) NOT NULL,                           -- Member ID related to payment
    AMOUNT NUMBER(6) NOT NULL,                              -- Payment amount
    PAYMENT_DATE DATE,                                      -- Date of payment
    PAYMENT_METHOD VARCHAR2(25)                             -- Method of payment
);

-- Table to store membership details
CREATE TABLE MEMBERSHIP (
    MEMBERSHIP_ID NUMBER(9) PRIMARY KEY NOT NULL,           -- Unique ID for membership
    PLAN_ID NUMBER(9) NOT NULL,                             -- ID of the membership plan
    START_DATE DATE,                                        -- Membership start date
    END_DATE DATE,                                          -- Membership end date
    STATUS NUMBER(1) CHECK (STATUS IN (0,1))                -- Status of membership (active/inactive)
);

-- Table for fitness center information
CREATE TABLE FITNESS_CENTRE (
    CENTRE_ID NUMBER(9) PRIMARY KEY NOT NULL,               -- Unique ID for fitness center
    F_NAME VARCHAR2(25) NOT NULL,                           -- Center manager's first name
    L_NAME VARCHAR2(25),                                    -- Center manager's last name
    C_LOCATION VARCHAR2(30),                                -- Center location
    FACILITY VARCHAR2(30)                                   -- Facilities available
);

-- Table for membership plan details
CREATE TABLE MEMBERSHIP_PLANS (
    PLAN_ID NUMBER(9) PRIMARY KEY NOT NULL,                 -- Unique ID for membership plan
    PLAN_NAME VARCHAR2(30) NOT NULL,                        -- Plan name
    BENEFITS VARCHAR2(80),                                  -- Plan benefits
    RENEWAL_DATE DATE,                                      -- Plan renewal date
    PRICE DECIMAL(10, 2)                                    -- Plan price
);

-- Table for promotional offers
CREATE TABLE PROMOTIONS (
    PROMOTION_ID NUMBER(9) PRIMARY KEY NOT NULL,            -- Unique ID for promotion
    P_TYPE VARCHAR2(30) NOT NULL,                           -- Promotion type
    DISCOUNT DECIMAL(10, 2) NOT NULL                        -- Discount amount
);

-- Table for invoices
CREATE TABLE INVOICES (
    INVOICE_ID NUMBER(9) PRIMARY KEY NOT NULL,              -- Unique ID for invoice
    PAYMENT_ID VARCHAR2(30) NOT NULL,                       -- Payment ID related to invoice
    SERVICES VARCHAR2(30)                                   -- Services listed on invoice
);

-- Table for personal training sessions
CREATE TABLE PERSONAL_TRAINING_SESSIONS (
    SESSION_ID NUMBER(9) PRIMARY KEY NOT NULL,              -- Unique ID for training session
    DATE_TIME TIMESTAMP NOT NULL,                           -- Date and time of session
    DURATION INTERVAL DAY TO SECOND NOT NULL,               -- Duration of session
    TRAINER_ID NUMBER(9) NOT NULL,                          -- Trainer ID for the session
    MEMBER_ID NUMBER(9) NOT NULL,                           -- Member ID for the session
    SESSION_STATUS VARCHAR2(30),                            -- Status of session
    WORKOUT_ID NUMBER(9) NOT NULL                           -- Workout plan ID associated with session
);

-- Table for fitness classes
CREATE TABLE FITNESS_CLASS (
    CLASS_ID NUMBER(9) PRIMARY KEY NOT NULL,                -- Unique ID for fitness class
    CENTRE_ID NUMBER(9) NOT NULL,                           -- Fitness center where the class is held
    STAFF_ID NUMBER(9) NOT NULL,                            -- Staff ID of the instructor
    FITNESS_CLASS_TYPE VARCHAR2(30) NOT NULL,               -- Type of fitness class
    DURATION INTERVAL DAY TO SECOND,                        -- Duration of class
    WORKOUT_ID NUMBER(9) NOT NULL                           -- Workout plan ID used in class
);

-- Table for workshops
CREATE TABLE WORKSHOPS (
    WORKSHOP_ID NUMBER(9) PRIMARY KEY NOT NULL,             -- Unique ID for workshop
    MEMBER_ID NUMBER(9) NOT NULL,                           -- Member attending the workshop
    INSTRUCTOR_ID NUMBER(9) NOT NULL,                       -- Instructor of the workshop
    CENTRE_ID NUMBER(9) NOT NULL,                           -- Fitness center holding the workshop
    WORKSHOP_DATE DATE                                      -- Date of the workshop
);

-- Table for staff information
CREATE TABLE STAFF (
    STAFF_ID NUMBER(9) NOT NULL,                            -- Unique ID for staff member
    FIRST_NAME VARCHAR2(25) NOT NULL,                       -- Staff member's first name
    LAST_NAME VARCHAR2(25) NOT NULL,                        -- Staff member's last name
    SEX CHAR(1),                                            -- Gender
    ADDRESS VARCHAR2(80),                                   -- Staff member's address
    ROLE VARCHAR2(30) NOT NULL,                             -- Role of staff member
    EMAIL VARCHAR2(320),                                    -- Staff email
    CONTACT_NUMBER NUMBER(11),                              -- Contact number
    EMERGENCY_CONTACT NUMBER(11),                           -- Emergency contact number
    SALARY NUMBER(6),                                       -- Salary of staff member
    PRIMARY KEY (STAFF_ID, ROLE)
);

-- Table for workout plans
CREATE TABLE WORKOUT_PLANS (
    WORKOUT_PLAN_ID NUMBER(9) PRIMARY KEY NOT NULL,         -- Unique ID for workout plan
    MEMBER_ID NUMBER(9),                                    -- ID of member using the workout plan
    STAFF_ID NUMBER(9),                                     -- Staff ID of trainer who created the plan
    CENTRE_ID NUMBER(9),                                    -- Fitness center where plan is implemented
    PLAN_DATE DATE,                                         -- Date of workout plan creation
    EXERCISE VARCHAR2(30),                                  -- Exercise details
    WORKOUT_REPS NUMBER(2),                                 -- Repetitions in workout
    WORKOUT_SETS NUMBER(2)                                  -- Sets in workout
);

-- Add foreign keys to the MEMBERS table
ALTER TABLE CLIENTS_GUESTS
ADD CONSTRAINT fk_member
FOREIGN KEY (MEMBER_ID) REFERENCES MEMBERS(MEMBER_ID);

ALTER TABLE GYM_ATTENDANCE
ADD CONSTRAINT fk_member_attendance
FOREIGN KEY (MEMBER_ID) REFERENCES MEMBERS(MEMBER_ID);

ALTER TABLE PAYMENTS
ADD CONSTRAINT fk_member_payments
FOREIGN KEY (MEMBER_ID) REFERENCES MEMBERS(MEMBER_ID);

ALTER TABLE MEMBERSHIP
ADD CONSTRAINT fk_plan_membership
FOREIGN KEY (PLAN_ID) REFERENCES MEMBERSHIP_PLANS(PLAN_ID);

ALTER TABLE PERSONAL_TRAINING_SESSIONS
ADD CONSTRAINT fk_member_training
FOREIGN KEY (MEMBER_ID) REFERENCES MEMBERS(MEMBER_ID);

ALTER TABLE PERSONAL_TRAINING_SESSIONS
ADD CONSTRAINT fk_trainer
FOREIGN KEY (TRAINER_ID) REFERENCES STAFF(STAFF_ID);

ALTER TABLE FITNESS_CLASS
ADD CONSTRAINT fk_centre_class
FOREIGN KEY (CENTRE_ID) REFERENCES FITNESS_CENTRE(CENTRE_ID);

ALTER TABLE FITNESS_CLASS
ADD CONSTRAINT fk_staff_class
FOREIGN KEY (STAFF_ID) REFERENCES STAFF(STAFF_ID);

ALTER TABLE WORKSHOPS
ADD CONSTRAINT fk_member_workshop
FOREIGN KEY (MEMBER_ID) REFERENCES MEMBERS(MEMBER_ID);

ALTER TABLE WORKSHOPS
ADD CONSTRAINT fk_instructor
FOREIGN KEY (INSTRUCTOR_ID) REFERENCES STAFF(STAFF_ID);

ALTER TABLE WORKSHOPS
ADD CONSTRAINT fk_centre_workshop
FOREIGN KEY (CENTRE_ID) REFERENCES FITNESS_CENTRE(CENTRE_ID);

ALTER TABLE GYM_ATTENDANCE
ADD CONSTRAINT fk_centre_attendance
FOREIGN KEY (CENTRE_ID) REFERENCES FITNESS_CENTRE(CENTRE_ID);

ALTER TABLE EQUIPMENT_RENTAL
ADD CONSTRAINT fk_equipment
FOREIGN KEY (EQUIPMENT_ID) REFERENCES EQUIPMENT_RENTAL(EQUIPMENT_ID);

-- Relationships between tables:
-- MEMBERS and HEALTH_ASSESSMENTS are related by MEMBER_ID (1-to-many)
-- MEMBERS and CLIENTS_GUESTS are related by MEMBER_ID (1-to-many)
-- MEMBERS and GYM_ATTENDENCE are related by MEMBER_ID (1-to-many)
-- MEMBERS and PAYMENTS are related by MEMBER_ID (1-to-many)
-- MEMBERS and PERSONAL_TRAINING_SESSIONS are related by MEMBER_ID (1-to-many)
-- MEMBERS and WORKOUT_PLANS are related by MEMBER_ID (1-to-many)
-- FITNESS_CENTRE and GYM_ATTENDENCE are related by CENTRE_ID (1-to-many)
-- FITNESS_CENTRE and FITNESS_CLASS are related by CENTRE_ID (1-to-many)
-- FITNESS_CENTRE and WORKSHOPS are related by CENTRE_ID (1-to-many)
-- STAFF and FITNESS_CLASS are related by STAFF_ID (1-to-many)
-- STAFF and PERSONAL_TRAINING_SESSIONS are related by TRAINER_ID (1-to-many)
-- STAFF and WORKOUT_PLANS are related by STAFF_ID (1-to-many)
-- STAFF and WORKSHOPS are related by INSTRUCTOR_ID (1-to-many)
-- MEMBERSHIP and MEMBERSHIP_PLANS are related by PLAN_ID (1-to-many)

