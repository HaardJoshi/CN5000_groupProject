-- Trigger: Prevent guests from having memberships
CREATE OR REPLACE TRIGGER trg_check_membership_client
BEFORE INSERT OR UPDATE ON Membership
FOR EACH ROW
DECLARE
    client_category VARCHAR2(10);
BEGIN
    -- Fetch client category to check if the client is a guest
    SELECT Client_Category INTO client_category
    FROM Clients
    WHERE Client_ID = :NEW.Client_ID;

    -- Raise an error if the client is a guest
    IF client_category = 'Guest' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Guests cannot have memberships.');
    END IF;
END trg_check_membership_client;
/

-- Trigger: Update discount usage and revenue loss in Discounts table
CREATE OR REPLACE TRIGGER trg_update_discount_usage
AFTER INSERT OR UPDATE ON Billing
FOR EACH ROW
BEGIN
    -- Update discount usage and revenue loss if a discount is applied
    IF :NEW.Discount_Applied = 'Y' AND :NEW.Discount_ID IS NOT NULL THEN
        UPDATE Discounts
        SET Usage_Count = Usage_Count + 1,
            Revenue_Loss = Revenue_Loss + :NEW.Discount_Amount
        WHERE Discount_ID = :NEW.Discount_ID;
    END IF;
END trg_update_discount_usage;
/

-- Trigger: Ensure Discount_Amount does not exceed £70
CREATE OR REPLACE TRIGGER trg_limit_discount_amount
BEFORE INSERT OR UPDATE OF Discount_Amount ON Billing
FOR EACH ROW
BEGIN
    -- Raise an error if Discount_Amount exceeds £70
    IF :NEW.Discount_Amount > 70 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Discount amount cannot exceed £70.');
    END IF;
END trg_limit_discount_amount;
/

-- Trigger: Validate Membership Start_Date and End_Date
CREATE OR REPLACE TRIGGER trg_validate_membership_dates
BEFORE INSERT OR UPDATE OF Start_Date, End_Date ON Membership
FOR EACH ROW
BEGIN
    -- Ensure End_Date is later than Start_Date
    IF :NEW.End_Date <= :NEW.Start_Date THEN
        RAISE_APPLICATION_ERROR(-20004, 'End_Date must be later than Start_Date.');
    END IF;
END trg_validate_membership_dates;
/


-- Trigger: Prevent duplicate bookings for the same class
CREATE OR REPLACE TRIGGER trg_prevent_duplicate_bookings
BEFORE INSERT OR UPDATE ON Class_Bookings
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    -- Check for confirmed duplicate bookings by the same client
    SELECT COUNT(*)
    INTO v_count
    FROM Class_Bookings
    WHERE Client_ID = :NEW.Client_ID AND Class_ID = :NEW.Class_ID AND Status = 'Confirmed';

    -- Raise error if duplicate booking exists
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20009, 'Client has already confirmed this class.');
    END IF;
END trg_prevent_duplicate_bookings;
/

-- Trigger: Ensure valid Trainer assignments
CREATE OR REPLACE TRIGGER trg_validate_trainer_assignment
BEFORE INSERT OR UPDATE ON Personal_Training_Sessions
FOR EACH ROW
DECLARE
    v_trainer_count NUMBER;
BEGIN
    -- Check if the Trainer_ID is valid and matches the 'Trainer' role
    SELECT COUNT(*)
    INTO v_trainer_count
    FROM Staff
    WHERE Staff_ID = :NEW.Trainer_ID AND Staff_Role = 'Trainer';

    -- Raise error if Trainer_ID is invalid
    IF v_trainer_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Invalid Trainer_ID: No such trainer exists.');
    END IF;
END trg_validate_trainer_assignment;
/


-- Trigger to allow null for pending transactions and raise error for null in confirmed transactions
CREATE OR REPLACE TRIGGER trg_default_transaction_id
BEFORE INSERT OR UPDATE ON Billing
FOR EACH ROW
BEGIN
    -- Allow NULL for pending transactions
    IF :NEW.Payment_Status = 'PENDING' THEN
        NULL;

    -- Raise error if Transaction_ID is NULL for confirmed transactions
    ELSIF :NEW.Payment_Status = 'CONFIRMED' AND :NEW.Transaction_ID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20012, 'Transaction_ID cannot be NULL for confirmed transactions.');

    -- Default Transaction_ID to -1 for Cash payments
    ELSIF :NEW.Payment_Method = 'Cash' AND :NEW.Transaction_ID IS NULL THEN
        :NEW.Transaction_ID := -1;

    -- Raise error for other cases with NULL Transaction_ID
    ELSIF :NEW.Transaction_ID IS NULL THEN
        RAISE_APPLICATION_ERROR(-20013, 'Transaction_ID cannot be NULL for this payment method or status.');
    END IF;
END trg_default_transaction_id;
/


-- Trigger to increment gym_visits every time the client registers check_in in gym_attendance
CREATE OR REPLACE TRIGGER IncrementGymVisits
AFTER INSERT ON Gym_Attendance
FOR EACH ROW
BEGIN
    -- Update the Gym_Visits column in the Clients table
    UPDATE Clients
    SET Gym_Visits = Gym_Visits + 1
    WHERE Client_ID = :NEW.Client_ID;
END IncrementGymVisits;
/

-- Trigger to prevent class booking if client's membership is inactive
CREATE OR REPLACE TRIGGER prevent_class_booking_inactive_membership
BEFORE INSERT ON Class_Bookings
FOR EACH ROW
DECLARE
    v_membership_status VARCHAR2(20);
BEGIN
    -- Check client's membership status before booking
    SELECT Status
    INTO v_membership_status
    FROM Membership
    WHERE Client_ID = :NEW.Client_ID;

    -- Prevent booking if membership is inactive
    IF v_membership_status = 'Inactive' 
        THEN RAISE_APPLICATION_ERROR(-20001, 'Cannot make a booking. Client membership is inactive.');
    END IF;
END prevent_class_booking_inactive_membership;
/
