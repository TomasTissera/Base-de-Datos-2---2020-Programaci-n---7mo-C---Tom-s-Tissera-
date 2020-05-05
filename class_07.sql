-- 1-Encuentra las películas con menos duración, muestra el título y la calificación.
SELECT title,rating 
  FROM film f 
  where f.length = (
    SELECT MIN(length) 
    FROM film f2 );
-- Usando ALL : SELECT title, rating FROM film WHERE length <= ALL (SELECT length FROM film);
 
-- 2-(Escriba una consulta que devuelva la tilde de la película cuya duración es la más baja. 
-- Si hay más de una película con la durtation más baja, la consulta devuelve un conjunto de resultados vacío.)

-- completar

-- 3-Genere un informe con una lista de clientes que muestre los pagos más bajos realizados por cada uno de ellos
-- Muestre la información del cliente, la dirección y la cantidad más baja, proporcione ambas soluciones usando ALL y / o ANY y MIN.

-- completar

-- 4-Genere un informe que muestre la información del cliente con el pago más alto y el pago más bajo en la misma fila.

-- completar
