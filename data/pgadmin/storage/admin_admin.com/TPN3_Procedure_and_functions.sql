--PROCEDIMIENTOS
--1. Crear un procedimiento que dado un id_artista, 
-- realizar una operación (decrementación (D) o
-- incrementación (I) ) sobre los oyentes mensuales.

--* El id_artista, la operación, y la cantidad a incrementar o
--* decrementar se reciben como parámetros del procedimiento

CREATE OR REPLACE PROCEDURE CAMBIO_OYENTES_ARTISTA(ID_ARTIST VARCHAR,OPERACION VARCHAR ,N_OYENTES INT)
AS $CAMBIO_OYENES_ARTISTA$
    BEGIN
        IF OPERACION = 'D' THEN
            UPDATE ARTISTA SET N_OYENTES_M= N_OYENTES_M-N_OYENTES WHERE ID_ARTISTA = ID_ARTIST;
        ELSEIF OPERACION = 'I' THEN
            UPDATE ARTISTA SET N_OYENTES_M= N_OYENTES_M+N_OYENTES WHERE ID_ARTISTA = ID_ARTIST;
        END IF;
    END;
$CAMBIO_OYENES_ARTISTA$ LANGUAGE PLPGSQL;
------------------------
--CALL
CALL cambio_oyentes_artista('4lxfqrEsLX6N1N4OCSkILp','I',10);

------------------------
--TEST
select * from artista
---------------------------------------------------

--2. Implementar un Procedimiento que dada una canción le incremente/decremente 15 seg de
--su duración.

CREATE OR REPLACE PROCEDURE CAMBIO_DURACION_PISTA(PISTA INT,OPERACION VARCHAR)
AS $CAMBIO_DURACION_PISTA$
    BEGIN
        IF OPERACION = 'D' THEN
            UPDATE PISTAS SET DURACION_SEG= DURACION_SEG-15 WHERE ID_PISTA = PISTA;
        ELSEIF OPERACION = 'I' THEN
            UPDATE PISTAS SET DURACION_SEG= DURACION_SEG+15 WHERE ID_PISTA = PISTA;
        END IF;
    END;
$CAMBIO_DURACION_PISTA$ LANGUAGE PLPGSQL;
------------------------
--CALL
CALL CAMBIO_DURACION_PISTA(3,'D');
CALL CAMBIO_DURACION_PISTA(3,'I');
------------------------
--TEST
select * from pistas
---------------------------------------------------
--FUNCIONES

--1. Crear una función que retorne el promedio de tiempo de duración de las canciones
--de un artista.

--* La función debe recibir como parámetro el id_artista y retornar un promedio.

CREATE OR REPLACE FUNCTION PROMEDIO_TIEMPO(P_ID_ARTISTA VARCHAR) 
RETURNS FLOAT AS $PROMEDIO_TIEMPO$
    DECLARE V_AUX FLOAT;
BEGIN
   SELECT AVG(DURACION_SEG) INTO V_AUX FROM  ALBUMS INNER JOIN PISTAS 
   ON ALBUMS.ID_ALBUM= PISTAS.ID_ALBUM
   WHERE ALBUMS.ID_ARTISTA=P_ID_ARTISTA;
   
   RETURN V_AUX;
END;
$PROMEDIO_TIEMPO$ LANGUAGE PLPGSQL;

----TEST
SELECT PROMEDIO_TIEMPO('58LV9VCRSJABBABFWS6SKP')


----------------------
--VISTAS

--1. Implemente una vista para visualizar el nombre de los álbumes, el nombre del artista de
--dicho álbum, el tipo de álbum y el año del álbum.

CREATE OR REPLACE VIEW ARTIST_INFO AS
SELECT albums.D_NOMBRE as albumsdn, ARTISTA.D_NOMBRE as artistadn, ALBUMS.D_TIPO_ALBUM, ALBUMS.N_ANIO
FROM ALBUMS INNER JOIN ARTISTA ON 
ARTISTA.ID_ARTISTA = ALBUMS.ID_ARTISTA;

--TEST
select * from artist_info



