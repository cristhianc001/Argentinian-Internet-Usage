 -- CREATE DATABASE internet_argentina;
USE internet_argentina;

-- ARREGLAR LA COLUMNA AÑO

ALTER TABLE penetracion_velocidad_regional_internet_fijo CHANGE COLUMN `AÃ±o` Año INT;
ALTER TABLE penetracion_velocidad_nacional_internet_fijo CHANGE COLUMN `AÃ±o` Año INT;
ALTER TABLE rango_velocidad_regional_unpivot CHANGE COLUMN `AÃ±o` Año INT;
ALTER TABLE tipo_conexion_regional_unpivot CHANGE COLUMN `AÃ±o` Año INT;
ALTER TABLE datos_economicos CHANGE COLUMN `AÃ±o` Año INT;

-- CREAR COPIA DE LA COLUMNA PROVINCIA Y LUEGO ARREGLARLA

ALTER TABLE penetracion_velocidad_regional_internet_fijo
ADD COLUMN Provincia2 TEXT AFTER Provincia;

UPDATE penetracion_velocidad_regional_internet_fijo
SET Provincia2 = Provincia;

UPDATE penetracion_velocidad_regional_internet_fijo
SET Provincia2 = REPLACE(Provincia2, 'Ã­', 'í');

UPDATE penetracion_velocidad_regional_internet_fijo
SET Provincia2 = REPLACE(Provincia2, 'Ã©', 'é');

UPDATE penetracion_velocidad_regional_internet_fijo
SET Provincia2 = REPLACE(Provincia2, 'Ã¡', 'á');

UPDATE penetracion_velocidad_regional_internet_fijo
SET Provincia2 = REPLACE(Provincia2, 'Ã³', 'ó');

UPDATE penetracion_velocidad_regional_internet_fijo
SET Provincia2 = REPLACE(Provincia2, 'Ãº', 'ú');

ALTER TABLE penetracion_velocidad_regional_internet_fijo
DROP COLUMN Provincia;

ALTER TABLE penetracion_velocidad_regional_internet_fijo CHANGE COLUMN `Provincia2` Provincia TEXT;

-- REPETIR PASOS PARA EL RESTO DE TABLAS CON PROVINCIAS

ALTER TABLE rango_velocidad_regional_unpivot
ADD COLUMN Provincia2 TEXT AFTER Provincia;

UPDATE rango_velocidad_regional_unpivot
SET Provincia2 = Provincia;

UPDATE rango_velocidad_regional_unpivot
SET Provincia2 = REPLACE(Provincia2, 'Ã­', 'í');

UPDATE rango_velocidad_regional_unpivot
SET Provincia2 = REPLACE(Provincia2, 'Ã©', 'é');

UPDATE rango_velocidad_regional_unpivot
SET Provincia2 = REPLACE(Provincia2, 'Ã¡', 'á');

UPDATE rango_velocidad_regional_unpivot
SET Provincia2 = REPLACE(Provincia2, 'Ã³', 'ó');

UPDATE rango_velocidad_regional_unpivot
SET Provincia2 = REPLACE(Provincia2, 'Ãº', 'ú');

ALTER TABLE rango_velocidad_regional_unpivot
DROP COLUMN Provincia;

ALTER TABLE rango_velocidad_regional_unpivot CHANGE COLUMN `Provincia2` Provincia TEXT;

-- SIGUIENTE TABLA

ALTER TABLE tipo_conexion_regional_unpivot
ADD COLUMN Provincia2 TEXT AFTER Provincia;

UPDATE tipo_conexion_regional_unpivot
SET Provincia2 = Provincia;

UPDATE tipo_conexion_regional_unpivot
SET Provincia2 = REPLACE(Provincia2, 'Ã­', 'í');

UPDATE tipo_conexion_regional_unpivot
SET Provincia2 = REPLACE(Provincia2, 'Ã©', 'é');

UPDATE tipo_conexion_regional_unpivot
SET Provincia2 = REPLACE(Provincia2, 'Ã¡', 'á');

UPDATE tipo_conexion_regional_unpivot
SET Provincia2 = REPLACE(Provincia2, 'Ã³', 'ó');

UPDATE tipo_conexion_regional_unpivot
SET Provincia2 = REPLACE(Provincia2, 'Ãº', 'ú');

ALTER TABLE tipo_conexion_regional_unpivot
DROP COLUMN Provincia;

ALTER TABLE tipo_conexion_regional_unpivot CHANGE COLUMN `Provincia2` Provincia TEXT;

-- ULTIMA TABLA

ALTER TABLE provincias
ADD COLUMN nombre2 TEXT AFTER nombre;

UPDATE provincias
SET nombre2 = nombre;

UPDATE provincias
SET nombre2 = REPLACE(nombre2, 'Ã­', 'í');

UPDATE provincias
SET nombre2 = REPLACE(nombre2, 'Ã©', 'é');

UPDATE provincias
SET nombre2 = REPLACE(nombre2, 'Ã¡', 'á');

UPDATE provincias
SET nombre2 = REPLACE(nombre2, 'Ã³', 'ó');

UPDATE provincias
SET nombre2 = REPLACE(nombre2, 'Ãº', 'ú');

ALTER TABLE provincias
DROP COLUMN nombre;

ALTER TABLE provincias CHANGE COLUMN `nombre2` nombre TEXT;

--

ALTER TABLE provincias
ADD COLUMN iso_nombre2 TEXT AFTER iso_nombre;

UPDATE provincias
SET iso_nombre2 = iso_nombre;

UPDATE provincias
SET iso_nombre2 = REPLACE(iso_nombre2, 'Ã­', 'í');

UPDATE provincias
SET iso_nombre2 = REPLACE(iso_nombre2, 'Ã©', 'é');

UPDATE provincias
SET iso_nombre2 = REPLACE(iso_nombre2, 'Ã¡', 'á');

UPDATE provincias
SET iso_nombre2 = REPLACE(iso_nombre2, 'Ã³', 'ó');

UPDATE provincias
SET iso_nombre2 = REPLACE(iso_nombre2, 'Ãº', 'ú');

ALTER TABLE provincias
DROP COLUMN iso_nombre;

ALTER TABLE provincias CHANGE COLUMN `iso_nombre2` iso_nombre TEXT;

-- 

ALTER TABLE provincias
ADD COLUMN nombre_completo2 TEXT AFTER nombre_completo;

UPDATE provincias
SET nombre_completo2 = nombre_completo;

UPDATE provincias
SET nombre_completo2 = REPLACE(nombre_completo2, 'Ã­', 'í');

UPDATE provincias
SET nombre_completo2 = REPLACE(nombre_completo2, 'Ã©', 'é');

UPDATE provincias
SET nombre_completo2 = REPLACE(nombre_completo2, 'Ã¡', 'á');

UPDATE provincias
SET nombre_completo2 = REPLACE(nombre_completo2, 'Ã³', 'ó');

UPDATE provincias
SET nombre_completo2 = REPLACE(nombre_completo2, 'Ãº', 'ú');

ALTER TABLE provincias
DROP COLUMN nombre_completo;

ALTER TABLE provincias CHANGE COLUMN `nombre_completo2` nombre_completo TEXT;

--
UPDATE provincias
SET categoria = REPLACE(categoria, 'Ã³', 'ó');

-- ALTER TABLE provincias DROP COLUMN `fuente`;

-- CAMBIO DE NOMBRE PARA ACORTAR

ALTER TABLE penetracion_velocidad_nacional_internet_fijo
RENAME TO penetracion_nacional;

ALTER TABLE penetracion_velocidad_regional_internet_fijo
RENAME TO penetracion_regional;

ALTER TABLE rango_velocidad_regional_unpivot
RENAME TO rangos_regional;

ALTER TABLE tipo_conexion_regional_unpivot
RENAME TO conexion_regional;