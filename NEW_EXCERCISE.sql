DROP DATABASE IF EXISTS COMPANYDB;
CREATE DATABASE COMPANYDB;
USE COMPANYDB;

-- Drop tables if they already exist (safe order because of FK)
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS DEPARTMENT;

CREATE TABLE DEPARTMENT (
    DNAME VARCHAR(20),
    DNUMBER INT PRIMARY KEY,
    MGRSSN VARCHAR(15),
    MGRSTARTDATE DATE
);

CREATE TABLE EMPLOYEE (
    FNAME VARCHAR(20),
    MINIT CHAR(1),
    LNAME VARCHAR(15),
    SSN VARCHAR(15) PRIMARY KEY,
    BDATE DATE,
    ADDRESS VARCHAR(100),
    SEX CHAR(1),
    SALARY INT,
    SUPERSSN VARCHAR(15),
    DNO INT,
    FOREIGN KEY (DNO) REFERENCES DEPARTMENT(DNUMBER)
);

INSERT INTO DEPARTMENT VALUES
('Research', 1, '111-11-1111', '2020-01-01'),
('Sales', 2, '222-22-2222', '2019-03-15'),
('HR', 3, '333-33-3333', '2021-06-10');

INSERT INTO EMPLOYEE
(FNAME,MINIT,LNAME,SSN,BDATE,ADDRESS,SEX,SALARY,SUPERSSN,DNO)
 VALUES
('John', 'A', 'Smith', '111-11-1111', '1990-05-12', 'Kathmandu', 'M', 50000, NULL, 1),
('Sara', 'B', 'Sharma', '222-22-2222', '1992-08-20', 'Lalitpur', 'F', 45000, '111-11-1111', 2),
('Ram', 'C', 'Thapa', '333-33-3333', '1999-02-15', 'Bhaktapur', 'M', 40000, '111-11-1111', 3),
('Laxman', 'K', 'Kumar', '444-44-4444', '1987-08-14', 'Syangja', 'M', 40000, '111-11-1111', 3),
('Riwaj', 'V', 'Adhikari', '555-55-5555', '1991-05-17', 'Bihar', 'M', 47000, '111-11-1111', 1);

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;
#ql. 10% Salary Raise for Research Department
select E.FNAME,E.LNAME,
E.SALARY * 1.1 AS increased_salary
from EMPLOYEE E
join DEPARTMENT D on E.DNO = D.DNUMBER
where D.DNAME = 'Research';
#2 Salary Statistics of Accounts Department
#sum, max, min, avg for department administration
select sum(SALARY) as Total from EMPLOYEE;
SELECT MAX(SALARY) AS HIGHEST_SALARY,
MIN(SALARY) AS LOWEST_SALARY,
AVG (SALARY) AS AVERAGE_SALARY FROM EMPLOYEE E JOIN DEPARTMENT D on E.DNO = D.DNUMBER WHERE D.DNAME='Sales';
#q3 Employees controlled by department no 5
select E.FNAME, E.LNAME from EMPLOYEE E
where E.DNO = 5;
#q4 Departments Having At Least 2 Employees
select D.DNAME, count(*) as Emp_count
from Employee E
join DEPARTMENT D on E.DNO = D.DNUMBER
group by D.DNUMBER, D.DNAME
HAVING count(*)>=2;
#q5 Employees Born in 1950 (1955-1999)
select * from EMPLOYEE 
where year(BDATE) between 1955 and 1999;