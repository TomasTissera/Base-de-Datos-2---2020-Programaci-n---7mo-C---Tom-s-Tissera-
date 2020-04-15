--Mostrar título y características especiales de películas que son PG-13
select title, special_features from film where rating ="PG-13";
--Obtenga una lista de todas las diferentes películas de duración.
select distinct rental_duration ,title ,description from  film f1 ; 
--Muestra el título, la tasa de alquiler y el costo de reemplazo de las películas que tienen un costo de reemplazo de 20.00 a 24.00
select title,rental_rate ,replacement_cost from film f where replacement_cost between 20.00 and 24.00;
--Muestra el título, la categoría y la calificación de las películas que tienen "Detrás de escena" como características especiales
select title , rating from film f2 where special_features = "Behind the Scenes";
--Mostrar nombre y apellido de los actores que actuaron en 'ZOOLANDER FICTION'

--Mostrar la dirección, ciudad y país de la tienda con id 1

--Mostrar un par de títulos de películas y calificación de películas que tienen la misma calificación.
select title , rating from film f where f.rating = f.rating order by rating 
--Obtenga todas las películas que están disponibles en la tienda id 2 y el nombre / apellido del administrador de esta tienda (el administrador aparecerá en todas las filas).




