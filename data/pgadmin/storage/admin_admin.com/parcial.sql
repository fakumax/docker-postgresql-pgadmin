-- by Vergara Facundo 2022-06-23

-- 1. En base a la siguiente relación, realicé una consulta para recuperar todos los registros de los artistas
-- que tengan más de 10.000.000 oyentes mensuales (n_oyentes_m)

SELECT id_artista,d_nombre, n_oyentes_m
FROM artista 
WHERE n_oyentes_m > 10000000;

-- 2. Realice la consulta que permita editar el nombre de un artista en particular.

UPDATE artista
SET d_nombre = 'Philip David Charles Collins'
WHERE id_artista = '4lxfqrEsLX6N1N4OCSkILp';

-- 3. Dada la siguiente sentencia que busca poner la fecha de alta de los registros que se insertan en la
-- tabla artista, realice las correcciones necesarias y escriba las suposiciones que considere.

CREATE OR REPLACE FUNCTION sp_AddDateArtist()
RETURNS TRIGGER AS $AddDateArtist$
DECLARE
	BEGIN
		NEW.f_alta = CURRENT_DATE;
	RETURN NEW;
END;
$AddDateArtist$ LANGUAGE plpgsql;

CREATE TRIGGER tg_AddDateArtist
	BEFORE INSERT ON artista
	FOR EACH ROW
EXECUTE PROCEDURE sp_AddDateArtist();

----------
--TEST

SELECT * FROM artista

INSERT INTO artista (id_artista, d_nombre)
VALUES( 'warawara',	'Juan Carlos');

-- 4. Dada la siguiente sentencia DDL, indique que tipo de dato debería ser el id_tabla si se desea que sea
-- autoincremental.

CREATE TABLE IF NOT EXISTS public.new_tabla
(
id_tabla SERIAL NOT NULL,
d_nombre character varying(300) NOT NULL,
d_apellido character varying(100) NOT NULL,
CONSTRAINT new_tabla_pkey PRIMARY KEY (id_tabla)
);
	
-- 5. Cree un procedimiento que dado un id_artista, realice una operación (decrementación (D) o
-- incrementación (I) ) sobre los oyentes mensuales.

CREATE OR REPLACE PROCEDURE sp_oyentes(id_art VARCHAR, operacion VARCHAR ,numero_oyentes INT)
AS $oyentes$
    BEGIN
        IF operacion = 'D' THEN
            UPDATE artista SET n_oyentes_m= n_oyentes_m - numero_oyentes WHERE id_artista = id_art;
        ELSEIF operacion = 'I' THEN
            UPDATE artista SET n_oyentes_m= n_oyentes_m + numero_oyentes WHERE id_artista = id_art;
        END IF;
    END;
$oyentes$ LANGUAGE PLPGSQL;

------------------------
--TEST
select * from artista
CALL sp_oyentes('58lV9VcRSjABbAbfWS6skp','I',1150);
CALL sp_oyentes('58lV9VcRSjABbAbfWS6skp','D',1150);

CALL sp_oyentes('79FMDwzZQxHgSkIYBl3ODU','I',1150);
CALL sp_oyentes('79FMDwzZQxHgSkIYBl3ODU','I',1150);



 
 
 
 