
-- TRABAJO PRACTICO SQL
-- Proyecto: retail_project
-- Motor: PostgreSQL

-- PASO 1: CREACION DE LA BASE DE DATOS
-- Esta instruccion debe ejecutarse desde la base postgres.
-- Luego hay que conectarse a retail_project
-- para ejecutar las instrucciones siguientes.

CREATE DATABASE retail_project;

-- PASO 2: CREACION DE LAS TABLAS

-- Crear la tabla clientes
CREATE TABLE clientes (
    id_cliente INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    edad INTEGER NOT NULL,
    CONSTRAINT chk_edad CHECK (edad >= 18)
);

-- Crear la tabla productos
CREATE TABLE productos (
    id_producto INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL,
    stock INTEGER NOT NULL,
    CONSTRAINT chk_precio CHECK (precio_unitario > 0),
    CONSTRAINT chk_stock CHECK (stock >= 0)
);

-- Crear la tabla ventas
CREATE TABLE ventas (
    id_venta INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    fecha_venta DATE NOT NULL,
    CONSTRAINT chk_cantidad CHECK (cantidad > 0),
    CONSTRAINT fk_cliente FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),
    CONSTRAINT fk_producto FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);

-- CARGA DE DATOS
BEGIN;

-- Insertar 5 clientes
INSERT INTO clientes (nombre, apellido, email, edad)
VALUES ('Juan', 'Perez', 'juan@gmail.com', 30);

INSERT INTO clientes (nombre, apellido, email, edad)
VALUES ('Maria', 'Gomez', 'maria@gmail.com', 25);

INSERT INTO clientes (nombre, apellido, email, edad)
VALUES ('Pedro', 'Lopez', 'pedro@gmail.com', 40);

INSERT INTO clientes (nombre, apellido, email, edad)
VALUES ('Ana', 'Martinez', 'ana@gmail.com', 35);

INSERT INTO clientes (nombre, apellido, email, edad)
VALUES ('Lucia', 'Fernandez', 'lucia@gmail.com', 28);

-- Insertar 5 productos
INSERT INTO productos (nombre, categoria, precio_unitario, stock)
VALUES ('Notebook', 'Electronica', 850000, 10);

INSERT INTO productos (nombre, categoria, precio_unitario, stock)
VALUES ('Mouse', 'Electronica', 15000, 50);

INSERT INTO productos (nombre, categoria, precio_unitario, stock)
VALUES ('Teclado', 'Electronica', 30000, 30);

INSERT INTO productos (nombre, categoria, precio_unitario, stock)
VALUES ('Escritorio', 'Muebles', 120000, 15);

INSERT INTO productos (nombre, categoria, precio_unitario, stock)
VALUES ('Silla', 'Muebles', 75000, 20);

-- Insertar 5 ventas
INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (1, 1, 1, '2026-11-10');

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (2, 2, 2, '2026-11-11');

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (3, 3, 1, '2026-11-12');

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (4, 4, 1, '2026-11-13');

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta)
VALUES (5, 5, 3, '2026-11-14');

COMMIT;

-- Verificar la cantidad de registros
SELECT 'clientes' AS tabla, COUNT(*) AS cantidad
FROM clientes
UNION ALL
SELECT 'productos', COUNT(*)
FROM productos
UNION ALL
SELECT 'ventas', COUNT(*)
FROM ventas;

-- Aumentar un 10% los precios de la categoría Muebles
UPDATE productos
SET precio_unitario = precio_unitario * 1.10
WHERE categoria = 'Muebles';

-- Eliminar una venta específica
DELETE FROM ventas
WHERE id_cliente = 5
  AND id_producto = 5
  AND fecha_venta = '2026-11-14'
  AND cantidad = 3;

