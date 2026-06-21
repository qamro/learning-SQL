-- Setup
CREATE DATABASE IF NOT EXISTS restaurant;
USE restaurant;

-- Tables
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

CREATE TABLE menu_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200),
    category_id INT,
    price DECIMAL(10,2),
    calories INT,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE tables (
    id INT AUTO_INCREMENT PRIMARY KEY,
    table_number INT,
    capacity INT,
    status VARCHAR(20) DEFAULT 'available'
);

CREATE TABLE staff (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    salary DECIMAL(10,2),
    phone VARCHAR(20),
    hire_date DATE
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    visits INT DEFAULT 0
);

CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    table_id INT,
    reservation_date DATE,
    reservation_time TIME,
    guests INT,
    status VARCHAR(20) DEFAULT 'confirmed',
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (table_id) REFERENCES tables(id)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    table_id INT,
    staff_id INT,
    customer_id INT,
    order_date DATETIME,
    status VARCHAR(20) DEFAULT 'pending',
    total_amount DECIMAL(10,2),
    FOREIGN KEY (table_id) REFERENCES tables(id),
    FOREIGN KEY (staff_id) REFERENCES staff(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    menu_item_id INT,
    quantity INT,
    price DECIMAL(10,2),
    notes TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (menu_item_id) REFERENCES menu_items(id)
);

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_date DATETIME,
    tip DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Insert Data
INSERT INTO categories (name, description) VALUES
('Starters', 'Appetizers and soups'),
('Main Course', 'Main dishes'),
('Desserts', 'Sweet treats'),
('Drinks', 'Beverages and cocktails'),
('Pizza', 'All kinds of pizza');

INSERT INTO menu_items (name, category_id, price, calories, is_available) VALUES
('Garlic Bread', 1, 4.99, 200, TRUE),
('Caesar Salad', 1, 7.99, 300, TRUE),
('Tomato Soup', 1, 5.99, 150, TRUE),
('Grilled Chicken', 2, 15.99, 450, TRUE),
('Beef Steak', 2, 24.99, 600, TRUE),
('Salmon Fillet', 2, 19.99, 400, TRUE),
('Pasta Carbonara', 2, 13.99, 550, TRUE),
('Chocolate Cake', 3, 6.99, 500, TRUE),
('Ice Cream', 3, 4.99, 300, TRUE),
('Tiramisu', 3, 7.99, 450, TRUE),
('Coca Cola', 4, 2.99, 140, TRUE),
('Orange Juice', 4, 3.99, 120, TRUE),
('Coffee', 4, 2.49, 5, TRUE),
('Margherita Pizza', 5, 11.99, 800, TRUE),
('Pepperoni Pizza', 5, 13.99, 950, TRUE),
('BBQ Chicken Pizza', 5, 14.99, 1000, TRUE);

INSERT INTO tables (table_number, capacity, status) VALUES
(1, 2, 'available'),
(2, 4, 'occupied'),
(3, 4, 'available'),
(4, 6, 'occupied'),
(5, 8, 'available'),
(6, 2, 'reserved'),
(7, 4, 'available'),
(8, 6, 'occupied');

INSERT INTO staff (name, role, salary, phone, hire_date) VALUES
('John Smith', 'Waiter', 2000.00, '123456789', '2022-01-15'),
('Emma Johnson', 'Waiter', 2000.00, '987654321', '2022-03-20'),
('Mike Brown', 'Chef', 3500.00, '456789123', '2021-06-10'),
('Sarah Davis', 'Chef', 3500.00, '321654987', '2021-08-05'),
('Tom Wilson', 'Manager', 5000.00, '654321789', '2020-11-12'),
('Lisa Miller', 'Cashier', 1800.00, '789123456', '2023-02-08');

INSERT INTO customers (name, phone, email, visits) VALUES
('Alice', '111222333', 'alice@email.com', 5),
('Bob', '444555666', 'bob@email.com', 3),
('Charlie', '777888999', 'charlie@email.com', 8),
('Diana', '000111222', 'diana@email.com', 2),
('Eve', '333444555', 'eve@email.com', 10),
('Frank', '666777888', 'frank@email.com', 1);

INSERT INTO reservations (customer_id, table_id, reservation_date, reservation_time, guests, status) VALUES
(1, 6, '2024-03-20', '19:00:00', 2, 'confirmed'),
(2, 3, '2024-03-21', '20:00:00', 4, 'confirmed'),
(3, 5, '2024-03-22', '18:30:00', 6, 'confirmed'),
(4, 7, '2024-03-23', '19:30:00', 3, 'cancelled'),
(5, 4, '2024-03-24', '20:30:00', 5, 'confirmed');

INSERT INTO orders (table_id, staff_id, customer_id, order_date, status, total_amount) VALUES
(2, 1, 1, '2024-03-15 12:00:00', 'completed', 45.96),
(4, 2, 2, '2024-03-15 13:00:00', 'completed', 67.94),
(8, 1, 3, '2024-03-15 14:00:00', 'completed', 89.93),
(2, 2, 4, '2024-03-16 12:30:00', 'completed', 34.97),
(4, 1, 5, '2024-03-16 13:30:00', 'completed', 120.94),
(8, 2, 6, '2024-03-16 14:30:00', 'pending', 55.96);

INSERT INTO order_items (order_id, menu_item_id, quantity, price) VALUES
(1, 1, 2, 4.99),
(1, 4, 1, 15.99),
(1, 8, 2, 6.99),
(1, 11, 2, 2.99),
(2, 2, 1, 7.99),
(2, 5, 2, 24.99),
(2, 9, 1, 4.99),
(2, 13, 2, 2.49),
(3, 3, 1, 5.99),
(3, 6, 2, 19.99),
(3, 10, 2, 7.99),
(3, 12, 3, 3.99),
(4, 14, 1, 11.99),
(4, 11, 2, 2.99),
(4, 9, 2, 4.99),
(5, 15, 2, 13.99),
(5, 16, 1, 14.99),
(5, 5, 2, 24.99),
(5, 8, 2, 6.99),
(6, 14, 2, 11.99),
(6, 11, 3, 2.99),
(6, 13, 4, 2.49);

INSERT INTO payments (order_id, amount, payment_method, payment_date, tip) VALUES
(1, 45.96, 'Credit Card', '2024-03-15 13:00:00', 5.00),
(2, 67.94, 'Cash', '2024-03-15 14:30:00', 8.00),
(3, 89.93, 'Credit Card', '2024-03-15 16:00:00', 10.00),
(4, 34.97, 'PayPal', '2024-03-16 14:00:00', 3.00),
(5, 120.94, 'Credit Card', '2024-03-16 15:30:00', 15.00),
(6, 55.96, 'Cash', '2024-03-16 16:00:00', 0.00);




-- QUERIES





-- 1. Show full menu with categories
SELECT menu_items.name, categories.name AS category,
menu_items.price, menu_items.calories
FROM menu_items
INNER JOIN categories ON menu_items.category_id = categories.id
ORDER BY categories.name;

-- 2. Show available tables
SELECT * FROM tables WHERE status = 'available';

-- 3. Show all staff and their roles
SELECT name, role, salary FROM staff
ORDER BY salary DESC;

-- 4. Show all reservations with customer names
SELECT customers.name, tables.table_number,
reservations.reservation_date, reservations.reservation_time,
reservations.guests, reservations.status
FROM reservations
INNER JOIN customers ON reservations.customer_id = customers.id
INNER JOIN tables ON reservations.table_id = tables.id;

-- 5. Show all orders with waiter and customer
SELECT customers.name AS customer, staff.name AS waiter,
tables.table_number, orders.total_amount, orders.status
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN staff ON orders.staff_id = staff.id
INNER JOIN tables ON orders.table_id = tables.id;

-- 6. Show most ordered items
SELECT menu_items.name, SUM(order_items.quantity) AS total_ordered
FROM order_items
INNER JOIN menu_items ON order_items.menu_item_id = menu_items.id
GROUP BY menu_items.name
ORDER BY total_ordered DESC;

-- 7. Total revenue
SELECT SUM(total_amount) AS total_revenue FROM orders
WHERE status = 'completed';

-- 8. Best waiter by total orders
SELECT staff.name, COUNT(*) AS total_orders,
SUM(orders.total_amount) AS total_revenue
FROM orders
INNER JOIN staff ON orders.staff_id = staff.id
GROUP BY staff.name
ORDER BY total_revenue DESC;

-- 9. Most loyal customers
SELECT name, visits FROM customers
ORDER BY visits DESC;

-- 10. Total tips per waiter
SELECT staff.name, SUM(payments.tip) AS total_tips
FROM payments
INNER JOIN orders ON payments.order_id = orders.id
INNER JOIN staff ON orders.staff_id = staff.id
GROUP BY staff.name
ORDER BY total_tips DESC;

-- 11. Revenue by payment method
SELECT payment_method, SUM(amount) AS total
FROM payments
GROUP BY payment_method
ORDER BY total DESC;

-- 12. Most expensive orders
SELECT customers.name, orders.total_amount, orders.order_date
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id
ORDER BY orders.total_amount DESC;