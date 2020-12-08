-- 1 Cree dos o tres consultas usando la tabla de direcciones en sakila db--
SELECT a.address 
	FROM address a
	JOIN city USING(city_id)
	JOIN country USING(country_id)
	WHERE postal_code in (99865)
;	
-- 3ms --
CREATE INDEX postalCode ON address(postal_code);
SELECT a.address 
	FROM address a
	JOIN city USING(city_id)
	JOIN country USING(country_id)
	WHERE postal_code in (99865)
;
-- 12ms --
-- 2 Ejecute consultas utilizando la tabla de actores, buscando columnas de nombre y apellido de forma independiente. 
-- Explique las diferencias y ¿por qué sucede eso?--
SELECT first_name
	FROM actor a 
-- 4ms	
SELECT last_name 
	FROM actor a 
-- 2ms
-- last_name tiene un indice

-- 3 Compare los resultados de la búsqueda de texto en la descripción de la película de mesa con LIKE y en el texto de la película usando MATCH ... CONTRA. Explica los resultados.--
SELECT description 
	FROM film f 
	WHERE description LIKE '%Fast%'
;
-- 52rw y 4 ms
SELECT description 
	FROM film_text ft 
	WHERE MATCH(title, description) AGAINST('Fast')
;
-- 52rw 119ms