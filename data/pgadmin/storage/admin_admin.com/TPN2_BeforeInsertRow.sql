-- Trabajo Práctico Áulico - TRIGGERS + Transacciones
-- PUNTO 1
-- ** BEFORE INSERT ROW **
-- 1. Crear triggers BIR, el mismo deberá colocar la fecha de alta y el usuario de alta.

CREATE OR REPLACE FUNCTION sp_AddDateUser()
RETURNS TRIGGER AS $AddDateUser$
DECLARE
	BEGIN
		NEW.f_alta = NOW();
		NEW.c_usuario_alta = CURRENT_USER;
	RETURN NEW;
END;
$AddDateUser$ LANGUAGE plpgsql;

CREATE TRIGGER tg_AddDUAlbum
	BEFORE INSERT ON albums
	FOR EACH ROW
EXECUTE PROCEDURE sp_AddDateUser();

CREATE TRIGGER tg_AddDUArtista
	BEFORE INSERT ON artista
	FOR EACH ROW
EXECUTE PROCEDURE sp_AddDateUser();

CREATE TRIGGER tg_AddDUCompany
	BEFORE INSERT ON company
	FOR EACH ROW
EXECUTE PROCEDURE sp_AddDateUser();

CREATE TRIGGER tg_AddDUPistas
	BEFORE INSERT ON pistas
	FOR EACH ROW
EXECUTE PROCEDURE sp_AddDateUser();
--------------------------------------------------

