--Se requiere crear un sitio web dedicado al mundo cinematográfico donde los usuarios
-- puedan buscar detalles del top 100 de películas más populares. El plus más importante de
-- este sitio web debe ser la variedad de filtros que ofrece para una búsqueda más efectiva.
-- Para este desafío necesitarás crear 2 tablas llamadas películas y reparto, sus datos los
-- consigues en los ficheros de extensión csv ubicados en el Apoyo Desafío.

-- Requerimientos
-- 1. Crear una base de datos llamada películas. (1 Punto)
    CREATE DATABASE peliculas;
    \c peliculas;  -- conecta a base de datos peliculas

-- 2. Cargar ambos archivos a su tabla correspondiente. (1 Punto)
    \COPY peliculasTable to 
    
-- 3. Obtener el ID de la película “Titanic”. (1 Punto)
    SELECT 

-- 4. Listar a todos los actores que aparecen en la película "Titanic". (1 Puntos)

-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford. (2 Puntos)

-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de

-- manera ascendente. (1 punto)

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser

-- nombrado para la consulta como “longitud_titulo”. (1 punto)

-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas.

-- (2 punto)