CREATE TABLE `employees` (
  `employeeNumber` int(11) NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int(11) DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 
(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),
(1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),
(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing');

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);


CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
	BEGIN
    INSERT INTO employees_audit
    SET action = 'update',
   	employeeNumber = OLD.employeeNumber,
    lastname = OLD.lastname,
    changedat = NOW(); 
	END $$
	
	
UPDATE employees 
SET lastName = 'Phan'
WHERE employeeNumber = 1056;
   
SELECT *
	FROM employees_audit;

-- 1 --

INSERT INTO sakila.employees
(employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle)
VALUES(10, 'Maradona', 'Diego', 'x10', null, '1', null, 'Dios');

-- Column 'email' cannot be null


-- 2 --

UPDATE employees SET employeeNumber = employeeNumber - 20

-- Has updated all the employees numbers for the same number but minus 20

UPDATE employees SET employeeNumber = employeeNumber + 20

-- it has an error beacuse when you run the update because when you add 20 to the first, he tries to take the number 
-- that someone else already has, even though you are going to update it later.

-- 3 --

ALTER TABLE employees 
  ADD age INT CHECK (age BETWEEN 16 AND 70)
;

-- 4 --

-- the table film_actor join the three tables having a PK for both. 
-- If any of these is modified nothing will happen but if eliminate some row this would leave the other two bad 

-- 5 --
-- Create a new column called lastUpdate to table employee and use trigger(s) to keep the date-time updated on inserts and updates operations.
-- Bonus: add a column lastUpdateUser and the respective trigger(s) to specify who was the last MySQL user that changed the row 
-- (assume multiple users, other than root, can connect to MySQL and change this table).

ALTER TABLE employees 
  ADD lastUpdate DATETIME DEFAULT CURRENT_TIMESTAMP
  
CREATE TRIGGER before_employees_update 
	BEFORE UPDATE OR INSERT ON employees
	FOR EACH ROW
 	BEGIN
	SET NEW.lastUpdate = CURRENT_TIMESTAMP;
	END
;


-- 6 --

SELECT name, is_instead_of_trigger
FROM sakila.film_text 
WHERE type = 'TR';

SHOW TRIGGERS;