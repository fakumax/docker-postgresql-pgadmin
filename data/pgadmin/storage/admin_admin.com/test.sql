--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2

-- Started on 2022-05-19 19:42:39 UTC

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 221 (class 1255 OID 16575)
-- Name: sp_backupuseradress(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_backupuseradress() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	BEGIN
		  NEW.f_alta = now();
		  NEW.c_usuario_alta = CURRENT_USER;
		  
		  CREATE TEMPORARY TABLE backup_User ON COMMIT DROP AS 
		  SELECT NEW.*;  
		  
		  CREATE TEMPORARY TABLE backup_Adress ON COMMIT DROP AS
			SELECT id_direccion,id_usuario,d_calle, n_altura, d_ciudad,
			c_postal,f_alta, f_actualizac,c_usuario_act,c_usuario_alta
			FROM   direccion
			WHERE  id_usuario = New.id_usuario;

		  TRUNCATE TABLE usuarios,direccion CASCADE;
    RETURN NEW;
END
$$;


ALTER FUNCTION public.sp_backupuseradress() OWNER TO postgres;

--
-- TOC entry 217 (class 1255 OID 16489)
-- Name: sp_updateuserdate(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sp_updateuserdate() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
	BEGIN
		NEW.f_actualizac = now();
		NEW.c_usuario_act = CURRENT_USER;
	RETURN NEW;
END
$$;


ALTER FUNCTION public.sp_updateuserdate() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 213 (class 1259 OID 16755)
-- Name: albums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.albums (
    id_album character varying(25) NOT NULL,
    id_artista character varying(25) NOT NULL,
    d_nombre character varying(100) NOT NULL,
    d_tipo_album character varying(20) NOT NULL,
    n_anio character varying(100),
    d_portada character varying(100),
    d_etiqueta character varying(50),
    m_ultimo character varying(1),
    f_alta date,
    c_usuario_alt character varying(128),
    f_actualizac date,
    c_usuario_act character varying(128)
);


ALTER TABLE public.albums OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16760)
-- Name: artista; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.artista (
    id_artista character varying(25) NOT NULL,
    d_nombre character varying(300) NOT NULL,
    c_verificado character varying(100),
    d_biografia character varying(4000),
    d_imagen character varying(300),
    n_oyentes_m integer,
    d_info character varying(100),
    n_seguidores integer,
    f_alta date,
    c_usuario_alta character varying(30),
    f_actualizac date,
    c_usuario_act character varying(30)
);


ALTER TABLE public.artista OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16765)
-- Name: direccion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.direccion (
    id_direccion integer NOT NULL,
    id_usuario integer NOT NULL,
    d_calle character varying(100),
    n_altura character varying(100),
    d_ciudad character varying(20),
    c_postal character varying(10),
    f_alta date,
    f_actualizac date,
    c_usuario_act character varying(100),
    c_usuario_alta character varying(100)
);


ALTER TABLE public.direccion OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16768)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id_usuario integer NOT NULL,
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
    c_usuario_act character varying(100)
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 3332 (class 0 OID 16755)
-- Dependencies: 213
-- Data for Name: albums; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.albums (id_album, id_artista, d_nombre, d_tipo_album, n_anio, d_portada, d_etiqueta, m_ultimo, f_alta, c_usuario_alt, f_actualizac, c_usuario_act) FROM stdin;
1KebhJy1lMp7sbPPLhBYLp	3UbyYnvNIT5DFXU4WgiGpP	Lay Down Your Love (2020 Remix)	SINGLE	2021	https://i.scdn.co/image/ab67616d00001e02968f0e9be36b876177297ff6	Rhino	S	\N	\N	\N	\N
70uPhkIhXTXM6MNNsMjAHx	3UbyYnvNIT5DFXU4WgiGpP	Whitesnake (2018 Remaster)	ALBUM	1987	https://i.scdn.co/image/ab67616d00001e02facf92d793609aa3bc5cc4e7	Rhino	R	\N	\N	\N	\N
1WFozsJ1CQfkuGcd9GjYTX	3UbyYnvNIT5DFXU4WgiGpP	Saints and Sinners (2013 Remaster)	ALBUM	1982	https://i.scdn.co/image/ab67616d00001e025422fe1b3700fc6fa354dbc1	Parlophone UK	R	\N	\N	\N	\N
6ujO2Xzt247YCYIpAmcb4r	3UbyYnvNIT5DFXU4WgiGpP	Whitesnake (30th Anniversary Edition)	ALBUM	1987	https://i.scdn.co/image/ab67616d00001e02eb93565b56b7d1aea022983d	Parlophone UK	R	\N	\N	\N	\N
2QE4Wrvpvs4DI9gX7WVTZO	3UbyYnvNIT5DFXU4WgiGpP	Whitesnake (30th Anniversary Super Deluxe Edition)	ALBUM	2017	https://i.scdn.co/image/ab67616d00001e0204b21b57a56514b8c321cd23	Parlophone UK	R	\N	\N	\N	\N
0SZg95nceCBL5G2THZihSA	3UbyYnvNIT5DFXU4WgiGpP	Flesh and Blood (Deluxe Edition)	ALBUM	2019	https://i.scdn.co/image/ab67616d00001e02cdd7f4bcdd32391a999ae4b6	Frontiers Records s.r.l.	R	\N	\N	\N	\N
5lruk7x8hyzy71xskWsrmp	3UbyYnvNIT5DFXU4WgiGpP	Ready an Willing (2013 Remaster)	ALBUM	1980	https://i.scdn.co/image/ab67616d00001e02194100543a02221c8be38fd5	Parlophone UK	R	\N	\N	\N	\N
36Fg5BRhoXvdqIH3qwTF9m	3UbyYnvNIT5DFXU4WgiGpP	Love Songs (2020 Remix)	ALBUM	2020	https://i.scdn.co/image/ab67616d00001e024d54bf9cd90e60f323ecf5ca	Rhino	R	\N	\N	\N	\N
1pJOaeAojUYs43sa15Q6nJ	3UbyYnvNIT5DFXU4WgiGpP	Slip of the Tongue (Super Deluxe Edition; 2019 Remaster)	ALBUM	2019	https://i.scdn.co/image/ab67616d00001e02685c05af3a44b4230832e675	Rhino	R	\N	\N	\N	\N
5Nkm0Ox8H2nvODE0xL9KBE	3UbyYnvNIT5DFXU4WgiGpP	The ROCK Album (2020 Remix)	ALBUM	2020	https://i.scdn.co/image/ab67616d00001e024915cf5829e23a7cbec275e6	Rhino	R	\N	\N	\N	\N
4tbNTPOYzfD13oC1UpSHoQ	3UbyYnvNIT5DFXU4WgiGpP	Slide It In (The Ultimate Edition; 2019 Remaster)	ALBUM	2019	https://i.scdn.co/image/ab67616d00001e02e21f94f659e8ee1532049ddd	Rhino	R	\N	\N	\N	\N
2sS9l8uc3d3UsK9unJyrD8	4lxfqrEsLX6N1N4OCSkILp	...But Seriously (Deluxe Edition)	ALBUM	1989	https://i.scdn.co/image/ab67616d00001e02fb2daafa0993f39d87a84385	Rhino	R	\N	\N	\N	\N
6sn6eWmPciSiHj0ltTBl7M	4lxfqrEsLX6N1N4OCSkILp	Hello, I Must Be Going! (Deluxe Edition)	ALBUM	1982	https://i.scdn.co/image/ab67616d00001e02ab0a92e5cd20c2224c44a8a6	Rhino	R	\N	\N	\N	\N
1cM3r0WQZWNkCpEbmFjLln	4lxfqrEsLX6N1N4OCSkILp	Face Value (Deluxe Editon)	ALBUM	1981	https://i.scdn.co/image/ab67616d00001e02f6954c1f074f66907a8c5483	Rhino	R	\N	\N	\N	\N
1rVhockt4RAiZFaK3M3zPB	4lxfqrEsLX6N1N4OCSkILp	No Jacket Required (2016 Remaster)	ALBUM	1985	https://i.scdn.co/image/ab67616d00001e0279553c4dcec1846d3a5c49ab	Rhino	R	\N	\N	\N	\N
1t89giOgPycfALwe2NuVf8	4lxfqrEsLX6N1N4OCSkILp	...But Seriously (2016 Remaster)	ALBUM	1989	https://i.scdn.co/image/ab67616d00001e02b7c2da1a4e0bc7f14a8d4bd9	Rhino	R	\N	\N	\N	\N
5Tby0U5VndHW0SomYO7Id7	4lxfqrEsLX6N1N4OCSkILp	Testify (Deluxe Edition)	ALBUM	2002	https://i.scdn.co/image/ab67616d00001e022881594ebf3be23f47016a50	Rhino	R	\N	\N	\N	\N
3YhgdRfaZrVIOORGK9SNiV	4lxfqrEsLX6N1N4OCSkILp	Serious Hits...Live! (2019 Remaster)	ALBUM	1990	https://i.scdn.co/image/ab67616d00001e02a4b4b80acc11278253d2f11c	Rhino	R	\N	\N	\N	\N
3a43NX3hFXATIa89aNk6AF	4lxfqrEsLX6N1N4OCSkILp	Both Sides (Deluxe Edition)	ALBUM	1993	https://i.scdn.co/image/ab67616d00001e02c32f183280ee8ab707da816a	Rhino	R	\N	\N	\N	\N
7avlHipAwnKsxcXwC9Wpin	4lxfqrEsLX6N1N4OCSkILp	No Jacket Required (Deluxe Edition)	ALBUM	1985	https://i.scdn.co/image/ab67616d00001e0257480be4ce4fd7659a25b7d9	Rhino	R	\N	\N	\N	\N
6kThy2uWIFJTuSC2VHTRnC	58lV9VcRSjABbAbfWS6skp	Story Of Love	SINGLE	2021	https://i.scdn.co/image/ab67616d00001e026f59425002541c27183c6dfc	Captain Kidd Corp.	S	\N	\N	\N	\N
0kBfgEilUFCMIQY5IOjG4t	58lV9VcRSjABbAbfWS6skp	Slippery When Wet	ALBUM	1986	https://i.scdn.co/image/ab67616d00001e021336b31b6a1799f0de5807ac	Island Records	R	\N	\N	\N	\N
0Q9SljCrM0CL0bR23MuP69	58lV9VcRSjABbAbfWS6skp	Crush	ALBUM	2000	https://i.scdn.co/image/ab67616d00001e027a231174875d7930de9dad58	Island Records	R	\N	\N	\N	\N
2FbviTPUjgJJUxsGM1sGDq	58lV9VcRSjABbAbfWS6skp	Keep The Faith	ALBUM	1992	https://i.scdn.co/image/ab67616d00001e0259bfe048568a969c6f0bd08c	Island Records	R	\N	\N	\N	\N
3mcKOl0KNe65BqiBa40WxR	58lV9VcRSjABbAbfWS6skp	New Jersey (Deluxe Edition)	ALBUM	1988	https://i.scdn.co/image/ab67616d00001e02901d0116a03d30a5c45bb99c	Island Records	R	\N	\N	\N	\N
1UUOBzIHw0noiRGRpbt3sz	58lV9VcRSjABbAbfWS6skp	Bon Jovi	ALBUM	1984	https://i.scdn.co/image/ab67616d00001e02ede118b5f0e159dd18d42b90	Island Records	R	\N	\N	\N	\N
1b6ChQEPZbOHVNi5vjqYr6	58lV9VcRSjABbAbfWS6skp	These Days	ALBUM	1995	https://i.scdn.co/image/ab67616d00001e028cadefc62ac1c0b7c4ab882a	Island Records	R	\N	\N	\N	\N
3VfBy3QX5peTfME0UxzZ2P	58lV9VcRSjABbAbfWS6skp	Have A Nice Day	ALBUM	2005	https://i.scdn.co/image/ab67616d00001e02a2841eb6e1649170cc312871	Island Records	R	\N	\N	\N	\N
400D8LXbvMuOzi4lVv89FM	58lV9VcRSjABbAbfWS6skp	This House Is Not For Sale	ALBUM	2018	https://i.scdn.co/image/ab67616d00001e02ab556d12ef113989ed5bf2e3	Bon Jovi Profit Split	R	\N	\N	\N	\N
67vqUSurP7icdgCiZ3DZsY	58lV9VcRSjABbAbfWS6skp	Bounce	ALBUM	2002	https://i.scdn.co/image/ab67616d00001e0236b92971a57850eaa9eaa58c	Island Records	R	\N	\N	\N	\N
6gZ9rRJt7m8g7ZzK8U6hcq	58lV9VcRSjABbAbfWS6skp	2020 (Deluxe)	ALBUM	2020	https://i.scdn.co/image/ab67616d00001e029f7ea39890e50740cd33be09	Captain Kidd Corp.	R	\N	\N	\N	\N
0CxPbTRARqKUYighiEY9Sz	3qm84nBOXUEQ2vnTfUTTFC	Use Your Illusion I	ALBUM	1991	https://i.scdn.co/image/ab67616d00001e02e44963b8bb127552ac761873	Geffen	R	\N	\N	\N	\N
00eiw4KOJZ7eC3NBEpmH4C	3qm84nBOXUEQ2vnTfUTTFC	Use Your Illusion II	ALBUM	1991	https://i.scdn.co/image/ab67616d00001e0292d21aef6c0d288cc4c05973	Geffen	R	\N	\N	\N	\N
3edmYBHOTxfz8NxJE1QmTP	3qm84nBOXUEQ2vnTfUTTFC	Appetite For Destruction (Super Deluxe Edition)	ALBUM	1987	https://i.scdn.co/image/ab67616d00001e025c851aceb156dea821264caa	Geffen	R	\N	\N	\N	\N
4ieR19hRkKeE81CalJPQNu	3qm84nBOXUEQ2vnTfUTTFC	The Spaghetti Incident?	ALBUM	1993	https://i.scdn.co/image/ab67616d00001e02d8a68fd3e16f7ff6932b47d9	Geffen	R	\N	\N	\N	\N
1RCAG3LrDwYsNU5ZiUJlWi	3qm84nBOXUEQ2vnTfUTTFC	G N R Lies	ALBUM	1988	https://i.scdn.co/image/ab67616d00001e02d2c9d673548c12ad1c32e38d	Geffen	R	\N	\N	\N	\N
0suNLpB9xraAv1FcdlITjQ	3qm84nBOXUEQ2vnTfUTTFC	Chinese Democracy	ALBUM	2008	https://i.scdn.co/image/ab67616d00001e02e29a351729da4d29214e54e2	Geffen	R	\N	\N	\N	\N
6AK5hiec0u0guq19bKlSMm	3qm84nBOXUEQ2vnTfUTTFC	Shadow Of Your Love	SINGLE	2018	https://i.scdn.co/image/ab67616d00001e02e60da07908a74190116673d3	Geffen	R	\N	\N	\N	\N
3DBIk4M0qaT0QR5DMIXnJq	3qm84nBOXUEQ2vnTfUTTFC	Move To The City (1988 Acoustic Version)	SINGLE	2018	https://i.scdn.co/image/ab67616d00001e0255598d2d52fc249fa166a3ca	Geffen	R	\N	\N	\N	\N
3eEUdIcGVpBEgQ086nCTmE	3qm84nBOXUEQ2vnTfUTTFC	Welcome To The Jungle (1986 Sound City Session)	SINGLE	2018	https://i.scdn.co/image/ab67616d00001e029d72298d1e18769f3931f5b6	Geffen	R	\N	\N	\N	\N
4HbgSDhY7du72um4tmMpgc	4mxWe1mtYIYfP040G38yvS	Tis The Season	EP	2020	https://i.scdn.co/image/ab67616d00001e02f1fb734f7dc74ff78c444aa5	UMG Recordings, Inc.	S	\N	\N	\N	\N
3HfbZ0TmLbCesnG7tjf6Lh	4mxWe1mtYIYfP040G38yvS	Good Time	ALBUM	2008	https://i.scdn.co/image/ab67616d00001e02c104770e832abae0fee95ac3	Arista Nashville	R	\N	\N	\N	\N
0zucVZLdGmH0opcSZ6aE4q	0IdYRFTswLdsGwSnzOaGNF	I Got Your Country Right Here	ALBUM	2010	https://i.scdn.co/image/ab67616d00001e02a742b110791557b91311f669	Redneck Records	R	\N	\N	\N	\N
7fAgXIGULuIxFRk1tIGGgt	0IdYRFTswLdsGwSnzOaGNF	Ready to Get Rowdy	ALBUM	2017	https://i.scdn.co/image/ab67616d00001e0235678e38662d903a35c53ec8	Redneck Records	R	\N	\N	\N	\N
6ZvksTxIcG4FZy7XYm6JJl	0IdYRFTswLdsGwSnzOaGNF	Snapshot	ALBUM	2014	https://i.scdn.co/image/ab67616d00001e023522321e403e2e9c02e992b7	Redneck Records	R	\N	\N	\N	\N
5Slgwh8PAxHhXXzItunLGq	0IdYRFTswLdsGwSnzOaGNF	Still Here for the Party	ALBUM	2014	https://i.scdn.co/image/ab67616d00001e025c68da75d0c5dd92cc12091a	Redneck Records	R	\N	\N	\N	\N
0HEuFHATf4xNesfim5EwMr	0IdYRFTswLdsGwSnzOaGNF	Right On Time	ALBUM	2013	https://i.scdn.co/image/ab67616d00001e026880c0416de1f0f565effaec	Redneck Records	R	\N	\N	\N	\N
4NuCrzNd98B7PdKjRl5TKP	0IdYRFTswLdsGwSnzOaGNF	Christmas in My Heart	ALBUM	2013	https://i.scdn.co/image/ab67616d00001e0225a29ab23788b840292a74f4	Redneck Records	R	\N	\N	\N	\N
2ankKa6uRIQEuwudlLo9rz	0IdYRFTswLdsGwSnzOaGNF	Rowdy	SINGLE	2016	https://i.scdn.co/image/ab67616d00001e0295a0900393e366ba0508e80a	Redneck Records	R	\N	\N	\N	\N
2US38BIkYb1habQEAGJyfD	4xFUf1FHVy696Q1JQZMTRj	Tears Of Gold	SINGLE	2020	https://i.scdn.co/image/ab67616d00001e02a9a3e3f494e96c3bc141b8a9	Universal Music Spain S.L.	S	\N	\N	\N	\N
0kys2jaKAiDPfNBd4z7LAg	4xFUf1FHVy696Q1JQZMTRj	Some Hearts	ALBUM	2005	https://i.scdn.co/image/ab67616d00001e02724bd326692d222c5906b0b0	Arista	R	\N	\N	\N	\N
6LURWtPusB5fGenqj0lbFd	4xFUf1FHVy696Q1JQZMTRj	Cry Pretty	ALBUM	2018	https://i.scdn.co/image/ab67616d00001e0221ecee777479b876967e8005	Capitol Nashville	R	\N	\N	\N	\N
4q3SkZWPYJtKno1RbnrjL4	4xFUf1FHVy696Q1JQZMTRj	Storyteller	ALBUM	2015	https://i.scdn.co/image/ab67616d00001e02e47f7d2c1163fba1e67c7ed1	19 Recordings Limited / Arista Nashville	R	\N	\N	\N	\N
7atJn49QvtOLiFxhQd2hp9	4xFUf1FHVy696Q1JQZMTRj	Blown Away	ALBUM	2012	https://i.scdn.co/image/ab67616d00001e0224e1589fb3eab8ae8831f388	19 Recordings Limited / Arista Nashville	R	\N	\N	\N	\N
3iLrVuA1k7onNmZTuUQH4u	4xFUf1FHVy696Q1JQZMTRj	Play On	ALBUM	2009	https://i.scdn.co/image/ab67616d00001e0203668e3f13559554eca8ccc6	19 Recordings Limited / Arista Nashville	R	\N	\N	\N	\N
1wI9NGtQCnhyweuVACpXW4	4xFUf1FHVy696Q1JQZMTRj	My Gift	ALBUM	2020	https://i.scdn.co/image/ab67616d00001e02bc71319c6b09b561381ddb3e	Capitol Nashville	R	\N	\N	\N	\N
5HwzpaqYOZABPnmvl5JYFX	4xFUf1FHVy696Q1JQZMTRj	Carnival Ride	ALBUM	2007	https://i.scdn.co/image/ab67616d00001e028b3962e95912849e28378231	Arista	R	\N	\N	\N	\N
46muKAiFbLEkonRNRpTuEH	4xFUf1FHVy696Q1JQZMTRj	The Champion	SINGLE	2018	https://i.scdn.co/image/ab67616d00001e02c880d0a68562e44254a33166	Capitol Nashville	R	\N	\N	\N	\N
1Vjh7qLsdhopIY1m1tQ5H0	4xFUf1FHVy696Q1JQZMTRj	Cry Pretty	SINGLE	2018	https://i.scdn.co/image/ab67616d00001e02041c6a4667efb4c057b52329	Capitol Nashville	R	\N	\N	\N	\N
16by1M7adOE6AeoyLzQZVc	5e4Dhzv426EvQe3aDb64jL	hole in the bottle (with Shania Twain)	SINGLE	2020	https://i.scdn.co/image/ab67616d00001e02fc203909b5eb4ba683a9fc7d	Black River Entertainment	S	\N	\N	\N	\N
4UMe0Ods7kygK6OISasZe9	5e4Dhzv426EvQe3aDb64jL	Come On Over	ALBUM	1997	https://i.scdn.co/image/ab67616d00001e02aaf012d56b8c72658da6c45f	Mercury Nashville	R	\N	\N	\N	\N
3wDeIA9tJU0uNlsroUdcYK	5e4Dhzv426EvQe3aDb64jL	The Woman In Me	ALBUM	1995	https://i.scdn.co/image/ab67616d00001e0297c04b4a131dc95ce5e83107	Mercury Nashville	R	\N	\N	\N	\N
5MUiqH86VtEvtVIY1loBDi	5e4Dhzv426EvQe3aDb64jL	Come On Over (International Version)	ALBUM	1999	https://i.scdn.co/image/ab67616d00001e022da577b0a17e5b2dabacf0f4	Mercury Nashville	R	\N	\N	\N	\N
5L1fa5sInW8EeKIXAGycMD	5e4Dhzv426EvQe3aDb64jL	Now (Deluxe)	ALBUM	2017	https://i.scdn.co/image/ab67616d00001e02ccc1d6296cb7746ed59717d9	Mercury Nashville	R	\N	\N	\N	\N
4h6bh60fEl4GAZiPhmrgMx	5e4Dhzv426EvQe3aDb64jL	Up! (Green Version)	ALBUM	2002	https://i.scdn.co/image/ab67616d00001e02e5edf8b84806ad24bd8b6baf	Mercury Nashville	R	\N	\N	\N	\N
1wA2xlIBYafcDO9xV13O35	5e4Dhzv426EvQe3aDb64jL	The Woman In Me (Super Deluxe Diamond Edition)	ALBUM	2020	https://i.scdn.co/image/ab67616d00001e02e9229feec02a671f954ba555	Mercury Nashville	R	\N	\N	\N	\N
7w8yxmTdAltZOJdzMMm3KC	5e4Dhzv426EvQe3aDb64jL	Still The One: Live From Vegas	ALBUM	2015	https://i.scdn.co/image/ab67616d00001e029bf01bec753bcb8967a5e9a0	Mercury Nashville	R	\N	\N	\N	\N
7o4ktUz3Z0Ky0L06avgkYz	5e4Dhzv426EvQe3aDb64jL	Shania Twain	ALBUM	1993	https://i.scdn.co/image/ab67616d00001e02464d543f1ac102e2e0ad818a	Mercury Nashville	R	\N	\N	\N	\N
F3CP3hyryelKiihuc4u4HD	mKJrFWpsH5Rfp5FJExPxi4	Grandes Exitos	EP	2021	lorem	Alan Jackson-Precious Memories II	\N	\N	\N	\N	\N
79yCfWigSGt94zi1CIkkJZ	4mxWe1mtYIYfP040G38yvS	A Lot About Livin (And A Little Bout Love)	ALBUM	1992	https://i.scdn.co/image/ab67616d00001e02933cf67cacfab71afa20c6c4	Arista Nashville	R	\N	\N	\N	\N
010wiwXUvegsmlERAv7vMe	4mxWe1mtYIYfP040G38yvS	Precious Memories	ALBUM	2006	https://i.scdn.co/image/ab67616d00001e0290149f78bbe33e47adbe5f8d	EMI Records Nashville	R	\N	\N	\N	\N
2QBJCHNMYQC1cyhSXW0ygV	4mxWe1mtYIYfP040G38yvS	Drive	ALBUM	2002	https://i.scdn.co/image/ab67616d00001e02c5d5d983f8d9edc7f695cc72	Arista Nashville	R	\N	\N	\N	\N
6767Q48U82ay3Vbr27YNbA	4mxWe1mtYIYfP040G38yvS	Don`t Rock The Jukebox	ALBUM	1991	https://i.scdn.co/image/ab67616d00001e02b6268335510514000eabf9d6	Arista/Legacy	R	\N	\N	\N	\N
4kZm2gtXOwFsXXQZZaYEhW	4mxWe1mtYIYfP040G38yvS	Everything I Love	ALBUM	1996	https://i.scdn.co/image/ab67616d00001e02e7f3d40336035d9bac39d4b0	Arista Nashville	R	\N	\N	\N	\N
2NVWzjDHYjiOsZuvdkPahB	4mxWe1mtYIYfP040G38yvS	Angels And Alcohol	ALBUM	2015	https://i.scdn.co/image/ab67616d00001e021b252bac4f5ba51128e50fd4	ALAN JACKSON - THIRTY MILES WEST	R	\N	\N	\N	\N
6oCWzZ0s3QMp1MJLKUV8QG	4mxWe1mtYIYfP040G38yvS	Freight Train	ALBUM	2010	https://i.scdn.co/image/ab67616d00001e022a7d75a99b407c6084b90f9e	Arista Nashville	R	\N	\N	\N	\N
1IwTlARBAG1aVi9uIBmZqm	4mxWe1mtYIYfP040G38yvS	Let It Be Christmas	ALBUM	2002	https://i.scdn.co/image/ab67616d00001e02cf9ce69f2c0a386b036f5f5f	Alan Jackson - Let It Be	R	\N	\N	\N	\N
7KitNG3Z6NUBXkCiBK1Wvb	4mxWe1mtYIYfP040G38yvS	Precious Memories: Vol. II	ALBUM	2013	https://i.scdn.co/image/ab67616d00001e02927ec4f34778ea985b0e9b2e	Alan Jackson-Precious Memories II	R	\N	\N	\N	\N
2ioso1tqQ5zABQDVYyiUi5	6uothxMWeLWIhsGeF7cyo4	A Day Without Rain	ALBUM	2000	https://i.scdn.co/image/ab67616d00001e0270dd4e18b9c3431ee7a9b8a1	WM UK	R	\N	\N	\N	\N
26qiUsjX8tgvAqb2H8bucZ	6uothxMWeLWIhsGeF7cyo4	Dark Sky Island	ALBUM	2015	https://i.scdn.co/image/ab67616d00001e025c756289de05ce242e34a32f	Warner Records	R	\N	\N	\N	\N
0NJjvdOd3ULUTvoVFCCFJN	6uothxMWeLWIhsGeF7cyo4	Watermark	ALBUM	1988	https://i.scdn.co/image/ab67616d00001e02ccda4935dab782fa037625de	WM UK	R	\N	\N	\N	\N
6ZuPbMe6CvQKl1nvAy0nZm	6uothxMWeLWIhsGeF7cyo4	Shepherd Moons	ALBUM	1991	https://i.scdn.co/image/ab67616d00001e023184c671068d02838d47b277	WM UK	R	\N	\N	\N	\N
2efGoxVxoX55EATLcD0o8y	6uothxMWeLWIhsGeF7cyo4	Amarantine	ALBUM	2005	https://i.scdn.co/image/ab67616d00001e02d6caaa8c2bf5887674f5ac8d	WM UK	R	\N	\N	\N	\N
4FStw70Tk1spCN8V1o11oW	6uothxMWeLWIhsGeF7cyo4	Dark Sky Island (Deluxe)	ALBUM	2015	https://i.scdn.co/image/ab67616d00001e02b0d26116f99689b0ec954e01	Warner Records	R	\N	\N	\N	\N
34NreMWi5xh62VQFWLPm9U	6uothxMWeLWIhsGeF7cyo4	The Memory of Trees	ALBUM	1995	https://i.scdn.co/image/ab67616d00001e0279b71630826dabe75aa31dbc	WM UK	R	\N	\N	\N	\N
6GWptUmmrWPABTWSed7Ow8	6uothxMWeLWIhsGeF7cyo4	Themes From Calmi Cuori Appassionati	ALBUM	2001	https://i.scdn.co/image/ab67616d00001e02508c86c93151fdbbeb8f033d	WM UK	R	\N	\N	\N	\N
2L4XSyyDeIW30SawLTOlj4	6uothxMWeLWIhsGeF7cyo4	The Celts	ALBUM	1987	https://i.scdn.co/image/ab67616d00001e02d558b3cb838905c87b018f4b	WM UK	R	\N	\N	\N	\N
6o6RblnNPtSpuIdv5p2cZe	6uothxMWeLWIhsGeF7cyo4	May It Be	SINGLE	2002	https://i.scdn.co/image/ab67616d00001e02ccbcabdad71c5f7eda5cb354	WM UK	R	\N	\N	\N	\N
1e1kJ1OxfK3lHhqx9XFNE4	79FMDwzZQxHgSkIYBl3ODU	Aint That Kind of Cowboy	EP	2020	https://i.scdn.co/image/ab67616d00001e0222188822d61ccdf522369d77	Verge Records Nashville	S	\N	\N	\N	\N
2ZdBjpNzKeluVjBdZ4x12j	79FMDwzZQxHgSkIYBl3ODU	Dangerous Man	ALBUM	2006	https://i.scdn.co/image/ab67616d00001e020df6f56597d09e573fd4890a	Capitol Nashville	R	\N	\N	\N	\N
1CBlavGzMBYjukEGkRtaFc	79FMDwzZQxHgSkIYBl3ODU	Dreamin Out Loud	ALBUM	1996	https://i.scdn.co/image/ab67616d00001e0289c5950d6b281013f8ee081c	Capitol Nashville	R	\N	\N	\N	\N
3XWgiQQ5dMilsbpKDWmzSA	79FMDwzZQxHgSkIYBl3ODU	Songs About Me	ALBUM	2005	https://i.scdn.co/image/ab67616d00001e02dce0e4b1e08f6052997faec4	Capitol Nashville	R	\N	\N	\N	\N
0VV2QMKnczUkPLtj707mGW	79FMDwzZQxHgSkIYBl3ODU	Ain’t That Kind of Cowboy	SINGLE	2020	https://i.scdn.co/image/ab67616d00001e02a5ea445454c35c1707ff9802	Verge Records Nashville	R	\N	\N	\N	\N
350yWsEhzbD2TOhZZAXglP	79FMDwzZQxHgSkIYBl3ODU	Somethings Going On	ALBUM	2017	https://i.scdn.co/image/ab67616d00001e026e0e9e116381e55bf6349566	Wheelhouse Records	R	\N	\N	\N	\N
6aCFYxUYpZuhh6nXHSUerx	79FMDwzZQxHgSkIYBl3ODU	Trace Adkins X	ALBUM	2008	https://i.scdn.co/image/ab67616d00001e02fc5101d3226800538e14a337	Capitol Nashville	R	\N	\N	\N	\N
7IcQKPDXnhWg9RF9Ydk3iJ	79FMDwzZQxHgSkIYBl3ODU	Comin On Strong	ALBUM	2003	https://i.scdn.co/image/ab67616d00001e0274759bb019b81c023e0c0e2f	Capitol Nashville	R	\N	\N	\N	\N
0pOtF6iIK7eqQRm7wIJV7P	79FMDwzZQxHgSkIYBl3ODU	Big Time	ALBUM	1997	https://i.scdn.co/image/ab67616d00001e02234647c542e71fa59f618323	Capitol Nashville	R	\N	\N	\N	\N
4lKYXIMIo0Gi8IgGWTsmlz	79FMDwzZQxHgSkIYBl3ODU	Love Will...	ALBUM	2013	https://i.scdn.co/image/ab67616d00001e02b1bc38c224363a6cd750eaf7	Show Dog Universal Music	R	\N	\N	\N	\N
1eIN0vpmHWQ2TEZspYu7mH	13YmWQJFwgZrd4bf5IjMY4	Off Road	SINGLE	2021	https://i.scdn.co/image/ab67616d00001e028af1a829c9dc316f540edae3	Arista Nashville	S	\N	\N	\N	\N
10XgYRGRtKApBh2P1K9yHS	13YmWQJFwgZrd4bf5IjMY4	Hits Alive	ALBUM	2010	https://i.scdn.co/image/ab67616d00001e026217585c07b7417999f03d92	Arista Nashville	R	\N	\N	\N	\N
32LSfRBN2QI84fkkVX0edr	13YmWQJFwgZrd4bf5IjMY4	Time Well Wasted	ALBUM	2005	https://i.scdn.co/image/ab67616d00001e024030bcd7ed0469896d86c3b2	Arista Nashville	R	\N	\N	\N	\N
7jdM09zOoPpNn59UzAeryS	13YmWQJFwgZrd4bf5IjMY4	Mud On The Tires	ALBUM	2003	https://i.scdn.co/image/ab67616d00001e027302ccf08d789304c55ee73e	Arista Nashville	R	\N	\N	\N	\N
3krMgq4qNrE8SvW5rRg50V	13YmWQJFwgZrd4bf5IjMY4	This Is Country Music	ALBUM	2011	https://i.scdn.co/image/ab67616d00001e02e4ed191be04ba0e4253c77f4	Arista Nashville	R	\N	\N	\N	\N
0GCQzPEkcFv8bR90sJf41x	13YmWQJFwgZrd4bf5IjMY4	American Saturday Night	ALBUM	2009	https://i.scdn.co/image/ab67616d00001e02d2993421bef048e835974055	Arista Nashville	R	\N	\N	\N	\N
5jz1XHH4z5CegCDlAe9ujP	13YmWQJFwgZrd4bf5IjMY4	Moonshine in the Trunk	ALBUM	2014	https://i.scdn.co/image/ab67616d00001e02148f5c0250b91887da0c5b08	Arista Nashville	R	\N	\N	\N	\N
43xH1kPS7aNKc2WJtUHRAs	13YmWQJFwgZrd4bf5IjMY4	Love and War	ALBUM	2017	https://i.scdn.co/image/ab67616d00001e0236e7e4018ed32aca78845d49	Arista Nashville	R	\N	\N	\N	\N
6em0G4V4kU9mRweKkCefgR	13YmWQJFwgZrd4bf5IjMY4	Part II	ALBUM	2001	https://i.scdn.co/image/ab67616d00001e0294da46e08a9a9971436da68a	Arista Nashville	R	\N	\N	\N	\N
1YZKUL8O3nkMmJXuZcREzr	13YmWQJFwgZrd4bf5IjMY4	5th Gear	ALBUM	2007	https://i.scdn.co/image/ab67616d00001e029df06e6e8206ad4bf66405bf	Arista Nashville	R	\N	\N	\N	\N
2qTiPM68z9kbAcDPVqNyoG	13YmWQJFwgZrd4bf5IjMY4	No I in Beer	SINGLE	2020	https://i.scdn.co/image/ab67616d00001e02150b51596dc5ebad7bf41420	Arista Nashville	R	\N	\N	\N	\N
5OYkhSnpSoztkCKind5tap	0IdYRFTswLdsGwSnzOaGNF	Here For The Party	ALBUM	2004	https://i.scdn.co/image/ab67616d00001e02ddf15202c076358827b81302	Epic	R	\N	\N	\N	\N
60weSLM1kGohit7YIVAvHa	0IdYRFTswLdsGwSnzOaGNF	All Jacked Up	ALBUM	2005	https://i.scdn.co/image/ab67616d00001e020e04d04811d0aa583b4f8831	Epic	R	\N	\N	\N	\N
69p0kNEn0mPNqkWwauuwOq	0IdYRFTswLdsGwSnzOaGNF	Under the Covers	ALBUM	2013	https://i.scdn.co/image/ab67616d00001e02cceae9b92235c55cdab23bcd	Redneck Records	R	\N	\N	\N	\N
3I9Z1nDCL4E0cP62flcbI5	3qm84nBOXUEQ2vnTfUTTFC	Appetite For Destruction	ALBUM	1987	https://i.scdn.co/image/ab67616d00001e0268384dd85fd5e95831252f60	Geffen	S	\N	\N	\N	\N
\.


--
-- TOC entry 3333 (class 0 OID 16760)
-- Dependencies: 214
-- Data for Name: artista; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.artista (id_artista, d_nombre, c_verificado, d_biografia, d_imagen, n_oyentes_m, d_info, n_seguidores, f_alta, c_usuario_alta, f_actualizac, c_usuario_act) FROM stdin;
3UbyYnvNIT5DFXU4WgiGpP	Whitesnake	1	\N	https://i.scdn.co/image/cf364f9aefbcb7d8e3ab1c4c355a169fdd65e22a	5288504	https://open.spotify.com/artist/3UbyYnvNIT5DFXU4WgiGpP?si=4Cant2e2SA6_V7S4GqHA6Q	1886924	\N	\N	\N	\N
4lxfqrEsLX6N1N4OCSkILp	Phil Collinsss	1	Phil Collins status as one of the most successful pop and adult contemporary singers of the 80s and 	https://i.scdn.co/image/f5b1b588936c53348efe5526caf65852a0bd1d36	14579724	https://open.spotify.com/artist/4lxfqrEsLX6N1N4OCSkILp?siBE7dnqKyQLCydyNDg4OEug	3446550	\N	\N	\N	\N
58lV9VcRSjABbAbfWS6skp	Bon Jovi	1	After ushering in the era of pop-metal with their 1986 blockbuster Slippery When Wet and its hit singles You Give Love a Bad Name, Wanted Dead or Alive, and Living on a Prayer, Bon Jovi wound up transcending the big-haired 80s, withstanding changes in style and sound to become one of the biggest Ame	https://i.scdn.co/image/dd5408b179b5792445e107c188a3c3a213a19f09	17493017	https://open.spotify.com/artist/58lV9VcRSjABbAbfWS6skp?si=GBJSO7WTRqCnfZOljnJXFQ	8896293	\N	\N	\N	\N
3qm84nBOXUEQ2vnTfUTTFC	Guns N Roses	1	\N	https://i.scdn.co/image/80920b4fc80b6d970e2934eb8abe27014fc60632	18808097	https://open.spotify.com/artist/3qm84nBOXUEQ2vnTfUTTFC?si=II4hCz-XSF6nokvhredfKA	19446882	\N	\N	\N	\N
4mxWe1mtYIYfP040G38yvS	Alan Jackson	1	\N	https://i.scdn.co/image/ce3925ef836dc9977b9100013777b70bc159ab02	4443221	https://open.spotify.com/artist/4mxWe1mtYIYfP040G38yvS?si=oDBpKcTXRYGMU0NGNihUPA	1454790	\N	\N	\N	\N
6uothxMWeLWIhsGeF7cyo4	Enya	0	With her blend of folk melodies, synthesized backdrops, and classical motifs, Enya created a distinctive style that more closely resembled new age than the folk and Celtic music that provided her initial influences. Enya is from Gweedore, County Donegal, Ireland, which she left in 1980 to join the I	https://i.scdn.co/image/bbcdfc19f66c1c63def713e856d6e46159f2cdfd	2955783	https://open.spotify.com/artist/6uothxMWeLWIhsGeF7cyo4?si=fBNeNRLyQCWLvsIiw5u7xw	1458046	\N	\N	\N	\N
79FMDwzZQxHgSkIYBl3ODU	Trace Adkins	1	Towering baritone Trace Adkins has sold more than 11 million albums and charted more than 20 singles in his 25 years in Nashville, a remarkable run for one of country music’s most easily identifiable stars. With over one billion spins on Pandora (10 million per month), one million followers on Spo	https://i.scdn.co/image/2d8aa54b0f9fd6e59b5ff57bd76520b77abb8ed9	1846087	https://open.spotify.com/artist/79FMDwzZQxHgSkIYBl3ODU?si=CZ3eGgX4TZyFHKBVwvKklw	1778268	\N	\N	\N	\N
13YmWQJFwgZrd4bf5IjMY4	Brad Paisley	1	Arguably the preeminent male country artist to emerge in the 2000s, Brad Paisley cannily blended the past with the present, paying constant tribute to his forefathers -- when he reached the top of the charts, he still found space for Little Jimmy Dickens and George Jones in his videos -- but pushing	https://i.scdn.co/image/6c35f9ead223914d15418a2e4a89106ba36772e7	3809059	https://open.spotify.com/artist/13YmWQJFwgZrd4bf5IjMY4?si=51QDgpFEQZKLLR6H-uACFw	1977414	\N	\N	\N	\N
4xFUf1FHVy696Q1JQZMTRj	Carrie Underwood	1	Carrie Underwood emerged from the promise of her 2005 American Idol win to become a true multi-format, multi-media superstar, spanning achievements in music, television, and film. A seven-time GRAMMY® Award winner, she has sold 64 million records worldwide and recorded 26 #1 singles, 13 of which sh	https://i.scdn.co/image/3d924a7ee8b489e1c399176288859b0fc6058e0f	5726304	https://open.spotify.com/artist/4xFUf1FHVy696Q1JQZMTRj?si=dUfo9eM9Sc6mXbCn2kcXOA	4410336	\N	\N	\N	\N
5e4Dhzv426EvQe3aDb64jL	Shania Twain	1	\N	https://i.scdn.co/image/fbfb362675a177890961cf1a1da7016797d407ff	8009694	https://open.spotify.com/artist/5e4Dhzv426EvQe3aDb64jL?si=OpzM4M4bQlaZDJUkgFtMIQ	2146992	\N	\N	\N	\N
rRlVdCtTarzJD72FMycSfY	Josesito in da shit	\N	\N	https://i1.sndcdn.com/avatars-000187013947-zflyoh-t240x240.jpg	15000	\N	25000	\N	\N	\N	\N
3OlW1EjBuRAinExZE7905d	Lorem boy	\N	\N	https://as01.epimg.net/masdeporte/imagenes/2019/01/25/polideportivo/1548450030_712066_1548450091_noticia_normal_recorte1.jpg	10000	\N	10000	\N	\N	\N	\N
\.


--
-- TOC entry 3334 (class 0 OID 16765)
-- Dependencies: 215
-- Data for Name: direccion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.direccion (id_direccion, id_usuario, d_calle, n_altura, d_ciudad, c_postal, f_alta, f_actualizac, c_usuario_act, c_usuario_alta) FROM stdin;
1	1	Kulas	Apt. 556	Gwenborough	92998-3874	\N	\N	\N	\N
2	2	Victor Plains	Suite 879	Wisokyburgh	90566-7771	\N	\N	\N	\N
3	3	Douglas Extension	Suite 847	McKenziehaven	59590-4157	\N	\N	\N	\N
4	4	Hoeger Mall	Apt. 692	South Elvis	53919-4257	\N	\N	\N	\N
5	5	Skiles Walks	Suite 351	Roscoeview	33263	\N	\N	\N	\N
6	6	Norberto Crossing	Apt. 950	South Christy	23505-1337	\N	\N	\N	\N
7	7	Rex Trail	Suite 280	Howemouth	58804-1099	\N	\N	\N	\N
8	8	Ellsworth Summit	Suite 729	Aliyaview	45169	\N	\N	\N	\N
9	9	Dayna Park	Suite 449	Bartholomebury	76495-3109	\N	\N	\N	\N
10	10	Kattie Turnpike	Suite 198	Lebsackbury	31428-2261	\N	\N	\N	\N
13	24	Bernardo Spil	18 875	Navarro	6605-6605	\N	\N	\N	\N
18	42	street	suite	misiones	3300	\N	\N	\N	\N
17	33	Calle Porteña	Apt. 2	BsAs	1234	\N	\N	\N	\N
13	28	LIBERTADOR	n_altura 123	GBA	3423	\N	\N	\N	\N
14	35	Avenida Siempre Viva	742	Springfield	1234-5678	\N	\N	\N	\N
15	36	MISIONES 4444	n_altura 111	POSADAS	3300	\N	\N	\N	\N
16	37	MISIONES 4444	n_altura 111	POSADAS	3300	\N	\N	\N	\N
11	22	calle falsa	Suite 852	Bs As	76495-3109	\N	\N	\N	\N
12	23	Calle Falsa	Suite Falsa 123	Chascomus	7130	\N	\N	\N	\N
13	32	Calle piola	Suite. 56	Bsas	234234	\N	\N	\N	\N
\.


--
-- TOC entry 3335 (class 0 OID 16768)
-- Dependencies: 216
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, d_nombre, d_apellido, d_clave, d_correo, n_celular, d_sitio_web, id_compania, f_alta, c_usuario_alta, f_actualizac, c_usuario_act) FROM stdin;
1	Leanne Graham	Sincere@april.com	81dc9bdb52d04dc20036dbd8313ed055	Sincere@april.com	1-770-736-8031 x56442	hildegard.org	1	\N	\N	\N	\N
2	Ervin Howell	Shanna@melissa.tv	81dc9bdb52d04dc20036dbd8313ed055	Shanna@melissa.tv	010-692-6593 x09125	anastasia.net	2	\N	\N	\N	\N
3	Clementine Bauch	Nathan@yesenia.net	81dc9bdb52d04dc20036dbd8313ed055	Nathan@yesenia.net	1-463-123-4447	ramiro.info	3	\N	\N	\N	\N
4	Patricia Lebsack	Julianne.OConner@kory.org	81dc9bdb52d04dc20036dbd8313ed055	Julianne.OConner@kory.org	493-170-9623 x156	kale.biz	4	\N	\N	\N	\N
5	Chelsey Dietrich	Lucio_Hettinger@annie.ca	81dc9bdb52d04dc20036dbd8313ed055	Lucio_Hettinger@annie.ca	(254)954-1289	demarco.info	5	\N	\N	\N	\N
6	Mrs. Dennis Schulist	Karley_Dach@jasper.info	81dc9bdb52d04dc20036dbd8313ed055	Karley_Dach@jasper.info	1-477-935-8478 x6430	ola.org	5	\N	\N	\N	\N
7	Kurtis Weissnat	Telly.Hoeger@billy.biz	81dc9bdb52d04dc20036dbd8313ed055	Telly.Hoeger@billy.biz	210.067.6132	elvis.io	7	\N	\N	\N	\N
8	Nicholas Runolfsdottir V	Sherwood@rosamond.me	81dc9bdb52d04dc20036dbd8313ed055	Sherwood@rosamond.me	586.493.6943 x140	jacynthe.com	1	\N	\N	\N	\N
9	Glenna Reichert	Chaim_McDermott@dana.io	81dc9bdb52d04dc20036dbd8313ed055	Chaim_McDermott@dana.io	(775)976-6794 x41206	conrad.com	2	\N	\N	\N	\N
10	Clementina DuBuque	Rey.Padberg@karina.biz	81dc9bdb52d04dc20036dbd8313ed055	Rey.Padberg@karina.biz	024-648-3804	ambrose.net	1	\N	\N	\N	\N
17	Evelin Senghaas	evelinsenghaas@gmail.com	81dc9bdb52d04dc20036dbd8313ed055	evelinsenghaas@gmail.com	3764816893	\N	3	\N	\N	\N	\N
18	Agustina Schmidt	agustina.schmidt@hotmail.com	81dc9bdb52d04dc20036dbd8313ed055	agustina.schmidt@hotmail.com	1544368315	\N	10	\N	\N	\N	\N
21	MATIAS	MATUTE	81dc9bdb52d04dc20036dbd8313eh055	\N	\N	\N	\N	\N	\N	\N	\N
13	Franco Bricchi	fbricchi@fi.uba.ar	81dc9bdb52d04dc20036dbd8313eh055	fbricchi@fi.uba.ar	1560017926	\N	\N	\N	\N	\N	\N
24	Bernardo Massone	bernardo@massone	milanesa1234	\N	\N	\N	2	\N	\N	\N	\N
11	Gustavo	gurthang75@gmail.com	81dc9bdb52d04dc20036dbd8313ed055	gurthang75@gmail.com	03764-663076	\N	10	\N	\N	\N	\N
40	Silvana Cabana	s.cabana	4592039dkslans	s.cabana@tdi.com.ar	3764647937	http://unaweb.com.ar	10	\N	\N	\N	\N
14	Gabriel Pizzi	gabrielpizzi00@gmail.com	81dc9bdb52d04dc20036dbd8313ed055	gabrielpizzi00@gmail.com	1144057298	\N	9	\N	\N	\N	\N
34	Nicolás Agustín Riedel	NRiedel	sapoPepe	nriedel@tdi.com.ar	31415926535	http://www.savewalterwhite.com	1	\N	\N	\N	\N
41	Joaquin Potocki	poto	Y*YO*QUE*TE*DESEO*A*MORIR	joaquinpotocki@gmail.com	3764-888888	pepe.com	10	\N	\N	\N	\N
32	Uriel Soifer	u_soifer	contra_super_secreta	lorem@lorem.com	11-2233-4455	www.lorem.com	10	\N	\N	\N	\N
33	Tomás Rodríguez Dala	tomyrd	54321	\N	1234567	\N	2	\N	\N	\N	\N
28	Ramiro Sanchez	RSanchez	ansdaxbcxzmnbch213213	rsanSAhez@tdi.com.ar	\N	\N	7	\N	\N	\N	\N
42	Hernan Vieira	hernan_vieira	messi	hernanvieira@gmail.com	3764123456	lorem.com	10	\N	\N	\N	\N
12	Leandro Picek	leandropicek231@gmail.com	49a6e9647380d326ac543095b6ffa26d	leandropicek231@gmail.com	03764-229638	\N	10	\N	\N	\N	\N
19	GUSTAVO	LALALA	81dc9bdb52d04dc20036dbd8313ed055	lorem@lorem.com	651651	lorem.com	10	\N	\N	\N	\N
25	LOREM IPSUM DOLOR	lorem@lorem.com	81dc9bdb52d04dc20036dbd8313ed055	lorem@lorem.com	651651	lorem.com.ar	10	\N	\N	\N	\N
16	Carolina Tiferes	carotiferes@gmail.com	81DC9BDB52D04DC20036DBD8313ED055	carotiferes@gmail.com	1123459876	caro.com	10	\N	\N	\N	\N
35	Juan Karabin	jkarabin	aguanteQuilmes123	juan@karabin.com	1515151515	www.juan.com	10	\N	\N	\N	\N
36	CS CAMILO VILLAMIZAR ARISTIZABAL	CVILRZABABAL	GGGIIIDDD	CVILRZABABAL@d_correo.COM	3764589632	HTTP://WWW.CVILRZABABAL.COM	10	\N	\N	\N	\N
37	CS CAROLINA SOARES	CARSOARES	GGGIIIDDD	CARSOARES@d_correo.COM	3764589632	HTTP://WWW.CARSOARES.COM	10	\N	\N	\N	\N
22	Santiago Locatelli	slocatelli@fi.uba.ar	81dc9bdb52d04dc20036dbd8313ed055	slocatelli@fi.uba.ar	1122334455	google.com	10	\N	\N	\N	\N
15	Juan Cruz	juancruz@hotmail.com	81dc9bdb52d04dc20036dbd8313ed055	juancruz@hotmail.com	555-1345-6789	juan.org	5	\N	\N	\N	\N
23	Franco Batastini	Bata340	Contraseña re loca mal	fbatastini@tdi.com.ar	2241532409	paginaloca.com	10	\N	\N	\N	\N
\.


--
-- TOC entry 3185 (class 2606 OID 16774)
-- Name: albums albums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id_album);


--
-- TOC entry 3187 (class 2606 OID 16776)
-- Name: artista artista_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.artista
    ADD CONSTRAINT artista_pkey PRIMARY KEY (id_artista, d_nombre);


--
-- TOC entry 3189 (class 2606 OID 16778)
-- Name: direccion capa_address_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT capa_address_pkey PRIMARY KEY (id_direccion, id_usuario);


--
-- TOC entry 3191 (class 2606 OID 16780)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 3192 (class 2606 OID 16781)
-- Name: direccion id_usuario; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT id_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);


-- Completed on 2022-05-19 19:42:39 UTC

--
-- PostgreSQL database dump complete
--

