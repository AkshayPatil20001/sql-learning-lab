#########################   SUBQUERY ASSIGNMENT      ########################################
use hr_original;

-- 1. Write a query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee whose last_name='Bull'. 
select concat(first_name, '', last_name) as full_name , salary from employees
where salary >(select salary from employees where last_name='Bull');

select last_name, salary from employees where last_name='Bull';  -- Just verifying 

-- 2. Write a query to find the name (first_name, last_name) of all employees who works in the IT department.
select concat(e.first_name, ' ', e.last_name) as full_name , d.department_name
from employees e join departments d on d.DEPARTMENT_ID=e.DEPARTMENT_ID where d.DEPARTMENT_NAME='IT'; 

SELECT first_name, last_name
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE department_name = 'IT'
);

-- 3. Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department. 
-- Hint : Write single-row and multiple-row subqueries
select concat(first_name, ' ', last_name) as full_name from employees
where MANAGER_ID is not null and department_id in (select department_id from departments
where location_id in 
(select location_id from locations where country_id='US')
);

SELECT 
  e.first_name,
  e.last_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.manager_id IS NOT NULL
  AND l.country_id = 'US';


-- 4. Write a query to find the name (first_name, last_name) of the employees who are managers. 
select concat(e.first_name, ' ', e.last_name) as full_name
from employees e join departments d on e.employee_id=d.manager_id;

select concat(first_name, ' ', last_name) as full_name from employees 
where employee_id in (select manager_id from departments);

-- 5. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary. 
select concat(first_name, ' ', last_name) as full_name ,
salary from employees  where salary  >(select avg(salary) from employees );

-- 6. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their job grade. 
select concat(first_name, ' ', last_name) as full_name,
salary from employees where
salary =(select min_salary from jobs where jobs.job_id=employees.JOB_ID);

-- 7. Write a query to find the name (first_name, last_name), and salary of the employees who earns more than 
-- the average salary and works in any of the IT departments. 

select concat(e.first_name, ' ', e.last_name) as full_name , e.salary, d.department_name
from employees e join departments d on e.DEPARTMENT_ID=d.DEPARTMENT_ID 
where d.DEPARTMENT_NAME='IT' and  e.SALARY > (select avg(SALARY) from employees);

select SALARY,concat(first_name, ' ', last_name) as full_name 
from employees where DEPARTMENT_ID=(select DEPARTMENT_ID from departments where DEPARTMENT_NAME='IT')
and SALARY > (select avg(SALARY) from employees);

-- 8. Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earning of Mr. Bell.
select SALARY,concat(first_name, ' ', last_name) as full_name 
from employees where salary >(select salary from employees where last_name='Bell') ;

-- 9. Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary as the minimum salary for all departments.
select SALARY,concat(first_name, ' ', last_name) as full_name , salary
from employees where salary=(select min(salary) from employees);

-- 10. Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary of all departments.
select SALARY,concat(first_name, ' ', last_name) as full_name , salary 
from employees where salary > (select avg(salary) from employees);

-- 11. Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is 
-- higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest. 
select concat(first_name, ' ', last_name)as full_name, 
salary from employees where salary > (select avg(salary) from employees where job_id='Sh_clerk')
order by salary asc;

select salary from employees where job_id='Sh_clerk';

-- 12. Write a query to find the name (first_name, last_name) of the employees who are not supervisors. 
select concat(first_name, ' ', last_name)as full_name, 
job_id from employees where
job_id =any(select job_id from jobs where not job_title='Supervisor');

select concat(e.first_name, ' ', e.last_name)as full_name, 
e.job_id, j.job_title from employees e join jobs j on j.job_id=e.job_id
where j.job_title !='Supervisor';
              
              ## Look at this query again there is self referencing in these table
              
-- 13. Write a query to display the employee ID, first name, last name, and department names of all employees. 
select employee_id, first_name, last_name,
(select department_name from departments where departments.department_id=employees.department_id) as department_name
from employees;

SELECT 
  e.employee_id,
  e.first_name,
  e.last_name,
  d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY e.employee_id;

-- 14. Write a query to display the employee ID, first name, last name, salary of all 
-- employees whose salary is above average for their departments.
select employee_id, first_name, last_name,salary from employees
where salary > any(select avg(e.salary) from  employees e 
join departments d on d.department_id=e.department_id group by d.department_name
);

select avg(e.salary), d.department_name from  employees e 
join departments d on d.department_id=e.department_id group by d.department_name;

-- 15. Write a query to fetch even numbered records from the employees table.
select * from employees where employee_id %2=0;

select * from employees where employee_id in (select employee_id from employees where employee_id %2=0); 

-- 16. Write a query to find the 5th maximum salary in the employees table. 
select distinct salary from employees order by salary desc;

select distinct salary from employees where
salary = (select distinct salary from employees order by salary desc limit 1 offset 4);

-- 17. Write a query to find the 4th minimum salary in the employees table.
select distinct salary from employees order by salary asc;
 
select distinct salary from employees where
salary = (select distinct salary from employees order by salary asc limit 1 offset 3);

-- 18. Write a query to select the last 10 records from a table. 
select * from employees order by employee_id desc limit 10;

select * from (select * from employees order by employee_id desc limit 10)as last10 order by employee_id asc;
## This above query retains the original order

-- 19. Write a query to list the department ID and name of all the departments where no employee is working. 
select e.department_id, d.department_name from employees e
join departments d on e.department_id=d.department_id where d.department_id is not null and employee_id is null;

SELECT department_id, department_name
FROM departments
WHERE department_id NOT IN ( 
    SELECT DISTINCT department_id
    FROM employees
    WHERE department_id IS NOT NULL
);

## Look for this query 

-- 20. Write a query to get 3 maximum salaries. 
select distinct salary  from employees
where salary  in (select distinct salary from employees )order by salary desc limit 3;

-- 21. Write a query to get 3 minimum salaries. 
select distinct salary  from employees
where salary  in (select distinct salary from employees )order by salary asc limit 3;

-- 22. Write a query to get nth max salaries of employees. 
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- 23. Write a query that returns all employees who have a salary greater than the average salary of their department.
SELECT e.employee_id, e.first_name, e.last_name, e.salary, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (
  SELECT AVG(e2.salary)
  FROM employees e2
  WHERE e2.department_id = e.department_id
);



select avg(e.salary)as avg, d.department_name from employees e
join departments d on d.department_id =e.department_id group by department_name; 

-- 24. Write a query that returns the names of all departments that have more than 10 employees.
select count(employee_id)as no_of, department_id from employees
group by department_id having no_of > 10;

SELECT department_name
FROM departments
WHERE department_id IN (
  SELECT department_id
  FROM employees
  WHERE department_id IS NOT NULL
  GROUP BY department_id
  HAVING COUNT(employee_id) > 10
);


select count(e.employee_id)as no_of , d.department_name from employees e
join departments d on d.department_id=e.department_id group by d.department_name
having no_of > 10;

-- 25. Write a query that returns the names of all employees who work in departments 
-- that have a total salary greater than $1,000,000.
select concat(e.first_name , ' ', e.last_name)as full_name,
d.department_name from employees e join departments d 
on d.department_id=e.department_id 
where e.department_id in (SELECT department_id
  FROM employees 
  group by department_id 
  having sum(salary)>100000);
  
  
select sum(e.salary)as summ, d.department_name from employees e
join departments d on d.department_id =e.department_id group by department_name
having summ > 100000;

-- 26. Write a query that returns the average salary of all employees who have been with the company for less than 3 years.
select  avg(e.salary)from employees e
join job_history jh on e.employee_id=jh.employee_id 
where timestampdiff(year, jh.start_date,jh.end_date) < 3 ;

select avg(salary) from employees 
where employee_id in (select employee_id from job_history where timestampdiff(year, start_date,end_date) < 3);



-- 27. Write a query that returns the names of all employees who have the same manager as the employee with ID 123.
select concat(first_name, ' ', last_name)as full_name
from employees where employee_id=123 and employee_id in (select manager_id from departments);

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE manager_id = (
  SELECT manager_id
  FROM employees
  WHERE employee_id = 123
);

-- Didn't understand these question 

-- 28. Write a query that returns the department name and average salary of the department with the highest average salary.
select avg(e.salary)as average, d.department_name from employees e
join departments d on e.department_id=d.department_id group by department_name
order by average desc limit 1;

SELECT department_name, average_salary
FROM (
  SELECT d.department_name, AVG(e.salary) AS average_salary
  FROM employees e
  JOIN departments d ON e.department_id = d.department_id
  GROUP BY d.department_name
) AS dept_avg
ORDER BY average_salary DESC
LIMIT 1;

-- 29. Write a query that returns the names of all employees who have a salary greater than the highest salary in the sales department.
select concat(e.first_name, ' ', e.last_name)as full_name,e.salary, d.department_name
from employees e left join departments d on d.department_id=e.department_id where 
e.salary >(select max(salary) from employees 
where department_id=(select department_id from departments where
department_name='Sales'));

-- Tried to check average salary of department Sales just to verify
(select max(salary) from employees 
where department_id=(select department_id from departments where
department_name='Sales'));

-- After doing downward part I understand i have to use left join
select * from employees where salary > 14000; 

-- 30. Write a query that returns the names of all employees who have a manager with a salary greater than $100,000.
select concat(e.first_name, ' ', e.last_name) as full_name, e.salary
from employees e
join employees m on e.manager_id = m.employee_id
where m.salary > 10000;

select concat(first_name, ' ', last_name) as full_name, salary
from employees  where manager_id in (
  select employee_id
  from employees
  where salary > 10000
);

-- Just to verify if anyone has salary greater than 1 lakh.
select salary from employees where salary > 100000;

-- 31. Write a query that returns the names of all departments that have at least one employee who has been with the company for more than 5 years
select department_name from departments
where department_id in 
(select department_id  from  employees where 
timestampdiff(year, hire_date, curdate()) > 5) ;


-- 32. Write a query that returns the name and salary of the employee with the second-highest salary in the company.
select distinct salary, concat(first_name, ' ',last_name) as full_name 
from employees
where salary =(select distinct salary from employees order by salary desc limit 1 offset 1);

select salary from employees order by salary desc;
