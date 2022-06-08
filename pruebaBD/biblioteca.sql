DROP DATABASE biblioteca;

CREATE DATABASE biblioteca;

\c biblioteca

CREATE TABLE comuna(
id INT NOT NULL,
nomComuna VARCHAR(30) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE socios(
rut VARCHAR(10) NOT NULL,
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NOT NULL,
direccion VARCHAR(60) NOT NULL,
telefono INT,
id_comuna INT REFERENCES comuna(id),
PRIMARY KEY(rut)
);

CREATE TABLE autor(
codAutor SERIAL,
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NOT NULL,
nacimiento INT,
muerte INT,
PRIMARY KEY (codAutor)
);
CREATE TABLE libros(
isbn BIGINT NOT NULL,
titulo VARCHAR(50),
paginas INT,
id_autor INT NOT NULL REFERENCES autor(codAutor),
id_coautor INT REFERENCES autor(codAutor),
PRIMARY KEY(isbn)
);
CREATE TABLE prestamo(
id SERIAL,
fecha_inicio DATE,
fecha_termino DATE,
id_libro BIGINT NOT NULL REFERENCES libros(isbn),
id_socio VARCHAR(10) NOT NULL REFERENCES socios(rut),
PRIMARY KEY(id)
);

-- update pg_database set encoding=8 where datname=’biblioteca’;

--llenado tabla comuna desde archivo
\COPY comuna FROM 'download/comunas.csv' csv header;

--transacción de llenado de tabla socios
BEGIN;
    INSERT INTO socios (rut, nombre, apellido, direccion,telefono,id_comuna) 
        VALUES ('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1', 911111111, 13101);
    INSERT INTO socios (rut, nombre, apellido, direccion,telefono,id_comuna) 
        VALUES ('2222222-2', 'ANA', 'PEREZ', 'PASAJE 2', 922222222, 13101);
    INSERT INTO socios (rut, nombre, apellido, direccion,telefono,id_comuna) 
        VALUES ('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2', 933333333, 13101);
    INSERT INTO socios (rut, nombre, apellido, direccion,telefono,id_comuna) 
        VALUES ('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3', 944444444, 13101);
    INSERT INTO socios (rut, nombre, apellido, direccion,telefono,id_comuna) 
        VALUES ('5555555-5', 'SILVANA', 'MUÑOZ', 'PASAJE 3', 955555555, 13101);
COMMIT;



--transaccion de llenado tabla autor
BEGIN;
    INSERT INTO autor(nombre, apellido, nacimiento) 
        VALUES('ANDRES', 'ULLOA', 1982);
    INSERT INTO autor(nombre, apellido, nacimiento, muerte)
        VALUES ('SERGIO', 'MARDONES', 1950, 2012);
    INSERT INTO autor(nombre, apellido, nacimiento, muerte)
        VALUES('JOSE', 'SALGADO', 1968, 2020);
    INSERT INTO autor(nombre, apellido, nacimiento)
        VALUES('ANA', 'SALGADO', 1972);
    INSERT INTO autor(nombre, apellido, nacimiento)
        VALUES('MARTIN', 'PORTA', 1976);
COMMIT;


--transaccion de llenado tabla libros
BEGIN;
    INSERT INTO libros (isbn, titulo, paginas, id_autor,id_coautor) 
        VALUES (1111111111111, 'CUENTOS DE TERROR', 344, 3, 4);
    INSERT INTO libros (isbn, titulo, paginas, id_autor) 
        VALUES (2222222222222, 'POESIAS CONTEMPORANEAS', 167, 1);
    INSERT INTO libros (isbn, titulo, paginas, id_autor) 
        VALUES (3333333333333, 'HISTORIA DE ASIA', 512, 1);
    INSERT INTO libros (isbn, titulo, paginas, id_autor) 
        VALUES (4444444444444, 'MANUAL DE MECANICA', 298, 5);
COMMIT;

--transaccion de llenado tabla prestamo

BEGIN;
    INSERT INTO prestamo (fecha_inicio, fecha_termino, id_libro,id_socio) 
        VALUES ('20-01-2020', '27-01-2020', 1111111111111, '1111111-1');
    INSERT INTO prestamo (fecha_inicio, fecha_termino, id_libro,id_socio) 
        VALUES ('20-01-2020', '30-01-2020', 2222222222222, '5555555-5');
    INSERT INTO prestamo (fecha_inicio, fecha_termino, id_libro,id_socio) 
        VALUES ('23-01-2020', '30-01-2020', 4444444444444, '4444444-4'); 
    INSERT INTO prestamo (fecha_inicio, fecha_termino, id_libro,id_socio) 
        VALUES ('27-01-2020', '04-02-2020', 1111111111111, '2222222-2'); 
    INSERT INTO prestamo (fecha_inicio, fecha_termino, id_libro,id_socio) 
        VALUES ('31-01-2020', '12-02-2020', 4444444444444, '1111111-1'); 
    INSERT INTO prestamo (fecha_inicio, fecha_termino, id_libro,id_socio) 
        VALUES ('31-01-2020', '12-02-2020', 2222222222222, '3333333-3'); 
COMMIT;

--QUERYS SOLICITADAS

--a. Mostrar todos los libros que posean menos de 300 páginas. (0.5 puntos)

SELECT isbn, titulo, paginas, autor.nombre || ' ' || autor.apellido AS autor
    FROM libros 
    INNER JOIN autor ON id_autor = autor.codAutor
    WHERE paginas < 300;

-- b. Mostrar todos los autores que hayan nacido después del 01-01-1970. (0.5 puntos)

SELECT nombre || ' ' || apellido AS AUTOR, NACIMIENTO 
    FROM autor 
    WHERE nacimiento >= 1970
    ORDER BY nacimiento ASC; 


--c. ¿Cuál es el libro más solicitado? (0.5 puntos)
SELECT id_libro AS ISBN, (SELECT titulo FROM libros WHERE prestamo.id_libro = isbn) AS TITULO, COUNT(id_libro) AS TOTAL_PRESTAMOS 
    FROM prestamo 
    GROUP BY id_libro;

--d. Si se cobrara una multa de $100 por cada día de atraso, 
-- mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días. (0.5 puntos)

SELECT id_socio, (SELECT nombre || ' ' || apellido FROM socios WHERE id_socio = rut) AS SOCIO,
        (SELECT titulo FROM libros WHERE isbn = id_libro) AS LIBRO_PRESTADO,
        fecha_inicio AS INICIO_PRESTAMO, fecha_termino AS FECHA_DEVOLUCION, fecha_termino - fecha_inicio AS DIAS_DE_RETRASO,
        (fecha_termino - fecha_inicio) * 100 AS MULTA_POR_ATRASO
    FROM prestamo WHERE (fecha_termino - fecha_inicio) > 7;