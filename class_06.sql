--1-Haz una lista de todos los actores que comparten el apellido. Muéstralas en orden
select
	*
	from actor a ,
	actor a2
where
	a.last_name <> a2.last_name;

--2-Encuentra actores que no funcionan en ninguna película.
select
	*
from
	actor a
where
	not exists (
	select
		actor_id
	from
		film_actor
	where
		a.actor_id = fa.actor_id
		and film_id = film_id);

--3-Encuentra clientes que alquilaron solo una película
select
	*
from
	customer c
where
	(
	select
		count(*)
	from
		rental r2
	where
		r2.customer_id = c.customer_id) = 1;

--4-Encuentra clientes que alquilaron más de una película
select
	*
from
	customer c
where
	(
	select
		count(*)
	from
		rental r2
	where
		r2.customer_id = c.customer_id) > 1;

--5-Enumere los actores que actuaron en 'BETRAYED REAR' o en 'CATCH AMISTAD'
select
	fitst_name ,
	last_name
from
	actor a,
	film_actor fa ,
	film f
where
	a.actor_id = fa.actor_id
	and f.film_id = fa.film_id
	and (f.title = "BETRAYED REAR"
	or f.title = "CATCH AMISTAD");

--6-Enumere los actores que actuaron en 'BETRAYED REAR' pero no en 'CATCH AMISTAD'
select
	*
from
	actor a,
	film_actor fa ,
	film f
where
	a.actor_id = fa.actor_id
	and f.film_id = fa.film_id
	and f.title = "BETRAYED REAR"
	and a.actor_id not in (
	select
		a2.actor_id
	from
		actor a2,
		film_actor fa2,
		film f2
	where
		a2.actor_id = fa2.actor_id
		and f2.film_id = fa2.film_id
		and f2.title = "CATCH AMISTAD" );

--7-Enumere los actores que actuaron tanto en 'BETRAYED REAR' como en 'CATCH AMISTAD'
select
	*
from
	actor a,
	film_actor fa ,
	film f
where
	a.actor_id = fa.actor_id
	and f.film_id = fa.film_id
	and f.title = "BETRAYED REAR"
	and a.actor_id in (
	select
		a2.actor_id
	from
		actor a2,
		film_actor fa2,
		film f2
	where
		a2.actor_id = fa2.actor_id
		and f2.film_id = fa2.film_id
		and f2.title = "CATCH AMISTAD" );

--8-Enumere todos los actores que no trabajaron en 'BETRAYED REAR' o 'CATCH AMISTAD'
select
	*
from
	actor a,
	film_actor fa ,
	film f
where
	a.actor_id = fa.actor_id
	and f.film_id = fa.film_id
	and (f.title != "BETRAYED REAR"
	or f.title != "CATCH AMISTAD");
 