--Se requiere crear un sitio web dedicado al mundo cinematográfico donde los usuarios
-- puedan buscar detalles del top 100 de películas más populares. El plus más importante de
-- este sitio web debe ser la variedad de filtros que ofrece para una búsqueda más efectiva.
-- Para este desafío necesitarás crear 2 tablas llamadas películas y reparto, sus datos los
-- consigues en los ficheros de extensión csv ubicados en el Apoyo Desafío.

-- Requerimientos
    DROP DATABASE peliculas;
-- 1. Crear una base de datos llamada películas. (1 Punto)
    CREATE DATABASE peliculas;
    \c peliculas -- conecta a base de datos peliculas

    CREATE TABLE peliculas(
    id INT,
    pelicula VARCHAR(60),
    estreno INT(04),
    director VARCHAR(20),
    PRIMARY KEY(id)
    );

    CREATE TABLE reparto(
    id_pelicula INT,
    actor VARCHAR(60),
    FOREIGN KEY (id_pelicula) REFERENCES peliculas(id)
    );


-- 2. Cargar ambos archivos a su tabla correspondiente. (1 Punto)
    \COPY peliculas FROM '../ApoyoTop100/peliculas.csv' csv header;
    \COPY reparto FROM '../ApoyoTop100/reparto.csv' delimiter ',';

-- 3. Obtener el ID de la película “Titanic”. (1 Punto)
    SELECT id FROM peliculas WHERE pelicula = 'Titanic';


-- 4. Listar a todos los actores que aparecen en la película "Titanic". (1 Puntos)
    SELECT actor FROM reparto WHERE id_pelicula = (SELECT id FROM peliculas WHERE pelicula = 'Titanic');

-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford. (2 Puntos)
    SELECT COUNT(id_pelicula) FROM reparto WHERE actor = 'Harrison Ford';


-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente. (1 punto)

    SELECT pelicula FROM peliculas WHERE estreno BETWEEN 1990 AND 1999 ORDER BY pelicula ASC;

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser

-- nombrado para la consulta como “longitud_titulo”. (1 punto)

    SELECT pelicula, LENGTH(pelicula) as longitud_titulo FROM peliculas;

-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas. (2 punto)

    SELECT MAX(LENGTH(pelicula)) FROM peliculas;