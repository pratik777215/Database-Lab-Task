create database TechSolutionDB;
use TechSolutionDB;

create table DEPARTMENT(
DeptID int primary key auto_increment,
DeptName varchar(255) not null,
Location varchar(255)
);

create table EMPLOYEE(
EmpID int primary key auto_increment,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Gender varchar(10) not null,
Salary Decimal(10,2) not null,
HireDate date not null,
DeptID int not null,
foreign key(DeptID) references DEPARTMENT(DeptID)
);

create table PROJECT(
ProjectID int primary key auto_increment,
ProjectName varchar(255) not null,
StartDate date not null,
EndDate date,
Budget Decimal(10,2)not null
);

create table WORKS_ON(
EmpID int not null,
ProjectID int not null,
HoursWorked Decimal not null,
Primary key(EmpID, ProjectID),
foreign key (EmpID) references EMPLOYEE(EmpID),
foreign key (ProjectID) references Project(ProjectID)
);


INSERT INTO DEPARTMENT (DeptName, Location) VALUES
('Engineering',       'New York'),
('Human Resources',   'Chicago'),
('Finance',           'Los Angeles'),
('Marketing',         'San Francisco'),
('Information Technology', 'Austin'),
('Operations',        'Seattle');



INSERT INTO EMPLOYEE (FirstName, LastName, Gender, Salary, HireDate, DeptID) VALUES
('James',   'Carter',   'Male',   72000.00, '2019-03-15', 1),
('Sarah',   'Mitchell', 'Female', 65000.00, '2020-07-01', 2),
('David',   'Thompson', 'Male',   89000.00, '2018-11-20', 3),
('Emily',   'Johnson',  'Female', 76000.00, '2021-01-10', 1),
('Michael', 'Brown',    'Male',   95000.00, '2017-06-25', 5),
('Jessica', 'Lee',      'Female', 58000.00, '2022-04-18', 4),
('Robert',  'Wilson',   'Male',   81000.00, '2019-09-30', 6),
('Ashley',  'Davis',    'Female', 70000.00, '2020-12-05', 3);



INSERT INTO PROJECT (ProjectName, StartDate, EndDate, Budget) VALUES
('Cloud Migration',         '2023-01-10', '2023-09-30', 150000.00),
('ERP System Upgrade',      '2022-06-01', '2023-03-31', 200000.00),
('Mobile App Development',  '2023-03-15', '2023-12-31', 120000.00),
('Cybersecurity Audit',     '2023-05-01', '2023-07-31',  50000.00),
('Data Analytics Platform', '2023-02-20', NULL,          175000.00),
('Website Redesign',        '2023-07-01', '2024-01-31',  80000.00);



INSERT INTO WORKS_ON (EmpID, ProjectID, HoursWorked) VALUES
(1, 1, 120),
(1, 3, 80),
(2, 4, 60),
(3, 2, 200),
(4, 1, 150),
(5, 5, 180),
(6, 6, 95),
(7, 2, 110),
(8, 5, 140);

# update the salary of employee 1 by increasing it by 10%
update EMPLOYEE set Salary = Salary * 1.1 where EmpID = 1;

select * from EMPLOYEE;

#Delete a project whose ProjectID is 5
delete from WORKS_ON where ProjectID= 5;
delete from PROJECT where ProjectId = 5;

# Display all employees who earn more than 50000
select * from EMPLOYEE where Salary > 50000;

# Display FirstName,LastName and Salary of employees sorted by salary in desending order.
select FirstName, LastName, Salary from EMPLOYEE order by Salary desc;

# Display Employees who belong to the It Department.
select E.EmpID, E.FirstName, E.LastName, E.Gender, E.Salary, E.HireDate from EMPLOYEE E
join DEPARTMENT D on E.DeptID = D.DeptID where D.DeptName = 'Information Technology';

# show the total number of employees in each department
select DeptName,COUNT(*) as total_Employees from EMPLOYEE E
Join DEPARTMENT D
on E.DeptID=D.DeptID group by DeptName;

# Display Employees who were hired after january 1 2020.
Select * from EMPLOYEE where HireDate > '2020-01-01';

#Display employee names along with their department names
Select E.FirstName, E.LastName, E.Salary, D.DeptName
from EMPLOYEE E join DEPARTMENT D on E.DeptID = D.DeptID;

# show employees and the project they are working on
Select E.FirstName, E.LastName, P.ProjectName
from EMPLOYEE E join WORKS_ON W on E.EmpID = W.EmpID
join PROJECT P on W.ProjectID = P.ProjectID;

# Display Project Names with total hours worked by employees name

select P.ProjectName, sum(w.HoursWorked) AS TotalHoursWorked from PROJECT P
join WORKS_ON W on P.ProjectID = W.ProjectID
group by P.ProjectName;

#Part E
#Find the Average Salary of employees in each department
select D.DeptName, avg(E.Salary) AS AverageSalary
from DEPARTMENT D
join EMPLOYEE E on D.DeptID = E.DeptID
GROUP BY D.DeptName;

# Display the Department with the highest number of employees
select d.deptname, count(e.empid) as totalemployees from department d
join employee e on d.deptid = e.deptid
group by d.deptname order by totalemployees desc
limit 1;

# find the employees whose salary is gerater than the average of all employee
select empid, firstname, lastname, salary
from employee
where salary > (select avg(salary) from employee);

# create a view named high salary employees that shows employees with salary greater than 60000.
CREATE VIEW HighSalaryEmployeess AS
SELECT EmpID, FirstName, LastName, Salary
FROM EMPLOYEE
WHERE Salary > 5000;


# To check the view
SELECT * FROM HighSalaryEmployeess;
# create an index on the LastName  columns of the EMPLOYEE table.
# create an index on the LastName column of the EMPLOYEE table
CREATE INDEX idx_lastname
ON EMPLOYEE(LastName);
