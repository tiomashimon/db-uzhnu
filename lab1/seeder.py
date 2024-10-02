import psycopg2
from faker import Faker
import random

# Створюємо підключення до PostgreSQL
conn = psycopg2.connect(
    host="localhost",
    database="my_uzhnu_db",
    user="postgres",
    password="changeme"
)
cursor = conn.cursor()

# Ініціалізуємо Faker
fake = Faker()

# Заповнюємо таблицю Stud
for _ in range(17):
    cursor.execute(
        "INSERT INTO Stud (Name, Data, Fakult, Kurs, E1, E2, E3, Stip) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)",
        (fake.name(), fake.date_of_birth(minimum_age=18, maximum_age=30), fake.word(), random.randint(1, 5),
         random.randint(60, 100), random.randint(60, 100), random.randint(60, 100), random.uniform(1000, 3000))
    )

# Заповнюємо таблицю Gurt
for _ in range(7):
    cursor.execute(
        "INSERT INTO Gurt (NameG, NameK, DateZ) VALUES (%s, %s, %s)",
        (fake.word(), fake.name(), fake.date_this_century())
    )

# Отримуємо всі значення NumS та NumG для заповнення таблиці Rob_Gurt
cursor.execute("SELECT NumS FROM Stud")
student_ids = [row[0] for row in cursor.fetchall()]

cursor.execute("SELECT NumG FROM Gurt")
gurt_ids = [row[0] for row in cursor.fetchall()]

# Створюємо множину для збереження унікальних комбінацій
unique_combinations = set()

# Заповнюємо таблицю Rob_Gurt
for _ in range(20):
    while True:
        nums = random.choice(student_ids)  # Вибираємо випадковий номер студента з наявних
        numg = random.choice(gurt_ids)     # Вибираємо випадковий номер гуртка з наявних
        combination = (nums, numg)

        # Перевіряємо, чи комбінація вже існує
        if combination not in unique_combinations:
            unique_combinations.add(combination)
            cursor.execute(
                "INSERT INTO Rob_Gurt (NumS, NumG, DateP, Robota) VALUES (%s, %s, %s, %s)",
                (nums, numg, fake.date_this_year(), fake.sentence())
            )
            break

conn.commit()

cursor.close()
conn.close()