--Cree una nueva base de datos llamada imdb
--Crear tablas: película (film_id, título, descripción, lanzamiento_año); actor (actor_id, first_name, last_name), film_actor (actor_id, film_id)
    --Usar ID de incremento automático
    --Crear PK
--Alterar tabla agregar columna last_update a película y actor
--Alterar tabla agrega claves foráneas a la tabla film_actor
--Inserte algunos actores, películas y quién actuó en cada película.

CREATE DATABASE imdb;

USE imdb;

CREATE TABLE film (film_id INT(11) NOT NULL AUTO_INCREMENT, title VARCHAR(40) NOT NULL, 'description' VARCHAR(90));

CREATE TABLE actor (
    actor_id INT(11) NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(40) NOT NULL,
    last_name VARCHAR(90),
    );

CREATE TABLE film_actor (
  actor_id SMALLINT UNSIGNED NOT NULL,
  film_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY  (actor_id,film_id),
  KEY idx_fk_film_id (`film_id`),
  CONSTRAINT fk_film_actor_actor FOREIGN KEY (actor_id) REFERENCES actor (actor_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_film_actor_film FOREIGN KEY (film_id) REFERENCES film (film_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

ALTER TABLE film
  ADD CONSTRAINT last_update DATE
    PRIMARY KEY (film_id);

ALTER TABLE actor
  ADD CONSTRAINT last_update DATE
    PRIMARY KEY (actor_id);

INSERT INTO film VALUE(1,'Busacando a Nemo' , 'Muy buena',20/20/20),
(2,'Busacando a luis' , 'Muy mala',10/10/10);

INSERT INTO actor VALUE(1,"Juan","Luis",09/09/09),
    (2,"Agostina","Gonzales",08/08/08);

INSERT INTO film_actor VALUE(1,2);

INSERT INTO film_actor VALUE(2,1);
