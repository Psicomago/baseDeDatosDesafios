-- 1. Crear una base de datos con nombre “Posts”. (1 Punto)
CREATE DATABASE post;

-- 2. Crear una tabla “post”, con los atributos id, nombre de usuario, fecha de creación,
-- contenido y descripción. (1 Punto)
CREATE TABLE post(
id SERIAL PRIMARY KEY,
nombreUsuario VARCHAR(60),
fecha date,
contenido VARCHAR(100),
descripción VARCHAR(100)
);

-- 3. Insertar 3 post, 2 para el usuario "Pamela" y uno para "Carlos". (0.6 Puntos)
INSERT INTO post (nombreUsuario, fecha, contenido, descripcion)
    VALUE ('Pamela', '')

-- 4. Modificar la tabla post, agregando la columna título. (1 Punto)

-- 5. Agregar título a las publicaciones ya ingresadas. (1 Punto)

-- 6. Insertar 2 post para el usuario "Pedro". (0.4 Puntos)

-- 7. Eliminar el post de Carlos. (1 Punto)

-- 8. Ingresar un nuevo post para el usuario "Carlos". (0.6 Puntos)

-- Parte 2
-- 1. Crear una nueva tabla llamada “comentarios”, con los atributos id, fecha, hora de
-- creación y contenido, que se relacione con la tabla posts. (1 Punto)
-- 2. Crear 2 comentarios para el post de "Pamela" y 4 para "Carlos". (0.4 Puntos)
-- 3. Crear un nuevo post para "Margarita". (1 Punto)
-- 4. Ingresar 5 comentarios para el post de Margarita. (1 Punto)