-- 1-Obtenga la cantidad de ciudades por país en la base de datos. Ordenarlos por país, country_id.
SELECT
	COUNT(*) as cities, c3.country
FROM
	city c,
	country c3
WHERE c.country_id = c3.country_id
GROUP BY c3.country, c.country_id;

-- 2-Obtenga la cantidad de ciudades por país en la base de datos. Muestra solo los países con más de 10 ciudades, ordena desde la mayor cantidad de ciudades hasta la más baja
SELECT
	COUNT(*) as cities, c3.country
FROM
	city c,
	country c3
WHERE c.country_id = c3.country_id
GROUP BY c3.country, c.country_id
HAVING cities > 10
ORDER BY cities;

-- 3-Genere un informe con el nombre del cliente (nombre, apellido), dirección, películas totales alquiladas y el dinero total gastado en alquilar películas.
-- °Muestre a los que gastaron más dinero primero.
SELECT
	c.first_name,
	c.last_name,
	a.address,
	COUNT(*) as amount_rented,
	sum(p.amount) as spent
FROM
	customer c,
	address a,
	rental r ,
	payment p
WHERE
	c.address_id = a.address_id
	AND c.customer_id = r.customer_id
	AND p.rental_id = r.rental_id
GROUP BY
	c.first_name,
	c.last_name,
	a.address
ORDER BY 
	spent DESC;

-- 4-¿Qué categorías de películas tienen la mayor duración de película (comparación promedio)?
-- °Ordenar por promedio en orden descendente
SELECT
	c.name,
	AVG(f.`length`) as average_length
FROM
	category c,
	film f ,
	film_category fc
WHERE
	f.film_id = fc.film_id
	AND c.category_id = fc.category_id
GROUP BY c.name
HAVING average_length > (SELECT AVG(f2.`length`) FROM film f2 )
ORDER BY average_length DESC;

-- 5-Mostrar ventas por calificación de película
SELECT
	COUNT(*) as sales,
	f.rating
FROM
	film f,
	inventory i,
	rental r
WHERE
	f.film_id = i.film_id
	AND r.inventory_id = i.inventory_id 
GROUP BY f.rating;