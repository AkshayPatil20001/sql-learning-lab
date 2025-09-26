create database assignment;
use assignment;-- 
show tables;
-- Q1.  Create a table students with columns: id (INT), name (VARCHAR, NOT NULL), and age (INT with default 18)
create table students(
id int, 
name varchar(20) not null,
age int default 18
);

-- Q2.  Insert into students: (1, NULL, 20). What will happen?
insert into students value(1,null,20);  -- It gives error saying column cannot be null
select *from students;

-- Q3.  Insert into students: (2, 'Ravi'). What will be stored in age?
insert into students values(2,'Ravi'); -- will not work because it expects 3 values
insert into students(id, name) values(2, 'Ravi');  -- will work

-- Q4. Why will the following query fail?INSERT INTO students (id) VALUES (3);
insert into students(id) values(3);  --  You didn’t provide values for name, which is NOT NULL.

-- Q5.  Modify the students table so that the age column default changes from 18 to 21.
alter table students alter column age set default 21;

-- Q6.  Drop the NOT NULL constraint on the name column. Write the query.
alter table students modify column name varchar(30);
desc students;

-- Q7.  Create a table department with columns: dept_id (INT, PRIMARY KEY), dept_name (VARCHAR).
create table department(
dept_id int primary key,
dept_name varchar(20)
);

-- Q8.  Insert (1,'IT') and (1,'HR'). What error will you get?
insert into department(dept_id, dept_name) values(1,'HR'),(1,'HR'); -- Duplicate entryy for primary key dept_id

-- Q9.  Can a table have two PRIMARY KEYS? Demonstrate with a query.
create table om
( name varchar(3),
id int primary key,  -- No, a table cannot have two separate PRIMARY KEY constraints.
mobile int primary key);

-- Q10. Create a table enrollment with composite primary key (student_id, course_id).
create table enrollment
(
student_id int,
course varchar(20),
course_id int,
primary key(student_id, course_id)
);
desc enrollment;
select * from enrollment;

-- Q11. Try inserting (101, 'DBMS') twice into enrollment. What happens?
insert into enrollment values(101, 'DBMS',1);
insert into enrollment values(101, 'DBMS',2);  
insert into enrollment values(103, 'DBMS',2);
insert into enrollment values(103, 'DBMS',2); -- error both student id and couurse id are repeated 
select * from enrollment;
## This creates a composite primary key on (student_id, course_id).
## It means: each student can enroll in a course only once, identified by the unique pair of student_id and course_id

-- Q12. Create a table users with columns: user_id (INT, PRIMARY KEY, AUTO_INCREMENT), email (VARCHAR, UNIQUE).
 create table users(
 user_id int primary key auto_increment,
 email varchar(30) unique
 );
 
 -- Q13. Insert ('abc@mail.com') twice. What error occurs?
 insert into users values(1,'abc@gmail.com');
 insert into users values(2,'abc@gmail.com'); -- Duplicat entry for key which is unique
 
 -- Q14.  Does the following query work? Why?
INSERT INTO users (email) VALUES (NULL);
INSERT INTO users (email) VALUES (NULL);  -- This is working null is treated as unique 
select * from users; 

-- Q15. Create a table products with UNIQUE constraint on (sku, region).
create table products(
sku varchar(20) unique,
region varchar(20) unique
);

-- Q16.  Insert (sku='A1', region='US') twice. What error?
insert into products values('A1', 'US');
insert into products values('A1', 'US');  -- Duplicate entry as we have set constraint as unique duplicate is not allowed

-- Q17. Create a table department with primary key dept_id. Then create employee table with foreign key dept_id referencing department.
drop table department;
create table department(
dept_id int primary key,
dept_name varchar(20)
);

create table employee(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
foreign key (dept_id) references department(dept_id) 
);
describe employee;

-- Q18.  Insert into employee (emp_id=1, name='Asha', dept_id=99) when no such dept exists. What error?
insert into employee values(1,'Asha',99); -- error foreign key constraint

## Imagine department is a list of valid hostel buildings, and employee is a list of students assigned to those hostels.
## If you try to assign a student to Hostel #99, but that hostel doesn’t exist, the system throws an error.
## This prevents “ghost references” and keeps your data clean.

-- Q19. Delete dept_id=1 from department when employees exist. What error without ON DELETE CASCADE?
insert into department values(12,'akshay');
insert into department values (13, 'Shiv');
select * from department;

insert into employee values(111,'anand',12);
insert into employee values(121, 'manav', 11); -- error foreign key constraint error code 1452
insert into employee values(122, 'nanda',12);
select * from employee;
describe employee;

delete from department where dept_id=12; -- error 
## The employee table has a record (Asha) that depends on dept_id = 1.
## Without ON DELETE CASCADE, MySQL blocks the deletion to prevent leaving orphaned records in employee.
## Imagine you’re managing hostel rooms:
		## department is the list of valid hostels.
		## employee is the list of students assigned to those hostels.
## If you try to delete Hostel #1, but students are still living there, 
## the system stops you—because it doesn’t want students assigned to a hostel that no longer exists.

-- Q20. Recreate employee table with ON DELETE CASCADE. What happens if you delete department 1?
drop table employee;
create table employee(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
foreign key (dept_id) references department(dept_id) 
on delete cascade
);

insert into employee values(111,'anand',12);
insert into employee values(121, 'manav', 11); -- error foreign key constraint error code 1452
insert into employee values(122, 'nanda',12);
insert into employee values(122, 'nanda',13);
select * from employee;
select * from department;
delete from department where dept_id=12;

-- Q21. Use ON DELETE SET NULL in the foreign key. What happens when parent is deleted?
drop  table employee;
create table employee(
emp_id int primary key,
emp_name varchar(20),
dept_id int,
foreign key (dept_id) references department(dept_id) 
on delete  set null
);

insert into department values(101,'IT');
insert into department values(102,'Phy');
select * from department;
select * from employee;
insert into employee values(122, 'nanda',102);
insert into employee values(123, 'tom',102);

delete from department where dept_id=13; -- set value null in placeof id

-- Q22.Write a query to drop a foreign key constraint fk_emp_dept.alter
drop tables employee,department;
CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
INSERT INTO department VALUES (1, 'IT'), (2, 'HR'), (3, 'Finance');

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);
INSERT INTO employee VALUES (101, 'Asha', 1), (102, 'Ravi', 2);

ALTER TABLE employee    -- -- ## Remove the rule that says dept_id in the employee 
DROP FOREIGN KEY fk_emp_dept; -- ## table must match a valid dept_id in the department table
## After Dropping 
## The employee.dept_id column becomes a regular column—no longer linked to department.
## You can now insert values like dept_id = 99 even if that department doesn’t exist.
## But this also means you lose referential integrity—your data can become inconsistent.

select * from employee;
desc employee;
INSERT INTO employee VALUES (103, 'Asha', 4);

-- Q23.  Add a new foreign key constraint fk_manager in employee table referencing itself (manager_id).
alter table employee add column manager_id int;

alter table employee add 
constraint fk_manager foreign key (manager_id)  references employee(emp_id);

-- Q24.  Create table accounts with balance >= 0 using CHECK.
create table account(
s_name varchar(20),
acc_bal decimal(10,2),
acc_id int primary key,
check (acc_bal >=0)
);

-- Q25.  Insert (id=1, balance=-100). What happens?
insert into account values('Param',100,1);

-- Q26. Modify the constraint so that balance must be between 100 and 1,000,000.
show create table account;

alter table account drop check account_chk_1;

alter table account add constraint
check (acc_bal between 100 and 1000000);

-- Q27.  Try to insert (id=2, balance=50). What error do you get?
insert into account values('Dharam',50,2);

-- Q28.  Create table invoices with invoice_id AUTO_INCREMENT PRIMARY KEY. Insert 3 rows. What will be the IDs?
create table invoices(
invoice_id int auto_increment primary key,
position varchar(10)
);
insert into invoices values(1,'First');
insert into invoices (position) values('Second');
insert into invoices (position) values('Third');
select * from invoices;

-- Q29.Delete last row. Insert again. Will AUTO_INCREMENT reuse the deleted number?
delete from  invoices where invoice_id=3;

-- Q30. Write queries to:Add a UNIQUE constraint on phone column in users.
					-- 	:Drop the UNIQUE constraint from users.
drop table users;
create table users(
user varchar(20),
phone int 
);
 -- adding unique constraint
alter table users
add constraint unique_phone unique(phone);
desc users;

insert into users values('Tanishq',2566127);
insert into users values('Pratish',2566127);  -- error violates uniqueness

-- Drop unique constraint
show create table users;
alter table users drop
index unique_phone;

insert into users values('Pratish',2566127); -- now works because we dropped uniqueness

-- Q31.Create a table library with a composite primary key (book_id, branch_id) and a UNIQUE constraint on (isbn, branch_id).

create table library(
book_id int ,
branch_id int,
isbn varchar(5),
primary key(book_id, branch_id),
unique(isbn,branch_id)
);
desc library;

-- Q32. Insert (book_id=1, branch_id=101, isbn='A123') twice. What error occurs?
insert into library values(1, 101,'A123');
insert into library values(1, 101,'A123'); -- Error Duplicate entry

-- Q33.  Insert (book_id=1, branch_id=102, isbn='A123'). Will it work? Why?
insert into library values(1,102, 'A123');

-- Q34 Can you have a table with PRIMARY KEY and multiple UNIQUE constraints? Write a query.
create table multiple_users (
    user_id int primary key,              -- Primary Key: unique and not null
    username varchar(50) unique,          -- Unique constraint #1
    email varchar(100) unique,            -- Unique constraint #2
    phone varchar(15),
    unique (phone)                        -- Unique constraint #3
);
INSERT INTO multiple_users VALUES (1, 'akshay', 'akshay@example.com', '9876543210');
INSERT INTO users VALUES (2, 'akshay', 'akshay2@example.com', '9876543211'); --  username duplicate
INSERT INTO users VALUES (3, 'neha', 'akshay@example.com', '9876543212');  --    email duplicate

-- Q35.  Try to create a table with both PRIMARY KEY(id) and UNIQUE(id). What happens?
create table test_table (
    id int primary key,
    name varchar(50),
    unique (id)
);

-- Q36.  Create table exam_results with composite primary key (student_id, exam_id) and CHECK constraint marks BETWEEN 0 AND 100.
create table exam_result(
student_id int,
exam_id int,
marks int,
primary key(student_id, exam_id),
check (marks between 0 and 100)
);

insert into exam_result values(1, 12, 45);
insert into exam_result values(1, 13, 55);
insert into exam_result values(2, 13, 56);
insert into exam_result values(1, 13, 58);  -- Dupplicate entry
insert into exam_result values(1, 13, 102); -- Constraint is violated

-- Q37. Create table orders referencing customers with ON UPDATE CASCADE. Update customer_id in parent – what happens in child?
show tables;
create table customers(
cust_id int primary key,
cust_name varchar(20)
);

create table orders(
product_name varchar(20),
product_id int primary key,
cust_id int,
foreign key (cust_id) references customers(cust_id)
on update cascade
);
insert into customers values(1, 'Amrit');
insert into customers values(2, 'Prabhat');

insert into orders values('LP', 21, 1);
insert into orders values('TV', 22, 1);
insert into orders values('DEsk', 24, 4); -- error
select * from customers;
select * from orders;

update customers set cust_id=5 where cust_id=1;

-- Q38.  Try to use ON DELETE SET DEFAULT in a foreign key. What happens in MySQL?
drop table orders;
create table orders(
product_name varchar(20),
product_id int primary key,
cust_id int,
foreign key (cust_id) references customers(cust_id)
on delete set default 
);
desc orders;
insert into orders values('LP', 21, 2);
insert into orders values('TV', 22, 2);

DELETE FROM customers WHERE cust_id = 2;
SELECT * FROM orders;

-- Q39.  Create a self-referencing foreign key categories(parent_id) referencing categories(id). Insert parent and child categories.
use assignment;
drop table categories;
create table categories (
    id int primary key,
    name varchar(50),
    parent_id int,
    foreign key (parent_id) references categories(id)
);

insert into categories VALUES (1, 'Electronics', NULL);
insert into categories VALUES (2, 'Books', NULL);
select * from categories;

INSERT INTO categories VALUES (3, 'Mobile Phones', 1);  -- Child of Electronics
INSERT INTO categories VALUES (4, 'Laptops', 1);        -- Child of Electronics
INSERT INTO categories VALUES (5, 'Fiction', 2);        -- Child of Books
INSERT INTO categories VALUES (6, 'Non-Fiction', 2);    -- Child of Books

INSERT INTO categories VALUES (7, 'Smartwatches', 99);  --  Error 1452

-- Q40. What happens if you delete a parent row in categories without ON DELETE CASCADE?
delete from categories where id=1; -- error cannoot delete

-- Q41.Write a query to temporarily disable foreign key checks and insert invalid data.
show create table categories;

alter table categories drop foreign key categories_ibfk_1;

INSERT INTO categories VALUES (7, 'Smartwatches', 99);  --  will execute any data 
select * from categories;

-- Q42. Write a query to re-enable foreign key checks.
delete from categories where parent_id=99;
alter table categories add
constraint categories_ibfk_1 foreign key  (parent_id) references categories(id);
INSERT INTO categories VALUES (7, 'Smartwatches', 99); -- error

-- Q43.  Explain with a query why indexes are automatically created when foreign keys are added.
CREATE TABLE demo1 (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE demo2 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES demo1(customer_id)
);
SHOW INDEX FROM demo1;
show index from customers;

-- Q44. Create a table employees with CHECK that salary > 20000.
drop table employee;

create table employee(
emp_name varchar(20),
emp_id int primary key
);
alter table employee add salary int check(salary >20000);
desc employee;
insert into employee value('Raghav',3,250000);
select * from employee;
insert into employee value('Raj',6,2500); -- Error code 

-- Q45. Insert (id=1, salary=15000). What error code will you get?
insert into employee value('Rohan',7,1500); -- Error code 

-- Q46.Add a CHECK constraint on gender column so only 'M' or 'F' is allowed.



