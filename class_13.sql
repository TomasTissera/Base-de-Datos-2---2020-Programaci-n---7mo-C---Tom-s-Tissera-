-- 1)Agregar un nuevo cliente
-- °Para almacenar 1
-- °Para la dirección, use una dirección existente. El que tiene la mayor dirección_id en 'Estados Unidos'
INSERT
	INTO
	customer (store_id, first_name, last_name, email, address_id, active , last_update)
VALUES(1, 'Lorenzo', 'Grasso', 'lolito@gmail.com',(
SELECT
	MAX(address_id)
from
	address
JOIN city
		USING(city_id)
JOIN country
		USING(country_id)
WHERE
	country = 'United States') , 1, CURRENT_TIMESTAMP);

-- 2)Agregar un alquiler
-- °Facilite la selección de cualquier título de película. Es decir, debería poder poner 'mosaico de película' en el lugar, y no en la identificación.
-- °No verifique si la película ya está alquilada, solo use cualquiera del inventario, por ejemplo, la que tenga la identificación más alta.
-- °Seleccione cualquier staff_id de la Tienda 2.
INSERT INTO
	rental (inventory_id, customer_id, return_date, staff_id, last_update)
VALUES((
        SELECT
            inventory_id
        FROM
	        inventory
        JOIN film USING(film_id)
        WHERE
	        title = 'ACADEMY DINOSAUR'
        limit 1 ),(
        SELECT
	        customer_id
        FROM
	        customer
        limit 1 ) ,
        NULL, (
            SELECT
	            staff_id
            FROM
	            staff
            where
	            staff.store_id = 2
            limit 1 )
, CURRENT_TIMESTAMP);

-- 3)Actualizar el año de la película según la calificación
-- °Por ejemplo, si la calificación es 'G', la fecha de lanzamiento será '2001'
-- °Puede elegir la asignación entre calificación y año.
-- °Escriba cuantas declaraciones sean necesarias.
UPDATE film set 
	release_year = 2001
where rating = "G";

UPDATE film set 
	release_year = 2002
where rating = "NC-17";

UPDATE film set 
	release_year = 2003
where rating = "PG-13";

UPDATE film set 
	release_year = 2004
where rating = "R";

-- 4)Devolver una película
-- °Escriba las declaraciones y consultas necesarias para los siguientes pasos.
-- °Encuentra una película que aún no haya sido devuelta. Y usa esa identificación de alquiler. Elija el último que se alquiló, por ejemplo.
-- °Usa la identificación para devolver la película.
UPDATE
	rental
SET
	return_date = CURRENT_TIMESTAMP
WHERE
	rental_id = (
	SELECT
		*
	FROM
		(
		SELECT
			r.rental_id
		FROM
			rental r
		WHERE
			r.return_date IS NULL
		LIMIT 1) rental);

-- 5)Intenta eliminar una película.
-- °Verifique qué sucede, describa qué hacer.
-- °Escriba todas las declaraciones de eliminación necesarias para eliminar por completo la película de la base de datos.
DELETE
FROM
	film_actor
WHERE
	film_id = 3;
--
DELETE
FROM
	film_category
WHERE
	film_id = 3;
-- 
DELETE
FROM
	payment
WHERE
	rental_id IN (
	SELECT
		rental_id
	FROM
		rental
	JOIN inventory
			USING(inventory_id)
	WHERE
		film_id = 3 );
--
DELETE
FROM
	rental
WHERE
	inventory_id IN (
	SELECT
		inventory_id
	FROM
		inventory
	WHERE
		film_id = 3 );
--
DELETE
FROM
	inventory
WHERE
	film_id = 3;
DELETE
FROM
	film
WHERE
	film_id = 3;

-- 6)Alquilar una película
-- °Encuentre una identificación de inventario que esté disponible para alquilar (disponible en la tienda), elija cualquier película. Guarda esta identificación en alguna parte.
-- °Agregar una entrada de alquiler
-- °Agregar una entrada de pago
-- °Use subconsultas para todo, excepto para la identificación de inventario que se puede usar directamente en las consultas.
SET
@someAvailableId =(
SELECT
	inventory_id
FROM
	inventory
WHERE
	inventory_id NOT IN (
	SELECT
		inventory_id
	FROM
		rental
	WHERE
		return_date IS NOT NULL)
LIMIT 1);

INSERT
	INTO
		rental (rental_id, inventory_id, customer_id, return_date, staff_id, last_update)
	VALUES(23452, @someAvailableId, 4, NULL, 1, CURRENT_TIMESTAMP);
INSERT
	INTO
		payment (customer_id, staff_id, rental_id, amount, last_update)
	VALUES(4, 1, 23452, 24, CURRENT_TIMESTAMP);
