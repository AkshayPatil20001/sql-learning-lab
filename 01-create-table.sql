show databases;
create database assignment4;
use assignment4;

##############################            Create table Assignment 4         #######################################
 -- 1.Write a SQL statement to create a simple table of countries including columns country_id,country_name and region_id.
 create table countries(
 country_id int primary key,
 country_name varchar(20),
 region_id int unique
 );
 
-- 2. Write a SQL statement to create a simple table of countries including columns country_id,country_name and region_id which already exists.
 create table countries(
 country_id int primary key,
 country_name varchar(20),
 region_id int unique
 );
desc countries;

-- 3. Write a SQL statement to create the structure of a table dup_countries similar to countries.
drop table dup_countries;
create table dup_countries like countries;   -- create duplication of all table including constraint
create table dup_countries select * from countries; -- Only schema not constraint
desc dup_countries;

-- 4. Write a SQL statement to create a duplicate copy of countries table including structure and data by name dup_countries.
create table dup_countries like countries;   -- create duplication of all table including constraint

-- 5. Write a SQL statement to create a table where countries set a constraint NULL.
create table locations(
countries varchar(20) null,
id int);

-- 6. Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, 
--    max_salary and check whether the max_salary amount exceeds the upper limit 25000.
create table jobs(
job_id int primary key,
job_title varchar(30),
salary int check(salary  <= 25000));

-- 7. Write a SQL statement to create a table named countries including columns country_id, 
--    country_name and region_id and make sure that no countries except Italy, India and China will be entered in the table.
drop table countries;
create table countries (
country_id int primary key,
country_name varchar(30),
region_id int unique,
check (country_name in ('India', 'Italy', 'China')));

insert into countries values(1, 'India', 45);
insert into countries values(1, 'Australia', 45); -- Constrant violated

-- 8. Write a SQL statement to create a table named job_histry including columns employee_id, start_date, end_date, 
--    job_id and department_id and make sure that the value against column end_date will be entered at the time of insertion to the format like '--/--/----'.
CREATE TABLE job_histry (
  employee_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date VARCHAR(10) NOT NULL,
  job_id INT,
  department_id INT,
  CHECK (end_date LIKE '__/__/____')
);

-- 9. Write a SQL statement to create a table named countries including columns country_id,
--    country_name and region_id and make sure that no duplicate data against column country_id will be allowed at the time of insertion.
drop table countries;
create table countries (
country_id int primary key,
country_name varchar(30),
region_id int unique,
check (country_name in ('India', 'Italy', 'China')));

-- 10. Write a SQL statement to create a table named jobs including columns job_id, job_title,
-- min_salary and max_salary, and make sure that, the default value for job_title is blank and min_salary is 
-- 8000 and max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.
drop table jobs;
create table jobs(
job_id int primary key,
job_title varchar(30),
min_sal int default 8000,
max_sal int default null);

-- 11. Write a SQL statement to create a table named countries including columns country_id, 
-- country_name and region_id and make sure that the country_id column will be a key field which 
-- will not contain any duplicate data at the time of insertion.
drop table countries;
create table countries (
country_id int primary key,
country_name varchar(30),
region_id int unique,
check (country_name in ('India', 'Italy', 'China')));

-- 12. Write a SQL statement to create a table countries including columns country_id,
-- country_name and region_id and make sure that the column country_id will be unique and store an auto incremented value.
drop table countries;
create table countries (
country_id int primary key auto_increment,
country_name varchar(30),
region_id int unique,
check (country_name in ('India', 'Italy', 'China')));

-- 13. Write a SQL statement to create a table countries including columns country_id, 
-- country_name and region_id and make sure that the combination of columns country_id and region_id will be unique.
drop table countries;
create table countries (
country_id int primary key,
country_name varchar(30),
region_id int unique,
unique(country_id, region_id));

-- 14. Write a SQL statement to create a table job_history including columns employee_id, 
-- start_date, end_date, job_id and department_id and make sure that, the employee_id column 
-- does not contain any duplicate value at the time of insertion and the foreign key column 
-- job_id contain only those values which are exists in the jobs table.
-- Here is the structure of the table jobs;
-- +------------+--------------+------+-----+---------+-------+
-- | Field      | Type         | Null | Key | Default | Extra |
-- +------------+--------------+------+-----+---------+-------+
-- | JOB_ID     | varchar(10)  | NO   | PRI |         |       |
-- | JOB_TITLE  | varchar(35)  | NO   |     | NULL    |       |
-- | MIN_SALARY | decimal(6,0) | YES  |     | NULL    |       |
-- | MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
-- +------------+--------------+------+-----+---------+-------+
drop table job_history;
CREATE TABLE job_history (
job_id varchar(10) primary key  default '' ,
job_title varchar(35) not null,
min_salary decimal(6,0),
max_salary decimal(6,0)
);
desc job_history;

-- 15. Write a SQL statement to create a table employees including columns employee_id, 
-- first_name, last_name, email, phone_number hire_date, job_id, salary, commission, 
-- manager_id and department_id and make sure that, the employee_id column does not contain any duplicate 
-- value at the time of insertion and the foreign key columns combined by department_id and manager_id columns contain 
-- only those unique combination values, which combinations are exists in the departments table.
-- Assume the structure of departments table below.
-- +-----------------+--------------+------+-----+---------+-------+
-- | Field           | Type         | Null | Key | Default | Extra |
-- +-----------------+--------------+------+-----+---------+-------+
-- | DEPARTMENT_ID   | decimal(4,0) | NO   | PRI | 0       |       |
-- | DEPARTMENT_NAME | varchar(30)  | NO   |     | NULL    |       |
-- | MANAGER_ID      | decimal(6,0) | NO   | PRI | 0       |       |
-- | LOCATION_ID     | decimal(4,0) | YES  |     | NULL    |       |
-- +-----------------+--------------+------+-----+---------+-------+

drop table employees;
CREATE TABLE employees (
employee_id varchar(10) ,
first_name varchar(35) ,
last_name varchar (20),
email varchar(20), 
department_name varchar(30) not null,
phone_number  int,
hire_date date, 
job_id int , 
salary int,
commission decimal(5,2) not null, 
manager_id decimal(4,0) not null default 0, 
department_id decimal(4,0) not null default 0,
primary key(department_id, manager_id)
);


-- 17. Write a SQL statement to create a table employees including 
-- columns employee_id, first_name, last_name, job_id, salary and make sure that,
-- the employee_id column does not contain any duplicate value at the time of insertion, 
-- and the foreign key column job_id, referenced by the column job_id of jobs table, can contain
--  only those values which are exists in the jobs table. The InnoDB Engine have been used to create 
--  the tables. The specialty of the statement is that, The ON UPDATE CASCADE action allows you to perform 
--  cross-table update and ON DELETE RESTRICT action reject the deletion. The default action is ON DELETE RESTRICT.
-- Assume that the structure of the table jobs and InnoDB Engine have been used to create the table jobs.
CREATE TABLE IF NOT EXISTS jobs ( 
JOB_ID integer NOT NULL UNIQUE PRIMARY KEY, 
JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
MIN_SALARY decimal(6,0) DEFAULT 8000, 
MAX_SALARY decimal(6,0) DEFAULT NULL
)ENGINE=InnoDB;


-- +------------+--------------+------+-----+---------+-------+
-- | Field      | Type         | Null | Key | Default | Extra |
-- +------------+--------------+------+-----+---------+-------+
-- | JOB_ID     | int(11)      | NO   | PRI | NULL    |       |
-- | JOB_TITLE  | varchar(35)  | NO   |     |         |       |
-- | MIN_SALARY | decimal(6,0) | YES  |     | 8000    |       |
-- | MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
-- +------------+--------------+------+-----+---------+-------+


-- 18. Write a SQL statement to create a table employees including columns employee_id, first_name, 
-- last_name, job_id, salary and make sure that, the employee_id column does not contain 
-- any duplicate value at the time of insertion, and the foreign key column job_id, referenced 
-- by the column job_id of jobs table, can contain only those values which are exists in the jobs 
-- table. The InnoDB Engine have been used to create the tables. The specialty of the statement is 
-- that, The ON DELETE CASCADE that lets you allow to delete records in the employees(child) table that 
-- refer to a record in the jobs(parent) table when the record in the parent table is deleted and the ON UPDATE RESTRICT actions reject any updates.
-- Assume that the structure of the table jobs and InnoDB Engine have been used to create the table jobs.
CREATE TABLE IF NOT EXISTS jobs ( 
JOB_ID integer NOT NULL UNIQUE PRIMARY KEY, 
JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
MIN_SALARY decimal(6,0) DEFAULT 8000, 
MAX_SALARY decimal(6,0) DEFAULT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS employees (
  employee_id INT NOT NULL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  job_id INT,
  salary DECIMAL(8,2),
  FOREIGN KEY (job_id)
    REFERENCES jobs(job_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

-- +------------+--------------+------+-----+---------+-------+
-- | Field      | Type         | Null | Key | Default | Extra |
-- +------------+--------------+------+-----+---------+-------+
-- | JOB_ID     | int(11)      | NO   | PRI | NULL    |       |
-- | JOB_TITLE  | varchar(35)  | NO   |     |         |       |
-- | MIN_SALARY | decimal(6,0) | YES  |     | 8000    |       |
-- | MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
-- +------------+--------------+------+-----+---------+-------+


-- 19. Write a SQL statement to create a table employees including columns employee_id, 
-- first_name, last_name, job_id, salary and make sure that, the employee_id column does 
-- not contain any duplicate value at the time of insertion, and the foreign key column job_id, 
-- referenced by the column job_id of jobs table, can contain only those values which are exists in the 
-- jobs table. The InnoDB Engine have been used to create the tables. The specialty of the statement is 
-- that, The ON DELETE SET NULL action will set the foreign key column values in the child table(employees) 
-- to NULL when the record in the parent table(jobs) is deleted, with a condition that the foreign key column 
-- in the child table must accept NULL values and the ON UPDATE SET NULL action resets the values in the rows in 
-- the child table(employees) to NULL values when the rows in the parent table(jobs) are updated.
-- Assume that the structure of two table jobs and InnoDB Engine have been used to create the table jobs.
CREATE TABLE IF NOT EXISTS jobs ( 
JOB_ID integer NOT NULL UNIQUE PRIMARY KEY, 
JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
MIN_SALARY decimal(6,0) DEFAULT 8000, 
MAX_SALARY decimal(6,0) DEFAULT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS employees (
  employee_id INT NOT NULL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  job_id INT,
  salary DECIMAL(8,2),
  FOREIGN KEY (job_id)
    REFERENCES jobs(job_id)
    ON DELETE CASCADE
    ON UPDATE RESTRICT
) ENGINE=InnoDB;

-- +------------+--------------+------+-----+---------+-------+
-- | Field      | Type         | Null | Key | Default | Extra |
-- +------------+--------------+------+-----+---------+-------+
-- | JOB_ID     | int(11)      | NO   | PRI | NULL    |       |
-- | JOB_TITLE  | varchar(35)  | NO   |     |         |       |
-- | MIN_SALARY | decimal(6,0) | YES  |     | 8000    |       |
-- | MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
-- +------------+--------------+------+-----+---------+-------+



-- 20. Write a SQL statement to create a table employees including columns employee_id, first_name, last_name,
--  job_id, salary and make sure that, the employee_id column does not contain any duplicate value at the 
--  time of insertion, and the foreign key column job_id, referenced by the column job_id of jobs table, 
--  can contain only those values which are exists in the jobs table. The InnoDB Engine have been used to
--  create the tables. The specialty of the statement is that, The ON DELETE NO ACTION and the ON UPDATE NO 
--  ACTION actions will reject the deletion and any updates.
-- Assume that the structure of two table jobs and InnoDB Engine have been used to create the table jobs.
CREATE TABLE IF NOT EXISTS jobs ( 
JOB_ID integer NOT NULL UNIQUE PRIMARY KEY, 
JOB_TITLE varchar(35) NOT NULL DEFAULT ' ', 
MIN_SALARY decimal(6,0) DEFAULT 8000, 
MAX_SALARY decimal(6,0) DEFAULT NULL
)ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS employees (
  employee_id INT NOT NULL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  job_id INT,
  salary DECIMAL(8,2),
  FOREIGN KEY (job_id)
    REFERENCES jobs(job_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- +------------+--------------+------+-----+---------+-------+
-- | Field      | Type         | Null | Key | Default | Extra |
-- +------------+--------------+------+-----+---------+-------+
-- | JOB_ID     | int(11)      | NO   | PRI | NULL    |       |
-- | JOB_TITLE  | varchar(35)  | NO   |     |         |       |
-- | MIN_SALARY | decimal(6,0) | YES  |     | 8000    |       |
-- | MAX_SALARY | decimal(6,0) | YES  |     | NULL    |       |
-- +------------+--------------+------+-----+---------+-------+
