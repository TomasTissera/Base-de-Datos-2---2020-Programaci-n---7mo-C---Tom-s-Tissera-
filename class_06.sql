--Haz una lista de todos los actores que comparten el apellido. Muéstralas en orden
select *from actor a , actor a2 where a.last_name <> a2.last_name;
--Encuentra actores que no funcionan en ninguna película.

--Encuentra clientes que alquilaron solo una película
select * from  customer c2 where active = 0;
--Encuentra clientes que alquilaron más de una película

--Enumere los actores que actuaron en 'BETRAYED REAR' o en 'CATCH AMISTAD'

--Enumere los actores que actuaron en 'BETRAYED REAR' pero no en 'CATCH AMISTAD'

--Enumere los actores que actuaron tanto en 'BETRAYED REAR' como en 'CATCH AMISTAD'

--Enumere todos los actores que no trabajaron en 'BETRAYED REAR' o 'CATCH AMISTAD'
