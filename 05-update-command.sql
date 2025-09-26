######################        UPDATE ASSIGNMENT       ################################

use hr;
-- 1. Write a SQL statement to change the email column of the employees table with 'not available' for all employees.
UPDATE employees
SET EMAIL = 'not available';
   
-- 2. Write a SQL statement to change the email and commission_pct column of employees table with 'not available' and 0.10 for all employees.
UPDATE employees 
SET 
    EMAIL = 'not available',
    COMMISSION_PCT = 0.10;

-- 3. Write a SQL statement to change the email and commission_pct column of employees table with 'not available' and 0.10 for those employees whose department_id is 110.
UPDATE employees
SET EMAIL = 'not available',
    COMMISSION_PCT = 0.10
WHERE DEPARTMENT_ID = 110;

-- 4. Write a SQL statement to change the email column of employees table with 'not available' 
-- for those employees whose department_id is 80 and gets a commission_pct is less than .20
UPDATE employees
SET EMAIL = 'not available'
WHERE DEPARTMENT_ID = 80
  AND COMMISSION_PCT < 0.20;

--  5. Write a SQL statement to change the email column of the employees table with 'not available' for those employees who belong to the 'Accounting' department.
-- If department_id for Accounting is known (e.g., 100):
UPDATE employees
SET EMAIL = 'not available'
WHERE DEPARTMENT_ID = 100;

-- 6. Write a SQL statement to change the salary of an employee to 8000 whose ID is 105, if the existing salary is less than 5000.
UPDATE employees
SET SALARY = 8000
WHERE EMPLOYEE_ID = 105
  AND SALARY < 5000;

-- 7. Write a SQL statement to change the job ID of the employee whose ID is 118, to SH_CLERK if the employee belongs to 
-- the department, whose ID is 30 and the existing job ID does not start with SH.
UPDATE employees
SET JOB_ID = 'SH_CLERK'
WHERE EMPLOYEE_ID = 118
  AND DEPARTMENT_ID = 30
  AND JOB_ID NOT LIKE 'SH%';

-- 8. Write a SQL statement to increase the salary of employees under the department 40, 90 and 110 according to 
-- the company rules that salary will be increased by 25% for department 40, 15% for department 90 and 10% for department 110 and 
-- the rest of the departments will remain the same.
-- Update job salary range
UPDATE employees
SET SALARY = CASE
  WHEN DEPARTMENT_ID = 40 THEN SALARY * 1.25
  WHEN DEPARTMENT_ID = 90 THEN SALARY * 1.15
  WHEN DEPARTMENT_ID = 110 THEN SALARY * 1.10
  ELSE SALARY
END;


-- 9.Write a SQL statement to increase the minimum and maximum salary of PU_CLERK by 2000 as well as the salary for those employees by 20% and commission percent by .10.
-- Update job salary range
UPDATE jobs
SET MIN_SALARY = MIN_SALARY + 2000,
    MAX_SALARY = MAX_SALARY + 2000
WHERE JOB_ID = 'PU_CLERK';

-- Update employee salary and commission
UPDATE employees
SET SALARY = SALARY * 1.20,
    COMMISSION_PCT = COMMISSION_PCT + 0.10
WHERE JOB_ID = 'PU_CLERK';
