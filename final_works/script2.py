import random
from faker import Faker
import datetime

faker = Faker("en_GB")  # For UK-specific data

def random_4_digit_id():
    """Generate a random 4-digit ID."""
    return random.randint(1000, 9999)

def create_insert_statement(table_name, data):
    """Generate SQL INSERT statement for the given table and data."""
    columns = ", ".join(data.keys())
    values = ", ".join(
        [f"'{value}'" if isinstance(value, str) else str(value) for value in data.values()]
    )
    return f"INSERT INTO {table_name} ({columns}) VALUES ({values});"

# Generate data for Class_Bookings table
def generate_class_bookings(client_ids, fitness_class_ids):
    statuses = ["Confirmed", "Canceled", "Waitlisted"]
    bookings = []
    for _ in range(15):
        bookings.append({
            "Booking_ID": random_4_digit_id(),
            "Class_ID": random.choice(fitness_class_ids),
            "Client_ID": random.choice(client_ids),
            "Status": random.choice(statuses)
        })
    return bookings

# Generate data for Billing table
def generate_billings(client_ids, discounts):
    payment_methods = ["Credit Card", "Debit Card", "Cash", "Direct Debit"]
    billings = []
    for _ in range(15):
        client_id = random.choice(client_ids)
        discount = random.choice(discounts + [None])  # Occasionally no discount applied
        discount_applied = "Y" if discount else "N"
        discount_amount = round(random.uniform(0, 70), 2) if discount else 0.00
        billings.append({
            "Billing_ID": random_4_digit_id(),
            "Transaction_ID": random.randint(100000, 999999) if discount_applied == "N" else None,
            "Client_ID": client_id,
            "Amount": round(random.uniform(10, 500), 2),
            "Billing_Date_Time": faker.date_time_this_year(),
            "Payment_Method": random.choice(payment_methods),
            "Payment_Status": random.choice(["CONFIRMED", "PENDING"]),
            "Discount_Applied": discount_applied,
            "Discount_Amount": discount_amount,
            "Discount_ID": discount if discount else None
        })
    return billings

# Data Setup
def main():
    # Placeholder for foreign key values
    client_ids = [random.randint(1000, 9999) for _ in range(20)]  # Assume 20 clients
    fitness_class_ids = [random.randint(1000, 9999) for _ in range(10)]  # Assume 10 fitness classes
    discount_ids = [random.randint(1000, 9999) for _ in range(4)]  # Assume 4 discount records

    # Generate data
    class_bookings = generate_class_bookings(client_ids, fitness_class_ids)
    billings = generate_billings(client_ids, discount_ids)

    # Generate SQL Statements
    sql_statements = []
    for record in class_bookings:
        sql_statements.append(create_insert_statement("Class_Bookings", record))
    for record in billings:
        sql_statements.append(create_insert_statement("Billing", record))

    # Write to output file
    with open("output2.sql", "w") as file:
        file.write("\n".join(sql_statements))

if __name__ == "__main__":
    main()
