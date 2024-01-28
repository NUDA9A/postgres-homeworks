"""Скрипт для заполнения данными таблиц в БД Postgres."""
import psycopg2
import csv
import north_data

conn = psycopg2.connect(
    host='localhost',
    database='north',
    user='postgres',
    password='3525'
)

cur = conn.cursor()

with open('./north_data/customers_data.csv', 'r', newline='') as customer_data:
    reader = csv.DictReader(customer_data)
    for row in reader:
        cur.execute('INSERT INTO customers VALUES (%s, %s, %s)', (row['customer_id'],
                                                                  row['company_name'],
                                                                  row['contact_name']))

with open('./north_data/employees_data.csv', 'r', newline='') as employees_data:
    reader = csv.DictReader(employees_data)
    for row in reader:
        cur.execute('INSERT INTO employees VALUES (%s, %s, %s, %s, %s, %s)', (row['employee_id'], row['first_name'],
                                                                              row['last_name'], row['title'],
                                                                              row['birth_date'], row['notes']))

with open('./north_data/orders_data.csv', 'r', newline='') as orders_data:
    reader = csv.DictReader(orders_data)
    for row in reader:
        cur.execute('INSERT INTO orders VALUES (%s, %s, %s, %s, %s)', (row['order_id'], row['customer_id'],
                                                                       row['employee_id'], row['order_date'],
                                                                       row['ship_city']))

conn.commit()
cur.close()
conn.close()
