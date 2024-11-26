# Database Trigger Documentation

This document outlines the purpose and functionality of the triggers implemented in the fitness center database.

---

## **1. Membership Triggers**

### **Trigger: `trg_check_membership_client`**
**Purpose**: Prevents guests from obtaining memberships.  
**Logic**:
- Checks the `Client_Category` of the `Client_ID` being added or updated.
- If the category is "Guest," the operation is blocked.

---

### **Trigger: `trg_validate_membership_dates`**
**Purpose**: Ensures that the `End_Date` of a membership is later than the `Start_Date`.  
**Logic**:
- Compares `End_Date` and `Start_Date` during insertion or update.
- Throws an error if `End_Date` is earlier or equal to `Start_Date`.

---

### **Trigger: `trg_update_membership_status`**
**Purpose**: Automatically marks memberships as `Inactive` when the `End_Date` has passed.  
**Logic**:
- Checks the `End_Date` during insertion or update.
- Updates `Status` to `Inactive` if `End_Date` is earlier than the current date.

---

### **Trigger: `trg_prevent_past_dates`**
**Purpose**: Ensures that memberships cannot be created or updated with past dates.  
**Logic**:
- Prevents `Start_Date` and `End_Date` from being set to a past date.

---

## **2. Billing Triggers**

### **Trigger: `trg_check_billing_client`**
**Purpose**: Prevents guests from being billed.  
**Logic**:
- Checks the `Client_Category` of the `Client_ID` in the `Billing` table.
- Blocks the transaction if the client is categorized as "Guest."

---

### **Trigger: `trg_default_transaction_id`**
**Purpose**: Assigns a default `Transaction_ID` for cash payments.  
**Logic**:
- If `Payment_Method` is "Cash" and `Transaction_ID` is not provided, assigns a default value of `-1`.

---

### **Trigger: `trg_update_discount_usage`**
**Purpose**: Tracks discount usage and updates revenue loss in the `Discounts` table.  
**Logic**:
- If a discount is applied, increments `Usage_Count` and updates `Revenue_Loss` based on `Discount_Amount`.

---

### **Trigger: `trg_limit_discount_amount`**
**Purpose**: Ensures the applied `Discount_Amount` does not exceed £70.  
**Logic**:
- Validates `Discount_Amount` during insertion or update.
- Blocks the transaction if the amount exceeds £70.

---

## **3. Class Booking Triggers**

### **Trigger: `trg_update_max_capacity`**
**Purpose**: Dynamically updates the `Max_Capacity` of classes based on booking status.  
**Logic**:
- **Confirmed Bookings**: Decrements `Max_Capacity`.
- **Waitlisted Bookings**: Decrements `Max_Capacity`.
- **Canceled Bookings**: Increments `Max_Capacity`.
- Ensures capacity does not drop below zero.

---

### **Trigger: `trg_prevent_duplicate_bookings`**
**Purpose**: Prevents duplicate confirmed bookings for the same class by a single client.  
**Logic**:
- Checks if a confirmed booking already exists for the `Client_ID` and `Class_ID`.
- Blocks duplicate entries.

---

## **4. Training Triggers**

### **Trigger: `trg_validate_trainer_assignment`**
**Purpose**: Ensures trainers assigned to classes are valid staff members with the role of "Trainer."  
**Logic**:
- Checks if the `Trainer_ID` exists and has the role of "Trainer."
- Blocks the assignment if no valid trainer is found.

---

## **5. Fitness Class Triggers**

### **Trigger: `trg_check_instructor_schedule`**
**Purpose**: Prevents scheduling conflicts for instructors.  
**Logic**:
- Checks for overlapping schedules for the same instructor.
- Blocks the transaction if a conflict is detected.

---

## **Error Codes**

| Error Code | Description                                               |
|------------|-----------------------------------------------------------|
| -20001     | Guests cannot have memberships.                           |
| -20002     | Guests cannot be billed.                                  |
| -20003     | Discount amount cannot exceed £70.                        |
| -20004     | End_Date must be later than Start_Date.                   |
| -20005     | Cannot confirm booking: Class is full.                    |
| -20006     | Cannot waitlist booking: Class is full.                   |
| -20007     | Start_Date cannot be in the past.                         |
| -20008     | End_Date cannot be in the past.                           |
| -20009     | Client has already confirmed this class.                  |
| -20010     | Invalid Trainer_ID: No such trainer exists.               |
| -20011     | Instructor has a scheduling conflict.                     |

---

## **Future Considerations**
- Add triggers to ensure proper cascading deletes or updates when clients, classes, or trainers are removed.
- Monitor performance overhead due to triggers in high-traffic tables.

---

**Author**: [Your Name]  
**Date**: [Date of Documentation]
