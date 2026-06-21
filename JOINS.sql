-- First create a new table
CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_name VARCHAR(100),
    score INT
);

INSERT INTO courses (student_id, course_name, score) VALUES
(1, 'Math', 90),
(1, 'Science', 85),
(2, 'Math', 78),
(3, 'Science', 92),
(4, 'Math', 88),
(5, 'Science', 76);

-- 1. Show student names with their courses
SELECT students.name, courses.course_name, courses.score
FROM students
INNER JOIN courses ON students.id = courses.student_id;

-- 2. Show students and their math scores
SELECT students.name, courses.score
FROM students
INNER JOIN courses ON students.id = courses.student_id
WHERE courses.course_name = 'Math';

-- 3. Show students with score above 85
SELECT students.name, courses.course_name, courses.score
FROM students
INNER JOIN courses ON students.id = courses.student_id
WHERE courses.score > 85;