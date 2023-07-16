USE internet_argentina;

-- CREAR TABLA
DROP TABLE IF EXISTS provincias;
CREATE TABLE provincias(
IdProvincia INT NOT NULL AUTO_INCREMENT,
Provincia VARCHAR (50) NOT NULL,
Primary key (IdProvincia)
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

-- INSERTAR VALORES
INSERT INTO provincias (Provincia) SELECT DISTINCT Provincia FROM penetracion_velocidad_regional_internet_fijo Order By Provincia;

-- AGREGANDO LA COLUMNA IDPROVINCIA A LAS OTRAS TABLAS
ALTER TABLE penetracion_velocidad_regional_internet_fijo ADD IdProvincia INT NOT NULL DEFAULT 0 AFTER Provincia;
ALTER TABLE rango_velocidad_regional_unpivot ADD IdProvincia INT NOT NULL DEFAULT 0 AFTER Provincia;
ALTER TABLE tipo_conexion_regional_unpivot ADD IdProvincia INT NOT NULL DEFAULT 0 AFTER Provincia;

-- INSERTANDO INFORMACION EN LAS COLUMNAS DE IDPROVINCIA
UPDATE penetracion_velocidad_regional_internet_fijo 
JOIN provincias 
ON penetracion_velocidad_regional_internet_fijo.provincia 
COLLATE utf8mb4_0900_ai_ci  = provincias.Provincia COLLATE utf8mb4_0900_ai_ci
SET penetracion_velocidad_regional_internet_fijo.IdProvincia = provincias.IdProvincia;

UPDATE rango_velocidad_regional_unpivot 
JOIN provincias 
ON rango_velocidad_regional_unpivot.provincia 
COLLATE utf8mb4_0900_ai_ci  = provincias.Provincia COLLATE utf8mb4_0900_ai_ci
SET rango_velocidad_regional_unpivot.IdProvincia = provincias.IdProvincia;

UPDATE tipo_conexion_regional_unpivot 
JOIN provincias 
ON tipo_conexion_regional_unpivot.provincia 
COLLATE utf8mb4_0900_ai_ci  = provincias.Provincia COLLATE utf8mb4_0900_ai_ci
SET tipo_conexion_regional_unpivot.IdProvincia = provincias.IdProvincia;

-- RELACIONANDO TABLA DE PROVINCIAS CON LAS DEMAS TABLAS

ALTER TABLE penetracion_velocidad_regional_internet_fijo ADD CONSTRAINT penetracion_fk_provincia 
FOREIGN KEY (IdProvincia) 
REFERENCES provincias (IdProvincia) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE rango_velocidad_regional_unpivot ADD CONSTRAINT rango_fk_provincia 
FOREIGN KEY (IdProvincia) 
REFERENCES provincias (IdProvincia) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE tipo_conexion_regional_unpivot ADD CONSTRAINT conexion_fk_provincia 
FOREIGN KEY (IdProvincia) 
REFERENCES provincias (IdProvincia) 
ON DELETE RESTRICT ON UPDATE RESTRICT;
