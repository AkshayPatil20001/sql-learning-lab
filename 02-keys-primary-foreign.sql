------------------------------ Assignment 1  ----------------------------------------

create database assignment;
use assignment;
-- 1) 
create table department(
dept_id int primary key,
dept_name varchar(20)
);

-- 2)
create table employee(
emp_id int primary key,
emp_name varchar(20),
salary int,
dept_id int,
foreign key (dept_id) references department(dept_id)
);

-- PArt B Data Insertion
insert into department(dept_id,dept_name) 
values(1,'IT'),
(2,'CS'),
(3,'Pharma');

insert into employee values(112, 'Shiva', 20000, 1);
insert into employee values(113, 'Bob', 25000, 2);
insert into employee values(114, 'Samuel', 30000, 3);
 
 ## Upper 3 wiil work but lower will not work because it shows error code 1452 hich means
 ## if you try to insert an employee with a dept_id that's not present in department, my sql 
 ## gives error.

-- insert into employee values(115, 'Shivam', 35000, 4);
-- insert into employee values(116, 'Shree', 5000, 5);

######################################################################################################
## Below is a example
-- Create Department table
CREATE TABLE Department1 (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);
-- Create Employee table with foreign key referencing Department
use assignment;
drop tables employee1, department1;
CREATE TABLE Employee1 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary INT CHECK (salary > 0),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department1(dept_id)
);
INSERT INTO Department1 (dept_id, dept_name)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO Employee1(emp_id, emp_name, salary, dept_id)
VALUES
(101, 'Akshay', 50000, 1),
(102, 'Vishwa', 45000, 2),
(103, 'Dev', 47000, 1),
(104, 'Riya', 42000, 3)
(105, 'Karan', 48000, 2);

##########################################################################################################
select * from department1;
select * from employee1;
-- Part c Queries to solve
-- 4) 
select e.emp_name, d.dept_name from employee1 e
inner join department1 d on e.dept_id=d.dept_id;

-- 5)
select e.emp_name, d.dept_name from employee1 e
inner join department1 d on e.dept_id=d.dept_id where dept_name='IT';

-- 6)
select d.dept_name, count(e.dept_id) from department1 d
inner join employee1 e on e.dept_id=d.dept_id group by e.dept_id;

-- 7)
INSERT INTO Employee1 (emp_id, emp_name, salary, dept_id)
VALUES (109, 'Meena', 53000, 3);

-- 8)
INSERT INTO Employee1 (emp_id, emp_name, salary, dept_id)
VALUES (112, 'Meena', 53000, 10);
-- error code 1452 Foreign key constraints protect your data from becoming inconsistent.

-- 9)
SET SQL_SAFE_UPDATES = 0;
DELETE FROM department1 WHERE dept_name = 'Finance';
SET SQL_SAFE_UPDATES = 1; -- (optional) turn it back on


delete from  department1 where dept_name='Finance';

-- 10) 
## Part D Advanced taks

---------------------------------------------------- -----------------------------------------
-- 10)
-- Create Department table
CREATE TABLE Department2 (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);
-- Create Employee table with foreign key referencing Department
CREATE TABLE Employee2 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary INT CHECK (salary > 0),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department2(dept_id)
    on delete cascade
);
INSERT INTO Department2 (dept_id, dept_name)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO Employee2(emp_id, emp_name, salary, dept_id)
VALUES
(101, 'Akshay', 50000, 1),
(102, 'Vishwa', 45000, 2),
(103, 'Dev', 47000, 1),
(104, 'Riya', 42000, 3),
(105, 'Karan', 48000, 2);

-- 10)
delete from department2 where dept_id=3;

select * from department2;

-- 11)
delete from department where dept_name='Finance';

------------------------------------------------------------------------------------------------------------------------- ------

CREATE TABLE Department3 (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);
-- Create Employee table with foreign key referencing Department

CREATE TABLE Employee3 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary INT CHECK (salary > 0),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department3(dept_id)
    on update  cascade
);
INSERT INTO Department3 (dept_id, dept_name)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO Employee3(emp_id, emp_name, salary, dept_id)
VALUES
(101, 'Akshay', 50000, 1),
(102, 'Vishwa', 45000, 2),
(103, 'Dev', 47000, 1),
(104, 'Riya', 42000, 3),
(105, 'Karan', 48000, 2);

UPDATE Department3 SET dept_id = 99 WHERE dept_id = 3;
select * from department3;

--------------------------------------------------------------------------

CREATE TABLE Department4 (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL
);
-- Create Employee table with foreign key referencing Department
use assignment;

CREATE TABLE Employee4 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50) NOT NULL,
    salary INT CHECK (salary > 0),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department4(dept_id)
    on delete set null 
);
INSERT INTO Department4 (dept_id, dept_name)
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

INSERT INTO Employee4(emp_id, emp_name, salary, dept_id)
VALUES
(101, 'Akshay', 50000, 1),
(102, 'Vishwa', 45000, 2),
(103, 'Dev', 47000, 1),
(104, 'Riya', 42000, 3),
(105, 'Karan', 48000, 2);

DELETE FROM Department4 WHERE dept_id = 2;

select * from employee4;
SELECT * FROM Employee4 WHERE dept_id IS NULL;


