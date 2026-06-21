-- Setup
CREATE DATABASE IF NOT EXISTS banking;
USE banking;

-- Tables
CREATE TABLE branches (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    address TEXT,
    phone VARCHAR(20)
);

CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(100),
    birth_date DATE,
    joined_date DATE
);

CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    branch_id INT,
    account_number VARCHAR(20),
    account_type VARCHAR(20),
    balance DECIMAL(15,2),
    opened_date DATE,
    status VARCHAR(20) DEFAULT 'active',
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (branch_id) REFERENCES branches(id)
);

CREATE TABLE transactions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    type VARCHAR(20),
    amount DECIMAL(15,2),
    transaction_date DATETIME,
    description TEXT,
    balance_after DECIMAL(15,2),
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

CREATE TABLE loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    branch_id INT,
    amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    monthly_payment DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (branch_id) REFERENCES branches(id)
);

CREATE TABLE cards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    card_number VARCHAR(20),
    card_type VARCHAR(20),
    expiry_date DATE,
    credit_limit DECIMAL(10,2),
    status VARCHAR(20) DEFAULT 'active',
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    branch_id INT,
    role VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    email VARCHAR(100),
    FOREIGN KEY (branch_id) REFERENCES branches(id)
);

-- Insert Data
INSERT INTO branches (name, city, address, phone) VALUES
('Main Branch', 'Paris', '1 Rue de Rivoli', '0123456789'),
('North Branch', 'London', '10 Oxford Street', '9876543210'),
('East Branch', 'Berlin', '5 Unter den Linden', '4567891230'),
('West Branch', 'Tokyo', '3 Shinjuku Ave', '3216549870');

INSERT INTO customers (name, email, phone, city, birth_date, joined_date) VALUES
('Alice Smith', 'alice@email.com', '111222333', 'Paris', '1990-05-15', '2020-01-10'),
('Bob Johnson', 'bob@email.com', '444555666', 'London', '1985-08-20', '2019-06-15'),
('Charlie Brown', 'charlie@email.com', '777888999', 'Berlin', '1995-03-10', '2021-03-20'),
('Diana Davis', 'diana@email.com', '000111222', 'Paris', '1988-11-25', '2018-08-05'),
('Eve Wilson', 'eve@email.com', '333444555', 'London', '1992-07-30', '2020-11-12'),
('Frank Miller', 'frank@email.com', '666777888', 'Berlin', '1987-01-18', '2017-04-08'),
('Grace Lee', 'grace@email.com', '999000111', 'Tokyo', '1993-09-22', '2022-02-14');

INSERT INTO accounts (customer_id, branch_id, account_number, account_type, balance, opened_date, status) VALUES
(1, 1, 'ACC001', 'savings', 15000.00, '2020-01-10', 'active'),
(1, 1, 'ACC002', 'checking', 5000.00, '2020-01-10', 'active'),
(2, 2, 'ACC003', 'savings', 25000.00, '2019-06-15', 'active'),
(3, 3, 'ACC004', 'checking', 8000.00, '2021-03-20', 'active'),
(4, 1, 'ACC005', 'savings', 50000.00, '2018-08-05', 'active'),
(5, 2, 'ACC006', 'checking', 3000.00, '2020-11-12', 'active'),
(6, 3, 'ACC007', 'savings', 12000.00, '2017-04-08', 'active'),
(7, 4, 'ACC008', 'checking', 7500.00, '2022-02-14', 'active');

INSERT INTO transactions (account_id, type, amount, transaction_date, description, balance_after) VALUES
(1, 'deposit', 5000.00, '2024-01-05 10:00:00', 'Salary', 20000.00),
(1, 'withdrawal', 1000.00, '2024-01-10 14:00:00', 'Rent payment', 19000.00),
(1, 'withdrawal', 500.00, '2024-01-15 11:00:00', 'Shopping', 18500.00),
(2, 'deposit', 2000.00, '2024-01-05 10:00:00', 'Transfer', 7000.00),
(2, 'withdrawal', 300.00, '2024-01-12 09:00:00', 'Groceries', 6700.00),
(3, 'deposit', 10000.00, '2024-01-08 11:00:00', 'Business income', 35000.00),
(3, 'withdrawal', 2000.00, '2024-01-20 15:00:00', 'Investment', 33000.00),
(4, 'deposit', 3000.00, '2024-02-01 10:00:00', 'Salary', 11000.00),
(5, 'deposit', 15000.00, '2024-02-05 09:00:00', 'Bonus', 65000.00),
(5, 'withdrawal', 5000.00, '2024-02-10 14:00:00', 'Car payment', 60000.00),
(6, 'deposit', 1500.00, '2024-02-15 10:00:00', 'Freelance', 4500.00),
(7, 'withdrawal', 2000.00, '2024-03-01 11:00:00', 'Vacation', 10000.00),
(8, 'deposit', 3000.00, '2024-03-05 10:00:00', 'Salary', 10500.00);

INSERT INTO loans (customer_id, branch_id, amount, interest_rate, start_date, end_date, status, monthly_payment) VALUES
(1, 1, 20000.00, 5.5, '2023-01-01', '2026-01-01', 'active', 600.00),
(2, 2, 50000.00, 4.5, '2022-06-01', '2027-06-01', 'active', 925.00),
(3, 3, 10000.00, 6.0, '2023-03-01', '2025-03-01', 'active', 450.00),
(4, 1, 100000.00, 3.5, '2021-01-01', '2031-01-01', 'active', 990.00),
(5, 2, 15000.00, 5.0, '2023-11-01', '2026-11-01', 'active', 450.00),
(6, 3, 8000.00, 6.5, '2022-04-01', '2024-04-01', 'completed', 380.00);

INSERT INTO cards (account_id, card_number, card_type, expiry_date, credit_limit, status) VALUES
(1, 'CARD001', 'debit', '2026-01-01', 0.00, 'active'),
(2, 'CARD002', 'credit', '2025-06-01', 5000.00, 'active'),
(3, 'CARD003', 'credit', '2026-12-01', 10000.00, 'active'),
(4, 'CARD004', 'debit', '2025-03-01', 0.00, 'active'),
(5, 'CARD005', 'credit', '2027-08-01', 20000.00, 'active'),
(6, 'CARD006', 'debit', '2024-11-01', 0.00, 'blocked'),
(7, 'CARD007', 'credit', '2026-04-01', 8000.00, 'active'),
(8, 'CARD008', 'debit', '2027-02-01', 0.00, 'active');

INSERT INTO employees (name, branch_id, role, salary, hire_date, email) VALUES
('John Smith', 1, 'Manager', 6000.00, '2015-03-01', 'john@bank.com'),
('Emma Johnson', 1, 'Teller', 2500.00, '2018-06-15', 'emma@bank.com'),
('Mike Brown', 2, 'Manager', 6000.00, '2014-09-01', 'mike@bank.com'),
('Sarah Davis', 2, 'Teller', 2500.00, '2019-11-20', 'sarah@bank.com'),
('Tom Wilson', 3, 'Manager', 6000.00, '2016-01-10', 'tom@bank.com'),
('Lisa Miller', 3, 'Teller', 2500.00, '2020-04-05', 'lisa@bank.com'),
('James Lee', 4, 'Manager', 6000.00, '2017-07-15', 'james@bank.com'),
('Anna White', 4, 'Teller', 2500.00, '2021-08-20', 'anna@bank.com');





-- queries






-- 1. Show all customers with their accounts
SELECT customers.name, accounts.account_number,
accounts.account_type, accounts.balance
FROM accounts
INNER JOIN customers ON accounts.customer_id = customers.id
ORDER BY accounts.balance DESC;

-- 2. Show richest customers
SELECT customers.name, SUM(accounts.balance) AS total_balance
FROM accounts
INNER JOIN customers ON accounts.customer_id = customers.id
GROUP BY customers.name
ORDER BY total_balance DESC;

-- 3. Show all transactions with account info
SELECT customers.name, transactions.type,
transactions.amount, transactions.description,
transactions.transaction_date
FROM transactions
INNER JOIN accounts ON transactions.account_id = accounts.id
INNER JOIN customers ON accounts.customer_id = customers.id
ORDER BY transactions.transaction_date DESC;

-- 4. Show all active loans
SELECT customers.name, loans.amount,
loans.interest_rate, loans.monthly_payment,
loans.end_date
FROM loans
INNER JOIN customers ON loans.customer_id = customers.id
WHERE loans.status = 'active';

-- 5. Show all credit cards
SELECT customers.name, cards.card_number,
cards.card_type, cards.credit_limit,
cards.expiry_date, cards.status
FROM cards
INNER JOIN accounts ON cards.account_id = accounts.id
INNER JOIN customers ON accounts.customer_id = customers.id
WHERE cards.card_type = 'credit';

-- 6. Total deposits per customer
SELECT customers.name, SUM(transactions.amount) AS total_deposits
FROM transactions
INNER JOIN accounts ON transactions.account_id = accounts.id
INNER JOIN customers ON accounts.customer_id = customers.id
WHERE transactions.type = 'deposit'
GROUP BY customers.name
ORDER BY total_deposits DESC;

-- 7. Show employees per branch
SELECT branches.name AS branch, employees.name,
employees.role, employees.salary
FROM employees
INNER JOIN branches ON employees.branch_id = branches.id
ORDER BY branches.name;

-- 8. Show blocked cards
SELECT customers.name, cards.card_number,
cards.card_type, cards.status
FROM cards
INNER JOIN accounts ON cards.account_id = accounts.id
INNER JOIN customers ON accounts.customer_id = customers.id
WHERE cards.status = 'blocked';

-- 9. Total loans per branch
SELECT branches.name, COUNT(*) AS total_loans,
SUM(loans.amount) AS total_amount
FROM loans
INNER JOIN branches ON loans.branch_id = branches.id
GROUP BY branches.name;

-- 10. Show withdrawals only
SELECT customers.name, transactions.amount,
transactions.description, transactions.transaction_date
FROM transactions
INNER JOIN accounts ON transactions.account_id = accounts.id
INNER JOIN customers ON accounts.customer_id = customers.id
WHERE transactions.type = 'withdrawal'
ORDER BY transactions.amount DESC;

-- 11. Average balance per branch
SELECT branches.name, AVG(accounts.balance) AS avg_balance
FROM accounts
INNER JOIN branches ON accounts.branch_id = branches.id
GROUP BY branches.name
ORDER BY avg_balance DESC;

-- 12. Show customers with loans and their balance
SELECT customers.name, accounts.balance,
loans.amount AS loan_amount, loans.monthly_payment
FROM loans
INNER JOIN customers ON loans.customer_id = customers.id
INNER JOIN accounts ON customers.id = accounts.customer_id;