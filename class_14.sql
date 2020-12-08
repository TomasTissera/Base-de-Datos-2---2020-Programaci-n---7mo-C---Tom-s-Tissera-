USE sakila;

-- Escribe una consulta que llegue a todos los clientes que viven en Argentina. 
-- Muestre el nombre y apellido en una columna, la dirección y la ciudad. 
SELECT c.first_name st_name, c.last_name,a.address ,co.country
FROM customer c
JOIN address a USING(address_id)
JOIN city ci USING(city_id)
JOIN country co USING(country_id)
WHERE country = "Argentina" 


-- Escribe una consulta que muestre el título, el idioma y la calificación de la película.
SELECT f.title, l.name, CASE WHEN f.rating = 'G' THEN 'All ages admitted.'
								WHEN f.rating = 'PG' THEN 'Some material may not be suitable for children.'
								WHEN f.rating = 'PG-13' THEN 'Some material may be inappropriate for children under 13.'
								WHEN f.rating = 'R' THEN 'Under 17 requires accompanying parent or adult guardian.'
								WHEN f.rating = 'NC-17' THEN 'No one 17 and under admitted.' END  AS 'Rating'
FROM film f
JOIN language l USING(language_id)


-- Escriba una consulta de búsqueda que muestre todas las películas (título y año de estreno) de las que participó un actor.
-- Suponga que el actor proviene de un cuadro de texto introducido a mano desde una página web. 
-- Asegúrese de "ajustar" el texto de entrada para tratar de encontrar las películas de la manera más eficaz que crea posible.
SELECT f.title, f.release_year , UPPER(CONCAT( a.first_name ,  ' ', a.last_name )) AS 'Actor'
FROM film f
JOIN film_actor fa USING(film_id)
JOIN actor a USING(actor_id)
WHERE CONCAT( a.first_name ,  ' ', a.last_name ) LIKE  UPPER('%ed guines%')


-- Encuentra todos los alquileres realizados en los meses de mayo y junio.
-- Muestra el título de la película, el nombre del cliente y si fue devuelto o no.
-- Debería devolverse una columna con dos valores posibles 'YES' y 'NO'.
SELECT f.title, CONCAT( c.first_name ,  ' ', c.last_name ) AS 'Customer', r.rental_date , CASE 	WHEN r.return_date IS NULL THEN 'NO'
																				WHEN r.return_date = r.return_date THEN 'YES' END AS 'RETURNED'
FROM film f
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
JOIN customer c USING(customer_id)
WHERE r.rental_date BETWEEN '2005-05-01 00:0:00' AND '2005-06-01 00:0:00'


-- Investigar las funciones CAST y CONVERT. Explique las diferencias, si las hay, escriba ejemplos basados en sakila DB.
-- Ambos hacen lo mismo
SELECT  (CAST(f.description  AS CHAR))
FROM film f 

SELECT (CONVERT(f.description ,CHAR))
FROM film f 


-- Investigar el tipo de función NVL, ISNULL, IFNULL, COALESCE, etc. 
-- Explique lo que hacen. Cuáles no están en MySql y escriben ejemplos de uso.
-- NVL y ISNULL no están en MYSQL

-- IFNULL es una función de control de flujo mientras que COALESCE() es una funcion de comparacion.

SELECT IFNULL(NULL,'HOLA MUNDO'); // HOLA MUNDO
SELECT IFNULL('BUENAS', 'NOCHES'); // BUENAS


-- Mientras que COALESCE retorna el primer parametro que no sea NULL:
SELECT COALESCE(NULL, NULL, 'HOLA', NULL, 'MUNDO'); // HOLA
SELECT COALESCE(NULL, NULL, NULL, 'MUNDO', 'BUENAS'); // MUNDO

