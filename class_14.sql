USE sakila;

-- Write a query that gets all the customers that live in Argentina. Show the first and last name in one column, the address and the city.
SELECT c.first_name st_name, c.last_name,a.address ,co.country
FROM customer c
JOIN address a USING(address_id)
JOIN city ci USING(city_id)
JOIN country co USING(country_id)
WHERE country = "Argentina" 


-- Write a query that shows the film title, language and rating. Rating shall be shown as the full text described here: 
-- https://en.wikipedia.org/wiki/Motion_picture_content_rating_system#United_States. Hint: use case.
SELECT f.title, l.name, CASE WHEN f.rating = 'G' THEN 'All ages admitted.'
								WHEN f.rating = 'PG' THEN 'Some material may not be suitable for children.'
								WHEN f.rating = 'PG-13' THEN 'Some material may be inappropriate for children under 13.'
								WHEN f.rating = 'R' THEN 'Under 17 requires accompanying parent or adult guardian.'
								WHEN f.rating = 'NC-17' THEN 'No one 17 and under admitted.' END  AS 'Rating'
FROM film f
JOIN language l USING(language_id)


-- Write a search query that shows all the films (title and release year) an actor was part of. 
-- Assume the actor comes from a text box introduced by hand from a web page. Make sure to "adjust" the input text to try to find the films as effectively as you think is possible.
SELECT f.title, f.release_year , UPPER(CONCAT( a.first_name ,  ' ', a.last_name )) AS 'Actor'
FROM film f
JOIN film_actor fa USING(film_id)
JOIN actor a USING(actor_id)
WHERE CONCAT( a.first_name ,  ' ', a.last_name ) LIKE  UPPER('%ed guines%')


-- Find all the rentals done in the months of May and June. Show the film title, customer name and if it was returned or not. 
-- There should be returned column with two possible values 'Yes' and 'No'.
SELECT f.title, CONCAT( c.first_name ,  ' ', c.last_name ) AS 'Customer', r.rental_date , CASE 	WHEN r.return_date IS NULL THEN 'NO'
																				WHEN r.return_date = r.return_date THEN 'YES' END AS 'RETURNED'
FROM film f
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
JOIN customer c USING(customer_id)
WHERE r.rental_date BETWEEN '2005-05-01 00:0:00' AND '2005-06-01 00:0:00'


-- Investigate CAST and CONVERT functions. Explain the differences if any, write examples based on sakila DB.
-- Ambos hacen lo mismo
SELECT  (CAST(f.description  AS CHAR))
FROM film f 

SELECT (CONVERT(f.description ,CHAR))
FROM film f 


-- Investigate NVL, ISNULL, IFNULL, COALESCE, etc type of function. Explain what they do. Which ones are not in MySql and write usage examples.
-- NVL and ISNULL are not in MYSQL

IFNULL es una función de control de flujo mientras que COALESCE() es una funcion de comparacion.

SELECT IFNULL(NULL,'HOLA MUNDO'); // HOLA MUNDO
SELECT IFNULL('BUENAS', 'NOCHES'); // BUENAS


Mientras que COALESCE retorna el primer parametro que no sea NULL:
SELECT COALESCE(NULL, NULL, 'HOLA', NULL, 'MUNDO'); // HOLA
SELECT COALESCE(NULL, NULL, NULL, 'MUNDO', 'BUENAS'); // MUNDO

