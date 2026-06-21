-- Setup
CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- Tables
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200),
    category_id INT,
    price DECIMAL(10,2),
    stock INT,
    rating DECIMAL(3,2),
    description TEXT,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(100),
    country VARCHAR(100),
    joined_date DATE
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    total_amount DECIMAL(10,2),
    shipping_address TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    rating INT,
    comment TEXT,
    review_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE coupons (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(20),
    discount_percent INT,
    expiry_date DATE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    payment_method VARCHAR(50),
    status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Insert Data
INSERT INTO categories (name, description) VALUES
('Electronics', 'Phones, Laptops, Gadgets'),
('Clothing', 'Men and Women Fashion'),
('Books', 'All kinds of books'),
('Food', 'Groceries and snacks'),
('Sports', 'Sports equipment and gear');

INSERT INTO products (name, category_id, price, stock, rating) VALUES
('iPhone 15', 1, 999.99, 50, 4.8),
('Samsung Galaxy', 1, 799.99, 80, 4.6),
('MacBook Pro', 1, 1999.99, 30, 4.9),
('Nike T-Shirt', 2, 29.99, 200, 4.3),
('Adidas Jeans', 2, 59.99, 150, 4.2),
('Clean Code Book', 3, 34.99, 100, 4.7),
('Python Book', 3, 29.99, 120, 4.5),
('Organic Coffee', 4, 14.99, 300, 4.4),
('Protein Bar', 4, 2.99, 500, 4.1),
('Football', 5, 24.99, 75, 4.6),
('Yoga Mat', 5, 19.99, 90, 4.5),
('AirPods', 1, 249.99, 60, 4.7);

INSERT INTO customers (name, email, phone, city, country, joined_date) VALUES
('Alice Smith', 'alice@email.com', '123456789', 'Paris', 'France', '2023-01-15'),
('Bob Johnson', 'bob@email.com', '987654321', 'London', 'UK', '2023-02-20'),
('Charlie Brown', 'charlie@email.com', '456789123', 'Berlin', 'Germany', '2023-03-10'),
('Diana Davis', 'diana@email.com', '321654987', 'Paris', 'France', '2023-04-05'),
('Eve Wilson', 'eve@email.com', '654321789', 'London', 'UK', '2023-05-12'),
('Frank Miller', 'frank@email.com', '789123456', 'Berlin', 'Germany', '2023-06-08'),
('Grace Lee', 'grace@email.com', '147258369', 'Tokyo', 'Japan', '2023-07-20');

INSERT INTO orders (customer_id, order_date, status, total_amount, shipping_address) VALUES
(1, '2024-01-10', 'delivered', 1029.98, 'Paris, France'),
(2, '2024-01-15', 'delivered', 799.99, 'London, UK'),
(3, '2024-02-01', 'delivered', 64.98, 'Berlin, Germany'),
(4, '2024-02-10', 'shipped', 2049.98, 'Paris, France'),
(5, '2024-02-15', 'delivered', 44.98, 'London, UK'),
(6, '2024-03-01', 'processing', 249.99, 'Berlin, Germany'),
(7, '2024-03-10', 'delivered', 54.98, 'Tokyo, Japan'),
(1, '2024-03-15', 'shipped', 34.99, 'Paris, France'),
(2, '2024-03-20', 'processing', 19.99, 'London, UK');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
(1, 1, 1, 999.99),
(1, 8, 2, 14.99),
(2, 2, 1, 799.99),
(3, 6, 1, 34.99),
(3, 7, 1, 29.99),
(4, 3, 1, 1999.99),
(4, 4, 1, 29.99),
(5, 10, 1, 24.99),
(5, 11, 1, 19.99),
(6, 12, 1, 249.99),
(7, 9, 5, 2.99),
(7, 8, 3, 14.99),
(8, 6, 1, 34.99),
(9, 11, 1, 19.99);

INSERT INTO reviews (product_id, customer_id, rating, comment, review_date) VALUES
(1, 1, 5, 'Best phone ever!', '2024-01-20'),
(2, 2, 4, 'Great phone good price', '2024-01-25'),
(6, 3, 5, 'Must read for developers!', '2024-02-10'),
(3, 4, 5, 'Amazing laptop!', '2024-02-20'),
(10, 5, 4, 'Good quality football', '2024-02-25'),
(12, 6, 5, 'Perfect sound quality!', '2024-03-10'),
(7, 3, 4, 'Very helpful book', '2024-02-12'),
(8, 7, 4, 'Delicious coffee!', '2024-03-15');

INSERT INTO coupons (code, discount_percent, expiry_date, is_active) VALUES
('SAVE10', 10, '2024-12-31', TRUE),
('SUMMER20', 20, '2024-08-31', TRUE),
('WELCOME5', 5, '2024-06-30', TRUE),
('EXPIRED50', 50, '2023-12-31', FALSE);

INSERT INTO payments (order_id, amount, payment_date, payment_method, status) VALUES
(1, 1029.98, '2024-01-10', 'Credit Card', 'completed'),
(2, 799.99, '2024-01-15', 'PayPal', 'completed'),
(3, 64.98, '2024-02-01', 'Credit Card', 'completed'),
(4, 2049.98, '2024-02-10', 'Bank Transfer', 'completed'),
(5, 44.98, '2024-02-15', 'PayPal', 'completed'),
(6, 249.99, '2024-03-01', 'Credit Card', 'pending'),
(7, 54.98, '2024-03-10', 'PayPal', 'completed'),
(8, 34.99, '2024-03-15', 'Credit Card', 'completed'),
(9, 19.99, '2024-03-20', 'PayPal', 'pending');






-- QUERIES




-- 1. Show all products with category name
SELECT products.name, categories.name AS category, 
products.price, products.stock, products.rating
FROM products
INNER JOIN categories ON products.category_id = categories.id;

-- 2. Show most expensive products
SELECT name, price FROM products
ORDER BY price DESC;

-- 3. Show all orders with customer names
SELECT customers.name, orders.order_date, 
orders.status, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

-- 4. Show delivered orders only
SELECT customers.name, orders.order_date, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id
WHERE orders.status = 'delivered';

-- 5. Show what each customer ordered
SELECT customers.name, products.name AS product,
order_items.quantity, order_items.price
FROM order_items
INNER JOIN orders ON order_items.order_id = orders.id
INNER JOIN customers ON orders.customer_id = customers.id
INNER JOIN products ON order_items.product_id = products.id;

-- 6. Total revenue
SELECT SUM(total_amount) AS total_revenue FROM orders;

-- 7. Revenue by country
SELECT customers.country, SUM(orders.total_amount) AS revenue
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id
GROUP BY customers.country
ORDER BY revenue DESC;

-- 8. Best rated products
SELECT name, rating FROM products
ORDER BY rating DESC;

-- 9. Show all reviews with customer and product
SELECT customers.name, products.name AS product,
reviews.rating, reviews.comment
FROM reviews
INNER JOIN customers ON reviews.customer_id = customers.id
INNER JOIN products ON reviews.product_id = products.id;

-- 10. Show active coupons
SELECT code, discount_percent, expiry_date
FROM coupons WHERE is_active = TRUE;

-- 11. Show pending payments
SELECT orders.id, customers.name, 
payments.amount, payments.payment_method
FROM payments
INNER JOIN orders ON payments.order_id = orders.id
INNER JOIN customers ON orders.customer_id = customers.id
WHERE payments.status = 'pending';

-- 12. Most sold products
SELECT products.name, SUM(order_items.quantity) AS total_sold
FROM order_items
INNER JOIN products ON order_items.product_id = products.id
GROUP BY products.name
ORDER BY total_sold DESC;