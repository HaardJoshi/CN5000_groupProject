CREATE TABLE MEMBERS
(
    MEMBER_ID NUMBER(9) NOT NULL,
    FNAME VARCHAR2(25) NOT NULL,
    LNAME VARCHAR2(25) NOT NULL,
    ADDRESS VARCHAR2(80) ,
    SEX CHAR(1) NULL,
    EMAIL VARCHAR(320) NOT NULL,
    CONTACT NUMBER(11),
    EMERGENCY_CONTACT NUMBER(11),
    PRIMARY KEY (MEMBER_ID)
);

CREATE TABLE HEALTH_ASSESSMENTS
(
    ASSESSMENT_ID NUMBER(9) NOT NULL,
    WEIGHT NUMBER(4,2),
    ASSESSMENT_DATE DATE,
    BMI NUMBER (4,2),
    PRIMARY KEY (ASSESSMENT_ID)
);

CREATE TABLE EQUIPMENT_RENTAL
(
    EQUIPMENT_ID NUMBER(9) NOT NULL,
    EQ_MODEL VARCHAR2(30),
    SERIAL_NUMBER NUMBER(9),
    MAINTENANCE_SCHEDULE VARCHAR2(30),
    PRIMARY KEY (EQUIPMENT_ID)
);

CREATE TABLE CLIENTS_GUESTS
(
  GUEST_ID      NUMBER(9) PRIMARY KEY NOT NULL,
  MEMBER_ID     NUMBER(9) NOT NULL,
  F_NAME        VARCHAR2(25) NOT NULL,
  L_NAME        VARCHAR2(25),
  ADDRESS       VARCHAR2(80),
  RELATION      VARCHAR2(25) NOT NULL,
  CONTACT_NO    NUMBER(10)
);

CREATE TABLE GYM_ATTENDENCE(
  MEMBER_ID     NUMBER(9) NOT NULL,
  CHECK_IN      DATE NOT NULL,
  CHECK_OUT     DATE,
  CENTRE_ID     NUMBER(9),
  GUEST_ID      NUMBER(9),
  PRIMARY KEY (MEMBER_ID, CHECK_IN)
);

CREATE TABLE PAYMENTS(
  PAYMENT_ID    NUMBER(9) PRIMARY KEY NOT NULL,
  MEMBER_ID     NUMBER(9) NOT NULL,
  AMOUNT        NUMBER(6) NOT NULL,
  PAYMENT_DATE  DATE,
  PAYMENT_METHOD  VARCHAR2(25)
);

CREATE TABLE MEMBERSHIP(
  MEMBERSHIP_ID NUMBER(9) PRIMARY KEY NOT NULL,
  PLAN_ID       NUMBER(9) NOT NULL,
  START_DATE    DATE,
  END_DATE      DATE,
  STATUS        NUMBER(1) CHECK (STATUS IN (0,1))
);

CREATE TABLE FITNESS_CENTRE
(
    CENTRE_ID NUMBER(9) PRIMARY KEY NOT NULL,
    F_NAME VARCHAR2(25) NOT NULL,
    L_NAME VARCHAR2(25),
    C_LOCATION VARCHAR2(30),
    FACILITY VARCHAR2(30)
);

CREATE TABLE MEMBERSHIP_PLANS
(
    PLAN_ID NUMBER(9) PRIMARY KEY NOT NULL,
    PLAN_NAME VARCHAR2(30) NOT NULL,
    BENEFITS VARCHAR2(80),
    RENEWAL_DATE DATE,
    PRICE DECIMAL(10, 2)
);

CREATE TABLE PROMOTIONS
(
    PROMOTION_ID NUMBER(9) PRIMARY KEY NOT NULL,
    P_TYPE VARCHAR2(30) NOT NULL,
    DISCOUNT DECIMAL(10, 2) NOT NULL
);

CREATE TABLE INVOICES
(
    INVOICE_ID NUMBER(9) PRIMARY KEY NOT NULL,
    PAYMENT_ID VARCHAR2(30) NOT NULL,
    SERVICES VARCHAR2(30)
);

CREATE TABLE PERSONAL_TRAINING_SESSIONS
(
    SESSION_ID NUMBER(9) PRIMARY KEY NOT NULL,
    DATE_TIME TIMESTAMP NOT NULL,
    DURATION INTERVAL DAY TO SECOND NOT NULL,
    TRAINER_ID NUMBER(9) NOT NULL,
    MEMBER_ID NUMBER(9) NOT NULL,
    SESSION_STATUS VARCHAR2(30),
    WORKOUT_ID NUMBER(9) NOT NULL
);

CREATE TABLE FITNESS_CLASS(
    CLASS_ID NUMBER(9),
    CENTRE_ID NUMBER(9),
    STAFF_ID NUMBER(9),
    FITNESS_CLASS_TYPE VARCHAR2(30) NOT NULL,
    DURATION TIMESTAMP,
    WORKOUT_ID NUMBER(9),
    PRIMARY KEY (CLASS_ID)
);

CREATE TABLE WORKSHOPS(
    WORKSHOP_ID NUMBER(9) NOT NULL,
    MEMBER_ID NUMBER(9) NOT NULL,
    INSTRUCTOR_ID NUMBER(9) NOT NULL,
    CENTRE_ID VARCHAR2(80),
    WORKSHOP_DATE DATE,
    PRIMARY KEY (WORKSHOP_ID)
);

CREATE TABLE STAFF(
    STAFF_ID NUMBER(9) NOT NULL,
    FIRST_NAME VARCHAR2(25) NOT NULL,
    LAST_NAME VARCHAR2(25) NOT NULL,
    SEX VARCHAR2(30),
    ADDRESS VARCHAR2(80),
    ROLE VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(320),
    CONTACT_NUMBER NUMBER(11),
    EMERGENCY_CONTACT NUMBER(11),
    SALARY NUMBER(6),
    PRIMARY KEY (STAFF_ID, ROLE)
);

CREATE TABLE WORKOUT_PLANS(
    WORKOUT_PLAN_ID NUMBER(9) NOT NULL,
    MEMBER_ID NUMBER(9),
    STAFF_ID NUMBER(9),
    CENTRE_ID NUMBER(9),
    PLAN_DATE DATE,
    PLAN_TIME TIMESTAMP,
    EXERCISE VARCHAR2(30),
    WORKOUT_REPS NUMBER(2),
    WORKOUT_SETS NUMBER(2),
    PRIMARY KEY (WORKOUT_PLAN_ID)
)