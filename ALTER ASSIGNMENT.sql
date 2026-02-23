create database pratikpariyar;
use pratikpariyar;
CREATE TABLE DEPT (
    DeptNO INT PRIMARY KEY,
    DName VARCHAR(255),
    LOC VARCHAR(255)
);
alter table DEPT rename as Department;
alter table Department ADD PINCODE varchar(10) NOT NULL;
alter table Department rename column DName to DeptAdd;
alter table Department modify LOC CHAR (10);
select * from Department;

DROP Table Department;