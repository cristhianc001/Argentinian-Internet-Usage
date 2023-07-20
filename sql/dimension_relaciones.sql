USE internet_argentina;
/* YA NO ES NECESARIO CREAR LA TABLA, SE IMPORTÓ CON LAS COORDENDAS
-- CREAR TABLA
DROP TABLE IF EXISTS provincias;
CREATE TABLE provincias(
IdProvincia INT NOT NULL AUTO_INCREMENT,
Provincia VARCHAR (50) NOT NULL,
Primary key (IdProvincia)
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_spanish_ci;

-- INSERTAR VALORES
INSERT INTO provincias (Provincia) SELECT DISTINCT Provincia FROM penetracion_velocidad_regional_internet_fijo Order By Provincia;
*/

ALTER TABLE penetracion_regional DROP COLUMN `IdProvincia`;
ALTER TABLE rangos_regional DROP COLUMN `IdProvincia`;
ALTER TABLE conexion_regional DROP COLUMN `IdProvincia`;

-- AGREGANDO LA COLUMNA IDPROVINCIA A LAS OTRAS TABLAS
ALTER TABLE penetracion_regional ADD IdProvincia INT NOT NULL DEFAULT 0 AFTER Provincia;
ALTER TABLE rangos_regional ADD IdProvincia INT NOT NULL DEFAULT 0 AFTER Provincia;
ALTER TABLE conexion_regional ADD IdProvincia INT NOT NULL DEFAULT 0 AFTER Provincia;

-- INSERTANDO INFORMACION EN LAS COLUMNAS DE IDPROVINCIA
UPDATE penetracion_regional 
JOIN provincias 
ON penetracion_regional.Provincia 
COLLATE utf8mb4_0900_ai_ci  = provincias.iso_nombre COLLATE utf8mb4_0900_ai_ci
SET penetracion_regional.IdProvincia = provincias.id;

UPDATE rangos_regional 
JOIN provincias 
ON rangos_regional.Provincia 
COLLATE utf8mb4_0900_ai_ci  = provincias.iso_nombre COLLATE utf8mb4_0900_ai_ci
SET rangos_regional.IdProvincia = provincias.id;

UPDATE conexion_regional 
JOIN provincias 
ON conexion_regional.Provincia 
COLLATE utf8mb4_0900_ai_ci  = provincias.iso_nombre COLLATE utf8mb4_0900_ai_ci
SET conexion_regional.IdProvincia = provincias.id;

-- RELACIONANDO TABLA DE PROVINCIAS CON LAS DEMAS TABLAS

ALTER TABLE provincias
ADD PRIMARY KEY (id);

ALTER TABLE penetracion_regional ADD CONSTRAINT penetracion_fk_provincia 
FOREIGN KEY (IdProvincia) 
REFERENCES provincias (id) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE rangos_regional ADD CONSTRAINT rango_fk_provincia 
FOREIGN KEY (IdProvincia) 
REFERENCES provincias (id) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE conexion_regional ADD CONSTRAINT conexion_fk_provincia 
FOREIGN KEY (IdProvincia) 
REFERENCES provincias (id) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

-- PARA BORRAR FK
-- ALTER TABLE tipo_conexion_regional_unpivot
-- DROP FOREIGN KEY conexion_fk_provincia;

select * from provincias;
