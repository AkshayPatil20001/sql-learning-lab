use hr_original;
#  STRING Assignment
-- 1. Write a query to display the FIRST_NAME and LAST_NAME concatenated as Full Name for all employees.
select concat(first_name, ' ', last_name) as full_name from employees;

-- 2. Write a query to display the FIRST_NAME in lowercase and the LAST_NAME in uppercase for all employees.
select upper(first_name), lower(last_name) from employees;

-- 3. Write a query to display the COUNTRY_NAME of all countries in uppercase.
select * from countries;
select upper(country_new) from countries;

-- 4. Write a query to display the FIRST_NAME and the length of the first name for all employees.
select first_name, length(first_name) from employees;

-- 5.Write a query to display the EMAIL and the length of the email address for employees whose email length is greater than 10
select email,length(email) from employees where length(email) > 5;
select * from employees;

-- 6. Write a query to extract the first three characters from the FIRST_NAME of all employees.
select substring(first_name, 1,3) from employees;

-- 7. Write a query to extract the last four characters of the PHONE_NUMBER for all employees.
select phone_number,substring(phone_number, length(phone_number)-3,length(phone_number)) from employees;

-- 8. Write a query to find the position of the letter 'a' in the LAST_NAME of all employees.
select last_name , locate('a',last_name ) from employees;

-- 9. Write a query to find the position of the substring 'IT' in the job title of all employees.
select * from employees;
select job_id , locate('IT',job_id ) from employees;

-- 10. Write a query to replace all occurrences of 'a' with 'X' in the FIRST_NAME of all employees.
select first_name, replace(first_name, 'a','x') from employees;

-- 11. Write a query to replace the region name 'Europe' with 'EU' in the REGION_NAME column.
select region_name, replace(region_name,'Europe','EU') from regions;

-- 12. Write a query to remove any leading and trailing spaces from the FIRST_NAME of all employees and display the cleaned-up names.
select first_name, trim(first_name) from employees;

-- 13. Write a query to remove any trailing spaces from the CITY names of all locations.
select city, rtrim(city) from locations;
select * from locations;

-- 14. Write a query to extract the first five characters from the EMAIL of all employees using the LEFT function.
select email, left(email, 5) from employees;

-- 15. Write a query to extract the last three characters from the COUNTRY_NAME of all countries using the RIGHT function.
select country_new, right(country_new,3) from countries;

-- 16. Write a query to extract the domain (everything after '@') from the EMAIL column of all employees.
select * from employee1;
select email, substring_index(email, '@',-1) as domain from employee1;

-- 17. Write a query to extract the country code (first part before space) from the PHONE_NUMBER of all employees.
select * from employees;
select phone_number, substring_index(phone_number, '.',1) as country_code from employees;

-- 18. Write a query to compare the FIRST_NAME and LAST_NAME of employees and display 0 if they are the same and a non-zero value if they are different.\
desc employee1;
insert into employee1 values(119, 'Rahul', 'Rahul', 'rahul.verma@example.com', '9876543218', '2018-08-20', 'DEV03', 58000.00, 0.11, 201, 10, TRUE);
select first_name, last_name,
if(first_name=last_name,0,1) from employee1;

-- 19. Write a query to compare the REGION_NAME of regions and display 0 if it is 'Asia' and 1 otherwise.
select * from regions;
select region_name, 
if(region_name='Asia',0,1)as check_regions from regions;

## Self made
CREATE TABLE regions1 (
    REGION_ID INT PRIMARY KEY,
    REGION_NAME VARCHAR(50),
    REGION_EMAIL VARCHAR(100)
);

INSERT INTO regions1 (REGION_ID, REGION_NAME, REGION_EMAIL) VALUES
(1, 'Asia', 'asia.team@example.com'),
(2, 'Europe', 'europe.team@company.org'),
(3, 'Africa', 'africa.team@global.net'),
(4, 'Asia ', 'asia.extra@domain.com'),         -- trailing space
(5, 'North America', 'na.team@worldwide.com'),
(6, 'South America', 'sa.team@continent.org'),
(7, 'Asia', 'asia.admin@region.in'),
(8, 'Australia', 'aus.team@pacific.com'),
(9, 'Asia', 'asia.support@cloud.io'),
(10, 'Europe', 'europe.admin@eurozone.eu');

select region_name, if(region_name='Asia',0,1) from regions1;

-- 20. Write a query to display the FIRST_NAME, LAST_NAME, and JOB_TITLE concatenated as a single string, with each value separated by a hyphen (-), for all employees.
select concat(first_name,' ', last_name, '-->', job_id) from employees;
select * from employees;


-- 21. Write a query to extract the username (portion before @) from the EMAIL column and display it along with the FIRST_NAME for all employees.
select * from employee1;
select email, substring_index(email, '@', 1) from employee1;

-- 22. Write a query to replace all occurrences of 'e' with 'E' in the LAST_NAME of employees whose LAST_NAME contains 'e'.
select last_name, replace(last_name, 'e', 'E') from employees;

-- 23. Write a query to find the position of the first occurrence of the letter 'o' in the FIRST_NAME of employees and display the name along with the position.
select first_name ,instr(first_name, 'o') from employees;

-- 24. Write a query to display the CITY name for all locations, removing any leading and trailing spaces, 
-- and also display the first three characters of the cleaned-up city name.
select city,trim(city)as trimmed, substring(city, 1,3)as first_three from locations;

-- 25. Write a query to find employees whose LAST_NAME contains the letter 'n' and display their LAST_NAME along with the position of the first occurrence of 'n'.
select last_name , instr(last_name, 'n') from employees;
show tables;
select * from locations;

-- 26. Write a query to find the position of the letter 'a' in the FIRST_NAME for all employees. Display the employee's first name and the position of the letter 'a'.
select first_name, instr(first_name ,'a') from employees;

-- 27. Write a query to display the position of the first occurrence of 'e' in the JOB_TITLE for all jobs, 
-- and display only those where the letter 'e' occurs after the 5th character.
select * from jobs;
select job_title , instr(job_title, 'e') from jobs where instr(job_title, 'e') > 5;

-- 28. Write a query to compare the FIRST_NAME and LAST_NAME of employees and display 
-- only those employees where the first name comes alphabetically before the last name
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE FIRST_NAME < LAST_NAME;

-- 29. Write a query to find all departments where the DEPARTMENT_NAME is either 'IT' or 'HR' using the FIND_IN_SET function.
select * from departments;
select department_name from departments where find_in_set(department_name, 'IT,HR') > 0;
SELECT FIND_IN_SET('HR', 'IT,HR,Finance,Admin') AS Position;

-- 30. Write a query to display the FIRST_NAME and the length of the name for employees whose FIRST_NAME length is greater than 6.
select first_name, length(first_name) as len from employees where length(first_name) > 6;

-- 31. Write a query to find all countries where the COUNTRY_NAME contains either 'China', 'India', or 'Japan'
select * from countries;
select country_new from countries where country_new in ('India', 'China', 'Japan');


-- 32. Write a query to find all employees who have DEPARTMENT_ID present in the list (50, 60, 70)
select * from employees;
select * from employees where department_id in (50, 60, 70);

-- 33. Write a query to extract the first two characters from the COUNTRY_NAME function and the last two characters displaying them along with the full COUNTRY_NAME.
select * from countries;
select country_new, substring(country_new, 1,2) from countries;

-- 34. Write a query to display employees whose LAST_NAME contains the letter 'o' at a position greater than half the length of their last name.
select last_name, instr(last_name, 'o') from employees where
instr(last_name, 'o') > length(last_name)/2;

-- 35. Write a query to find employees whose FIRST_NAME contains the letter 'a' and the letter 'e' and display the positions of both.
select first_name, instr(first_name, 'o'),instr(first_name, 'a') from employees;

-- 36. Write a query to extract the domain from the EMAIL column for employees and only display employees whose domain is 'example.com'.
SELECT FIRST_NAME, LAST_NAME, EMAIL
FROM EMPLOYEES
WHERE SUBSTRING_INDEX(EMAIL, '@', -1) = 'example.com';

-- 37. Write a query to count the number of employees who belong to department IDs 50, 60, or 70
select department_id , count(employee_id) from employees where department_id in(50, 60, 70) group by department_id;
select count(department_id) from employees where department_id=50;

-- 38. Write a query to display all COUNTRY_NAMEs from the countries table where REGION_ID is either 1 or 3 
select * from countries where region_id in(1, 3);

-- 39. Write a query to find employees who either work in departments 50, 60, or 70 or have a salary greater than 10,000.
select * from employees where department_id in (50, 60, 70) or salary > 10000;

-- 40. Write a query to find employees whose DEPARTMENT_ID is either 50 or 60 and their MANAGER_ID is either 103 or 108.
select *from employees where department_id in (50, 60) and manager_id in (103, 108);