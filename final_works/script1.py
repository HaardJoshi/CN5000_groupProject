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

# Generate data for Clients table
def generate_clients():
    relationships = ["Spouse", "Child", "Sibling", "Friend", "Parent", None]
    clients = []
    for _ in range(20):
        clients.append({
            "Client_ID": random_4_digit_id(),
            "First_Name": faker.first_name(),
            "Last_Name": faker.last_name(),
            "Client_Category": random.choice(["Member", "Guest"]),
            "Relationship": random.choice(relationships),
            "Contact": faker.phone_number(),
            "Emergency_Contact": faker.phone_number(),
            "Email": faker.email(),
            "Address": faker.address().replace("\n", ", "),
        })
    return clients

# Generate data for Membership table
def generate_memberships(client_ids):
    memberships = []
    for _ in range(15):
        client_id = random.choice(client_ids)
        start_date = faker.date_this_year()
        end_date = start_date + datetime.timedelta(days=random.randint(30, 365))
        memberships.append({
            "Membership_ID": random_4_digit_id(),
            "Client_ID": client_id,
            "Plan_Type": random.choice(["Silver", "Gold", "Platinum"]),
            "Start_Date": start_date,
            "End_Date": end_date,
            "Status": "Active" if end_date > datetime.date.today() else "Inactive",
            "Price": round(random.uniform(50, 500), 2)
        })
    return memberships

# Generate data for Fitness_Classes table
def generate_fitness_classes(staff_ids):
    class_types = ["Aerobic Fitness", "Strength Training", "Core Exercises",
                   "Balance Training", "Flexibility and Stretching"]
    class_names = ["Cardio", "AMRAP", "Bodyweight", "HIIT", "Outdoor", "TRX"]
    fitness_classes = []
    for _ in range(10):
        fitness_classes.append({
            "Class_ID": random_4_digit_id(),
            "Class_Name": random.choice(class_names),
            "Class_Type": random.choice(class_types),
            "Schedule": faker.date_time_this_month(),
            "Instructor_ID": random.choice(staff_ids),
            "Max_Capacity": random.randint(10, 30)
        })
    return fitness_classes

# Generate data for Discounts table
def generate_discounts():
    discounts = []
    discount_codes = [str(random.randint(1000000000, 9999999999)) for _ in range(4)]
    for i in range(4):
        discounts.append({
            "Discount_ID": random_4_digit_id(),
            "Discount_Type": random.choice(["Promotion", "Referral"]),
            "Discount_Code": discount_codes[i],
            "Usage_Count": 0,
            "Revenue_Loss": 0.00
        })
    return discounts

# Generate data for other tables
def generate_training(client_ids, staff_ids):
    training = []
    for _ in range(10):
        training.append({
            "Training_ID": random_4_digit_id(),
            "Client_ID": random.choice(client_ids),
            "Trainer_ID": random.choice(staff_ids),
            "Session_Schedule": faker.date_time_this_year(),
            "Workout_Details": faker.text(max_nb_chars=200)
        })
    return training

def generate_health_assessments(client_ids, staff_ids):
    assessments = []
    for _ in range(10):
        assessments.append({
            "Assessment_ID": random_4_digit_id(),
            "Client_ID": random.choice(client_ids),
            "Trainer_ID": random.choice(staff_ids),
            "Assessment_Time": faker.date_time_this_year(),
            "Weight": round(random.uniform(50, 100), 2),
            "BMI": round(random.uniform(18.5, 30), 2),
            "Body_Fat_Percentage": round(random.uniform(10, 40), 2)
        })
    return assessments

def generate_gym_attendance(client_ids, facility_ids):
    attendance = []
    for _ in range(10):
        attendance.append({
            "Attendance_ID": random_4_digit_id(),
            "Client_ID": random.choice(client_ids),
            "Check_in": faker.date_time_this_month(),
            "Check_out": faker.date_time_this_month(),
            "Facility_ID": random.choice(facility_ids)
        })
    return attendance

def generate_equipment_rentals(client_ids, facility_ids):
    equipment_models = ["Treadmill", "Rowing Machine", "Exercise Bike", "Elliptical",
                        "Dumbbells", "Barbells", "Kettlebells", "Pull-up Bars",
                        "Resistance Bands", "Medicine Balls"]
    rentals = []
    for _ in range(10):
        rentals.append({
            "Rental_ID": random_4_digit_id(),
            "Facility_ID": random.choice(facility_ids),
            "Equipment_SNo": random.randint(100, 999),
            "Equipment_Model": random.choice(equipment_models),
            "Client_ID": random.choice(client_ids),
            "Rental_Date": faker.date_this_year(),
            "Return_Date": faker.date_this_year(),
            "Maintenance_Schedule": faker.date_this_year()
        })
    return rentals

# Main Execution
clients = generate_clients()
client_ids = [client["Client_ID"] for client in clients]

staff = [{"Staff_ID": random_4_digit_id(), "First_Name": faker.first_name(),
          "Last_Name": faker.last_name(), "Staff_Role": random.choice(["Trainer", "Instructor"]),
          "Specialization": random.choice(["Cardio", "Strength", "Flexibility"]),
          "Contact": faker.phone_number(), "Emergency_Contact": faker.phone_number(),
          "Salary": round(random.uniform(20000, 50000), 2)} for _ in range(10)]
staff_ids = [staff["Staff_ID"] for staff in staff]

facilities = [{"Facility_ID": random_4_digit_id(), "Facility_Name": f"Facility {i+1}",
               "Facility_Location": faker.city()} for i in range(5)]
facility_ids = [facility["Facility_ID"] for facility in facilities]

fitness_classes = generate_fitness_classes(staff_ids)
memberships = generate_memberships(client_ids)
discounts = generate_discounts()
training = generate_training(client_ids, staff_ids)
health_assessments = generate_health_assessments(client_ids, staff_ids)
gym_attendance = generate_gym_attendance(client_ids, facility_ids)
equipment_rentals = generate_equipment_rentals(client_ids, facility_ids)

# SQL Generation
sql_statements = []

for table_data, table_name in [
    (clients, "Clients"), (staff, "Staff"), (facilities, "Facilities"),
    (fitness_classes, "Fitness_Classes"), (memberships, "Membership"),
    (discounts, "Discounts"), (training, "Training"),
    (health_assessments, "Health_Assessments"), (gym_attendance, "Gym_Attendance"),
    (equipment_rentals, "Equipment_Rentals")
]:
    for record in table_data:
        sql_statements.append(create_insert_statement(table_name, record))

# Write to file
with open("output.sql", "w") as file:
    file.write("\n".join(sql_statements))
