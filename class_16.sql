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

-- Ha actualizado todos los números de empleados para el mismo número pero menos 20

UPDATE employees SET employeeNumber = employeeNumber + 20

-- tiene un error porque al ejecutar la actualización porque al sumar 20 al primero, intenta tomar el número
-- que otra persona ya tiene, aunque lo actualizará más tarde.

-- 3 --

ALTER TABLE employees 
  ADD age INT CHECK (age BETWEEN 16 AND 70)
;

-- 4 --

-- la tabla film_actor une las tres tablas que tienen un PK para ambas.
-- Si se modifica alguno de estos no pasará nada pero si se elimina alguna fila esto dejaría los otros dos en mal estado

-- 5 --
-- Cree una nueva columna llamada lastUpdate para el empleado de la tabla y use activadores para mantener la fecha y hora actualizada en las operaciones de inserciones y actualizaciones.
-- Bonificación: agregue una columna lastUpdateUser y los activadores respectivos para especificar quién fue el último usuario de MySQL que cambió la fila
-- (suponga que varios usuarios, además de root, pueden conectarse a MySQL y cambiar esta tabla).

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