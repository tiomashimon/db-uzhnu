-- 1. Для кожного факультету знайти кількість відмінників, які на ньому навчаються.
SELECT fakult, COUNT(*) AS vidminnyky_count
FROM stud
WHERE e1 = 5 AND e2 = 5 AND e3 = 5
GROUP BY fakult;

-- 2. Для кожного курсу факультету (задає викладач) знайти кількість студентів, які на ньому навчаються.
-- Результат впорядкувати спочатку по кількості, а потім по алфавіту.
SELECT kurs, COUNT(*) AS students_count
FROM stud
WHERE fakult = 'Математичний'
GROUP BY kurs
ORDER BY students_count DESC, kurs ASC;

-- 3. Для кожного факультету знайти мінімальну ненульову стипендію, яка на ньому виплачується.
SELECT fakult, MIN(stip) AS min_stip
FROM stud
WHERE stip > 0
GROUP BY fakult;

-- 4. Знайти факультет, на якому навчається найбільша кількість студентів.
SELECT fakult, COUNT(*) AS students_count
FROM stud
GROUP BY fakult
ORDER BY students_count DESC
LIMIT 1;

-- 5. Для кожного керівника гуртка знайти, якою кількістю гуртків він керує.
SELECT namek AS supervisor, COUNT(*) AS gurt_count
FROM gurt
GROUP BY namek;

-- 6. Знайти на якому курсі факультету (задає викладач) виплачується найменша середня стипендія.
SELECT kurs, AVG(stip) AS avg_stip
FROM stud
WHERE fakult = 'Математичний'  
GROUP BY kurs
ORDER BY avg_stip ASC
LIMIT 1;

-- 7. Знайти на якому факультеті навчається найбільша кількість студентів, які народилися весною.
SELECT fakult, COUNT(*) AS spring_students
FROM stud
WHERE EXTRACT(MONTH FROM data) IN (3, 4, 5)
GROUP BY fakult
ORDER BY spring_students DESC
LIMIT 1;

-- 8. Для кожного курсу факультету (задає викладач) підрахувати скільки студентів з іменем «…» на ньому навчається.
-- Результат впорядкувати за кількістю в порядку спадання.
SELECT kurs, COUNT(*) AS name_count
FROM stud
WHERE fakult = 'Математичний'  
AND name = 'Ім'я'  -- Заміни на потрібне ім'я
GROUP BY kurs
ORDER BY name_count DESC;

-- 9. Знайти номер гуртка, в якому бере участь найменша (ненульова) кількість студентів.
SELECT numg AS gurt_number, COUNT(nums) AS students_count
FROM rob_gurt
GROUP BY numg
HAVING students_count > 0
ORDER BY students_count ASC
LIMIT 1;

-- 10. Для кожного курсу кожного факультету підрахувати кількість студентів, які не здали принаймні 1 іспит.
-- Результат впорядкувати спочатку по факультетам, а потім по курсам.
SELECT fakult, kurs, COUNT(*) AS failed_students
FROM stud
WHERE e1 < 3 OR e2 < 3 OR e3 < 3
GROUP BY fakult, kurs
ORDER BY fakult ASC, kurs ASC;
