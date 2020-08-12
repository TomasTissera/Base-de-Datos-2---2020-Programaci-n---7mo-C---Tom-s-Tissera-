-- 1Create a view named list_of_customers, it should contain the following columns:
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
-- 2Create a view named film_details, it should contain the following columns: film id, title, description, category, price, length, rating, actors - as a string of all the actors separated by comma. Hint use GROUP_CONCAT
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
-- 3Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.
select
	category,
	total_sales
from
	sakila.sales_by_film_category;


-- 4Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.
select
	concat( a2.actor_id ,
	a2.first_name ,
	a2.last_name ) as "actor",
	(select count( fa.film_id ) from film_actor fa )

from
	actor a2
-- 5Analyze view actor_info, explain the entire query and specially how the sub query works. Be very specific, take some time and decompose each part and give an explanation for each.
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
-- 6Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.