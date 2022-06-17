-- Ejemplo de transacciones entre cuentas de clientes de un banco.
------Creación de tablas-----
CREATE TABLE transaccion (
id_transaccion serial,
id_cliente integer,
fecha_transaccion varchar(10) NOT NULL,
monto_transaccion numeric(10,2) NOT NULL,
descripcion varchar NULL,
id_cuenta integer,
PRIMARY KEY (id_transaccion)
)

CREATE TABLE cuenta(
    id_cuenta serial,
	id_cliente integer,
    balance_actual numeric(10,2) NULL,
	PRIMARY KEY (id_cuenta)
)

CREATE TABLE cliente(
    id_cliente serial,
    nombre varchar(10) NOT NULL,
    apellido varchar(10) NOT NULL,
	PRIMARY KEY (id_cliente)
)
--------------------------------------
select * from cliente
insert into cliente (nombre,apellido) values ('carlos','sarasa');
insert into cliente (nombre,apellido) values ('rufina','rodriguez');
insert into cliente (nombre,apellido) values ('pancracia','lavalle');
insert into cliente (nombre,apellido) values ('geronimo','lezcano');
insert into cliente (nombre,apellido) values ('ruperto','montenegro');
--------------------------------------
select * from cuenta
insert into cuenta (id_cliente,balance_actual) values (1,22.5);
insert into cuenta (id_cliente,balance_actual) values (2,40.1);
insert into cuenta (id_cliente,balance_actual) values (3,1240.1);
insert into cuenta (id_cliente,balance_actual) values (4,10120.0);
insert into cuenta (id_cliente,balance_actual) values (5,417);

-----------TRANSACCIONES----------------
BEGIN;
	UPDATE cuenta SET balance_actual = balance_actual – 100 WHERE nombre = 'carlos';
	SAVEPOINT marcador1;
	UPDATE cuenta SET balance_actual = balance_actual + 100 WHERE nombre = 'rufina';
	-- se desea descartar la actualizacion para rufina y en vez hacerla para pancracia —
	ROLLBACK TO marcador1;
	UPDATE cuenta SET balance_actual = balance_actual + 100 WHERE nombre = 'pancracia';
COMMIT;


