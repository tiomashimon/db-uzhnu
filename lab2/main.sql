-- 1. Вивести інформацію про всіх студентів з таблиці stud.
SELECT * FROM stud;

-- 2. Вивести інформацію про всі гуртки з таблиці gurt.
SELECT * FROM gurt;

-- 3. Вивести прізвища та дати народження всіх студентів.
SELECT name, data FROM stud;

-- 4. Вивести інформацію про студентів факультету (задає викладач).
SELECT * FROM stud WHERE fakult = 'Назва_факультету';

-- 5. Вивести прізвища та оцінки всіх першокурсників фізичного факультету.
SELECT name, e1, e2, e3 FROM stud WHERE kurs = 1 AND fakult = 'Фізичний';

-- 6. Вивести інформацію про студентів, які не отримують стипендію, але мають принаймні одну п’ятірку.
SELECT * FROM stud WHERE stip = 0 AND (e1 = 5 OR e2 = 5 OR e3 = 5);

-- 7. Вивести прізвища, курс та факультет всіх відмінників, впорядкувавши їх за алфавітом.
SELECT name, kurs, fakult FROM stud WHERE e1 = 5 AND e2 = 5 AND e3 = 5 ORDER BY name ASC;

-- 8. Вивести інформацію про студентів факультету (задає викладач), які отримують стипендію, впорядкувавши відомості спочатку по курсам, в порядку спадання, а потім по алфавіту.
SELECT * FROM stud WHERE fakult = 'Математичний' AND stip > 0 ORDER BY kurs DESC, name ASC;

-- 9. Для кожного студента факультету (задає викладач) вивести його прізвище та середній бал.
SELECT name, (e1 + e2 + e3) / 3.0 AS average_grade FROM stud WHERE fakult = 'Математичний';

-- 10. Вивести назви факультетів без повторів.
SELECT DISTINCT fakult FROM stud;

-- 11. Вивести прізвища керівників гуртків без повторів, впорядкувавши їх в оберненому до алфавіту порядку.
SELECT DISTINCT namek FROM gurt ORDER BY namek DESC;

-- 12. Знайти найбільшу стипендію факультету (задає викладач).
SELECT MAX(stip) FROM stud WHERE fakult = 'Назва_факультету';

-- 13. Знайти середню стипендію, яку отримують студенти, що мають принаймні одну двійку.
SELECT AVG(stip) FROM stud WHERE e1 = 2 OR e2 = 2 OR e3 = 2;

-- 14. Знайти кількість студентів факультету (задає викладач), які отримали за іспити рівно одну п’ятірку.
SELECT COUNT(*) FROM stud WHERE fakult = 'Математичний' AND (e1 = 5 OR e2 = 5 OR e3 = 5) AND (e1 + e2 + e3) = 5;

-- 15. Знайти середній сумарний бал студентів факультету (задає викладач), які навчаються на першому курсі.
SELECT AVG(total_grade) FROM (SELECT NumS, (e1 + e2 + e3) AS total_grade FROM stud WHERE fakult = 'Назва_факультету' AND kurs = 1) AS subquery;

-- 16. Знайти мінімальний середній бал студентів, що не отримують стипендію.
SELECT MIN(average_grade) FROM (SELECT (e1 + e2 + e3) / 3.0 AS average_grade FROM stud WHERE stip = 0) AS subquery;

-- 17. Знайти кількість різних факультетів університету.
SELECT COUNT(DISTINCT fakult) FROM stud;

-- 18. Знайти кількість студентів, які записані в хоча б один з гуртків.
SELECT COUNT(DISTINCT nums) FROM rob_gurt;  -- таблиця з відношенням студентів і гуртків

-- 19. Знайти дату останнього запису в гуртки.
SELECT MAX(datep) FROM rob_gurt;

-- 20. Знайти дату заснування найпершого гуртка.
SELECT MIN(datez) FROM gurt;

-- 21. Знайти кількість різних сум стипендій серед тих, які отримують студенти-фізики.
SELECT COUNT(DISTINCT stip) FROM stud WHERE fakult = 'Фізичний';

-- 22. Знайти першого по алфавіту студента-математика.
SELECT * FROM stud WHERE fakult = 'Математичний' ORDER BY name ASC LIMIT 1;

-- 23. Вивести відомості про наймолодшого студента фізичного факультету.
SELECT * FROM stud WHERE fakult = 'Фізичний' ORDER BY data DESC LIMIT 1;

-- 24. Вивести відомості про студента-математика, середній бал якого є найменшим.
SELECT * FROM stud WHERE fakult = 'Математичний' ORDER BY (e1 + e2 + e3) / 3.0 ASC LIMIT 1;

-- 25. Вивести прізвища перших трьох за успішністю студентів хімічного факультету.
SELECT name FROM stud WHERE fakult = 'Хімічний' ORDER BY (e1 + e2 + e3) / 3.0 DESC LIMIT 3;

-- 26. Знайти номер студента, який першим записався в один з гуртків.
SELECT nums FROM rob_gurt ORDER BY datep ASC LIMIT 1;

-- 27. Знайти кількість студентів-математиків, які народилися у травні.
SELECT COUNT(*) FROM stud WHERE fakult = 'Математичний' AND EXTRACT(MONTH FROM data) = 5;

-- 28. Знайти наймолодшого студента фізичного факультету, який святкує свій день народження зимою.
SELECT * FROM stud WHERE fakult = 'Фізичний' AND EXTRACT(MONTH FROM data) IN (12, 1, 2) ORDER BY data DESC LIMIT 1;

-- 29. Вивести відомості про студентів, які народилися 1 вересня.
SELECT * FROM stud WHERE EXTRACT(DAY FROM data) = 1 AND EXTRACT(MONTH FROM data) = 9;

-- 30. Вивести інформацію про гуртки, які були засновані в поточному місяці поточного року, впорядкувавши записи за прізвищами керівників.
SELECT * FROM gurt WHERE EXTRACT(MONTH FROM datez) = EXTRACT(MONTH FROM NOW()) AND EXTRACT(YEAR FROM datez) = EXTRACT(YEAR FROM NOW()) ORDER BY namek;
