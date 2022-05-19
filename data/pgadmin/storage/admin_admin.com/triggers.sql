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


