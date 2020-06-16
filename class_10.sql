-- 1- Encuentra todos los títulos de películas que no están en el inventario.
select
	title
from
	film f
inner join inventory i on
	f.film_id != i.film_id;
-- 2-Encuentra todas las películas que están en el inventario pero que nunca se alquilaron.

--Mostrar título e inventario_id.(title and inventory_id.)
--Este ejercicio es complicado.
--pista: use subconsultas en FROM y WHERE o use la combinación izquierda y pregunte si uno de los campos es nulo


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

-- 3-Genere un informe con:

--nombre del cliente (nombre, apellido), identificación de la tienda, título de la película,
--cuando la película fue alquilada y devuelta para cada uno de estos clientes
--ordenar por store_id, apellido del cliente

select
	c.last_name ,
	c.first_name ,
	s.store_id ,
	f.title ,
	r.rental_date ,
	r.return_date
from
	customer c
inner join store s on
	c.store_id = s.store_id
inner join inventory i on
	s.store_id = i.store_id
inner join film f on
	i.film_id = f.film_id
inner join rental r on
	c.customer_id = r.customer_id
order by
	s.store_id,
	c.last_name;

-- 4-Mostrar ventas por tienda (dinero de películas alquiladas)

--muestre la ciudad, el país, la información del gerente y las ventas totales (dinero) de la tienda 
--(opcional) Use concat para mostrar la ciudad y el país y el nombre y apellido del administrador

select
	c.city ,
	co.country ,
	concat(st.first_name , "   /    ", st.last_name , "   /    ", st.email , "   /    ", st.staff_id ) as "información del gerente" ,
	sum(p.amount) as "money"
from
	store s
inner join inventory i on
	s.store_id = i.store_id
inner join film f on
	i.film_id = f.film_id
inner join address a on
	s.address_id = a.address_id
inner join city c on
	c.city_id = a.city_id
inner join country co on
	co.country_id = c.country_id
inner join staff st on
	st.store_id = s.store_id
inner join payment p on
	st.staff_id = p.staff_id ;

-- 5-¿Qué actor ha aparecido en la mayoría de las películas?

select
	"el actor ",
	a.last_name ,
	" es el que aparecio la mayoria de las peliculas "
from
	actor a
inner join film_actor fa on
	a.actor_id = fa.actor_id
inner join film f on
	f.film_id = fa.film_id
group by
	a.actor_id
order by
	count(*) desc
limit 1 ; 