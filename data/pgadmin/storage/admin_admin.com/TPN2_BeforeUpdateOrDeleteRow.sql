-- Trabajo Práctico Áulico - TRIGGERS + Transacciones
-- PUNTO 3
-- ** BEFORE UPDATE OR DELETE ROW **
-- 1. Crear una tabla llamada nombte_tabla_hist, la misma deberá tener los mismos campos que
-- la tabla base, pero tendra su propio id de tipo autoincremental y tendrá 3 columnas extra que
-- serán f_operacion, c_usuario_operacion, c_operacion.

CREATE TABLE albums_hist(
	id_album_hist serial,
	id_album character varying(25),
	id_artista character varying(25),
	d_nombre character varying(100),
	d_tipo_album character varying(20),
	n_anio character varying(100),
	d_portada character varying(100),
	d_etiqueta character varying(50),
	m_ultimo character varying(1),
	f_alta date,
	c_usuario_alt character varying(128),
	f_actualizac date,
	c_usuario_act character varying(128),
	f_operacion date,
	c_usuario_operacion character varying(128),
	c_operacion character varying(1),
	PRIMARY KEY (id_album_hist)
);

CREATE TABLE artista_hist(
	id_artista_hist serial,
	id_artista character varying(25),
	d_nombre character varying(300) NOT NULL,
	c_verificado character varying(100),
	d_biografia character varying(4000) NOT NULL,
	d_imagen character varying(300) NOT NULL,
	n_oyentes_m integer,
	d_info character varying(100),
	n_seguidores integer,
	f_alta date,
	c_usuario_alta character varying(30),
	f_actualizac date,
	c_usuario_act character varying(30),
	f_operacion date,
	c_usuario_operacion character varying(30),
	c_operacion character varying(1),
PRIMARY KEY (id_artista_hist)
);

CREATE TABLE company_hist(
	id_company_hist serial,
	id_company integer,
	nombre character varying(255),
	f_alta date,
	c_usuario_alta character varying(20),
	f_actualizac date,
	c_usuario_act character varying(20),
	f_operacion date,
	c_usuario_operacion character varying(20),
	c_operacion character varying(1),
PRIMARY KEY (id_company_hist)
);

CREATE TABLE pistas_hist(
	id_pista_hist serial,
	id_pista integer,
	id_album character varying,
	nombre character varying(100),
	numero integer,
	duracion_seg integer,
	f_alta date,
	c_usuario_alta character varying(100),
	f_actualizac date,
	c_usuario_act character varying(100),
	f_operacion date,
	c_usuario_operacion character varying(100),
	c_operacion character varying(1),
	PRIMARY KEY (id_pista_hist)
);

-- 2. Crear un trigger HIST para la tabla, el mismo deberá insertar el registro OLD en la tabla
-- nombte_tabla_hist, la c_operacion será "U" o "D" según la operación que se realicé si es
-- update or delete. La fecha de operación será la actual y el usuario el USER.

-----ALBUMS----------
CREATE OR REPLACE FUNCTION sp_UpdateDeleteAlbums()
	RETURNS TRIGGER AS $UpdateDeleteAlbums$
DECLARE
	BEGIN
		IF (TG_OP = 'DELETE') THEN
            INSERT INTO albums_hist 
			(id_album, id_artista, d_nombre, d_tipo_album, n_anio,d_portada,
			 d_etiqueta, m_ultimo,f_alta,c_usuario_alt,
			 f_actualizac,c_usuario_act,f_operacion,c_usuario_operacion,c_operacion)
			VALUES (OLD.*,now(),CURRENT_USER,'D');
			RETURN OLD;   
        ELSIF (TG_OP = 'UPDATE') THEN
			INSERT INTO albums_hist 
			(id_album, id_artista, d_nombre, d_tipo_album, n_anio,d_portada,
			 d_etiqueta, m_ultimo,f_alta,c_usuario_alt,
			 f_actualizac,c_usuario_act,f_operacion,c_usuario_operacion,c_operacion)
			VALUES (OLD.*,now(),CURRENT_USER,'U');
			RETURN NEW;
	    END IF;
	RETURN NEW;
END
$UpdateDeleteAlbums$ LANGUAGE plpgsql;

--* TRIGGER *--
CREATE TRIGGER tg_UpdateDeleteAlbums
	BEFORE UPDATE OR DELETE
	ON albums
	FOR EACH ROW
EXECUTE PROCEDURE sp_UpdateDeleteAlbums()

-----ARTISTA----------
CREATE OR REPLACE FUNCTION sp_UpdateDeleteArtista()
	RETURNS TRIGGER AS $UpdateDeleteArtista$
DECLARE
	BEGIN
		IF (TG_OP = 'DELETE') THEN
            INSERT INTO artista_hist 
			( id_artista, d_nombre, c_verificado, d_biografia,
			 d_imagen, n_oyentes_m ,d_info, n_seguidores,f_alta,c_usuario_alta,
			 f_actualizac,c_usuario_act,f_operacion,c_usuario_operacion,c_operacion)
			VALUES (OLD.*,now(),CURRENT_USER,'D');
			RETURN OLD;   
        ELSIF (TG_OP = 'UPDATE') THEN
			INSERT INTO artista_hist 
			( id_artista, d_nombre, c_verificado, d_biografia,
			 d_imagen, n_oyentes_m ,d_info, n_seguidores,f_alta,c_usuario_alta,
			 f_actualizac,c_usuario_act,f_operacion,c_usuario_operacion,c_operacion)
			VALUES (OLD.*,now(),CURRENT_USER,'U');
			RETURN NEW;
	    END IF;
	RETURN NEW;
END
$UpdateDeleteArtista$ LANGUAGE plpgsql;

--* TRIGGER *--
CREATE TRIGGER tg_UpdateDeleteArtista
	BEFORE UPDATE OR DELETE
	ON artista
	FOR EACH ROW
EXECUTE PROCEDURE sp_UpdateDeleteArtista()

-----COMPANY----------
CREATE OR REPLACE FUNCTION sp_UpdateDeleteCompany()
	RETURNS TRIGGER AS $UpdateDeleteCompany$
DECLARE
	BEGIN
		IF (TG_OP = 'DELETE') THEN
            INSERT INTO company_hist 
			( id_company, nombre,f_alta,c_usuario_alta,
			 f_actualizac,c_usuario_act,f_operacion,c_usuario_operacion,c_operacion)
			VALUES (OLD.*,now(),CURRENT_USER,'D');
			RETURN OLD;   
        ELSIF (TG_OP = 'UPDATE') THEN
			INSERT INTO company_hist 
			( id_company, nombre,f_alta,c_usuario_alta,
			 f_actualizac,c_usuario_act,f_operacion,c_usuario_operacion,c_operacion)
			VALUES (OLD.*,now(),CURRENT_USER,'U');
			RETURN NEW;
	    END IF;
	RETURN NEW;
END
$UpdateDeleteCompany$ LANGUAGE plpgsql;

--* TRIGGER *--
CREATE TRIGGER tg_UpdateDeleteCompany
	BEFORE UPDATE OR DELETE
	ON company
	FOR EACH ROW
EXECUTE PROCEDURE sp_UpdateDeleteCompany()

-----PISTAS----------
CREATE OR REPLACE FUNCTION sp_UpdateDeletePistas()
	RETURNS TRIGGER AS $UpdateDeletePistas$
DECLARE
	BEGIN
		IF (TG_OP = 'DELETE') THEN
            INSERT INTO pistas_hist 
			( id_pista, id_album, nombre,numero,duracion_seg,f_alta,
			 c_usuario_alta,f_actualizac,c_usuario_act,f_operacion,c_usuario_operacion,c_operacion)
			VALUES (OLD.*,now(),CURRENT_USER,'D');
			RETURN OLD;   
        ELSIF (TG_OP = 'UPDATE') THEN
			INSERT INTO pistas_hist 
			( id_pista, id_album, nombre,numero,duracion_seg,f_alta,
			 c_usuario_alta,f_actualizac,c_usuario_act,f_operacion,c_usuario_operacion,c_operacion)
			VALUES (OLD.*,now(),CURRENT_USER,'U');
			RETURN NEW;
	    END IF;
	RETURN NEW;
END
$UpdateDeletePistas$ LANGUAGE plpgsql;

--* TRIGGER *--
CREATE TRIGGER tg_UpdateDeletePistas
	BEFORE UPDATE OR DELETE
	ON pistas
	FOR EACH ROW
EXECUTE PROCEDURE sp_UpdateDeletePistas()
------------------------------
--TEST
--ALBUMS
select * from albums
select * from albums_hist

UPDATE albums SET d_nombre = 'Lay Down Your Love Remix' WHERE id_album='1KebhJy1lMp7sbPPLhBYLp';
DELETE from albums  WHERE id_album='1KebhJy1lMp7sbPPLhBYLp';

--TEST
--ARTISTA
select * from artista
select * from artista_hist

UPDATE artista SET d_nombre = 'John Bon Jovi' WHERE id_artista='58lV9VcRSjABbAbfWS6skp';
DELETE from artista  WHERE id_artista='58lV9VcRSjABbAbfWS6skp';
--TEST
--COMPANY
select * from company
select * from company_hist

UPDATE company SET nombre = 'Sony Music' WHERE id_company=2;
DELETE from company  WHERE id_company=2;

--TEST
--PISTAS
select * from pistas
select * from pistas_hist

UPDATE pistas SET nombre = 'Rough an ready --update' WHERE id_pista=2;
DELETE from pistas  WHERE id_pista=2;

