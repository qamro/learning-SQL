-- 1. Update Alice's grade to B
UPDATE students SET grade = 'B' WHERE name = 'Alice';

-- 2. Update all Berlin students age to 25
UPDATE students SET age = 25 WHERE city = 'Berlin';

-- 3. Delete students with grade C
DELETE FROM students WHERE grade = 'C';

-- 4. Check results
SELECT * FROM students;