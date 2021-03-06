PGDMP         8                z            Artistas    14.2    14.2     ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                        1262    24627    Artistas    DATABASE     f   CREATE DATABASE "Artistas" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Spain.1252';
    DROP DATABASE "Artistas";
                postgres    false            ?            1259    24676    albums    TABLE     ?  CREATE TABLE public.albums (
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
    DROP TABLE public.albums;
       public         heap    postgres    false            ?            1259    24655    artista    TABLE     ?  CREATE TABLE public.artista (
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
    DROP TABLE public.artista;
       public         heap    postgres    false            ?            1259    24645 	   direccion    TABLE     t  CREATE TABLE public.direccion (
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
    DROP TABLE public.direccion;
       public         heap    postgres    false            ?            1259    24633    usuarios    TABLE     ?  CREATE TABLE public.usuarios (
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
    DROP TABLE public.usuarios;
       public         heap    postgres    false            n           2606    24682    albums albums_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id_album);
 <   ALTER TABLE ONLY public.albums DROP CONSTRAINT albums_pkey;
       public            postgres    false    212            l           2606    24661    artista artista_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.artista
    ADD CONSTRAINT artista_pkey PRIMARY KEY (id_artista, d_nombre);
 >   ALTER TABLE ONLY public.artista DROP CONSTRAINT artista_pkey;
       public            postgres    false    211    211            j           2606    24649    direccion capa_address_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT capa_address_pkey PRIMARY KEY (id_direccion, id_usuario);
 E   ALTER TABLE ONLY public.direccion DROP CONSTRAINT capa_address_pkey;
       public            postgres    false    210    210            h           2606    24639    usuarios usuarios_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id_usuario);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public            postgres    false    209            o           2606    24650    direccion id_usuario    FK CONSTRAINT     ?   ALTER TABLE ONLY public.direccion
    ADD CONSTRAINT id_usuario FOREIGN KEY (id_usuario) REFERENCES public.usuarios(id_usuario);
 >   ALTER TABLE ONLY public.direccion DROP CONSTRAINT id_usuario;
       public          postgres    false    210    209    3176           