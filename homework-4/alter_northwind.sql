-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CHECK(unit_price > 0);

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CHECK(discontinued in (0, 1));

-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
CREATE TABLE discontinued_products
(
	product_id smallint PRIMARY KEY,
	product_name varchar(40),
	supplier_id smallint REFERENCES suppliers(supplier_id),
	category_id smallint REFERENCES categories(category_id),
	quantity_per_unit varchar(20),
	unit_price real,
	units_in_stock smallint,
	units_on_order smallint,
	reorder_level smallint
);
INSERT INTO discontinued_products (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, units_on_order, reorder_level)
SELECT product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, units_on_order, reorder_level
FROM products
WHERE discontinued = 1;

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
ALTER TABLE order_details DROP CONSTRAINT product_id;
ALTER TABLE order_details ADD CONSTRAINT product_id
FOREIGN KEY fk_order_details_products ON DELETE CASCADE;
DELETE FROM products
WHERE discontinued = 1;