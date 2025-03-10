
#Creating a Database

CREATE DATABASE Employee_Management_system;
SHOW DATABASES;
USE employee_management_system;
SHOW tables;

#CREATING TABLE EMPLOYEES
CREATE TABLE employees (
    employee_id int primary key,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    job_title_id INT,
    hire_date DATE
);
INSERT INTO employees (employee_id, first_name, last_name, department_id, job_title_id, hire_date)
VALUES 
(1001, 'John', 'Doe', 1, 1, '2020-06-01'),
(1002, 'Jane', 'Smith', 2, 2, '2019-04-15'),
(1003, 'Robert', 'Johnson', 3, 3, '2021-11-01'),
(1004, 'Emily', 'Davis', 4, 4, '2018-03-22'),
(1005, 'Michael', 'Brown', 5, 5, '2017-08-11'),
(1006, 'Sarah', 'Taylor', 6, 6, '2022-02-07');

select * from employees;

#CREATING TABLE SALARIES

CREATE TABLE salaries (
    employee_id INT,
    salary DECIMAL(10, 2)    
);

INSERT INTO salaries (employee_id, salary)
VALUES 
(1001, 65000.00),
(1002, 72000.00),
(1003, 95000.00),
(1004, 55000.00),
(1005, 62000.00),
(1006, 48000.00);

#CREATING TABLE JOB_TITLES

CREATE TABLE job_titles (
    job_title_id INT,
    job_title_name VARCHAR(100)
);
INSERT INTO job_titles (job_title_id, job_title_name)
VALUES 
(1, 'HR Manager'),
(2, 'Financial Analyst'),
(3, 'Software Engineer'),
(4, 'Sales Executive'),
(5, 'Marketing Specialist'),
(6, 'Support Specialist');

#CREATING TABLE DEPARTMENTS

CREATE TABLE departments (
    department_id INT,
    department_name VARCHAR(100)
);

INSERT INTO departments (department_id, department_name)
VALUES 
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Engineering'),
(4, 'Sales'),
(5, 'Marketing'),
(6, 'Customer Support');

#RETREVING ALL DATA FROM EACH TABLE
select * from employees;
select * from departments;
select * from job_titles;
select * from salaries;


# CRUD OPERATIONS
	#Insert a New Employee
INSERT INTO employees (employee_id, first_name, last_name, department_id, job_title_id, hire_date)
VALUES (1007, 'Alex', 'Miller', 3, 3, '2024-01-15');

	#Update Job Title
UPDATE employees
SET job_title_id = 4
WHERE employee_id = 1003;

	#Delete an Employee
DELETE FROM employees
WHERE employee_id = 1006;

select * from employees;

	#Read Employee Data
SELECT * FROM employees WHERE employee_id = 1002;

#JOINS
#Join Employees and Salaries to View Full Employee Information:
select * from employees e
JOIN departments d on e.department_id = d.department_id
JOIN job_titles j on e.job_title_id = j.job_title_id
JOIN salaries s on e.employee_id = s.employee_id;

#Group By and Aggregate Functions

select department_name, Avg(salary) AS AVG_SALARY from employees e
JOIN departments d on e.department_id = d.department_id
JOIN salaries s on e.employee_id = s.employee_id
group by department_name;

#Add New Employee
INSERT INTO employees (employee_id, first_name, last_name, department_id, job_title_id, hire_date)
VALUES (1008, 'David', 'Wright', 3, 3, '2024-02-10');

#Update Job Title
UPDATE employees
SET job_title_id = 2
WHERE employee_id = 1001;

select * from employees;
#View Employees by Department
select e.employee_id, e.first_name, e.last_name, j.job_title_name, d.department_name from employees e
JOIN departments d on e.department_id = d.department_id
JOIN job_titles j on e.job_title_id = j.job_title_id
where d.department_name = 'Human Resources';

select * from departments;

#Generate Report of Employees Earning Above a Certain Salary Threshold
SELECT e.employee_id, e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.employee_id = s.employee_id
WHERE s.salary > 60000;