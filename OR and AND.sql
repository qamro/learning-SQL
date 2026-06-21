-- 1. Students from Paris with grade A
SELECT * FROM students WHERE city = 'Paris' AND grade = 'A';

-- 2. Students from Paris or London
SELECT * FROM students WHERE city = 'Paris' OR city = 'London';

-- 3. Students older than 20 with grade B
SELECT * FROM students WHERE age > 20 AND grade = 'B';