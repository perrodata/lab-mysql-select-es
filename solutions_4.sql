-- Desafió 1:
-- En este desafío escribirás una consulta SELECT de MySQL que una varias tablas 
-- para descubrir qué títulos ha publicado cada autor en qué editoriales. 
-- Tu salida debe tener al menos las siguientes columnas:
-- AUTHOR ID - el ID del autor
-- LAST NAME - apellido del autor
-- FIRST NAME - nombre del autor
-- TITLE - nombre del título publicado
-- PUBLISHER - nombre de la editorial donde se publicó el título 

-- UTILIZAMOS EL LEFT PORQUE PASAMOS DE UNA TABLA CON MÁS CONTENIDO A UNA CON MENOS CONTENIDO.
USE PUBLICATIONS;
SELECT au.au_id as 'AUTHOR ID',au.au_lname AS 'LAST NAME',au.au_fname AS 'FIRST NAME',libros.title AS 'TITLE' ,editorial.pub_name AS 'PUBLISHER'
FROM authors AS au
LEFT JOIN 
titleauthor AS title ON  au.au_id = title.au_id
LEFT JOIN
titles AS libros ON title.title_id = libros.title_id
LEFT JOIN
publishers AS editorial ON libros.pub_id = editorial.pub_id
;

-- Desafío 2 - ¿Quién ha publicado cuántos y dónde?
-- Partiendo de tu solución en el Desafío 1, consulta cuántos títulos ha publicado cada autor en cada editorial

USE PUBLICATIONS;
SELECT au.au_id as 'AUTHOR ID',au.au_lname AS 'LAST NAME',au.au_fname AS 'FIRST NAME',editorial.pub_name AS 'PUBLISHER', COUNT(libros.title) AS 'TITLE COUNT'
FROM authors AS au
LEFT JOIN 
titleauthor AS title ON  au.au_id = title.au_id
LEFT JOIN
titles AS libros ON title.title_id = libros.title_id
LEFT JOIN
publishers AS editorial ON libros.pub_id = editorial.pub_id

WHERE editorial.pub_name IS NOT NULL
GROUP BY au.au_id, au.au_lname, au.au_fname, editorial.pub_name
ORDER BY au.au_id DESC
;

-- DESAFÍO 3 
-- ¿Quiénes son los 3 principales autores que han vendido el mayor número de títulos? Escribe una consulta para averiguarlo.
-- Requisitos:
-- Tu salida debería tener las siguientes columnas:
-- AUTHOR ID - el ID del autor
-- LAST NAME - apellido del autor
-- FIRST NAME - nombre del autor
-- TOTAL - número total de títulos vendidos de este autor
-- Tu salida debería estar ordenada basándose en TOTAL de mayor a menor.
-- Solo muestra los 3 mejores autores en ventas.

SELECT 
	a.au_id as 'AUTHOR ID',
	a.au_lname AS 'LAST NAME',
	a.au_fname AS 'FIRST NAME',
	SUM(d.qty) AS 'TOTAL'
FROM authors AS a
LEFT JOIN 
titleauthor AS b ON  a.au_id = b.au_id
LEFT JOIN
titles AS c ON b.title_id = c.title_id
LEFT JOIN
sales AS d ON c.title_id = d.title_id
GROUP BY a.au_id,a.au_lname,a.au_fname,d.qty
ORDER BY d.qty DESC
LIMIT 3
;

-- Desafío 4 - Ranking de Autores Más Vendidos
-- Ahora modifica tu solución en el Desafío 3 para que la salida muestre a todos los 23 autores en lugar de solo los 3 principales. Ten en cuenta que los autores que han vendido 0 títulos también deben aparecer en tu salida (idealmente muestra 0 en lugar de NULL como TOTAL). También ordena tus resultados basándose en TOTAL de mayor a menor.

SELECT 
	a.au_id as 'AUTHOR ID',
	a.au_lname AS 'LAST NAME',
	a.au_fname AS 'FIRST NAME',
	coalesce(sum(d.qty),0) AS 'TOTAL'
FROM authors AS a
LEFT JOIN 
titleauthor AS b ON  a.au_id = b.au_id
LEFT JOIN
titles AS c ON b.title_id = c.title_id
LEFT JOIN
sales AS d ON c.title_id = d.title_id
GROUP BY a.au_id,a.au_lname,a.au_fname,d.qty
ORDER BY d.qty DESC
;





