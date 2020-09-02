-- 1 --
SELECT a.address 
	FROM address a
	JOIN city USING(city_id)
	JOIN country USING(country_id)
	WHERE postal_code in (99865)
;	
	
-- 3ms --
-- la corri varias veces asi que no tiene sentido ese numero --

CREATE INDEX postalCode ON address(postal_code);

SELECT a.address 
	FROM address a
	JOIN city USING(city_id)
	JOIN country USING(country_id)
	WHERE postal_code in (99865)
;

-- 12ms --
-- yyyyyyyy los resultados no son buenos pero por que me olvide de fijarme la primera ejecucion
-- de igual forma creo que rondaba entre los 50ms asi que obviamnete mejoro 

-- 2 --
SELECT first_name
	FROM actor a 
	
-- 4ms	
	
SELECT last_name 
	FROM actor a 

-- 2ms
	
-- esto paso ya que last_name tiene un indice :)
	
-- 3 --
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

-- no se por que tardo mas, se supone q con el indice deveria demorar menos :(
-- calculo que para realizar estas pruevas deverias borrar el cache primero (L