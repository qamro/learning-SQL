-- 1. Show all students
SELECT * FROM students;

-- 2. Show only name and age
SELECT name, age FROM students;

-- 3. Show only students from Paris
SELECT * FROM students WHERE city = 'Paris';

-- 4. Show students older than 21
SELECT * FROM students WHERE age > 21;

-- 5. Show students with grade A
SELECT * FROM students WHERE grade = 'A';