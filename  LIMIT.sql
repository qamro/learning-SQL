-- 1. Show only 3 students
SELECT * FROM students LIMIT 3;

-- 2. Show the oldest 2 students
SELECT * FROM students ORDER BY age DESC LIMIT 2;

-- 3. Show the youngest student
SELECT * FROM students ORDER BY age ASC LIMIT 1;