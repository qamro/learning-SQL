-- 1. Count students in each city
SELECT city, COUNT(*) FROM students GROUP BY city;

-- 2. Count students in each grade
SELECT grade, COUNT(*) FROM students GROUP BY grade;

-- 3. Average age by city
SELECT city, AVG(age) FROM students GROUP BY city;

-- 4. Oldest student in each city
SELECT city, MAX(age) FROM students GROUP BY city;