-- SQL-команды для создания таблиц
CREATE TABLE employees
(
	employee_id serial PRIMARY KEY,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	title varchar(255) NOT NULL,
	birth_date DATE NOT NULL,
	notes text
);

CREATE TABLE customers
(
	customer_id varchar(255) PRIMARY KEY,
	company_name varchar(255) NOT NULL,
	contact_name varchar(255)
);

CREATE TABLE orders
(
	order_id int PRIMARY KEY,
	customer_id varchar(255) REFERENCES customers(customer_id),
	employee_id serial REFERENCES employees(employee_id),
	order_date DATE NOT NULL,
	ship_city varchar(255) NOT NULL
);