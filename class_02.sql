--Cree una nueva base de datos llamada imdb --Crear tablas: película (film_id,
--título,
--descripción,
--lanzamiento_año);

--actor (actor_id,
--first_name,
--last_name),
--film_actor (actor_id,
--film_id) --Usar ID de incremento automático --Crear PK --Alterar tabla agregar columna last_update a película y actor --Alterar tabla agrega claves foráneas a la tabla film_actor --Inserte algunos actores,
--películas y quién actuó en cada película. create database imdb;

use imdb;

create table film (film_id int(11) not null auto_increment,
title varchar(40) not null,
'description' varchar(90));

create table actor ( actor_id int(11) not null auto_increment,
first_name varchar(40) not null,
last_name varchar(90),
);

create table film_actor ( actor_id smallint unsigned not null,
film_id smallint unsigned not null,
primary key (actor_id,
film_id),
key idx_fk_film_id (`film_id`),
constraint fk_film_actor_actor foreign key (actor_id) references actor (actor_id) on
delete
	restrict on
	update
		cascade,
		constraint fk_film_actor_film foreign key (film_id) references film (film_id) on
		delete
			restrict on
			update
				cascade );

alter table film add constraint last_update date primary key (film_id);

alter table actor add constraint last_update date primary key (actor_id);

insert
	into
	film VALUE(1,
	'Busacando a Nemo' ,
	'Muy buena',
	20 / 20 / 20),
	(2,
	'Busacando a luis' ,
	'Muy mala',
	10 / 10 / 10);

insert
	into
	actor VALUE(1,
	"Juan",
	"Luis",
	09 / 09 / 09),
	(2,
	"Agostina",
	"Gonzales",
	08 / 08 / 08);

insert
	into
	film_actor VALUE(1,
	2);

insert
	into
	film_actor VALUE(2,
	1); 