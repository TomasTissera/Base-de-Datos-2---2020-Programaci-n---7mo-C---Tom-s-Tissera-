--1-Haz una lista de todos los actores que comparten el apellido. Muéstralas en orden
select *from actor a , actor a2 
    where a.last_name <> a2.last_name;

--2-Encuentra actores que no funcionan en ninguna película.
SELECT * FROM actor a 
    WHERE NOT EXISTS (
        SELECT actor_id 
        FROM film_actor 
        where a.actor_id = fa.actor_id 
        AND film_id = film_id);

--3-Encuentra clientes que alquilaron solo una película
SELECT * FROM customer c 
    WHERE(
        SELECT COUNT(*) 
        FROM rental r2 
        WHERE r2.customer_id = c.customer_id) = 1;

--4-Encuentra clientes que alquilaron más de una película
SELECT * FROM customer c 
    WHERE (SELECT COUNT(*) 
        FROM rental r2 
        WHERE r2.customer_id = c.customer_id) > 1;

--5-Enumere los actores que actuaron en 'BETRAYED REAR' o en 'CATCH AMISTAD'
SELECT fitst_name , last_name FROM actor a, film_actor fa , film f 
    WHERE a.actor_id=fa.actor_id
	AND f.film_id = fa.film_id 
    AND (f.title = "BETRAYED REAR" OR f.title = "CATCH AMISTAD");

--6-Enumere los actores que actuaron en 'BETRAYED REAR' pero no en 'CATCH AMISTAD'
SELECT * FROM actor a, film_actor fa , film f 
    WHERE a.actor_id=fa.actor_id
	AND f.film_id=fa.film_id 
    AND f.title="BETRAYED REAR" 
    AND a.actor_id NOT IN (
		SELECT a2.actor_id 
        from actor a2, film_actor fa2, film f2 
        WHERE a2.actor_id = fa2.actor_id 
		AND f2.film_id=fa2.film_id 
        AND f2.title="CATCH AMISTAD"
	);

--7-Enumere los actores que actuaron tanto en 'BETRAYED REAR' como en 'CATCH AMISTAD'
SELECT * FROM actor a, film_actor fa , film f 
    WHERE a.actor_id=fa.actor_id
	AND f.film_id=fa.film_id 
    AND f.title="BETRAYED REAR" 
    AND a.actor_id IN (
		SELECT a2.actor_id 
        from actor a2, film_actor fa2, film f2 
        WHERE a2.actor_id = fa2.actor_id 
		AND f2.film_id=fa2.film_id 
        AND f2.title="CATCH AMISTAD"
	);

--8-Enumere todos los actores que no trabajaron en 'BETRAYED REAR' o 'CATCH AMISTAD'
SELECT * FROM actor a, film_actor fa , film f 
    WHERE a.actor_id=fa.actor_id
	AND f.film_id = fa.film_id 
    AND (f.title != "BETRAYED REAR" OR f.title != "CATCH AMISTAD");
