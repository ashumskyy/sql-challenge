-- List the employee number, last name, first name, sex, and salary of each employee.

SELECT e.emp_no as "Employees Number", e.last_name as "Last Name", e.first_name as "First Name", e.sex as "Sex", s.salary as "Salary"
FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT e.first_name as "First Name", e.last_name as "Last Name", e.hire_date
FROM employees AS e
WHERE extract(year from hire_date) = 1986;

-- List the manager of each department along with their department number, department name, 
-- employee number, last name, and first name (2 points)

SELECT dm.dept_no as "Department Number", d.dept_name as "Deprtments Name", e.emp_no as "Employees Number", e.last_name as "Last Name", e.first_name as "First Name"
FROM dept_manager dm
JOIN departments d
ON dm.dept_no = d.dept_no
JOIN employees e
ON dm.emp_no = e.emp_no
JOIN titles
ON e.emp_title_id = titles.title_id
WHERE titles.title = 'Manager';

-- List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name.

SELECT d.dept_no as "Department Number", e.emp_no as "Employee Number", e.last_name as "Last Name", e.first_name as "First Name", d.dept_name as "Deprtments Name"
FROM departments d
JOIN dept_emp
ON d.dept_no = dept_emp.dept_no
JOIN employees e
ON dept_emp.emp_no = e.emp_no;

-- List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT e.first_name as "First Name", e.last_name as "Last Name", e.sex as "Sex"
FROM employees e
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT e.emp_no as "Employee Number", e.last_name as "Last Name", e.first_name as "First Name"
FROM employees e
WHERE emp_no IN(
	SELECT emp_no
	FROM dept_emp
	WHERE dept_no IN(
		SELECT dept_no
		FROM departments d
		WHERE dept_name = 'Sales'
	)
);

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no as "Employee Number", e.last_name as "Last Name", e.first_name as "First Name", d.dept_name as "Departments Name"
FROM employees e
JOIN dept_emp
ON e.emp_no = dept_emp.emp_no
JOIN departments d 
ON dept_emp.dept_no = d.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development';

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name as "Last Name", COUNT(*) as "Frequency"
FROM employees
GROUP BY last_name
ORDER BY "Frequency" DESC;