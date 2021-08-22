-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/M0IpHt
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Modify this code to update the DB schema diagram.
-- To reset the sample schema, replace everything with
-- two dots ('..' - without quotes).

DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS customer_list;
DROP TABLE IF EXISTS titles;


CREATE TABLE "departments" (
    "dept_no" VARCHAR(20)   NOT NULL,
    "dept_name" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

SELECT * FROM departments;

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" VARCHAR(20)   NOT NULL
);

SELECT * FROM dept_emp;

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(20)   NOT NULL,
    "emp_no" int   NOT NULL
);

SELECT * FROM dept_manager;

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" VARCHAR(20)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(20)   NOT NULL,
    "last_name" VARCHAR(20)   NOT NULL,
    "sex" VARCHAR(20)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

SELECT * FROM employees;

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL
);

SELECT * FROM salaries;


CREATE TABLE "titles" (
    "title_id" VARCHAR(20)   NOT NULL,
    "title" VARCHAR(20)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

SELECT * FROM titles;

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_emp" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "dept_manager" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

--List the following details of each employee: employee number, last name, first name, sex, and salary.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no;

--List first name, last name, and hire date for employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '12/31/1986';

--List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.

SELECT departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.emp_no, employees.last_name, employees.first_name
FROM ((employees
INNER JOIN dept_manager ON employees.emp_no = dept_manager.emp_no)
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no);


--List the department of each employee with the following information: employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM ((employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no)
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no);

--List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List all employees in the Sales department, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM ((employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no)
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no)
WHERE dept_name = 'Sales';

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM ((employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no)
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no)
WHERE dept_name = 'Sales' OR dept_name = 'Development';

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT employees.last_name, COUNT(employees.last_name) AS "Last Name Count"
From employees
GROUP BY employees.last_name
ORDER BY "Last Name Count" DESC;