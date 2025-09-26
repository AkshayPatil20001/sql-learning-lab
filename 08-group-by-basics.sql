##############################   Assignment on Group by and Order by     ################################3
use northwind;
-- 1.Write a SQL query to find the number of employees hired in each year.
select * from employees;
select count(employee_id) emp_hired_each_year, year(hire_date) from employees
group by year(hire_date);

-- 2. Write a SQL query to find the number of employees in each department.
select count(employee_id) emp_each_department, title from employees
group by title;

-- 3. Write a SQL query to find the department with the highest total salary.
use hr_original;
-- Department with highest Salary
SELECT department_id, SUM(salary) AS total
FROM employees
GROUP BY department_id
ORDER BY total DESC
LIMIT 1;


-- 4. Write a query to list the number of jobs available in the employees table.
use northwind;
select * from employees;
SELECT COUNT(DISTINCT JOB_ID) AS JOB_COUNT
FROM EMPLOYEES;



-- 5. Write a query to get the total salaries payable to employees.
use hr_original;
select * from employees;
select sum(salary)as total_salary from employees;

-- 6. Write a query to get the minimum salary from the employees table.
select min(salary) as min_sal from employees;

-- 7. Write a query to get the maximum salary of an employee working as a Programmer. 
select max(salary) as max_sal,job_id  from employees where 
job_id='IT_PROG';

-- 8. Write a query to get the average salary and number of employees working the department 90. 
select avg(salary), count(employee_id) from employees where  department_id=90;

-- 9. Write a query to get the highest, lowest, sum, and average salary of all employees. 
select avg(salary)as avereage1, min(salary)minimum, max(salary)maxi from employees;

-- 10. Write a query to get the number of employees with the same job
use northwind;
select * from employees;
select count(employee_id), title from employees
group by title;

-- 11. Write a query to get the difference between the highest and lowest salaries. 
use hr_original;
select max(salary)-min(salary) as differnce, max(salary)mx, min(salary)mn from employees;

-- 12. Write a query to find the manager ID and the salary of the lowest-paid employee for that manager. 
select * from employees;
select min(salary) , manager_id from employees group by manager_id;
select min(salary), manager_id from employees where manager_id=103; -- For my assurance like manually checking 

-- 13. Write a query to get the department ID and the total salary payable in each department.
select department_id , sum(salary)as total_salary from employees
group by department_id;

select sum(salary), department_id from employees where department_id=10; -- rechecking

-- 14. Write a query to get the average salary for each job ID excluding programmer. 
select avg(salary), job_id from employees where job_id !='IT_PROG' group by job_id;

-- 15. Write a query to get the total salary, maximum, minimum, average salary of employees 
-- (job ID wise), for department ID 90 only. 
select sum(salary) , max(salary), min(salary), avg(salary)
,job_id from employees where department_id=90 group by job_id;

-- 16. Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000.
select job_id, max(salary)mx from employees group by job_id having mx>=4000;

-- 17. Write a query to get the average salary for all departments employing more than 10 employees.
select avg(salary) , count(department_id)ct from employees group by department_id 
having ct > 10;