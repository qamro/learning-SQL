-- Setup
CREATE DATABASE IF NOT EXISTS store;
USE store;

-- Tables
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200),
    category_id INT,
    price DECIMAL(10,2),
    stock INT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Insert Data
INSERT INTO categories (name) VALUES
('Electronics'),
('Clothing'),
('Food'),
('Books');

INSERT INTO products (name, category_id, price, stock) VALUES
('Laptop', 1, 999.99, 50),
('Phone', 1, 499.99, 100),
('T-Shirt', 2, 19.99, 200),
('Jeans', 2, 49.99, 150),
('Pizza', 3, 9.99, 500),
('Burger', 3, 5.99, 300),
('SQL Book', 4, 29.99, 75),
('Python Book', 4, 34.99, 60);

INSERT INTO customers (name, email, city) VALUES
('Alice', 'alice@email.com', 'Paris'),
('Bob', 'bob@email.com', 'London'),
('Charlie', 'charlie@email.com', 'Berlin'),
('Diana', 'diana@email.com', 'Paris'),
('Eve', 'eve@email.com', 'London');

INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
(1, 1, 1, '2024-01-10'),
(1, 7, 2, '2024-01-15'),
(2, 2, 1, '2024-02-01'),
(2, 3, 3, '2024-02-10'),
(3, 5, 5, '2024-02-15'),
(4, 1, 1, '2024-03-01'),
(4, 8, 1, '2024-03-05'),
(5, 4, 2, '2024-03-10'),
(5, 6, 4, '2024-03-15'),
(1, 2, 1, '2024-03-20');



-- QUERIES


-- 1. Show all products with their category name
SELECT products.name, categories.name AS category, products.price
FROM products
INNER JOIN categories ON products.category_id = categories.id;

-- 2. Show all Electronics
SELECT products.name, products.price, products.stock
FROM products
INNER JOIN categories ON products.category_id = categories.id
WHERE categories.name = 'Electronics';

-- 3. Show all orders with customer and product names
SELECT customers.name, products.name, orders.quantity, orders.order_date
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN products ON orders.product_id = products.id;

-- 4. Total spent by each customer
SELECT customers.name, 
SUM(products.price * orders.quantity) AS total_spent
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN products ON orders.product_id = products.id
GROUP BY customers.name
ORDER BY total_spent DESC;

-- 5. Most sold product
SELECT products.name, SUM(orders.quantity) AS total_sold
FROM orders
INNER JOIN products ON orders.product_id = products.id
GROUP BY products.name
ORDER BY total_sold DESC;

-- 6. Products low on stock (less than 100)
SELECT name, stock FROM products
WHERE stock < 100
ORDER BY stock ASC;

-- 7. Revenue by category
SELECT categories.name, 
SUM(products.price * orders.quantity) AS revenue
FROM orders
INNER JOIN products ON orders.product_id = products.id
INNER JOIN categories ON products.category_id = categories.id
GROUP BY categories.name
ORDER BY revenue DESC;

-- 8. Customers from Paris and their orders
SELECT customers.name, products.name, orders.order_date
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN products ON orders.product_id = products.id
WHERE customers.city = 'Paris';