-- 1. Cities with more than 2 students
SELECT city, COUNT(*) FROM students 
GROUP BY city HAVING COUNT(*) > 2;

-- 2. Grades with average age over 21
SELECT grade, AVG(age) FROM students 
GROUP BY grade HAVING AVG(age) > 21;