/* Descripción
Se requiere crear un sitio web dedicado al mundo cinematográfico donde los usuarios
puedan buscar detalles del top 100 de películas más populares. El plus más importante de
este sitio web debe ser la variedad de filtros que ofrece para una búsqueda más efectiva.
Para este desafío necesitarás crear 2 tablas llamadas películas y reparto.
*/

-- Requerimientos

--Alternativa 1
-- 1. Crear una base de datos llamada películas.

CREATE DATABASE peliculas;

\c peliculas;

CREATE TABLE peliculas (
    id INT PRIMARY KEY,
    titulo VARCHAR,
    año_estreno INT,
    director VARCHAR
);

CREATE TABLE reparto (
    pelicula_id INT,
    actor VARCHAR,
    FOREIGN KEY (pelicula_id) REFERENCES peliculas(id)
);



-- 2. Cargar ambos archivos a su tabla correspondiente y aplicar el truncado de estas.
TRUNCATE TABLE peliculas, reparto;

COPY peliculas(id, titulo, año_estreno, director)
FROM '<rutade del archivo>/peliculas.csv' WITH (FORMAT csv, HEADER true);

COPY reparto(pelicula_id, actor)
FROM '/<rutade del archivo>/reparto.csv' WITH (FORMAT csv, HEADER false);


--3. Obtener el ID de la película “Titanic”.
SELECT id FROM peliculas WHERE titulo = 'Titanic';


-- 4. Listar a todos los actores que aparecen en la película "Titanic".
SELECT actor FROM reparto
JOIN peliculas ON reparto.pelicula_id = peliculas.id
WHERE peliculas.titulo = 'Titanic';


-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford.
SELECT COUNT(*) FROM reparto
JOIN peliculas ON reparto.pelicula_id = peliculas.id
WHERE reparto.actor = 'Harrison Ford';


-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de manera ascendente.
SELECT titulo FROM peliculas
WHERE año_estreno BETWEEN 1990 AND 1999
ORDER BY titulo ASC;
-- EL ASC es por defecto pero por temas de requerimientos.

 -- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser nombrado para la consulta como “longitud_titulo”.
SELECT titulo, LENGTH(titulo) AS longitud_titulo FROM peliculas;


-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas.
-- Solo longitud 
SELECT MAX(LENGTH(titulo)) FROM peliculas;

-- Nombre y Longitud
SELECT titulo, LENGTH(titulo) AS longitud_titulo
FROM peliculas
WHERE LENGTH(titulo) = (
  SELECT MAX(LENGTH(titulo))
  FROM peliculas
);


