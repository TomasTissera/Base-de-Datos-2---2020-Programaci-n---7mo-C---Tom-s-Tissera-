
-- 1-Encuentra las películas con menos duración, muestra el título y la calificación.
select
	title,
	rating
from
	film f
where
	f.length = (
	select
		min(length)
	from
		film f2 );
--  Usando ALL : SELECT title, rating FROM film WHERE length <= ALL (SELECT length FROM film);
--  2-(Escriba una consulta que devuelva la tilde de la película cuya duración es la más baja. 

--  Si hay más de una película con la durtation más baja, la consulta devuelve un conjunto de resultados vacío.)
select
	title,
	rating
from
	film f
where
	f.`length` = (
	select
		min(`length`)
	from
		film f2)
	and f.film_id = all (
	select
		f.film_id
	from
		film f
	where
		f.`length` = (
		select
			min(`length`)
		from
			film f2));
-- 3-Genere un informe con una lista de clientes que muestre los pagos más bajos realizados por cada uno de ellos

-- Muestre la información del cliente, la dirección y la cantidad más baja, proporcione ambas soluciones usando ALL y / o ANY y MIN.
select
	distinct c.customer_id,
	c.first_name,
	c.last_name,
	a.address,
	p.amount as 'min_amount'
from
	customer c,
	address a,
	payment p
where
	c.address_id = a.address_id
	and p.customer_id = c.customer_id
	and p.amount in (
	select
		min(p2.amount)
	from
		payment p2WHERE p2.customer_id = c.customer_id)
order by
	min_amount;
-- 4-Genere un informe que muestre la información del cliente con el pago más alto y el pago más bajo en la misma fila.
select
	distinct c.customer_id,
	c.first_name,
	c.last_name,
	a.address,
	p.amount as 'min_amount',
	p3.amount as "max_amount"
from
	customer c,
	address a,
	payment p,
	payment p3
where
	c.address_id = a.address_id
	and p.customer_id = c.customer_id
	and p3.customer_id = c.customer_id
	and p.amount <= all (
	select
		p2.amount
	from
		payment p2
	where
		p2.customer_id = c.customer_id)
	and p3.amount >= all (
	select
		p2.amount
	from
		payment p2
	where
		p2.customer_id = c.customer_id)
order by
	min_amount;
-- 