 -- CREATE DATABASE internet_argentina;
USE internet_argentina;

-- ARREGLAR LA COLUMNA AÑO

ALTER TABLE penetracion_velocidad_regional_internet_fijo CHANGE COLUMN `AÃ±o` Año INT;
ALTER TABLE penetracion_velocidad_nacional_internet_fijo CHANGE COLUMN `AÃ±o` Año INT;
ALTER TABLE rango_velocidad_regional_unpivot CHANGE COLUMN `AÃ±o` Año INT;
ALTER TABLE tipo_conexion_regional_unpivot CHANGE COLUMN `AÃ±o` Año INT;

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


