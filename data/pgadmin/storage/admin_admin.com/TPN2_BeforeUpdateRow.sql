-- Trabajo Práctico Áulico - TRIGGERS + Transacciones
-- PUNTO 2
-- ** BEFORE UPDATE ROW **
-- 1. Crear triggers BUR para las tablas. El mismo deberá insertar la fecha de actualización y el
-- usuario_act en la tabla usuarios.
CREATE OR REPLACE FUNCTION sp_UpdateBeforeDateUser()
RETURNS TRIGGER AS $UpdateBeforeDateUser$
DECLARE
	BEGIN
		NEW.f_actualizac = NOW();
		NEW.c_usuario_act = CURRENT_USER;
	RETURN NEW;
END;
$UpdateBeforeDateUser$ LANGUAGE plpgsql;

CREATE TRIGGER tg_UAlbums
	BEFORE UPDATE
	ON albums
	FOR EACH ROW
EXECUTE PROCEDURE sp_UpdateBeforeDateUser();

CREATE TRIGGER tg_UArtista
	BEFORE UPDATE
	ON artista
	FOR EACH ROW
EXECUTE PROCEDURE sp_UpdateBeforeDateUser();

CREATE TRIGGER tg_UCompany
	BEFORE UPDATE
	ON company
	FOR EACH ROW
EXECUTE PROCEDURE sp_UpdateBeforeDateUser();

CREATE TRIGGER tg_UPistas
	BEFORE UPDATE
	ON pistas
	FOR EACH ROW
EXECUTE PROCEDURE sp_UpdateBeforeDateUser();
--------------------------------------------------
--TEST-
SELECT * FROM albums
UPDATE albums SET d_nombre = 'White Snake' WHERE id_album='6ujO2Xzt247YCYIpAmcb4r';
 
select * from artista
UPDATE artista SET d_nombre = 'White Snake' WHERE id_artista='3UbyYnvNIT5DFXU4WgiGpP';

select * from company
UPDATE company SET nombre = 'Universal Music' WHERE id_company=1;

select * from pistas
UPDATE pistas SET nombre = 'Sangre Joven' WHERE id_pista=1;
