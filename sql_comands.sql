-- 7) В подключенном MySQL репозитории создать базу данных “Друзья человека”
CREATE DATABASE IF NOT EXISTS man_friend;

USE man_friend;
-- 8) Создать таблицы с иерархией из диаграммы в БД
CREATE TABLE IF NOT EXISTS animals
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    Class_name VARCHAR(20)
);

INSERT INTO animals (Class_name)
VALUES 
('pack_animals'),
('pets');

CREATE TABLE IF NOT EXISTS pack_animals
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    genus VARCHAR(20),
    class_id INT DEFAULT 1,
    FOREIGN KEY (class_id) REFERENCES animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pack_animals (genus)
VALUES
('camels'),
('horses'),
('donkeys');

CREATE TABLE IF NOT EXISTS pets
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    genus VARCHAR(20),
    class_id INT DEFAULT 2,
    FOREIGN KEY (class_id) REFERENCES animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO pets (genus)
VALUES
('dogs'),
('cats'),
('hamsters');

-- 9) Заполнить низкоуровневые таблицы именами(животных), командами которые они выполняют и датами рождения
CREATE TABLE IF NOT EXISTS dogs
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    birthdate DATE,
    commands VARCHAR(50),
    genus_id INT DEFAULT 1,
    FOREIGN KEY (genus_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO dogs (name, birthdate, commands)
VALUES
('Jack', '1997-10-15', 'lie, run'),
('Rex', '2008-11-15', 'jump, lie'),
('Jerry','2022-05-16', 'run,sit, come here');

CREATE TABLE IF NOT EXISTS cats
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    birthdate DATE,
    commands VARCHAR(50),
    genus_id INT DEFAULT 2,
    FOREIGN KEY (genus_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO cats (name, birthdate, commands)
VALUES
('Tom', '2009-01-16', 'ks-ks-ks'),
('Barsik', '2015-01-16', '');

CREATE TABLE IF NOT EXISTS hamsters
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    birthdate DATE,
    commands VARCHAR(50),
    genus_id INT DEFAULT 3,
    FOREIGN KEY (genus_id) REFERENCES pets (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO hamsters (name, birthdate, commands)
VALUES
('Stich', '2009-01-16', ''),
('Apolon', '2021-01-16', '');

CREATE TABLE IF NOT EXISTS camels
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    birthdate DATE,
    commands VARCHAR(50),
    genus_id INT DEFAULT 1,
    FOREIGN KEY (genus_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO camels (name, birthdate, commands)
VALUES
('Jon', '2012-09-17', 'go ahead'),
('Victor', '2022-01-16', '');
 
 CREATE TABLE IF NOT EXISTS horses
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    birthdate DATE,
    commands VARCHAR(50),
    genus_id INT DEFAULT 2,
    FOREIGN KEY (genus_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO horses (name, birthdate, commands)
VALUES
('Stela', '2021-10-16', 'go ahead, stop'),
('Arrow', '2019-11-11', 'stop');

 CREATE TABLE IF NOT EXISTS donkeys
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    birthdate DATE,
    commands VARCHAR(50),
    genus_id INT DEFAULT 3,
    FOREIGN KEY (genus_id) REFERENCES pack_animals (id) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO donkeys (name, birthdate, commands)
VALUES
('Steve', '2017-03-26', 'go ahead');

-- 10) Удалив из таблицы верблюдов, т.к. верблюдов решили перевезти в другой питомник на зимовку.
-- Объединить таблицы лошади, и ослы в одну таблицу.
DELETE FROM camels;

SELECT name, birthdate, commands FROM horses
UNION SELECT name, birthdate, commands FROM donkeys;

-- 11) Создать новую таблицу “молодые животные” в которую попадут все животные старше 1 года, но младше 3 лет 
-- и в отдельном столбце с точностью до месяца подсчитать возраст животных в новой таблице
DROP TEMPORARY TABLE IF EXISTS temp_animals;
CREATE TEMPORARY TABLE temp_animals AS
SELECT *, 'Собаки' as genus FROM dogs
UNION SELECT *, 'Кошки' as genus FROM cats
UNION SELECT *, 'Хомяки' as genus FROM hamsters
UNION SELECT *, 'Ослы' as genus FROM donkeys
UNION SELECT *, 'Лошади' as genus FROM horses;

CREATE TABLE young_animal AS
SELECT name, birthdate, commands, genus, TIMESTAMPDIFF(MONTH, birthdate, CURDATE()) AS age_in_month
FROM temp_animals WHERE birthdate BETWEEN ADDDATE(curdate(), INTERVAL -3 YEAR) AND ADDDATE(CURDATE(), INTERVAL -1 YEAR);
 
SELECT * FROM young_animal;

-- 12) Объединить все таблицы в одну, при этом сохраняя поля, указывающие на прошлую принадлежность к старым таблицам.
SELECT h.name, h.birthdate, h.commands, pa.genus, ya.age_in_month 
FROM horses h
LEFT JOIN young_animal ya ON ya.name = h.name
LEFT JOIN pack_animals pa ON pa.id = h.genus_id
UNION
SELECT d.name, d.birthdate, d.commands, pa.genus, ya.age_in_month
FROM donkeys d
LEFT JOIN young_animal ya ON ya.name = d.name
LEFT JOIN pack_animals pa ON pa.id = d.genus_id
UNION
SELECT d.name, d.birthdate, d.commands, p.genus, ya.age_in_month
FROM dogs d
LEFT JOIN young_animal ya ON ya.name = d.name
LEFT JOIN pets p ON p.id = d.genus_id
UNION
SELECT c.name, c.birthdate, c.commands, p.genus, ya.age_in_month
FROM cats c
LEFT JOIN young_animal ya ON ya.name = c.name
LEFT JOIN pets p ON p.id = c.genus_id
UNION
SELECT ha.name, ha.birthdate, ha.commands, p.genus, ya.age_in_month
FROM hamsters ha
LEFT JOIN young_animal ya ON ya.name = ha.name
LEFT JOIN pets p ON p.id = ha.genus_id    






