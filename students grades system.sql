-- Setup
CREATE DATABASE IF NOT EXISTS school;
USE school;

-- Tables
CREATE TABLE teachers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    subject VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    city VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);

CREATE TABLE grades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    score INT,
    exam_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

-- Insert Data
INSERT INTO teachers (name, subject, email) VALUES
('Mr. Smith', 'Math', 'smith@school.com'),
('Mrs. Johnson', 'Science', 'johnson@school.com'),
('Mr. Brown', 'History', 'brown@school.com'),
('Mrs. Davis', 'English', 'davis@school.com');

INSERT INTO students (name, age, city, email) VALUES
('Alice', 20, 'Paris', 'alice@email.com'),
('Bob', 22, 'London', 'bob@email.com'),
('Charlie', 21, 'Berlin', 'charlie@email.com'),
('Diana', 23, 'Paris', 'diana@email.com'),
('Eve', 20, 'London', 'eve@email.com'),
('Frank', 24, 'Berlin', 'frank@email.com');

INSERT INTO subjects (name, teacher_id) VALUES
('Math', 1),
('Science', 2),
('History', 3),
('English', 4);

INSERT INTO grades (student_id, subject_id, score, exam_date) VALUES
(1, 1, 90, '2024-01-15'),
(1, 2, 85, '2024-01-20'),
(1, 3, 78, '2024-01-25'),
(2, 1, 75, '2024-01-15'),
(2, 2, 88, '2024-01-20'),
(2, 4, 92, '2024-01-25'),
(3, 1, 95, '2024-01-15'),
(3, 3, 70, '2024-01-25'),
(4, 2, 88, '2024-01-20'),
(4, 4, 79, '2024-01-25'),
(5, 1, 65, '2024-01-15'),
(5, 2, 72, '2024-01-20'),
(6, 3, 85, '2024-01-25'),
(6, 4, 91, '2024-01-25');


-- QUERIES


-- 1. Show all students with their grades
SELECT students.name, subjects.name AS subject, grades.score
FROM grades
INNER JOIN students ON grades.student_id = students.id
INNER JOIN subjects ON grades.subject_id = subjects.id;

-- 2. Show average score per student
SELECT students.name, AVG(grades.score) AS average
FROM grades
INNER JOIN students ON grades.student_id = students.id
GROUP BY students.name
ORDER BY average DESC;

-- 3. Show highest score in each subject
SELECT subjects.name, MAX(grades.score) AS highest_score
FROM grades
INNER JOIN subjects ON grades.subject_id = subjects.id
GROUP BY subjects.name;

-- 4. Show students who passed (score above 80)
SELECT students.name, subjects.name AS subject, grades.score
FROM grades
INNER JOIN students ON grades.student_id = students.id
INNER JOIN subjects ON grades.subject_id = subjects.id
WHERE grades.score > 80;

-- 5. Show students who failed (score below 75)
SELECT students.name, subjects.name AS subject, grades.score
FROM grades
INNER JOIN students ON grades.student_id = students.id
INNER JOIN subjects ON grades.subject_id = subjects.id
WHERE grades.score < 75;

-- 6. Show teacher and their students
SELECT teachers.name AS teacher, subjects.name AS subject,
students.name AS student, grades.score
FROM grades
INNER JOIN students ON grades.student_id = students.id
INNER JOIN subjects ON grades.subject_id = subjects.id
INNER JOIN teachers ON subjects.teacher_id = teachers.id;

-- 7. Best student overall
SELECT students.name, AVG(grades.score) AS average
FROM grades
INNER JOIN students ON grades.student_id = students.id
GROUP BY students.name
ORDER BY average DESC
LIMIT 1;

-- 8. Count students per subject
SELECT subjects.name, COUNT(*) AS total_students
FROM grades
INNER JOIN subjects ON grades.subject_id = subjects.id
GROUP BY subjects.name;