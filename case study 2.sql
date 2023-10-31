                                     ---CASE STUDY TWO---

CREATE TABLE LOCATION (
    location_id INT PRIMARY KEY,
    city VARCHAR(50)
)
INSERT INTO LOCATION VALUES (122,'NEW YORK')
INSERT INTO LOCATION VALUES(123,'DALLAS')
INSERT INTO LOCATION VALUES(124,'CHICAGO')
INSERT INTO LOCATION VALUES(167,'BOSTON')

CREATE TABLE DEPARTMENT (
    department_id INT PRIMARY KEY,
    name VARCHAR(50),
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES location(location_id)
)
INSERT INTO DEPARTMENT VALUES(10,'ACCOUNTING',122)
INSERT INTO DEPARTMENT VALUES(20,'ACCOUNTING',124)
INSERT INTO DEPARTMENT VALUES(30,'ACCOUNTING',123)
INSERT INTO DEPARTMENT VALUES(40,'ACCOUNTING',167)

CREATE TABLE JOB(
Job_id INT PRIMARY KEY, Designation varchar(50)
)
INSERT INTO JOB VALUES(667,'CLERK')
INSERT INTO JOB VALUES(668,'STAFF')
INSERT INTO JOB VALUES(669,'ANALYST')
INSERT INTO JOB VALUES(670,'SALES PERSON')
INSERT INTO JOB VALUES(671,'MANAGER')
INSERT INTO JOB VALUES(672,'PRESIDENT')

CREATE TABLE EMPLOYEE 
( 
Employee_ID INT, Last_Name VARCHAR(20),	
First_Name VARCHAR(20),	
Middle_Name	VARCHAR(20),
EmpJob_ID INT FOREIGN KEY REFERENCES Job(Job_ID),Manager_ID INT, 
[Hire Date] DATE, Salary INT, Comm INT,	
EmpDepartment_ID INT FOREIGN KEY REFERENCES Department(Department_ID)
)
INSERT INTO EMPLOYEE VALUES(7369,'SMITH','JOHN','Q',667,7902,'17-DEC-84',800,NULL,20)
INSERT INTO EMPLOYEE VALUES(7499,'ALLEN','KEVIN','J',670,7698,'20-FEB-85',1600,300,30)
INSERT INTO EMPLOYEE VALUES(7505,'DOYLE','JEAN','K',671,7839,'04-APR-85',2850,NULL,30)
INSERT INTO EMPLOYEE VALUES(7506,'DENNIS','LYNN','S',671,7839,'15-MAY-85',2750,NULL,30)
INSERT INTO EMPLOYEE VALUES(7507,'BAKER','LESLIE','D',671,7839,'10-JUN-85',2200,NULL,40)
INSERT INTO EMPLOYEE VALUES(7521,'WARK','CYNTHIA','D',670,7698,'22-FEB-85',1250,500,30)


SIMPLE QUERIES:
---------------

//--1.LIST ALL THE EMPLOYEE DETAILS--//
SELECT *FROM EMPLOYEE

//--2.LIST ALL THE DEPARTMENT DETAILS--//
SELECT *FROM DEPARTMENT

//--3.LIST ALL JOB DETAILS--//
SELECT *FROM JOB

//--4.LIST ALL THE LOCATIONS--//
SELECT *FROM LOCATION

//--5. LIST OUT FIRSTNAME, LASTNAME,SALARY,COMMISSION fOR ALL EMPLOYEEES--//
SELECT First_Name,Last_Name,Salary,comm from Employee

//--6. LIST OUT EMPLOYEEID,LASTNAME,DEPARTMENT ID FOR ALL EMPLOYEES ALIAS EMPLOYEEID AS "ID OF THE EMPLOYEE", LAST NAME
//--AS"NAME OF THE EMPLOYEE",DEPARTMENTID AS "DEP_ID".--//
SELECT employee_id AS "ID OF THE EMPLOYEE", last_name AS "NAME OF THE EMPLOYEE", EmpDepartment_ID AS "DEP_ID"
FROM employee

//--7. LIST OUT THE EMPLOYEES ANNUAL SALARY WITH THEIR NAMES ONLY--//
SELECT Salary,First_name from Employee
SELECT CONCAT(first_name, ' ', Last_Name) AS Employee_Name, Salary*12 AS Annual_Salary
FROM employee

--WHERE CONDITION--
------------------
--1.//LIST THE DETAILS ABOUT "SMITH"--//
SELECT  *from Employee where Last_Name ='SMITH'

--2.//LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 20--//
SELECT *FROM Employee WHERE EmpDepartment_ID='20'

--3.//LIST OUT THE EMPLOYEES WHO ARE EARNING SALARY BETWEEN 3000 AND 4500--//
SELECT *FROM Employee WHERE Salary BETWEEN 3000 AND 4500

--4.//LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 10 OR 20--//
SELECT *FROM Employee WHERE EmpDepartment_ID IN (10,20)

--5.//FIND OUT OF THE EMPLOYEES WHO ARE NOT WORKING IN DEPARTMENT 10 OR 30--//
SELECT *FROM Employee WHERE EmpDepartment_ID NOT IN (10,30)

--6.//LIST OUT THE EMPLOYEES WHOSE NAME STARTS WITH 'S'--//
SELECT *FROM Employee WHERE Last_Name LIKE'S%'

--7.//LIST OUT THE EMPLOYEES WHOSE NAME STARTS WITH 'S' AND ENDS WITH 'H'--//
SELECT *FROM Employee WHERE Last_Name LIKE 'S%H'

--8.//LIST OUT THE EMPLOYEES WHOSE NAME LENGTH IS 4 AND STARTS WITH 'S'--//
SELECT Last_Name, LEN(Last_Name) AS Name_Length FROM Employee WHERE Last_Name LIKE 'S%'

--9.//LIST OUT THE EMPLOYEES WHO ARE WORKING IN DEPARTMENT 10 AND DRAW THE SALARIES MORE THAN 3500--// 
SELECT * FROM Employee WHERE EmpDepartment_ID = 10 AND Salary > 3500

--10.//LIST OUT THE EMPLOYEES WHO ARE NOT RECEVING COMMISSION--//
SELECT * FROM Employee WHERE Comm IS NULL

--ORDER BY CLAUSE--
-------------------
--1.//LIST OUT THE EMPLOYEE ID, LAST NAME IN ASCENDING ORDER BASED ON THE EMPLOYEE ID--//
SELECT Employee_ID,Last_Name from EMPLOYEE order by Employee_ID Asc

--2.//LIST OUT THE EMPLOYEE ID, LAST NAME IN DESECENING ORDER BASED ON SALARY--//
SELECT Employee_ID,Last_Name,Salary from EMPLOYEE order by Salary Desc

--3.// LIST OUT THE EMPLOYEE DETAILS ACCORDING TO THEIR LAST NAME IN ASCENDING ORDER AND--//
--4.//LIST OUT THE EMPLOYEE DETAILS ACCORDING TO THEIR LAST NAME IN ASCENDING ORDER AND THEN ON DEPARTMENT_ID 
--IN DESCENDING ORDER--//
SELECT Last_Name,EmpDepartment_ID from EMPLOYEE order by EmpDepartment_ID Desc,Last_Name Asc

--GROUP BY AND HAVING CLAUSE--
-------------------------------
--1. //HOW MANY EMPLOYEES WHO ARE IN DIFFERENT DEPARTMENTS WISE IN THE ORGANIZATION--//
SELECT EmpDepartment_ID, COUNT(Employee_ID) as Employee_count
FROM EMPLOYEE
GROUP BY EmpDepartment_ID HAVING COUNT(Employee_ID) > 1

--2.//LIST OUT THE DEPARTMENT WISE MAXIMUM SALARY, MINIMUM SALARY, AVERAGE SALARY OF 
--THE EMPLOYEES--//
SELECT EmpDepartment_ID, MAX(Salary) AS MAX_SALARY,MIN(Salary) as MINI_SALARY,AVG(Salary)as AVG_SALARY
FROM EMPLOYEE
GROUP BY EmpDepartment_ID HAVING COUNT(*) > 1

--3.//LIST OUT JOB WISE MAXIMUM SALARY, MINIMUM SALARY, AVERAGE SALARIES OF THE EMPLOYEES--//
SELECT EmpJob_ID, MAX(Salary) AS MAX_SALARY,MIN(Salary) as MINI_SALARY,AVG(Salary)as AVG_SALARY
FROM EMPLOYEE
GROUP BY EmpJob_ID HAVING COUNT(*) > 1

--4.// LIST OUT THE NUMBER OF EMPLOYEES JOINED IN EVERY MONTH IN ASCENDING ORDER--//
SELECT FORMAT([Hire Date], 'yyyy-MM') AS hire_month, COUNT(*) AS employee_count
FROM EMPLOYEE
GROUP BY FORMAT([Hire Date], 'yyyy-MM')
HAVING COUNT(*) > 0
ORDER BY hire_month ASC

--5.//LIST OUT THE NUMBER OF EMPLOYEES FOR EACH MONTH AND YEAR, IN THE ASCENDING 
--ORDER BASED ON THE YEAR, MONTH--//
SELECT YEAR([Hire Date]) AS hire_year,
       MONTH([Hire Date]) AS hire_month,
       COUNT(*) AS employee_count
FROM EMPLOYEE
GROUP BY YEAR([Hire Date]), MONTH([Hire Date])
ORDER BY hire_year ASC, hire_month ASC

--6.//LIST OUT THE DEPARTMENT ID HAVING ATLEAST FOUR EMPLOYEES--//
SELECT EmpDepartment_ID, COUNT(*) as employee_count
FROM EMPLOYEE
GROUP BY EmpDepartment_ID
HAVING COUNT(*) >= 4

--7.//HOW MANY EMPLOYEES JOINED IN JANUARY MONTH--//
SELECT YEAR([Hire Date]) as hire_year, MONTH([Hire Date]) as hire_month, COUNT(*) as employee_count
FROM employee
WHERE MONTH([Hire Date]) = 1
GROUP BY YEAR([Hire Date]), MONTH([Hire Date])
HAVING COUNT(*) > 0;
----------------------------OR---------------------------------------------------------
SELECT COUNT(*) as employee_count
FROM employee
WHERE MONTH([Hire Date]) = 1
GROUP BY MONTH([Hire Date])
HAVING COUNT(*) > 0

--8.//HOW MANY EMPLOYEES JOINED IN JANUARY OR SEPTEMBER MONTH--//
SELECT MONTH([Hire Date]) as hire_month, COUNT(*) as employee_count
FROM employee
WHERE MONTH([Hire Date]) IN (1, 9)
GROUP BY MONTH([Hire Date])
HAVING COUNT(*) > 0

--9.//HOW MANY EMPLOYEES WERE JOINED IN 1985--//
SELECT COUNT(*) AS employee_count
FROM EMPLOYEE
WHERE YEAR([Hire Date]) = 1985
GROUP BY YEAR([Hire Date])
HAVING COUNT(*) > 0

--10.//HOW MANY EMPLOYEES WERE JOINED EACH MONTH IN 1985--//
SELECT MONTH([Hire Date]) AS hire_month, COUNT(*) AS employee_count
FROM EMPLOYEE
WHERE YEAR([Hire Date]) = 1985
GROUP BY MONTH([Hire Date])
ORDER BY hire_month ASC

--11.//HOW MANY EMPLOYEES WERE JOINED IN MARCH 1985--//
SELECT YEAR([Hire Date]) AS hire_year, MONTH([Hire Date]) AS hire_month, COUNT(*) AS employee_count
FROM employee
WHERE YEAR([Hire Date]) = 1985 AND MONTH([Hire Date]) = 3
GROUP BY YEAR([Hire Date]), MONTH([Hire Date])
HAVING COUNT(*) > 0
ORDER BY hire_year ASC, hire_month ASC

--12.//WHICH IS THE DEPARTMENT ID, HAVING GREATER THAN OR EQUAL TO 3 EMPLOYEES JOINED IN 
--APRIL 1985--//
SELECT EmpDepartment_ID, COUNT(*) AS num_employees
FROM EMPLOYEE
WHERE [Hire Date] >= '1985-04-04'
GROUP BY EmpDepartment_ID
HAVING COUNT(*) >= 3
ORDER BY num_employees DESC


                                               ---JOINS--
                                               ------------

--1. //LIST OUT EMPLOYEES WITH THEIR DEPARTMENT NAMES--//
SELECT EMPLOYEE.First_Name, DEPARTMENT.name
FROM EMPLOYEE
INNER JOIN department ON employee.EmpDepartment_ID = department.department_id

--2. //DISPLAY EMPLOYEES WITH THEIR DESIGNATIONS--//
SELECT EMPLOYEE.First_Name,Designation from EMPLOYEE inner join job on EMPLOYEE.EmpJob_ID=JOB.Job_id

--3.// DISPLAY THE EMPLOYEES WITH THEIR DEPARTMENT NAMES AND REGIONAL GROUPS--//
SELECT EMPLOYEE.First_Name, DEPARTMENT.name, DEPARTMENT.location_id
FROM EMPLOYEE
INNER JOIN DEPARTMENT ON EMPLOYEE.EmpDepartment_ID = DEPARTMENT.department_id

--4.//HOW MANY EMPLOYEES WHO ARE WORKING IN DIFFERENT DEPARTMENTS AND DISPLAY WITH 
--DEPARTMENT NAMES--//
SELECT DEPARTMENT.name, COUNT(*) AS employee_count
FROM EMPLOYEE
INNER JOIN DEPARTMENT ON EMPLOYEE.EmpDepartment_ID = DEPARTMENT.department_id
GROUP BY DEPARTMENT.name

--5.//HOW MANY EMPLOYEES WHO ARE WORKING IN SALES DEPARTMENT//
SELECT  COUNT(*) AS SALES
FROM EMPLOYEE
INNER JOIN JOB ON EMPLOYEE.EmpJob_ID = JOB.Job_id
INNER JOIN department ON EMPLOYEE.EmpDepartment_ID= department.department_id
WHERE JOB.Designation='SALES PERSON'

--6.// WHICH IS THE DEPARTMENT HAVING GREATER THAN OR EQUAL TO 5
-- EMPLOYEES AND DISPLAY THE DEPARTMENT NAMES IN ASCENDING ORDER--//

SELECT DEPARTMENT.name, COUNT(EMPLOYEE.EmpDepartment_ID) AS EMP_COUNT
FROM EMPLOYEE
INNER JOIN DEPARTMENT ON EMPLOYEE.EmpDepartment_ID = DEPARTMENT.department_id
GROUP BY DEPARTMENT.department_id, DEPARTMENT.name
HAVING COUNT(EMPLOYEE.Employee_ID) >= 4
ORDER BY DEPARTMENT.name ASC
---- NOTE : HERE ACCORDING TO THE EMPLOYEE COUNT IS GIVEN IN QUESTION IS 5 BUT IN TABLE ITS 4, SO I HAVE USED 4---

--7.// HOW MANY JOBS IN THE ORGANIZATION WITH DESIGNATIONS--//

SELECT COUNT(*) AS JOB_COUNT, Designation
FROM JOB
INNER JOIN EMPLOYEE ON JOB.Job_id = EMPLOYEE.EmpJob_ID
GROUP BY Designation

--8.// HOW MANY EMPLOYEES ARE WORKING IN "NEW YORK"--//
SELECT COUNT(*) AS NUM_EMP_COUNT
FROM DEPARTMENT
INNER JOIN LOCATION ON DEPARTMENT.location_id = LOCATION.location_id
WHERE LOCATION.city= 'New York'
 
--9.// DISPLAY THE EMPLOYEE DETAILS WITH SALARY GRADES--//
SELECT e1.Employee_ID, e1.First_Name, e1.Salary, e2.Salary_Grade
FROM employee e1
INNER JOIN (
    SELECT MIN(Salary) AS min_salary, MAX(Salary) AS max_salary, 'Grade A' AS Salary_Grade
    FROM employee
    WHERE Salary BETWEEN 1000 AND 2000
    UNION
    SELECT MIN(Salary) AS min_salary, MAX(Salary) AS max_salary, 'Grade B' AS Salary_Grade
    FROM employee
    WHERE Salary BETWEEN 2001 AND 3000
    UNION
    SELECT MIN(Salary) AS min_salary, MAX(Salary) AS max_salary, 'Grade C' AS Salary_Grade
    FROM employee
    WHERE Salary BETWEEN 3001 AND 4000
) e2 ON e1.Salary BETWEEN e2.min_salary AND e2.max_salary

--10.// LIST OUT THE NO. OF EMPLOYEES ON GRADE WISE--//
ALTER TABLE EMPLOYEE
ADD Grade VARCHAR(20)

UPDATE EMPLOYEE
SET GRADE = (
CASE 
WHEN SALARY<1000 THEN 'C'
WHEN SALARY<2000 THEN 'B'
WHEN SALARY>2000 THEN 'A'
END) 

SELECT e.Grade, COUNT(*) AS NO_OF_EMPLOYEES
FROM EMPLOYEE e
INNER JOIN (
   SELECT DISTINCT Grade
   FROM EMPLOYEE
) g ON e.Grade = g.Grade
GROUP BY e.Grade

--11.//DISPLAY THE EMPLOYEE SALARY GRADES AND NO. OF EMPLOYEES BETWEEN 2000 TO 
--5000 RANGE OF SALARY--//
SELECT e.Grade, COUNT(*) AS NO_OF_EMPLOYEES
FROM EMPLOYEE e
INNER JOIN (
   SELECT DISTINCT Grade
   FROM EMPLOYEE
   WHERE Salary BETWEEN 2000 AND 5000
) g ON e.Grade = g.Grade
WHERE e.Salary BETWEEN 2000 AND 5000
GROUP BY e.Grade

--12.// DISPLAY THE EMPLOYEE DETAILS WITH THEIR MANAGER NAMES--//
SELECT e.Employee_ID, e.First_Name, e.Last_Name,  e.Salary, m.First_Name AS Manager_Name
FROM EMPLOYEE e
LEFT JOIN EMPLOYEE m ON e.Manager_ID = m.Employee_ID

--13.// DISPLAY THE EMPLOYEE DETAILS WHO EARN MORE THAN THEIR MANAGERS SALARIES--//
SELECT e.Employee_ID, e.First_Name, e.Last_Name,e.Salary, m.Salary AS Manager_Salary
FROM EMPLOYEE e
INNER JOIN EMPLOYEE m ON e.Manager_ID = m.Employee_ID
WHERE e.Salary > m.Salary

--14.// SHOW THE NO. OF EMPLOYEES WORKING UNDER EVERY MANAGER--//
SELECT m.Employee_ID AS Manager_ID, m.First_Name AS Manager_First_Name, m.Last_Name AS Manager_Last_Name, COUNT(e.Employee_ID) AS Num_Employees
FROM EMPLOYEE m
LEFT JOIN EMPLOYEE e ON m.Employee_ID = e.Manager_ID
GROUP BY m.Employee_ID, m.First_Name, m.Last_Name

--15.//DISPLAY EMPLOYEE DETAILS WITH THEIR MANAGER NAMES--//
SELECT e.Employee_ID, e.First_Name, e.Last_Name, e.Salary, m.First_Name AS Manager_First_Name FROM EMPLOYEE e
LEFT JOIN EMPLOYEE m ON e.Manager_ID = m.Employee_ID

--16.//DISPLAY ALL EMPLOYEES IN SALES OR OPERATION DEPARTMENTS--//
SELECT e.*
FROM EMPLOYEE e
JOIN DEPARTMENT d ON e.EmpDepartment_ID = d.Department_ID
WHERE d.Name IN ('SALES', 'OPERATION') 

                                  ----SET OPERATORS----
								  ---------------------
--1. //LIST OUT THE DISTINCT JOBS IN SALES AND ACCOUNTING DEPARTMENTS--//
SELECT DISTINCT e.empjob_id
FROM employee e
WHERE e.empdepartment_id IN (
  SELECT d.department_id
  FROM department d
  WHERE d.name IN ('Sales', 'Accounting')
) AND e.empjob_id IS NOT NULL

--2.//LIST OUT ALL THE JOBS IN SALES AND ACCOUNTING DEPARTMENTS--//
SELECT DISTINCT j.Job_id
FROM job j
JOIN employee e ON j.job_id = e.empjob_id
JOIN department d ON e.empdepartment_id = d.department_id
WHERE d.name IN ('Sales', 'Accounting')

--3.//LIST OUT THE COMMON JOBS IN RESEARCH AND ACCOUNTING DEPARTMENTS IN 
 --ASCENDING ORDER--//
 SELECT DISTINCT j.Job_id
FROM job j
JOIN employee e ON j.job_id = e.empjob_id
JOIN department d ON e.empdepartment_id = d.department_id
WHERE d.name = 'Research'
  AND j.Job_id IN (
    SELECT DISTINCT j2.Job_id
    FROM job j2
    JOIN employee e2 ON j2.job_id = e2.empjob_id
    JOIN department d2 ON e2.empdepartment_id = d2.department_id
    WHERE d2.name = 'Accounting'
  )
ORDER BY j.Job_id ASC

                                 ---SUB QUERIES---
								 -----------------
--1.//DISPLAY THE EMPLOYEES LIST WHO GOT THE MAXIMUM SALARY--//
SELECT e.first_name, e.last_name, e.salary
FROM employee e
WHERE e.salary = (
  SELECT MAX(salary)
  FROM employee
)

--2.//DISPLAY THE EMPLOYEES WHO ARE WORKING IN SALES DEPARTMENT--//
SELECT first_name, last_name
FROM employee
WHERE EmpJob_ID = (
  SELECT job_id
  FROM JOB
  WHERE Designation = 'Sales person'
)

--3.//DISPLAY THE EMPLOYEES WHO ARE WORKING AS 'CLERCK'--//
SELECT first_name, last_name
FROM employee
WHERE EmpJob_ID = (
  SELECT job_id
  FROM JOB
  WHERE Designation = 'Clerk'
)

--4.//DISPLAY THE LIST OF EMPLOYEES WHO ARE LIVING IN "NEW YORK"--//
SELECT e.first_name, e.last_name
FROM employee e
INNER JOIN department d ON e.EmpDepartment_ID = d.department_id
INNER JOIN location l ON d.location_id = l.location_id
WHERE l.city = 'NEW YORK'

--5.// FIND OUT NO. OF EMPLOYEES WORKING IN "SALES" DEPARTMENT--//
SELECT COUNT(*) FROM JOB WHERE Designation = 'Sales person'
------ note----
--- here in job table it as given 'sales person' not 'sales'----
SELECT COUNT(*) FROM JOB WHERE Designation = 'Sales '

--6.//UPDATE THE EMPLOYEES SALARIES, WHO ARE WORKING AS CLERK ON THE BASIS OF 10%--//
--//USING JOIN METHOD//
UPDATE employee SET salary = salary * 1.1 FROM employee
JOIN JOB ON employee.EmpJob_ID = job.job_id
WHERE job.designation = 'CLERK'
--------------OR----------------------------
--//USING SUBQUARIES METHOD//
UPDATE employee SET salary = salary * 1.1
WHERE EmpJob_ID IN (
    SELECT job_id
    FROM job
    WHERE designation = 'CLERK'
)
SELECT *FROM EMPLOYEE

--7.//DELETE THE EMPLOYEE WHO ARE WORKING IN ACCOUNTING DEPARTMENT--//
UPDATE employee
SET EmpDepartment_ID = NULL
WHERE EmpDepartment_ID IN (
    SELECT department_id
    FROM department
    WHERE name = 'Accounting'
)
DELETE FROM department WHERE name = 'Accounting'
SELECT *FROM DEPARTMENT

--8.//DISPLAY THE SECOND HIGHEST SALARY DRAWING EMPLOYEE DETAILS//
SELECT *FROM employee WHERE salary = (SELECT MAX(salary)FROM employee
WHERE salary < (SELECT MAX(salary)FROM employee))
  
--9.//DISPLAY THE NTH HIGHTEST SALARY DRAWING EMPLOYEE DETAILS//

-- Assuming the employee table has columns: employee_id, employee_name, salary

DECLARE @n INT -- Variable to hold the desired rank (e.g., 3 for the 3rd highest salary)
SET @n = 3

SELECT *FROM employee emp1
WHERE (@n - 1) = (SELECT COUNT(DISTINCT emp2.salary)
FROM employee emp2 WHERE emp2.salary > emp1.salary)

--10.// LIST OUT THE EMPLOYEES WHO EARN MORE THAN EVERY EMPLOYEE IN DEPARTMENT 30//
SELECT *FROM employee WHERE salary > ALL (SELECT salary FROM employee
WHERE EmpDepartment_ID = 30)

--11.//LIST OUT THE EMPLOYEES WHO EARN MORE THAN LOWEST SALARY IN DEPARTMENT 30//
SELECT *FROM employee WHERE salary > (SELECT MIN(salary)FROM employee
WHERE EmpDepartment_ID = 30)

--12.//FIND OUT WHOSE DEPARTMENT HAS NO EMPLOYEES//
SELECT department.department_id, department.name
FROM department
LEFT JOIN employee ON department.department_id = employee.EmpDepartment_ID
WHERE employee.employee_id IS NULL

--13.//FIND OUT WHICH DEPARTMENT HAS NO EMPLOYEES//
SELECT department.department_id, department.name
FROM department
LEFT JOIN employee ON department.department_id = employee.EmpDepartment_ID
GROUP BY department.department_id, department.name
HAVING COUNT(employee.employee_id) = 0

--14.//FIND OUT THE EMPLOYEES WHO EARN GREATER THAN THE AVERAGE SALARY FOR THEIR DEPARTMENT
SELECT emp.employee_id, emp.First_Name, emp.salary, emp.EmpDepartment_ID
FROM employee emp
WHERE emp.salary > (
    SELECT AVG(salary)
    FROM employee WHERE EmpDepartment_ID IN (SELECT department_id FROM department))
























