create database assignment3;
use assignment3;
-- Create 'customers' table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    address VARCHAR(100)
);

-- Create 'employees' table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age VARCHAR(10),  -- This will be modified later to INT
    salary DECIMAL(10, 2),
    department_id INT
);

-- Create 'contacts' table
CREATE TABLE contacts (
    contact_id INT PRIMARY KEY,
    name VARCHAR(50),
    address VARCHAR(100)  -- This will be renamed later to 'home_address'
);

-- Create 'departments' table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Create 'students' table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- Create 'users' table
CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100)  -- This will have a unique constraint added later
);

-- Create 'inventory' table
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    quantity INT  -- Default value will be set later
);

-- Create 'products' table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Create 'locations' table
CREATE TABLE locations (
    location_id INT,
    street_address VARCHAR(100),
    postal_code VARCHAR(20),
    city VARCHAR(50),
    state_province VARCHAR(50),  -- This will be renamed to 'state' later
    country_id VARCHAR(2),
    PRIMARY KEY (location_id)
);

-- Create 'job_history' table
CREATE TABLE job_history (
    employee_id INT,
    job_id VARCHAR(10),
    department_id INT,
    start_date DATE,
    end_date DATE
);

-- Create 'jobs' table
CREATE TABLE jobs (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(50),
    min_salary DECIMAL(10, 2),
    max_salary DECIMAL(10, 2)
);


-- 1. Write a query to add a new column named 'phone_number' of type VARCHAR(20) to a table named 'customers'.
describe customers;
alter table customers add column
phone_number varchar(20);

-- 2. Write a query to modify the data type of the column 'age' in a table named 'employees' to INT.
describe employees;
alter table employees modify column age int;

-- 3. Write a query to rename the column 'address' to 'home_address' in a table named 'contacts'.
describe contacts;
alter table contacts rename column address to home_address;

-- 4. Write a query to add a foreign key constraint named 'fk_department' to a column named 'department_id' 
-- in a table named 'employees', referencing the 'department_id' column in a table named 'departments'.
describe employees;
alter table employees add constraint fk_department
foreign key (department_id) references departments(department_id);

-- 5. Write a query to drop the primary key constraint from a table named 'students'.
describe students;
alter table students drop primary key;

-- 6. Write a query to add a unique constraint named 'uc_email' to a column named 'email' in a table named 'users'.
desc users;
alter table users add constraint uc_email unique(email);

-- 7. Write a query to add a default value of '0' to a column named 'quantity' in a table named 'inventory'.
desc inventory;
alter table inventory alter column quantity set default 0;

-- 8. Write a query to modify the position of the column 'last_name' to be the first column in a table named 'customers'.
desc customers;
alter table customers modify column last_name varchar(50) first;
alter table customers modify column email varchar(50) after customer_id; -- emailmoved to position 3

-- 9. Write a query to change the auto-increment value of a column named 'product_id' to start from 1001 in a table named 'products'.
desc products;
alter table products modify column
product_id int auto_increment, auto_increment=1001;
insert into products(product_name, price) values('Akshay',45000);
select * from products;

-- 10. Write a query to add a check constraint named 'chk_salary' to a column named 'salary' in a table named 'employees', 
--  ensuring that the salary is greater than or equal to 2000.
desc employees;
alter table employees add constraint chk_salary  check(salary >=2000);

####################################################################################################################
##																												  ##
## 																												  ##
##																												  ##						
####################################################################################################################
-- Based on hr database
use hr_original;
-- 1. Write a SQL statement to rename the table countries to country_new.
desc countries;
alter table countries rename column country_name to country_new;

-- 2. Write a SQL statement to add a column region_id to the table locations.
desc locations;
alter table locations add column region_id int;

-- 3. Write a SQL statement to add a column ID as the first column of the table locations.
alter table locations modify column region_id int first;

-- 4. Write a SQL statement to add a column region_id after state_province to the table locations.
alter table locations modify column region_id int after state_province;
desc locations;

-- 5. Write a SQL statement to change the data type of the column country_id to integer in the table locations.
desc locations;-- 
alter table locations modify column country_id int;

-- 6. Write a SQL statement to drop the column city from the table locations.
desc locations;
alter table locations drop column city;

-- 7. Write a SQL statement to change the name of the column state_province to state, keeping the data type and size same.
alter table locations change state_province  state varchar(100);

-- 8. Write a SQL statement to add a primary key for the columns location_id in the locations table.
alter table locations add constraint primary key(location_id);

-- 9. Write a SQL statement to add a primary key for a combination of columns location_id and country_id.
desc locations;
alter table locations drop primary key;
alter table locations add constraint primary key(location_id, country_id);

-- 10. Write a SQL statement to drop the existing primary from the table locations on a combination of columns location_id and country_id.
alter table locations drop primary key;

-- 11. Write a SQL statement to add a foreign key on the job_id column of the job_history table referencing the primary key job_id of jobs table.
desc jobs;
alter table job_history add constraint
fk_job foreign key(job_id) references  jobs (job_id);
desc job_history;

-- 12. Write a SQL statement to add a foreign key constraint named fk_job_id on the job_id column of the job_history 
--     table referencing the primary key job_id of the jobs table.
alter table job_history add constraint fk_job_id  foreign key(job_id) 
references jobs (job_id);

-- 13. Write a SQL statement to drop the existing foreign key fk_job_id from the job_history table on job_id column which is referencing the job_id of jobs table.
alter table job_history drop  foreign key fk_job_id;
desc job_history;
alter table job_history drop  foreign key fk_job;

-- 14. Write a SQL statement to add an index named indx_job_id on job_id column in the table job_history.
alter table job_history 
add index indx_job_id (job_id);
show index from job_history;
desc job_history;

-- 15. Write a SQL statement to drop the index indx_job_id from job_history table.
alter table job_history
drop index indx_job_id;

-- 16.  Write a query to change the length of the email column in the customers table to VARCHAR(150).
select * from customers;
desc customers;
alter table customers modify email varchar(150);

-- 17. Write a query to add a new column status of type VARCHAR(10) with a default value of 'active' to the employees table.
desc employees;
alter table employees add column status varchar(10) default 10;

-- 18. Write a query to drop the phone_number column from the customers table.
desc customers;
alter table customers drop column phone_number;

-- 19. Write a query to modify the department_name column in the departments table to ensure it cannot contain NULL values.
desc departments;
alter table departments modify department_name varchar(50) not null;

-- 20. Write a query to drop the UNIQUE constraint on the email column in the users table.
use assignment3;
desc users;
show indexes from users;  -- 0 for non unique
alter table users drop constraint uc_email;

-- 21. Write a query to rename the inventory table to product_inventory.
desc inventory;
alter table inventory rename product_inventory; 
desc product_inventory;

-- 22.Write a query to add a foreign key constraint on the employee_id column of the job_history table, 
--  referencing the employee_id column of the employees table, with ON DELETE CASCADE.
desc job_history;
alter table job_history add constraint foreign key (employee_id) references
employees(employee_id) on delete cascade;

-- 23.Write a query to change the default value of the status column in the employees table to 'inactive'. 
desc employees;
alter table employees modify status varchar(10) default 'inactive';

-- 24.Write a query to drop the foreign key constraint named fk_department from the employees table.
desc employees;
show indexes from employees;
alter table employees drop foreign key fk_department;

-- 25.Write a query to move the salary column to be after the last_name column in the employees table.
desc employees;
alter table employees modify column salary decimal(10,2) after last_name ;

-- 26.Write a query to remove the default value from the status column in the employees table.
show indexes from employees;
alter table employees modify status varchar(10) ;

-- 27. Write a query to rename the uc_email constraint on the email column in the users table to unique_email_constraint.
-- here we have to drop constraint  uc_email and again
-- Drop the old constraint
-- Recreate it with the new name unique_email_constraint
desc users;
show indexes from users;
ALTER TABLE users
ADD CONSTRAINT uc_email
UNIQUE (email);

alter table users drop index uc_email ;

alter table users add constraint unique_email_address unique (email);
desc users;

-- 28.Write a query to disable the foreign key constraint fk_department on the employees table and then re-enable it.
SET FOREIGN_KEY_CHECKS = 0;   -- disable foreign key globally
SET FOREIGN_KEY_CHECKS = 1;  -- enable foreign keys globally

SHOW CREATE TABLE employees;

-- drop foreign key constraint
alter table employees
drop index fk_department;

-- again add
alter table employees
add constraint fk_department foreign key
(department_id) references departments (department_id);

-- 29.Write a query to change the age column in the employees table to SMALLINT and allow it to accept NULL values.
desc employees;
alter table employees modify age smallint;

