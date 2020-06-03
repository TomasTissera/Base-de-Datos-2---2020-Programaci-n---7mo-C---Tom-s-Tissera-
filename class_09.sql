
-- 1-Obtenga la cantidad de ciudades por país en la base de datos. Ordenarlos por país, country_id.
select
	count(*) as cities,
	c3.country
from
	city c,
	country c3
where
	c.country_id = c3.country_id
group by
	c3.country,
	c.country_id;
-- 2-Obtenga la cantidad de ciudades por país en la base de datos. Muestra solo los países con más de 10 ciudades, ordena desde la mayor cantidad de ciudades hasta la más baja
select
	count(*) as cities,
	c3.country
from
	city c,
	country c3
where
	c.country_id = c3.country_id
group by
	c3.country,
	c.country_id
having
	cities > 10
order by
	cities;

----------------------------------------------------TEO
select
	country,
	count(*) as ciudades
from
	city
inner join country on
	city.country_id = country.country_id
group by
	country
having
	count(*) >= 10
order by
	count(*) desc;

----------------------------------------------------TEO
-- 3-Genere un informe con el nombre del cliente (nombre, apellido), dirección, películas totales alquiladas y el dinero total gastado en alquilar películas.

-- °Muestre a los que gastaron más dinero primero.
select
	c.first_name,
	c.last_name,
	a.address,
	count(*) as amount_rented,
	sum(p.amount) as spent
from
	customer c,
	address a,
	rental r ,
	payment p
where
	c.address_id = a.address_id
	and c.customer_id = r.customer_id
	and p.rental_id = r.rental_id
group by
	c.first_name,
	c.last_name,
	a.address
order by
	spent desc;

----------------------------------------------martinez
select
	concat(cu.first_name, " ", cu.last_name) as name,
	a.address,
	(
	select
		count(*)
	from
		rental r
	where
		r.customer_id = cu.customer_id) as total_films,
	(
	select
		sum(amount)
	from
		payment p2
	where
		p2.customer_id = cu.customer_id) as total_money
from
	customer cu,
	address a
where
	cu.address_id = a.address_id
order by
	total_money desc;

-------------------------------------------------
-- 4-¿Qué categorías de películas tienen la mayor duración de película (comparación promedio)?

-- °Ordenar por promedio en orden descendente
select
	c.name,
	avg(f.`length`) as average_length
from
	category c,
	film f ,
	film_category fc
where
	f.film_id = fc.film_id
	and c.category_id = fc.category_id
group by
	c.name
having
	average_length > (
	select
		avg(f2.`length`)
	from
		film f2 )
order by
	average_length desc;
-- 5-Mostrar ventas por calificación de película
select
	count(*) as sales,
	f.rating
from
	film f,
	inventory i,
	rental r
where
	f.film_id = i.film_id
	and r.inventory_id = i.inventory_id
group by
	f.rating;

-------------------------------
-- Cordoba
select
	film.rating,
	sum(payment.amount) as sales
from
	payment
inner join rental on
	payment.rental_id = rental.rental_id
inner join inventory on
	rental.inventory_id = inventory.inventory_id
inner join film on
	inventory.film_id = film.film_id
group by
	film.rating;

-------------------------------- 