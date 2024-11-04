CREATE DATABASE NEWWORK;
USE NEWWORK;

-- Creating Employee table
CREATE TABLE employee (
    empid SERIAL PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
  );

-- Inserting data into Employee table
INSERT INTO employee (name, department, salary) VALUES
('Alice Smith', 'HR', 55000.00),
('Bob Johnson', 'HR', 55000.00),
('Charlie Brown', 'HR', 60000.00),
('David Lee', 'HR', 62000.00),
('Emma Watson', 'IT', 65000.00),
('Franklin Adams', 'IT', 70000.00),
('Grace Taylor', 'Finance', 75000.00),
('Henry Ford', 'Admin', 80000.00);

-- Creating Department table
CREATE TABLE department (
    dep_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(50)
);

-- Inserting data into Department table
INSERT INTO department (department_name, location) VALUES
('HR', 'Headquarters'),
('Admin', 'Central Office'),
('IT', 'Tech Park'),
('Finance', 'Financial District'),
('Sales', 'Sales Complex'),
('Marketing', 'Marketing Hub');

-- 1. Select all employees from the HR department:
SELECT * FROM EMPLOYEE WHERE department="HR";

-- 2. Count the number of employees in each department:
SELECT DEPARTMENT, COUNT(*) AS NO_OF_EMPLOYEES FROM EMPLOYEE GROUP BY department;

-- 3. Find employees with a salary greater than the average salary:
SELECT AVG(salary) FROM employee;
SELECT * FROM employee WHERE salary > (SELECT AVG(salary) FROM employee);

-- 4. Find departments with more than 2 employees:
SELECT DEPARTMENT FROM EMPLOYEE GROUP BY DEPARTMENT HAVING COUNT(*)>2;

-- 5. List employees along with their department information:
SELECT E.empid,E.name,D.dep_id,D.department_name,D.location 
FROM EMPLOYEE AS E INNER JOIN DEPARTMENT AS D 
ON E.department=D.department_name;

-- 6. List all departments and their employees, even if there are no employees assigned:
SELECT department.department_name, department.location, employee.name, employee.salary
FROM department 
LEFT JOIN employee ON department.department_name = employee.department;

-- 7. Find the highest salary among all employees:
SELECT MAX(SALARY) FROM EMPLOYEE;

-- 8. Find the average salary for each department:
SELECT DEPARTMENT,AVG(SALARY) AVG_SALARY FROM EMPLOYEE GROUP BY DEPARTMENT;

-- 9. Calculate the total salary for each department:
SELECT DEPARTMENT,SUM(SALARY) TOTAL_SALARY FROM EMPLOYEE GROUP BY DEPARTMENT;

-- 10. Rank employees by salary within each department:
SELECT name,department,salary FROM EMPLOYEE ORDER BY SALARY DESC;

-- 11. Find the employee with the highest salary in each department:
SELECT * FROM employee AS e 
WHERE (e.department, e.salary) IN (SELECT department, MAX(salary) FROM employee GROUP BY department);

-- 12. List employees whose names start with 'A':
SELECT * FROM employee WHERE name LIKE 'A%';

-- 13. Find employees with salaries between 60000 and 80000
SELECT * FROM employee WHERE salary BETWEEN 60000 AND 80000;

-- 14. List departments located in 'Headquarters' or 'Tech Park':
SELECT * FROM department WHERE location IN ('Headquarters', 'Tech Park');

-- 15. Count the number of employees per character length of their name:
SELECT LENGTH(name) AS name_length, COUNT(*) AS employee_count FROM employee GROUP BY name_length;

-- 16. Find employees whose name contains 'son':
SELECT * FROM employee WHERE name LIKE '%son%';

-- 17. Find the employee with the lowest salary:
SELECT * FROM employee ORDER BY salary ASC LIMIT 1;

-- 18. Find employees whose department is not 'HR':
SELECT * FROM employee WHERE department <> 'HR';

-- 19. List employees with a salary greater than 60000 and sorted by salary in descending order:
SELECT * FROM employee WHERE salary > 60000 ORDER BY salary DESC;

-- 20. List all employees along with their department and location, but only for departments with more than 1 employee:
SELECT employee.empid, employee.name, department.department_name, department.location
FROM employee
JOIN department ON employee.department = department.department_name
WHERE employee.department IN (
    SELECT department
    FROM employee
    GROUP BY department
    HAVING COUNT(empid) > 1
);


-- 21. Find the department with the highest average salary among employees:
SELECT department 
FROM employee 
GROUP BY department 
ORDER BY AVG(salary) DESC 
LIMIT 1;

-- 22. List all employees who have the same salary as at least one other employee:
SELECT * FROM employee WHERE salary IN (SELECT salary FROM employee GROUP BY salary HAVING COUNT(*) > 1);

-- 23. Find the employee(s) with the highest salary in each location:
SELECT e.*
FROM employee e
JOIN department d ON e.department = d.department_name
WHERE (d.location, e.salary) IN (SELECT location, MAX(salary) FROM employee JOIN department ON employee.department = department.department_name GROUP BY location);

-- 24. List all departments and the average salary of employees within each department, sorted by average salary in descending order:
SELECT department, AVG(salary) AS average_salary FROM employee GROUP BY department ORDER BY average_salary DESC;

-- 25. Find the employee(s) with the highest salary who are not in the 'Admin' department:
SELECT * FROM employee WHERE salary = (SELECT MAX(salary) FROM employee WHERE department <> 'Admin');

-- 26. Find the employee(s) with the second-highest salary:
SELECT * FROM employee WHERE salary = (SELECT DISTINCT salary FROM employee ORDER BY salary DESC LIMIT 1 OFFSET 1);
