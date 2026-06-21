-- Setup
CREATE DATABASE IF NOT EXISTS university;
USE university;

-- Tables
CREATE TABLE faculties (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    dean VARCHAR(100),
    building VARCHAR(50),
    established_year INT
);

CREATE TABLE departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    faculty_id INT,
    head_of_department VARCHAR(100),
    FOREIGN KEY (faculty_id) REFERENCES faculties(id)
);

CREATE TABLE professors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    email VARCHAR(100),
    phone VARCHAR(20),
    salary DECIMAL(10,2),
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(100),
    department_id INT,
    enrollment_date DATE,
    gpa DECIMAL(3,2),
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(200),
    code VARCHAR(20),
    department_id INT,
    professor_id INT,
    credits INT,
    semester VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (professor_id) REFERENCES professors(id)
);

CREATE TABLE enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    grade DECIMAL(4,2),
    status VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

CREATE TABLE scholarships (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    amount DECIMAL(10,2),
    requirements TEXT
);

CREATE TABLE student_scholarships (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    scholarship_id INT,
    awarded_date DATE,
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (scholarship_id) REFERENCES scholarships(id)
);

-- Insert Data
INSERT INTO faculties (name, dean, building, established_year) VALUES
('Faculty of Science', 'Dr. Newton', 'Block A', 1950),
('Faculty of Engineering', 'Dr. Tesla', 'Block B', 1960),
('Faculty of Arts', 'Dr. Picasso', 'Block C', 1955),
('Faculty of Medicine', 'Dr. House', 'Block D', 1970);

INSERT INTO departments (name, faculty_id, head_of_department) VALUES
('Computer Science', 2, 'Dr. Gates'),
('Mathematics', 1, 'Dr. Euler'),
('Physics', 1, 'Dr. Einstein'),
('Literature', 3, 'Dr. Shakespeare'),
('Medicine', 4, 'Dr. Watson'),
('Electrical Engineering', 2, 'Dr. Faraday');

INSERT INTO professors (name, department_id, email, phone, salary, hire_date) VALUES
('Prof. Smith', 1, 'smith@uni.com', '111222333', 6000.00, '2015-09-01'),
('Prof. Johnson', 2, 'johnson@uni.com', '444555666', 5500.00, '2016-09-01'),
('Prof. Brown', 3, 'brown@uni.com', '777888999', 5800.00, '2014-09-01'),
('Prof. Davis', 4, 'davis@uni.com', '000111222', 5000.00, '2017-09-01'),
('Prof. Wilson', 5, 'wilson@uni.com', '333444555', 7000.00, '2013-09-01'),
('Prof. Miller', 6, 'miller@uni.com', '666777888', 6200.00, '2015-09-01');

INSERT INTO students (name, email, phone, city, department_id, enrollment_date, gpa) VALUES
('Alice', 'alice@email.com', '123111222', 'Paris', 1, '2022-09-01', 3.8),
('Bob', 'bob@email.com', '456333444', 'London', 1, '2022-09-01', 3.2),
('Charlie', 'charlie@email.com', '789555666', 'Berlin', 2, '2021-09-01', 3.5),
('Diana', 'diana@email.com', '012777888', 'Paris', 3, '2023-09-01', 3.9),
('Eve', 'eve@email.com', '345999000', 'London', 4, '2021-09-01', 2.8),
('Frank', 'frank@email.com', '678111333', 'Berlin', 5, '2020-09-01', 3.6),
('Grace', 'grace@email.com', '901444555', 'Tokyo', 1, '2022-09-01', 3.7),
('Henry', 'henry@email.com', '234666777', 'Paris', 6, '2023-09-01', 3.1),
('Iris', 'iris@email.com', '567888999', 'London', 2, '2021-09-01', 3.4),
('Jack', 'jack@email.com', '890000111', 'Berlin', 1, '2022-09-01', 2.9);

INSERT INTO courses (name, code, department_id, professor_id, credits, semester) VALUES
('Introduction to Programming', 'CS101', 1, 1, 3, 'Fall 2024'),
('Data Structures', 'CS201', 1, 1, 4, 'Fall 2024'),
('Calculus I', 'MATH101', 2, 2, 3, 'Fall 2024'),
('Linear Algebra', 'MATH201', 2, 2, 3, 'Fall 2024'),
('Quantum Physics', 'PHY301', 3, 3, 4, 'Fall 2024'),
('World Literature', 'LIT101', 4, 4, 3, 'Fall 2024'),
('Anatomy', 'MED101', 5, 5, 5, 'Fall 2024'),
('Circuit Theory', 'EE101', 6, 6, 4, 'Fall 2024');

INSERT INTO enrollments (student_id, course_id, enrollment_date, grade, status) VALUES
(1, 1, '2024-09-01', 95.00, 'completed'),
(1, 2, '2024-09-01', 88.00, 'completed'),
(2, 1, '2024-09-01', 75.00, 'completed'),
(2, 2, '2024-09-01', 70.00, 'completed'),
(3, 3, '2024-09-01', 85.00, 'completed'),
(3, 4, '2024-09-01', 90.00, 'completed'),
(4, 5, '2024-09-01', 98.00, 'completed'),
(5, 6, '2024-09-01', 72.00, 'completed'),
(6, 7, '2024-09-01', 88.00, 'completed'),
(7, 1, '2024-09-01', 92.00, 'completed'),
(7, 2, '2024-09-01', 87.00, 'completed'),
(8, 8, '2024-09-01', 79.00, 'completed'),
(9, 3, '2024-09-01', 83.00, 'completed'),
(10, 1, '2024-09-01', 65.00, 'completed'),
(10, 2, '2024-09-01', 60.00, 'completed');

INSERT INTO scholarships (name, amount, requirements) VALUES
('Excellence Award', 5000.00, 'GPA above 3.8'),
('Need Based Grant', 3000.00, 'Financial need'),
('Sports Scholarship', 2000.00, 'Athletic achievement'),
('Research Grant', 4000.00, 'Research contribution');

INSERT INTO student_scholarships (student_id, scholarship_id, awarded_date) VALUES
(1, 1, '2024-01-15'),
(4, 1, '2024-01-15'),
(3, 2, '2024-02-01'),
(6, 4, '2024-02-15'),
(7, 1, '2024-03-01');





-- QUERIES




-- 1. Show all departments with faculty name
SELECT departments.name AS department,
faculties.name AS faculty,
departments.head_of_department
FROM departments
INNER JOIN faculties ON departments.faculty_id = faculties.id;

-- 2. Show all professors with department
SELECT professors.name, departments.name AS department,
professors.salary
FROM professors
INNER JOIN departments ON professors.department_id = departments.id
ORDER BY professors.salary DESC;

-- 3. Show all students with department
SELECT students.name, departments.name AS department,
students.gpa, students.city
FROM students
INNER JOIN departments ON students.department_id = departments.id
ORDER BY students.gpa DESC;

-- 4. Show all courses with professor name
SELECT courses.name, courses.code, professors.name AS professor,
courses.credits, courses.semester
FROM courses
INNER JOIN professors ON courses.professor_id = professors.id;

-- 5. Show student enrollments with grades
SELECT students.name, courses.name AS course,
enrollments.grade, enrollments.status
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.id
INNER JOIN courses ON enrollments.course_id = courses.id
ORDER BY enrollments.grade DESC;

-- 6. Show top students by GPA
SELECT name, gpa, city FROM students
ORDER BY gpa DESC
LIMIT 5;

-- 7. Average grade per course
SELECT courses.name, AVG(enrollments.grade) AS average_grade
FROM enrollments
INNER JOIN courses ON enrollments.course_id = courses.id
GROUP BY courses.name
ORDER BY average_grade DESC;

-- 8. Count students per department
SELECT departments.name, COUNT(*) AS total_students
FROM students
INNER JOIN departments ON students.department_id = departments.id
GROUP BY departments.name
ORDER BY total_students DESC;

-- 9. Show scholarship winners
SELECT students.name, scholarships.name AS scholarship,
scholarships.amount, student_scholarships.awarded_date
FROM student_scholarships
INNER JOIN students ON student_scholarships.student_id = students.id
INNER JOIN scholarships ON student_scholarships.scholarship_id = scholarships.id;

-- 10. Highest paid professors
SELECT professors.name, departments.name AS department,
professors.salary
FROM professors
INNER JOIN departments ON professors.department_id = departments.id
ORDER BY professors.salary DESC;

-- 11. Students with GPA above 3.5
SELECT name, gpa, city FROM students
WHERE gpa > 3.5
ORDER BY gpa DESC;

-- 12. Total credits per student
SELECT students.name, SUM(courses.credits) AS total_credits
FROM enrollments
INNER JOIN students ON enrollments.student_id = students.id
INNER JOIN courses ON enrollments.course_id = courses.id
GROUP BY students.name
ORDER BY total_credits DESC;