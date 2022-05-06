-- 1)
ALTER TABLE USUARIOS RENAME ID_COMPANIA TO ID_COMPANY

-- 2) 
CREATE TABLE IF NOT EXISTS COMPANY (
	ID_COMPANY SERIAL PRIMARY KEY,
	NOMBRE VARCHAR(50),
	F_ALTA DATE,
	C_USUARIO_ALTA VARCHAR (50),
	F_ACTUALIZAC DATE,
	C_USUARIO_ACT VARCHAR (50)
);

-- 3)
create sequence sec_id_company
start with 1
increment by 1

--4)
INSERT INTO company (nombre, f_alta, c_usuario_alta, f_actualizac, c_usuario_act )
values 
('Universal Music Group', CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('Sony Music Entertainment', CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('Warner Music Group', CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('YG Entertainment', CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('SM Entretainment', CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('JYP Entertainment', CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('Sony Music Entertainment US Latin LLC', CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('PolyGram', CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('DEL Records', CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('Epic Records', CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER)
;
-- 5)
ALTER TABLE usuarios 
ADD FOREIGN KEY (id_company) REFERENCES company(id_company);
--6)
DELETE FROM company
WHERE id_company = 10;

--# El error es que tiene una llave foranea y contiene datos. Por eso no puede eliminarse

--7)
CREATE TABLE IF NOT EXISTS pistas (
	id_pista serial PRIMARY KEY, 
	id_album VARCHAR,
	nombre VARCHAR (50),
	número INT,
	duracion_seg INT, 
	f_alta DATE, 
	c_usuario_alta VARCHAR (50),
	f_actualizac DATE, 
	c_usuario_act VARCHAR (50), 
	FOREIGN KEY (id_album) REFERENCES albums(id_album)
	);
--8)
INSERT INTO pistas (id_album, nombre, número, duracion_seg, f_alta, c_usuario_alta,f_actualizac, c_usuario_act)
values 
('1WFozsJ1CQfkuGcd9GjYTX', 'Young Blood', 1, 211, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('1WFozsJ1CQfkuGcd9GjYTX', 'Rough an Ready', 2, 172, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('1WFozsJ1CQfkuGcd9GjYTX', 'Bloody Luxury', 3, 203, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('1WFozsJ1CQfkuGcd9GjYTX', 'Victim of Love', 4, 213, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('1WFozsJ1CQfkuGcd9GjYTX', 'Crying in the Rain', 5, 361, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('400D8LXbvMuOzi4lVv89FM', 'When We Were Us', 1, 214, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('400D8LXbvMuOzi4lVv89FM', 'Walls', 2, 217, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('400D8LXbvMuOzi4lVv89FM', 'This House Is Not For Sale', 3, 216, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('400D8LXbvMuOzi4lVv89FM', 'Living With The Ghost', 4, 284, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER),
('400D8LXbvMuOzi4lVv89FM', 'Knockout', 5, 209, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER)
;
-- 9)
SELECT artista.d_nombre
FROM artista
INNER JOIN albums ON artista.id_artista=albums.id_artista 
where albums.d_tipo_album = 'ALBUM'
group by artista.d_nombre
-- 10)
SELECT SUM(n_oyentes_m) AS sumatoria_oyentes_mensuales from artista
-- 11)
SELECT artista.d_nombre,artista.n_oyentes_m,artista.n_seguidores,albums.d_nombre,albums.d_tipo_album,albums.n_anio
FROM artista
INNER JOIN albums ON artista.id_artista=albums.id_artista 
WHERE albums.d_tipo_album = 'ALBUM' AND n_oyentes_m = (select max(n_oyentes_m) from artista )
ORDER BY  albums.n_anio desc limit 1
-- 12)
SELECT nombre , duracion_seg, id_album
FROM pistas
ORDER BY id_album ASC, duracion_seg ASC;
-- 13)
SELECT id_artista, d_tipo_album
FROM albums WHERE d_tipo_album != 'ALBUM'
GROUP BY id_artista, d_tipo_album
-- 14)
DELETE FROM usuarios
WHERE id_usuario > 10;
-- 15)
select COUNT(d_ciudad) from direccion where d_ciudad = 'POSADAS'
-- 16)
INSERT INTO usuarios 
VALUES (45, 'carlos', 'x', 'youtube', 'algo@algo.COM', '32112', 'HTTP://WWW.algo.COM', 10, CURRENT_DATE, CURRENT_USER, CURRENT_DATE, CURRENT_USER)
-- 17)
SELECT *
FROM usuarios
INNER JOIN direccion ON direccion.id_usuario=usuarios.id_usuario 
--18)
update artista set n_oyentes = n_oyentas +100 
where id_artista in (select id_artista from albums where TO_NUMBER(n_anio,'99999999') between 2019 and 2022);
--19)
update artista set n_seguidores = n_seguidores -50
where id_artista in(select id_artista from albums where d_tipo_album <> 'ALBUM')

SELECT DISTINCT artista.id_artista,artista.n_seguidores,artista.d_nombre
from artista
INNER JOIN albums
ON artista.id_artista = albums.id_artista
where d_tipo_album <> 'ALBUM'

--20)
UPDATE direccion
SET d_ciudad = UPPER(d_ciudad)
--21)
SELECT *
FROM pistas
INNER JOIN albums ON pistas.id_album=albums.id_album 
--22)
SELECT d_nombre FROM artista WHERE MOD(n_oyentes_m,2) = 0;
--23)
update pistas set duracion_seg = duracion_seg +15 
where número % 2 = 1 

