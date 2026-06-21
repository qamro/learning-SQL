-- Setup
CREATE DATABASE IF NOT EXISTS library;
USE library;

-- Tables
CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200),
    author VARCHAR(100),
    genre VARCHAR(50),
    year INT,
    available BOOLEAN DEFAULT TRUE
);

CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    join_date DATE
);

CREATE TABLE borrowings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    member_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (member_id) REFERENCES members(id)
);

-- Insert Data
INSERT INTO books (title, author, genre, year) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925),
('1984', 'George Orwell', 'Dystopia', 1949),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960),
('Clean Code', 'Robert Martin', 'Technology', 2008),
('The Alchemist', 'Paulo Coelho', 'Fiction', 1988),
('Harry Potter', 'J.K. Rowling', 'Fantasy', 1997),
('Dune', 'Frank Herbert', 'Sci-Fi', 1965);

INSERT INTO members (name, email, join_date) VALUES
('Alice', 'alice@email.com', '2024-01-15'),
('Bob', 'bob@email.com', '2024-02-20'),
('Charlie', 'charlie@email.com', '2024-03-10'),
('Diana', 'diana@email.com', '2024-04-05');

INSERT INTO borrowings (book_id, member_id, borrow_date, return_date) VALUES
(1, 1, '2024-05-01', '2024-05-15'),
(2, 2, '2024-05-03', NULL),
(3, 1, '2024-05-10', NULL),
(4, 3, '2024-05-12', '2024-05-20'),
(5, 4, '2024-05-15', NULL),
(6, 2, '2024-05-18', NULL);



-- QUERIES


-- 1. Show all books
SELECT * FROM books;

-- 2. Show all Fiction books
SELECT * FROM books WHERE genre = 'Fiction';

-- 3. Show books ordered by year
SELECT * FROM books ORDER BY year ASC;

-- 4. Show all members
SELECT * FROM members;

-- 5. Show who borrowed what book
SELECT members.name, books.title, borrowings.borrow_date
FROM borrowings
INNER JOIN members ON borrowings.member_id = members.id
INNER JOIN books ON borrowings.book_id = books.id;

-- 6. Show books not returned yet (return_date is NULL)
SELECT members.name, books.title, borrowings.borrow_date
FROM borrowings
INNER JOIN members ON borrowings.member_id = members.id
INNER JOIN books ON borrowings.book_id = books.id
WHERE borrowings.return_date IS NULL;

-- 7. Count how many books each member borrowed
SELECT members.name, COUNT(*) AS total_borrowed
FROM borrowings
INNER JOIN members ON borrowings.member_id = members.id
GROUP BY members.name;

-- 8. Most popular genre
SELECT genre, COUNT(*) AS total
FROM books
GROUP BY genre
ORDER BY total DESC;