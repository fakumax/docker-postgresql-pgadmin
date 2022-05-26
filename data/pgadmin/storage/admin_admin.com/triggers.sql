--TP triggers 

--BEFORE INSERT ROW--
--1)* STORE PROCEDURE *--
CREATE OR REPLACE FUNCTION sp_insertUserDate()
	RETURNS TRIGGER AS $insertUserDate$
DECLARE
	BEGIN
		NEW.f_alta = now();
		NEW.c_usuario_alta = CURRENT_USER;
	RETURN NEW;
END
$insertUserDate$ LANGUAGE plpgsql;

--1)* TRIGGER *--
CREATE TRIGGER tg_insertUserDate
	BEFORE INSERT
	ON usuarios
	FOR EACH ROW
EXECUTE PROCEDURE sp_insertUserDate()

--2)* Backup *--
-- Backup de usuarios . 
-- usuarios>backup> 
-- Filename: backup_usuarios
-- Format: custom
-- Encoding: UTF-8
-- Role Name: postgres
-- Tab Data/objects-Data
-- Select Data

-- Backup de direccion. 
-- usuarios>backup> 
-- Filename: backup_direccion
-- Format: custom
-- Encoding: UTF-8
-- Role Name: postgres
-- Tab Data/objects-Data
-- Select Data

--3)* TRUNCATE *--
TRUNCATE TABLE usuarios,direccion CASCADE;

--4)* RESTORE *--
--Restore usuarios
--Usuarios>Restore
--Filename: /backup_usuarios.sql
--Role: postgres

--Restore direccion
--Usuarios>Restore
--Filename: /backup_direccion.sql
--Role: postgres


-------------------------------------
--BEFORE UPDATE ROW--
--* STORE PROCEDURE *--
CREATE OR REPLACE FUNCTION sp_UpdateUserDate()
	RETURNS TRIGGER AS $UpdateUserDate$
DECLARE
	BEGIN
		NEW.f_actualizac = now();
		NEW.c_usuario_act = CURRENT_USER;
	RETURN NEW;
END
$UpdateUserDate$ LANGUAGE plpgsql;

--* TRIGGER *--
CREATE TRIGGER tg_UpdateUserDate
	BEFORE UPDATE
	ON usuarios
	FOR EACH ROW
EXECUTE PROCEDURE sp_UpdateUserDate()

-------------------------------------
--UPDATE TEST
UPDATE usuarios SET d_nombre = 'Facundo' WHERE id_usuario=1;
select * from  usuarios;

--BEFORE UPDATE OR DELETE ROW
--3)* STORE PROCEDURE *--
CREATE TABLE usuarios_hist(
	id_usuarios_hist serial,
	d_nombre character varying(300) NOT NULL,
	d_apellido character varying(100) NOT NULL,
	d_clave character varying(32) NOT NULL,
	d_correo character varying(100),
	n_celular character varying(100),
	d_sitio_web character varying(100),
	id_compania integer,
	f_alta date,
	c_usuario_alta character varying(100),
	f_actualizac date,
	c_usuario_act character varying(100),
	f_operacion date,
	c_usuario_operacion character varying(10),
	c_operacion character varying(50),
PRIMARY KEY (id_usuarios_hist)
);
 
CREATE OR REPLACE FUNCTION sp_UpdateDelete()
	RETURNS TRIGGER AS $UpdateDelete$
DECLARE
	BEGIN
		IF (TG_OP = 'DELETE') THEN
            INSERT INTO usuarios_hist(f_operacion,c_usuario_operacion,c_operacion)
			SELECT OLD.*;
        ELSIF (TG_OP = 'UPDATE') THEN
			INSERT INTO usuarios_hist 
			(id_usuarios_hist, d_nombre,d_apellido,d_clave,d_correo,
			 n_celular,d_sitio_web,id_compania,f_alta,c_usuario_alta,
			 f_actualizac,c_usuario_act,f_operacion,c_usuario_operacion,c_operacion)
			VALUES (OLD.*,now(),CURRENT_USER,'U')
			ON CONFLICT (id_usuarios_hist) DO UPDATE SET 
			id_usuarios_hist = EXCLUDED.id_usuarios_hist,
			f_operacion=now(),
			c_usuario_operacion=CURRENT_USER,
			c_operacion='U'
			;
	    END IF;
	RETURN NEW;
END
$UpdateDelete$ LANGUAGE plpgsql;

select * from usuarios;
select * from usuarios_hist;

--* TRIGGER *--
CREATE TRIGGER tg_InsertarRegistro
	BEFORE UPDATE
	ON usuarios
	FOR EACH ROW
EXECUTE PROCEDURE sp_UpdateDelete()

--UPDATE TEST
UPDATE usuarios SET d_nombre = 'Facusrrr' WHERE id_usuario=1;
UPDATE usuarios_hist SET f_operacion = '2020-01-01' WHERE id_usuarios_hist=2;

DELETE from usuarios_hist  WHERE id_usuarios_hist=1;
select * from  usuarios;
select * from  usuarios_hist;



