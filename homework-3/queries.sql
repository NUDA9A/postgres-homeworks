-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT customers.company_name AS customer, CONCAT(employees.last_name, ' ', employees.first_name) AS employee
FROM orders
INNER JOIN customers USING(customer_id)
INNER JOIN employees USING(employee_id)
WHERE employees.city = 'London' and customers.city = 'London' and ship_via = 2;

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT p.product_name, p.units_in_stock, s.contact_name, s.phone
FROM products AS p
INNER JOIN suppliers AS s USING(supplier_id)
INNER JOIN categories AS c USING(category_id)
WHERE p.discontinued = 0 and p.units_in_stock < 25 and (c.category_name = 'Dairy Products' or c.category_name = 'Condiments')
ORDER BY p.units_in_stock;

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT customers.company_name FROM customers
LEFT JOIN orders USING(customer_id)
WHERE orders.customer_id is NULL;

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT products.product_name AS p_name
FROM products
WHERE product_name IN (
	SELECT products.product_name
	FROM products
	INNER JOIN order_details USING(product_id)
	WHERE order_details.quantity = 10
);