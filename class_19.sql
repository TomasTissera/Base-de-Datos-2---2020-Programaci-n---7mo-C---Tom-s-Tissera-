-- 1 Crear un usuario data_analyst
create user data_analyst@localhost identified by 'password';

-- 2 Otorgue permisos solo para SELECCIONAR, ACTUALIZAR y ELIMINAR a todas las tablas de sakila.
GRANT SELECT, UPDATE , DELETE ON *.* TO data_analyst@localhost;
SHOW grants for data_analyst@localhost;

-- 3 Inicie sesión con este usuario e intente crear una tabla. Muestre el resultado de esa operación.
-- ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'prueba'

-- 4 Intente actualizar el título de una película. Escribe el script de actualización.
update film set title = 'Ejercicio 4'where film_id = 1;

-- 5 Con root o cualquier usuario administrador, revoque el permiso de ACTUALIZACIÓN. Escribe el comando
revoke update on sakila.* from data_analyst@localhost;
SHOW grants for data_analyst@localhost;

-- 6 Inicie sesión nuevamente con data_analyst e intente nuevamente la actualización realizada en el paso 4. Muestre el resultado.
-- ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
