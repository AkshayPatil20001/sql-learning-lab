###################        Assignment on JOIN          ############################################

use hr_original;
select * from countries;
select * from employees;
select * from locations;
select * from regions;
select * from departments;
select * from job_history;
select * from jobs;

-- 1. Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
select d.department_name, d.location_id,l.street_address, l.city, l.state_province, c.country_new
from departments d join locations l on l.location_id=d.location_id join
countries c on c.country_id=l.country_id;

-- 2. Write a query to find the name (first_name, last name), department ID and name of all the employees
select concat(e.first_name, ' ', e.last_name)as full_name ,department_id from employees e;

-- 3. Write a query to find the name (first_name, last_name), job, department ID and name of the employees who works in London.
select concat(e.first_name, ' ', e.last_name)as full_name, d.department_name ,e.department_id, l.city
from employees e join departments d  on d.department_id=e.department_id
join locations l on l.location_id=d.location_id  where l.city='London';

-- 4. Write a query to find the employee id, name (last_name) along with their manager_id and name (last_name).
select e.employee_id, e.last_name,e.manager_id from employees e;

-- 5. Write a query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'.
select concat(first_name, ' ', last_name)as full_name, date(hire_date) from employees  where 
date(hire_date) >(select date(hire_date)from employees where last_name='Jones');

select concat(first_name, ' ', last_name)as full_name ,hire_date from employees where last_name='Jones';

-- 6. Write a query to get the department name and number of employees in the department.
select * from departments;
select d.department_name, count(e.employee_id) from employees
e join departments d on d.department_id=e.department_id group by department_name;
 
-- 7. Write a query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90.
select jh.employee_id, j.job_title, jh.start_date, jh.end_date, datediff( jh.end_date,jh.start_date)as date_diff 
from  job_history jh join jobs j on jh.job_id=j.job_id where jh.department_id=90 ;

-- 8. Write a query to display the department ID and name and first name of manager.
SELECT 
  d.department_id,
  d.department_name,
  e.first_name AS manager_first_name
FROM departments d
JOIN employees e ON d.manager_id = e.employee_id
ORDER BY d.department_id;

-- 9. Write a query to display the department name, manager name, and city.
select d.department_name,e.first_name as manager_first_name , l.city from employees e
join departments d on d.manager_id=e.employee_id join locations l
on l.location_id=d.location_id; 

-- 10. Write a query to display the job title and average salary of employees.
select j.job_title , avg(salary) from employees e 
join jobs j on j.job_id =e.job_id group by j.job_title;

-- 11. Write a query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job.
select j.job_title ,min(salary) from jobs j join
employees e on e.job_id=j.job_id group by j.job_title;


-- 12. Write a query to display the job history that were done by any employee who is currently drawing more than 10000 of salary.
-- 13. Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years.
