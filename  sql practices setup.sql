CREATE DATABASE IF NOT EXISTS learning_sql;
USE learning_sql;

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    grade VARCHAR(10),
    city VARCHAR(100)
);

INSERT INTO students (name, age, grade, city) VALUES
('Alice', 20, 'A', 'Paris'),
('Bob', 22, 'B', 'London'),
('Charlie', 21, 'A', 'Paris'),
('Diana', 23, 'C', 'Berlin'),
('Eve', 20, 'B', 'London'),
('Frank', 24, 'A', 'Paris'),
('Grace', 22, 'C', 'Berlin'),
('Henry', 21, 'B', 'London');