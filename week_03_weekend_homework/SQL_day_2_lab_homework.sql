SELECT *
FROM  CHARACTERS;

SELECT *
FROM  committees ;

SELECT *
FROM  employees ;

SELECT *
FROM  employees_committees ;

SELECT *
FROM  pay_details ;

SELECT *
FROM  teams ;

SELECT *
FROM  employees_indexed ;

--  question 1

-- Find the first name, last name and team name of employees who are members of teams.

SELECT 
	e.first_name AS employee_first_name,
	e.last_name AS employee_last_name,
	t.name AS employee_team
FROM employees AS e  INNER JOIN teams AS t
ON e.team_id = t.id ;

-- Find the first name, last name and team name of employees who are members of teams and are enrolled in the pension scheme.

SELECT 
	e.first_name AS employee_first_name,
	e.last_name AS employee_last_name,
	t.name AS employee_team
FROM employees AS e  INNER JOIN teams AS t
ON e.team_id = t.id 
WHERE e.pension_enrol = TRUE;

--  Find the first name, last name and team name of employees who are members of teams, where their team has a charge cost greater than 80.

SELECT 
	e.first_name AS employee_first_name,
	e.last_name AS employee_last_name,
	t.name AS employee_team,
	t.charge_cost 
FROM employees AS e  INNER JOIN teams AS t
ON e.team_id = t.id 
WHERE  CAST(t.charge_cost AS int) > 80;

--  Question 2
 
-- Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them.
SELECT *
FROM (employees AS e LEFT JOIN pay_details AS p 
ON e.pay_detail_id  = p.id) LEFT JOIN teams AS t 
ON e.team_id = t.id ;


--  Question 3
-- Make a table, which has each employee id along with the team that employee belongs to.

SELECT 
 t.name AS team_name,
--  e.id AS employee_id,
 count(e.*) AS number_of_employee
FROM employees AS e INNER JOIN teams AS t 
ON e.team_id = t.id 
GROUP BY t.name
ORDER BY number_of_employee DESC ;

--   Question 4
--  Create a table with the team id, team name and the count of the number of employees in each team

SELECT
	t.id AS team_id,
    t.name AS team_name, 
 count(e.*) AS number_of_employee
FROM employees AS e INNER JOIN teams AS t 
ON e.team_id = t.id 
GROUP BY t.id ;

-- The total_day_charge of a team is defined as the charge_cost of the team multiplied by the number of employees in the
-- team. Calculate the total_day_charge for each team.


SELECT  
	table_2.name, 
	table_2.charge_cost ,
	table_2.total_day_charge 
FROM (
SELECT 
	teams.name, 
	teams.charge_cost ,
	(CAST(teams.charge_cost AS int) * number_of_employee) AS total_day_charge
FROM teams INNER JOIN (
                   SELECT
	t.id AS team_id,
    t.name AS team_name, 
     count(e.*) AS number_of_employee
FROM employees AS e INNER JOIN teams AS t 
ON e.team_id = t.id 
GROUP BY t.id) AS table_1
ON teams.id = table_1.team_id)AS table_2
where table_2.total_day_charge > 5000;

