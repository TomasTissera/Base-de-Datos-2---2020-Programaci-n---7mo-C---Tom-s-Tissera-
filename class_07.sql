-- 1-Encuentra las películas con menos duración, muestra el título y la calificación.
SELECT title,  rating 
  FROM film f 
  where f.length = (
    SELECT MIN(length) 
    FROM film f2 );
-- Usando ALL : SELECT title, rating FROM film WHERE length <= ALL (SELECT length FROM film);
 
-- 2-(Escriba una consulta que devuelva la tilde de la película cuya duración es la más baja. 
-- Si hay más de una película con la durtation más baja, la consulta devuelve un conjunto de resultados vacío.)
SELECT title,	rating 
  from film f
  where f.`length` = (
      SELECT MIN(`length`)
	FROM film f2)
	AND f.film_id = ALL (
	  SELECT f.film_id
    FROM film f
    where f.`length` = (
		  SELECT	MIN(`length`)
		  FROM film f2));

-- 3-Genere un informe con una lista de clientes que muestre los pagos más bajos realizados por cada uno de ellos
-- Muestre la información del cliente, la dirección y la cantidad más baja, proporcione ambas soluciones usando ALL y / o ANY y MIN.

SELECT DISTINCT c.customer_id, c.first_name, c.last_name,	a.address,	p.amount AS 'min_amount'
  FROM	customer c,	address a,	payment p
  WHERE	c.address_id = a.address_id
	AND p.customer_id = c.customer_id
	AND p.amount IN (
	  SELECT MIN(p2.amount)
	  FROM payment p2WHERE p2.customer_id = c.customer_id)
  ORDER BY	min_amount;

-- 4-Genere un informe que muestre la información del cliente con el pago más alto y el pago más bajo en la misma fila.

 SELECT	DISTINCT c.customer_id,	c.first_name,	c.last_name,	a.address,	p.amount 
 AS 'min_amount',	p3.amount 
 AS "max_amount"
  FROM	customer c,	address a,	payment p,	payment p3
  WHERE	c.address_id = a.address_id
	AND p.customer_id = c.customer_id
	AND p3.customer_id = c.customer_id
	AND p.amount <= ALL (
	  SELECT	p2.amount
	  FROM	payment p2
	  WHERE	p2.customer_id = c.customer_id)
	AND p3.amount >= ALL (
  	SELECT	p2.amount
  	FROM payment p2
  	WHERE	p2.customer_id = c.customer_id)
  ORDER BY	min_amount;
