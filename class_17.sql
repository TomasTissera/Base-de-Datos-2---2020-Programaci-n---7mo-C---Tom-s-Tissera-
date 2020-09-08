-- 1 --
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
-- 2 --
SELECT first_name
	FROM actor a 
-- 4ms	
SELECT last_name 
	FROM actor a 
-- 2ms
-- last_name tiene un indice
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