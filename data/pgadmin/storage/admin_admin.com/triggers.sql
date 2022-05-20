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

--INSERT TEST
INSERT INTO usuarios(id_usuario,d_nombre,d_apellido,d_clave,d_correo,n_celular,d_sitio_web,id_company,f_alta,c_usuario_alta,f_actualizac,c_usuario_act) 
VALUES (71,'fafa','wara','fafa','fafa@fafa.com','37646464','www.fafa',1,'2021-01-01','2021-01-01','2021-01-01','2021-01-01')

--2-3)* STORE PROCEDURE *--
CREATE OR REPLACE FUNCTION sp_BackupUserAdress()
	RETURNS TRIGGER AS $BackupUserAdress$
DECLARE
	BEGIN
		  CREATE TEMPORARY TABLE backup_User ON COMMIT DROP AS 
		  SELECT NEW.*;  
		  
		  CREATE TEMPORARY TABLE backup_Adress ON COMMIT DROP AS
			SELECT id_direccion,id_usuario,d_calle, n_altura, d_ciudad,
			c_postal,f_alta, f_actualizac,c_usuario_act,c_usuario_alta
			FROM   direccion
			WHERE  id_usuario = New.id_usuario;
		  --El truncate lo hice manual ya que no funciona aquí.
		  TRUNCATE TABLE usuarios,direccion CASCADE;
    RETURN NEW;
END
$BackupUserAdress$ LANGUAGE plpgsql;

CREATE TRIGGER tg_BackupUserAdress 
	BEFORE INSERT
	ON usuarios
	FOR EACH ROW 
EXECUTE PROCEDURE sp_BackupUserAdress();

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


--UPDATE TEST
UPDATE usuarios SET d_nombre = 'Facundo' WHERE id_usuario=39;
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
	c_usuario_operacion integer,
	c_operacion integer,
PRIMARY KEY (id_usuarios_hist)
);
  
select * from usuarios_hist
select * from usuarios

CREATE OR REPLACE FUNCTION sp_InsertarRegistro()
	RETURNS TRIGGER AS $InsertarRegistro$
DECLARE
	BEGIN
		NEW.d_nombre = OLD.d_nombre;
		NEW.d_apellido = OLD.d_apellido;
		NEW.d_clave = OLD.d_clave;
		NEW.d_correo = OLD.d_correo;
		NEW.n_celular = OLD.n_celular;
		NEW.d_sitio_web = OLD.d_sitio_web;
     	NEW.id_compania = OLD.id_compania;
		NEW.f_alta = OLD.f_alta;
		NEW.c_usuario_alta = OLD.c_usuario_alta;
		NEW.f_actualizac = OLD.f_actualizac;
		NEW.c_usuario_act = OLD.c_usuario_act;
		NEW.f_operacion = OLD.f_operacion;
		OLD.c_usuario_operacion = CURRENT_USER;
		OLD.c_operacion = 'U';
	RETURN New;
END
$InsertarRegistro$ LANGUAGE plpgsql;

--* TRIGGER *--
CREATE TRIGGER tg_InsertarRegistro
	BEFORE UPDATE
	ON usuarios_hist
	FOR EACH ROW
EXECUTE PROCEDURE sp_InsertarRegistro()

--UPDATE TEST
UPDATE usuarios SET d_nombre = 'Facundoss' WHERE id_usuario=71;
select * from  usuarios;
select * from  usuarios_hist;



