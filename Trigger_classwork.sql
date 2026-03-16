CREATE DATABASE BankDB;
USE BankDB;

# ACCOUNTS TABLE
CREATE TABLE accounts(
account_id INT PRIMARY KEY,
account_holder VARCHAR(100),
balance DECIMAL(10,2)
);

INSERT INTO accounts VALUES
(1,'Ram',50000),
(2,'Shyam',10000),
(3,'Sita',20000);

# Transaction: Transfer Rs 5000 from Ram to Shyam
START TRANSACTION;

UPDATE accounts
SET balance = balance - 5000
WHERE account_id = 1;

UPDATE accounts
SET balance = balance + 5000
WHERE account_id = 2;

COMMIT;


# Transaction: Transfer from Shyam to Sita and demonstrate ROLLBACK
START TRANSACTION;

UPDATE accounts
SET balance = balance - 10000
WHERE account_id = 2;

UPDATE accounts
SET balance = balance + 10000
WHERE account_id = 3;

ROLLBACK;


# Transaction demonstrating SAVEPOINT
START TRANSACTION;

UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 1;

SAVEPOINT sp1;

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 2;

ROLLBACK TO sp1;

COMMIT;


# -------------------------
# TRIGGERS
# -------------------------

# Create employee table
CREATE TABLE employee (
emp_id INT PRIMARY KEY,
name VARCHAR(100),
salary DECIMAL(10,2)
);

# Create salary_log table
CREATE TABLE salary_log(
log_id INT AUTO_INCREMENT PRIMARY KEY,
emp_id INT,
old_salary DECIMAL(10,2),
new_salary DECIMAL(10,2),
updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


# BEFORE INSERT trigger (salary must be >=10000)
DELIMITER $$

CREATE TRIGGER check_salary
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
IF NEW.salary < 10000 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Salary must be atleast 10000';
END IF;
END$$

DELIMITER ;


# AFTER UPDATE trigger to record salary changes
DELIMITER $$

CREATE TRIGGER log_salary_update
AFTER UPDATE ON employee
FOR EACH ROW
BEGIN
INSERT INTO salary_log(emp_id, old_salary, new_salary)
VALUES (OLD.emp_id, OLD.salary, NEW.salary);
END$$

DELIMITER ;


# -------------------------
# STORED PROCEDURES
# -------------------------

# Procedure to retrieve all employees
DELIMITER $$

CREATE PROCEDURE getEmployees()
BEGIN
SELECT * FROM employee;
END$$

DELIMITER ;

CALL getEmployees();


# Procedure to insert a new employee
DELIMITER $$

CREATE PROCEDURE addEmployee(
IN p_id INT,
IN p_name VARCHAR(100),
IN p_salary DECIMAL(10,2)
)
BEGIN
INSERT INTO employee VALUES(p_id, p_name, p_salary);
END$$

DELIMITER ;

CALL addEmployee(5,'Hari',20000);


# Procedure to update employee salary
DELIMITER $$

CREATE PROCEDURE updateEmployeeSalary(
IN p_emp_id INT,
IN p_new_salary DECIMAL(10,2)
)
BEGIN
UPDATE employee
SET salary = p_new_salary
WHERE emp_id = p_emp_id;
END$$

DELIMITER ;

CALL updateEmployeeSalary(5,25000);

# create a stored procedure that tranfers money between two accounts using a transaction.alter
Delimiter $$
create procedure transferMoney(
in from_account int, in to_account int,
in amount decimal)
begin
start transaction;
UPDATE accounts
SET balance = balance - amount
where account_id = from_account;
update accounts
set balance = balance + amount
where account_id = to_account;
commit;
end $$
Delimiter ;
call transferMoney(1,2,5000);