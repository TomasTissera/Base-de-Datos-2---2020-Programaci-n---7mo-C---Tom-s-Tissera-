-- 1)Encuentra todos los títulos de películas que no están en el inventario.
SELECT
	f.title
FROM
	film f
WHERE
	f.film_id NOT IN (
	SELECT
		i3.film_id
	FROM
		inventory i3 );
--- Forma de hacerlo con join
SELECT * FROM film f LEFT OUTER JOIN inventory i ON f.film_id = i.film_id where inventory_id IS NULL;

-- 2)Encuentra todas las películas que están en el inventario pero que nunca se alquilaron.
-- Mostrar título e inventario_id.
-- Este ejercicio es complicado.
-- pista: use subconsultas en FROM y WHERE o use la combinación izquierda y pregunte si uno de los campos es nulo
SELECT
	title, inventory.inventory_id, rental.rental_id
FROM
	film 
INNER JOIN 
	inventory 
	ON film.film_id = inventory.film_id 
LEFT OUTER JOIN 
	rental 
	ON inventory.inventory_id = rental.inventory_id
WHERE rental_id IS NULL;

-- 3)Genere un informe con:
-- °nombre del cliente (nombre, apellido), identificación de la tienda, título de la película,
-- °cuando la película fue alquilada y devuelta para cada uno de estos clientes
-- °ordenar por store_id, apellido del cliente
SELECT
	first_name,
	last_name, rental_id, inventory.store_id as "store id" , title , rental_date, return_date
FROM
	customer
INNER JOIN 
	rental USING(customer_id)
INNER JOIN 
	inventory USING(inventory_id)
INNER JOIN 
	film USING(film_id)
ORDER BY last_name, "store id";

-- 4)Mostrar ventas por tienda (dinero de películas alquiladas)
-- °muestre la ciudad, el país, la información del gerente y las ventas totales (dinero) de la tienda
-- °(opcional) Use concat para mostrar la ciudad y el país y el nombre y apellido del administrador
SELECT SUM(amount) as "Total sales", store.store_id, CONCAT(city, ", ", country), CONCAT(first_name," ", last_name)
FROM
	payment
INNER JOIN
	rental USING(rental_id)
INNER JOIN 
	inventory USING(inventory_id)
INNER JOIN
	store USING(store_id)
INNER JOIN 
	address USING(address_id)
INNER JOIN city USING(city_id)
INNER JOIN country USING(country_id), 
staff  
where staff.staff_id = store.manager_staff_id 
GROUP BY store_id;

-- 5)¿Qué actor ha aparecido en la mayoría de las películas?

SELECT 
	actor
FROM
	(
	SELECT
		concat(a.first_name, " ", a.last_name) AS actor, COUNT(fa.actor_id) as amount_featured
	FROM
		actor a, film_actor fa
	where
		a.actor_id = fa.actor_id
	GROUP BY
		fa.actor_id
	order by
		amount_featured desc
	limit 1) as a;

-- Otra solución

SELECT
	CONCAT(first_name, " ", a.last_name) 
FROM
	actor a
WHERE
	actor_id = (
	SELECT
		actor_id	
	FROM
		(
		SELECT
			actor_id ,COUNT(actor_id) as instance_amount
		FROM
			film_actor fa
		GROUP BY actor_id
		ORDER BY instance_amount DESC 
		limit 1
		) a
	);
