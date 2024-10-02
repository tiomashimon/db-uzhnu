-- Створюємо базу даних
CREATE DATABASE my_university_db;

-- Підключаємось до бази даних
\c my_university_db;

-- Створюємо таблицю Stud
CREATE TABLE Stud (
  NumS SERIAL PRIMARY KEY,
  Name VARCHAR(100),
  Data DATE,
  Fakult VARCHAR(100),
  Kurs INT,
  E1 INT,
  E2 INT,
  E3 INT,
  Stip DECIMAL
);

-- Створюємо таблицю Gurt
CREATE TABLE Gurt (
  NumG SERIAL PRIMARY KEY,
  NameG VARCHAR(100),
  NameK VARCHAR(100),
  DateZ DATE
);

-- Створюємо таблицю Rob_Gurt
CREATE TABLE Rob_Gurt (
  NumS INT,
  NumG INT,
  DateP DATE,
  Robota VARCHAR(100),
  PRIMARY KEY (NumS, NumG),
  FOREIGN KEY (NumS) REFERENCES Stud(NumS) ON DELETE CASCADE,
  FOREIGN KEY (NumG) REFERENCES Gurt(NumG) ON DELETE CASCADE
);
