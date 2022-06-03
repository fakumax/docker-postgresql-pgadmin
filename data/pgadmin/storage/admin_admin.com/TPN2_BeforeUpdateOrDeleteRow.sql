-- Trabajo Práctico Áulico - TRIGGERS + Transacciones
-- PUNTO 3
-- ** BEFORE UPDATE OR DELETE ROW **
-- 1. Crear una tabla llamada nombte_tabla_hist, la misma deberá tener los mismos campos que
-- la tabla base, pero tendra su propio id de tipo autoincremental y tendrá 3 columnas extra que
-- serán f_operacion, c_usuario_operacion, c_operacion.

CREATE TABLE album_hist(
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


select * from albums
select * from artista
select * from company
select * from pistas