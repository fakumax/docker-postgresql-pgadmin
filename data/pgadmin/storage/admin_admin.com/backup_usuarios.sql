--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2

-- Started on 2022-05-26 22:16:21 UTC

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
-- TOC entry 3335 (class 0 OID 16768)
-- Dependencies: 216
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id_usuario, d_nombre, d_apellido, d_clave, d_correo, n_celular, d_sitio_web, id_company, f_alta, c_usuario_alta, f_actualizac, c_usuario_act) FROM stdin;
1	qwdq	qweqwe	qweqe	aasdw	\N	\N	\N	2022-05-26	postgres	\N	\N
\.


-- Completed on 2022-05-26 22:16:22 UTC

--
-- PostgreSQL database dump complete
--

