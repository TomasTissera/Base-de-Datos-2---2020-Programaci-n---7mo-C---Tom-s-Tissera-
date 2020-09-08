-- 1 Crear un usuario data_analyst
CREATE USER super@localhost IDENTIFIED BY 'data_analyst';
-- 2 Otorgue permisos solo para SELECCIONAR, ACTUALIZAR y ELIMINAR a todas las tablas de sakila.
GRANT SELECT, UPDATE , DELETE ON *.* TO 'super'@'localhost' WITH GRANT OPTION;
-- 3 Inicie sesión con este usuario e intente crear una tabla. Muestre el resultado de esa operación.
-- 4 Intente actualizar el título de una película. Escribe el script de actualización.
-- 5 Con root o cualquier usuario administrador, revoque el permiso de ACTUALIZACIÓN. Escribe el comando
REVOKE UPDATE PRIVILEGES, GRANT OPTION FROM data_analyste;
-- 6 Inicie sesión nuevamente con data_analyst e intente nuevamente la actualización realizada en el paso 4. Muestre el resultado.