/* 1. Select the information from the “dept_no” column of the “departments” table.*/

SELECT dept_no FROM departments;

/* 2. Select all data from the “departments” table. */

SELECT * FROM departments;

/* 3. Select all people from the “employees” table whose first name is “Elvis”.*/

SELECT * FROM employees
WHERE first_name = 'Elvis';

/* 4. Retrieve a list with all female employees whose first name is Kellie.  */

SELECT * FROM employees
WHERE first_name = 'Kellie' AND gender = 'F'; 

/* 5. Retrieve a list with all employees whose first name is either Kellie or Aruna. */
SELECT * FROM employees
WHERE first_name = 'Kellie' OR first_name = 'Aruna'; 

/* 6. Retrieve a list with all female employees whose first name is either Kellie or Aruna. */

SELECT * FROM employees
WHERE gender = 'F' AND (first_name = 'Kellie' OR first_name = 'Aruna');

/* 7. Use the IN operator to select all individuals from the “employees” table, whose first name is either “Denis”, or “Elvis”. */

SELECT * FROM employees
WHERE first_name IN ('Denis' , 'Elvis');

/* 8. Extract all records from the ‘employees’ table, aside from those with employees named John, Mark, or Jacob. */

SELECT * FROM employees
WHERE first_name NOT IN ('John' , 'Mark', 'Jacob');

/* 9. Working with the “employees” table, use the LIKE operator to select the data about all individuals, whose first name starts with “Mark”; specify that the name can be succeeded by any sequence of characters. */

SELECT * FROM employees
WHERE first_name LIKE('Mark%');

/* 10. Retrieve a list with all employees who have been hired in the year 2000. */

SELECT * FROM employees
WHERE hire_date LIKE ('%2000%');

/* 11. Retrieve a list with all employees whose employee number is written with 5 characters, and starts with “1000”. */

SELECT * FROM employees
WHERE emp_no LIKE ('1000_');

/* 12. Extract all individuals from the ‘employees’ table whose first name contains “Jack”. */

SELECT * FROM employees
WHERE first_name LIKE ('%JACK%');

/* 13. extract another list containing the names of employees that do not contain “Jack”. */

SELECT * FROM employees
WHERE first_name NOT LIKE ('%Jack%');

/* 14. Select all the information from the “salaries” table regarding contracts from 66,000 to 70,000 dollars per year. */

SELECT * FROM salaries
WHERE salary BETWEEN 66000 AND 70000;

/* 15. Retrieve a list with all individuals whose employee number is not between ‘10004’ and ‘10012’.*/

SELECT * FROM employees
WHERE emp_no NOT BETWEEN '10004' AND '10012';

/* 16. Select the names of all departments with numbers between ‘d003’ and ‘d006’. */

SELECT dept_name FROM departments
WHERE dept_no BETWEEN 'd003' AND 'd006';

/* 17. Select the names of all departments whose department number value is not null. */

SELECT dept_name FROM departments
WHERE dept_no IS NOT NULL;

/* 18. Retrieve a list with data about all female employees who were hired in the year 2000 or after. */

SELECT * FROM employees
WHERE hire_date >= '2000-01-01' AND gender = 'F';

/* 19. Extract a list with all employees’ salaries higher than $150,000 per annum. */

SELECT * FROM salaries
WHERE salary > 150000;
 
/* 20. Obtain a list with all different “hire dates” from the “employees” table. */

SELECT DISTINCT hire_date FROM employees;

/* 21. How many annual contracts with a value higher than or equal to $100,000 have been registered in the salaries table? */

SELECT COUNT(*) FROM salaries
WHERE salary >= 100000;

/* 22. How many managers do we have in the “employees” database? Use the star symbol (*) in your code to solve this exercise. */

SELECT COUNT(*) FROM dept_manager;

/* 23. Select all data from the “employees” table, ordering it by “hire date” in descending order. */

SELECT * FROM employees
ORDER BY hire_date DESC;

/* 24. Write a query that obtains an output whose first column must contain annual salaries higher than 80,000 dollars. The second column, renamed to “emps_with_same_salary”, must show the number of employee contracts signed with this salary. */

SELECT salary, COUNT(emp_no) AS emps_with_same_salary
FROM salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY salary;

/* 25. Select all employees whose average salary is higher than $120,000 per annum. */

SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) > 120000
ORDER BY emp_no;

/* 26. Select the employee numbers of all individuals who have signed more than 1 contract after the 1st of January 2000. */

SELECT emp_no
FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

/* 27. Select the first 100 rows from the ‘dept_emp’ table. */

SELECT * FROM dept_emp
LIMIT 100;

/* 28. How many departments are there in the “employees” database? Use the ‘dept_emp’ table to answer the question. */

SELECT COUNT(DISTINCT dept_no)
FROM dept_emp;

/* 29. What is the total amount of money spent on salaries for all contracts starting after the 1st of January 1997? */

SELECT SUM(salary)
FROM salaries
WHERE from_date > '1997-01-01';

/* 30. Which is the lowest employee number in the database? */

SELECT MIN(emp_no)
FROM employees;

/* 31. Which is the highest employee number in the database? */

SELECT MAX(emp_no)
FROM employees;

/* 32. What is the average annual salary paid to employees who started after the 1st of January 1997? */

SELECT AVG(salary)
FROM salaries
WHERE from_date > '1997-01-01';

/* 33. Round the average amount of money spent on salaries for all contracts that started after the 1st of January 1997 to a precision of cents. */

SELECT ROUND(AVG(salary), 2)
FROM salaries
WHERE from_date > '1997-01-01';

/* 34. Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. */

SELECT 
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no;

/* 35. Join the 'employees' and the 'dept_manager' tables to return a subset of all the employees whose last name is Markovitch. See if the output contains a manager with that name.  */

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    dm.from_date
FROM employees e
        LEFT JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY dm.dept_no DESC, e.emp_no;

/* 36. Extract a list containing information about all managers’ employee number, first and last name, department number, and hire date. Use the old type of join syntax to obtain the result. */

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    dm.dept_no,
    e.hire_date
FROM employees e, dept_manager dm
WHERE e.emp_no = dm.emp_no;

/* 37. Select the first and last name, the hire date, and the job title of all employees whose first name is “Margareta” and have the last name “Markovitch”. */

SELECT e.first_name, e.last_name, e.hire_date, t.title
FROM employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE first_name = 'Margareta'
        AND last_name = 'Markovitch'
ORDER BY e.emp_no;

/* 38. Use a CROSS JOIN to return a list with all possible combinations between managers from the dept_manager table and department number 9. */

SELECT dm.*, d.*
FROM departments d
        CROSS JOIN
    dept_manager dm
WHERE d.dept_no = 'd009'
ORDER BY d.dept_name;   

/* 39. Return a list with the first 10 employees with all the departments they can be assigned to. */

SELECT e.*, d.*
FROM employees e
        CROSS JOIN
    departments d
WHERE e.emp_no < 10011
ORDER BY e.emp_no, d.dept_name;

/* 40. Select all managers’ first and last name, hire date, job title, start date, and department name. */

SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE t.title = 'Manager'
ORDER BY e.emp_no;

/* 41. How many male and how many female managers do we have in the ‘employees’ database? */

SELECT e.gender, COUNT(dm.emp_no)
FROM employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;

/* 42. Extract the information about all department managers who were hired between the 1st of January 1990 and the 1st of January 1995. */

SELECT * FROM dept_manager
WHERE emp_no IN (SELECT emp_no FROM employees
				WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');
                
/* 43. Select the entire information for all employees whose job title is “Assistant Engineer”.  */

SELECT * FROM employees e
WHERE EXISTS (SELECT * FROM titles t
			 WHERE t.emp_no = e.emp_no
                AND title = 'Assistant Engineer');

/* 44. Create a procedure that will provide the average salary of all employees.
Then, call the procedure. */

DELIMITER $$
CREATE PROCEDURE avg_salary()
BEGIN
SELECT AVG(salary) FROM salaries;
END$$
DELIMITER ;

CALL avg_salary;

CALL avg_salary();

CALL employees.avg_salary;

CALL employees.avg_salary();

/* 45. Create a procedure called ‘emp_info’ that uses as parameters the first and the last name of an individual, and returns their employee number. */

DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer)
BEGIN
SELECT e.emp_no 
INTO p_emp_no 
FROM employees e
WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
END$$

/* 46. Create a variable, called ‘v_emp_no’, where you will store the output of the procedure you created in the last exercise. Call the same procedure, inserting the values ‘Aruna’ and ‘Journel’ as a first and last name respectively. Finally, select the obtained output. */

SET @v_emp_no = 0;
CALL emp_info('Aruna', 'Journel', @v_emp_no);
SELECT @v_emp_no;

/* 47. Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, and returns the salary from the newest contract of that employee. */

DELIMITER $$
CREATE FUNCTION emp_info(p_first_name varchar(255), p_last_name varchar(255)) RETURNS decimal(10,2)
BEGIN
DECLARE v_max_from_date date;
DECLARE v_salary decimal(10,2);
SELECT MAX(from_date)
INTO v_max_from_date 
FROM employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name
        AND e.last_name = p_last_name;
SELECT s.salary
INTO v_salary 
FROM employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name
        AND e.last_name = p_last_name
        AND s.from_date = v_max_from_date;        
RETURN v_salary;
END$$

DELIMITER ;
SELECT EMP_INFO('Aruna', 'Journel');

/* 48. obtain a result set containing the employee number, first name, and last name of all employees with a number higher than 109990. Create a fourth column in the query, indicating whether this employee is also a manager, according to the data provided in the dept_manager table, or a regular employee. */

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE WHEN dm.emp_no IS NOT NULL THEN 'Manager' ELSE 'Employee' END AS is_manager
FROM employees e
        LEFT JOIN
    dept_manager dm ON dm.emp_no = e.emp_no
WHERE e.emp_no > 109990;

/* 49. Extract a dataset containing the following information about the managers: employee number, first name, and last name. Add two columns at the end – one showing the difference between the maximum and minimum salary of that employee, and another one saying whether this salary raise was higher than $30,000 or NOT. */

SELECT
    dm.emp_no,  
    e.first_name,  
    e.last_name,  
    MAX(s.salary) - MIN(s.salary) AS salary_difference,  
    CASE  
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more then $30,000'  
        ELSE 'Salary was NOT raised by more then $30,000'  
    END AS salary_raise  
FROM dept_manager dm  
        JOIN  
    employees e ON e.emp_no = dm.emp_no  
        JOIN  
    salaries s ON s.emp_no = dm.emp_no  
GROUP BY s.emp_no;  

/* 50. Extract the employee number, first name, and last name of the first 100 employees, and add a fourth column, called “current_employee” saying “Is still employed” if the employee is still working in the company, or “Not an employee anymore” if they aren’t. */

SELECT
    e.emp_no,
    e.first_name,
    e.last_name,
    CASE
        WHEN MAX(de.to_date) > SYSDATE() THEN 'Is still employed'
        ELSE 'Not an employee anymore'
    END AS current_employee
FROM employees e
        JOIN
    dept_emp de ON de.emp_no = e.emp_no
GROUP BY de.emp_no
LIMIT 100;

/* 51. Write a query that upon execution, assigns a row number to all managers we have information for in the "employees" database (regardless of their department).
Let the numbering disregard the department the managers have worked in. Also, let it start from the value of 1. Assign that value to the manager with the lowest employee number. */

SELECT 
    emp_no,
    dept_no,
    ROW_NUMBER() OVER (ORDER BY emp_no) AS row_num
FROM dept_manager;

/* 52. Write a query that upon execution, assigns a sequential number for each employee number registered in the "employees" table. Partition the data by the employee's first name and order it by their last name in ascending order (for each partition). */

SELECT
	emp_no,
	first_name,
	last_name,
	ROW_NUMBER() OVER (PARTITION BY first_name ORDER BY last_name) AS row_num
FROM employees;

/* 53. Obtain a result set containing the salary values each manager has signed a contract for. To obtain the data, refer to the "employees" database. 
Use window functions to add the following two columns to the final output:
- a column containing the row number of each row from the obtained dataset, starting from 1.
- a column containing the sequential row numbers associated to the rows for each manager, where their highest salary has been given a number equal to the number of rows in the given partition, and their lowest - the number 1.
Finally, while presenting the output, make sure that the data has been ordered by the values in the first of the row number columns, and then by the salary values for each partition in ascending order. */

SELECT 
	dm.emp_no,
    salary,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary ASC) AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num2   
FROM dept_manager dm
    JOIN 
    salaries s ON dm.emp_no = s.emp_no;


/* 54. Obtain a result set containing the salary values each manager has signed a contract for. To obtain the data, refer to the "employees" database.
Use window functions to add the following two columns to the final output:
- a column containing the row numbers associated to each manager, where their highest salary has been given a number equal to the number of rows in the given partition, and their lowest - the number 1.
- a column containing the row numbers associated to each manager, where their highest salary has been given the number of 1, and the lowest - a value equal to the number of rows in the given partition.
Let your output be ordered by the salary values associated to each manager in descending order. */

SELECT 
	dm.emp_no,
    salary,
    ROW_NUMBER() OVER () AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num2
FROM dept_manager dm
    JOIN 
    salaries s ON dm.emp_no = s.emp_no
ORDER BY row_num1, emp_no, salary ASC;

/* 55. Write a query that provides row numbers for all workers from the "employees" table, partitioning the data by their first names and ordering each partition by their employee number in ascending order.*/

SELECT
	emp_no,
	first_name,
	ROW_NUMBER() OVER w AS row_num
FROM employees
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);

/* 56. Find out the lowest salary value each employee has ever signed a contract for. To obtain the desired output, use a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword.
Also, to obtain the desired result set, refer only to data from the “salaries” table. */

SELECT a.emp_no,
       MIN(salary) AS min_salary 
FROM (SELECT emp_no, salary, ROW_NUMBER() OVER w AS row_num
	  FROM salaries
	  WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a
GROUP BY emp_no;

/* 57. Again, find out the lowest salary value each employee has ever signed a contract for. Once again, to obtain the desired output, use a subquery containing a window function. This time, however, introduce the window specification in the field list of the given subquery.
To obtain the desired result set, refer only to data from the “salaries” table. */

SELECT a.emp_no,
       MIN(salary) AS min_salary 
FROM (SELECT emp_no, salary, ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary) AS row_num
	  FROM salaries) a
GROUP BY emp_no;

/* 58. Once again, find out the lowest salary value each employee has ever signed a contract for. This time, to obtain the desired output, avoid using a window function. Just use an aggregate function and a subquery.
To obtain the desired result set, refer only to data from the “salaries” table. */

SELECT
    a.emp_no, MIN(salary) AS min_salary
FROM (SELECT
        emp_no, salary
    FROM salaries) a
GROUP BY emp_no;

/* 59. Once more, find out the lowest salary value each employee has ever signed a contract for. To obtain the desired output, use a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword. Moreover, obtain the output without using a GROUP BY clause in the outer query.
To obtain the desired result set, refer only to data from the “salaries” table. */

SELECT a.emp_no, a.salary as min_salary 
FROM (SELECT emp_no, salary, ROW_NUMBER() OVER w AS row_num
	  FROM salaries 
      WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a
WHERE a.row_num=1;

/* 60. Find out the second-lowest salary value each employee has ever signed a contract for. To obtain the desired output, use a subquery containing a window function, as well as a window specification introduced with the help of the WINDOW keyword. Moreover, obtain the desired result set without using a GROUP BY clause in the outer query.
To obtain the desired result set, refer only to data from the “salaries” table. */

SELECT a.emp_no, a.salary as min_salary 
FROM (SELECT emp_no, salary, ROW_NUMBER() OVER w AS row_num
	  FROM salaries
      WINDOW w AS (PARTITION BY emp_no ORDER BY salary)) a
WHERE a.row_num=2;

/* 61. Write a query containing a window function to obtain all salary values that employee number 10560 has ever signed a contract for.
Order and display the obtained salary values from highest to lowest. */

SELECT emp_no, salary, ROW_NUMBER() OVER w AS row_num
FROM salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/* 62. Write a query that upon execution, displays the number of salary contracts that each manager has ever signed while working in the company. */

SELECT
    dm.emp_no, (COUNT(salary)) AS no_of_salary_contracts
FROM dept_manager dm
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY emp_no
ORDER BY emp_no;

/* 63. Write a query that upon execution retrieves a result set containing all salary values that employee 10560 has ever signed a contract for. Use a window function to rank all salary values from highest to lowest in a way that equal salary values bear the same rank and that gaps in the obtained ranks for subsequent rows are allowed. */

SELECT emp_no, salary, RANK() OVER w AS rank_num
FROM salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/* 64. Write a query that upon execution retrieves a result set containing all salary values that employee 10560 has ever signed a contract for. Use a window function to rank all salary values from highest to lowest in a way that equal salary values bear the same rank and that gaps in the obtained ranks for subsequent rows are not allowed. */

SELECT emp_no, salary, DENSE_RANK() OVER w AS rank_num
FROM salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

/* 65. Write a query that ranks the salary values in descending order of all contracts signed by employees numbered between 10500 and 10600 inclusive. Let equal salary values for one and the same employee bear the same rank. Also, allow gaps in the ranks obtained for their subsequent rows. */

SELECT 
    e.emp_no,
    RANK() OVER w as employee_salary_ranking,
    s.salary
FROM employees e
		JOIN
    salaries s ON s.emp_no = e.emp_no
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);

/* 66. Write a query that ranks the salary values in descending order of the following contracts from the "employees" database:
- contracts that have been signed by employees numbered between 10500 and 10600 inclusive.
- contracts that have been signed at least 4 full-years after the date when the given employee was hired in the company for the first time.
In addition, let equal salary values of a certain employee bear the same rank. Do not allow gaps in the ranks obtained for their subsequent rows. */

SELECT
    e.emp_no,
    DENSE_RANK() OVER w as employee_salary_ranking,
    s.salary,
    e.hire_date,
    s.from_date,
    (YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start
FROM employees e
		JOIN
    salaries s ON s.emp_no = e.emp_no
    AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5
WHERE e.emp_no BETWEEN 10500 AND 10600
WINDOW w as (PARTITION BY e.emp_no ORDER BY s.salary DESC);

/* 67. Write a query that can extract the following information from the "employees" database:
- the salary values (in ascending order) of the contracts signed by all employees numbered between 10500 and 10600 inclusive
- a column showing the previous salary from the given ordered list
- a column showing the subsequent salary from the given ordered list
- a column displaying the difference between the current salary of a certain employee and their previous salary
- a column displaying the difference between the next salary of a certain employee and their current salary
Limit the output to salary values higher than $80,000 only.
Also, to obtain a meaningful result, partition the data by employee number. */

SELECT
	emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
    LEAD(salary) OVER w AS next_salary,
    salary - LAG(salary) OVER w AS diff_salary_current_previous,
	LEAD(salary) OVER w - salary AS diff_salary_next_current
FROM salaries
    WHERE salary > 80000 AND emp_no BETWEEN 10500 AND 10600
WINDOW w AS (PARTITION BY emp_no ORDER BY salary);

/* 68. The MySQL LAG() and LEAD() value window functions can have a second argument, designating how many rows/steps back (for LAG()) or forth (for LEAD()) we'd like to refer to with respect to a given record.
With that in mind, create a query whose result set contains data arranged by the salary values associated to each employee number (in ascending order). Let the output contain the following six columns:
- the employee number
- the salary value of an employee's contract (i.e. which we’ll consider as the employee's current salary)
- the employee's previous salary
- the employee's contract salary value preceding their previous salary
- the employee's next salary
- the employee's contract salary value subsequent to their next salary
Restrict the output to the first 1000 records you can obtain. */

SELECT
	emp_no,
    salary,
    LAG(salary) OVER w AS previous_salary,
	LAG(salary, 2) OVER w AS 1_before_previous_salary,
	LEAD(salary) OVER w AS next_salary,
    LEAD(salary, 2) OVER w AS 1_after_next_salary
FROM salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary)
LIMIT 1000;

/* 69. Create a query that upon execution returns a result set containing the employee numbers, contract salary values, start, and end dates of the first ever contracts that each employee signed for the company. */

SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
FROM salaries s
        JOIN
    (SELECT emp_no, MIN(from_date) AS from_date
    FROM salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
WHERE s.from_date = s1.from_date;

/* 70. Consider the employees' contracts that have been signed after the 1st of January 2000 and terminated before the 1st of January 2002 (as registered in the "dept_emp" table).
Create a MySQL query that will extract the following information about these employees:
- Their employee number
- The salary values of the latest contracts they have signed during the suggested time period
- The department they have been working in (as specified in the latest contract they've signed during the suggested time period)
- Use a window function to create a fourth field containing the average salary paid in the department the employee was last working in during the suggested time period. Name that field "average_salary_per_department".*/

SELECT
    de2.emp_no, d.dept_name, s2.salary, AVG(s2.salary) OVER w AS average_salary_per_department
FROM
    (SELECT
    de.emp_no, de.dept_no, de.from_date, de.to_date
	FROM dept_emp de
        JOIN
		(SELECT emp_no, MAX(from_date) AS from_date
		FROM dept_emp
		GROUP BY emp_no) de1 ON de1.emp_no = de.emp_no
	WHERE de.to_date < '2002-01-01'
	AND de.from_date > '2000-01-01'
	AND de.from_date = de1.from_date) de2
JOIN
    (SELECT
    s1.emp_no, s.salary, s.from_date, s.to_date
	FROM salaries s
		JOIN
    (SELECT
	emp_no, MAX(from_date) AS from_date
	FROM salaries
    GROUP BY emp_no) s1 ON s.emp_no = s1.emp_no
	WHERE s.to_date < '2002-01-01'
	AND s.from_date > '2000-01-01'
	AND s.from_date = s1.from_date) s2 ON s2.emp_no = de2.emp_no
JOIN
    departments d ON d.dept_no = de2.dept_no
GROUP BY de2.emp_no, d.dept_name
WINDOW w AS (PARTITION BY de2.dept_no)
ORDER BY de2.emp_no, salary;

/* 71. Use a CTE (a Common Table Expression) and a SUM() function in the SELECT statement in a query to find out how many male employees have never signed a contract with a salary value higher than or equal to the all-time company salary average. */

WITH cte AS (SELECT AVG(salary) AS avg_salary FROM salaries)

SELECT
	SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg,
	COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s 
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' 
JOIN cte c;

/* 72. Use a CTE (a Common Table Expression) and (at least one) COUNT() function in the SELECT statement of a query to find out how many male employees have never signed a contract with a salary value higher than or equal to the all-time company salary average. */

WITH cte AS (SELECT AVG(salary) AS avg_salary FROM salaries)

SELECT
	COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
	COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s 
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' 
JOIN cte c;

/* 73. Use MySQL joins (and don’t use a Common Table Expression) in a query to find out how many male employees have never signed a contract with a salary value higher than or equal to the all-time company salary average (i.e. to obtain the same result as in the previous exercise). */

SELECT
    SUM(CASE WHEN s.salary < a.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg,
    COUNT(s.salary) AS no_of_salary_contracts
FROM
    (SELECT
        AVG(salary) AS avg_salary
    FROM salaries s) a
        JOIN
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'M';

/* 74. Use a cross join in a query to find out how many male employees have never signed a contract with a salary value higher than or equal to the all-time company salary average (i.e. to obtain the same result as in the previous exercise). */

WITH cte AS (SELECT AVG(salary) AS avg_salary FROM salaries)

SELECT
	SUM(CASE WHEN s.salary < c.avg_salary THEN 1 ELSE 0 END) AS no_salaries_below_avg_w_sum,
# COUNT(CASE WHEN s.salary < c.avg_salary THEN s.salary ELSE NULL END) AS no_salaries_below_avg_w_count,
	COUNT(s.salary) AS no_of_salary_contracts
FROM salaries s 
JOIN employees e ON s.emp_no = e.emp_no AND e.gender = 'M' 
CROSS JOIN cte c;

/* 75. Use two common table expressions and a SUM() function in the SELECT statement of a query to obtain the number of male employees whose highest salaries have been below the all-time average. */

WITH cte1 AS (SELECT AVG(salary) AS avg_salary FROM salaries),

cte2 AS (SELECT s.emp_no, MAX(s.salary) AS max_salary
		FROM salaries s
			JOIN 
		employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
		GROUP BY s.emp_no)

SELECT
	SUM(CASE WHEN c2.max_salary < c1.avg_salary THEN 1 ELSE 0 END) AS highest_salaries_below_avg
FROM employees e
JOIN cte2 c2 ON c2.emp_no = e.emp_no
JOIN cte1 c1;

/* 76. Use two common table expressions and a COUNT() function in the SELECT statement of a query to obtain the number of male employees whose highest salaries have been below the all-time average. */

WITH cte_avg_salary AS (SELECT AVG(salary) AS avg_salary FROM salaries),

cte_m_highest_salary AS (SELECT s.emp_no, MAX(s.salary) AS max_salary
						FROM salaries s 
							JOIN 
						employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
						GROUP BY s.emp_no)

SELECT
	COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS max_salary
FROM employees e
JOIN cte_m_highest_salary c2 ON c2.emp_no = e.emp_no
JOIN cte_avg_salary c1;

/* 77. Does the result from the previous exercise change if you used the Common Table Expression (CTE) for the male employees' highest salaries in a FROM clause, as opposed to in a join? */

WITH cte_avg_salary AS (SELECT AVG(salary) AS avg_salary FROM salaries),

cte_m_highest_salary AS (SELECT s.emp_no, MAX(s.salary) AS max_salary
						FROM salaries s 
							JOIN 
						employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
						GROUP BY s.emp_no)

SELECT
	COUNT(CASE WHEN c2.max_salary < c1.avg_salary THEN c2.max_salary ELSE NULL END) AS max_salary
FROM cte_m_highest_salary c2
JOIN cte_avg_salary c1;

/* 78. Store the highest contract salary values of all male employees in a temporary table called male_max_salaries. */

CREATE TEMPORARY TABLE male_max_salaries
SELECT
    s.emp_no, MAX(s.salary)
FROM salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'M'
GROUP BY s.emp_no;

/* 79. Write a query that, upon execution, allows you to check the result set contained in the male_max_salaries temporary table you created in the previous exercise. */

SELECT * FROM male_max_salaries;

/* 80. Create a temporary table called dates containing the following three columns:
- one displaying the current date and time,
- another one displaying two months earlier than the current date and time, and a
- third column displaying two years later than the current date and time. */

CREATE TEMPORARY TABLE dates
SELECT
    NOW(),
    DATE_SUB(NOW(), INTERVAL 2 MONTH) AS two_months_earlier,
    DATE_SUB(NOW(), INTERVAL -2 YEAR) AS two_years_later;

/* 81. Write a query that, upon execution, allows you to check the result set contained in the dates temporary table you created in the previous exercise. */

SELECT * FROM dates dates;

/* 82. Create a query joining the result sets from the dates temporary table you created during the previous lecture with a new Common Table Expression (CTE) containing the same columns. Let all columns in the result set appear on the same row. */

WITH cte AS (SELECT
			 NOW(),
			 DATE_SUB(NOW(), INTERVAL 2 MONTH) AS cte_a_month_earlier,
			 DATE_SUB(NOW(), INTERVAL -2 YEAR) AS cte_a_year_later)

SELECT * FROM dates d1 JOIN cte c;

/* 83. Again, create a query joining the result sets from the dates temporary table you created during the previous lecture with a new Common Table Expression (CTE) containing the same columns. This time, combine the two sets vertically. */

WITH cte AS (SELECT
			 NOW(),
			 DATE_SUB(NOW(), INTERVAL 1 MONTH) AS cte_a_month_earlier,
			 DATE_SUB(NOW(), INTERVAL -1 YEAR) AS cte_a_year_later)

SELECT * FROM dates UNION SELECT * FROM cte;

/* 84. Drop the male_max_salaries and dates temporary tables you recently created. */

DROP TABLE IF EXISTS male_max_salaries;
DROP TABLE IF EXISTS dates;