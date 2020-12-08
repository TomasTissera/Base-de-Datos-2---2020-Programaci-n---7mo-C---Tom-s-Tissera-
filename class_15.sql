-- 1 Cree una vista llamada list_of_customers, debe contener las siguientes columnas:
-- customer id
-- customer full name,
-- address
-- zip code
-- phone
-- city
-- country
-- status (when active column is 1 show it as 'active', otherwise is 'inactive')
-- store id
create view list_of_customers as
select
	c2.customer_id ,
	concat( c2.first_name, " " , c2.last_name)as nombre_completo ,
	a.address ,
	a.phone ,
	s.store_id,
	(case
		when (c2.active = 1) then 'activa'
		else 'inactiva' end) as activo
from
	customer c2
inner join address a
		using(address_id)
inner join store s
		using(store_id)
select
	*
	from list_of_customers;
-- 2 Cree una vista llamada detalles de la película, debe contener las siguientes columnas: 
-- identificación de la película, título, descripción, categoría, precio, duración, calificación, actores, como una cadena de todos los actores separados por comas.
-- Sugerencia: use GROUP_CONCAT
create view film_details as
select
	f.film_id ,
	f.title ,
	f.description ,
	c.category_id ,
	f.replacement_cost ,
	f.`length` ,
	f.rating ,
	concat(a.first_name , " ", a.last_name ) as "Actor"
from
	film f
inner join film_category fc
		using(film_id)
inner join category c
		using(category_id)
inner join film_actor fa
		using(film_id)
inner join actor a
		using(actor_id);
SELECT *
        FROM film_details;
-- 3 Cree la view sales_by_film_category, debería devolver las columnas 'categoría' y 'total_rental'.
select
	category,
	total_sales
from
	sakila.sales_by_film_category;

create or replace view sales_by_film_category as 
select category.name, count(rental_id) as total_rental from category
inner join film_category using(category_id)
inner join film using(film_id)
inner join inventory using(film_id)
inner join rental using(inventory_id) group by category.category_id;
-- 4 Cree una vista llamada actor_information donde debe devolver, id del actor, nombre, apellido y la cantidad de películas en las que actuó.
select
	concat( a2.actor_id ,
	a2.first_name ,
	a2.last_name ) as "actor",
	(select count( fa.film_id ) from film_actor fa )

from
	actor a2
-- 5 Analice la vista actor_info, explique toda la consulta y especialmente cómo funciona la subconsulta.
-- Sea muy específico, tómese un tiempo y descomponga cada parte y dé una explicación de cada una.
select
	actor_id,
	first_name,
	last_name,
	film_info
from
	sakila.actor_info;

select
	a.actor_id ,
	a.first_name ,
	a.last_name ,
	concat("todos los datos referidos pedidos de diferentes tablas")
from
	actor a
inner join film_actor fa
		using(actor_id)
inner join film f
		using(film_id)
inner join `language` l
		using(language_id)
inner join film_category
		using(film_id)
inner join category c
		using(category_id)