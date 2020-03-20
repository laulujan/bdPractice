SELECT * FROM medics1.doctors;
//Es muy buena práctica de programación especificar el Schema y luego la tabla, muy bien ;)

SELECT 
  price 
FROM medics1.doctors as docresult 
WHERE speciality_id = 1; 
//El alias en este caso, si lo usas en la tabla, hay que usarlo en el SELECT (docresult.price) y en el Where (docresult.speciality_id)
//si lo que querias era el alia de la columna se pondria price AS docresult

SELECT AVG(price) FROM doctors AS promedio;
//correcto

SELECT 
  name, 
  price 
FROM medics1.doctors as docs 
WHERE speciality_id IS NOT NULL 
GROUP BY speciality_id 
HAVING price > 500;
//Si usamos alias en la tabla, hay que usarlo en el Select
//si usas agrupamientos, hay que usar funciones de agrupamiento para tener un resultado (ej. COUNT,SUM) si no solo te traera el primer resultado del agrupamiento
//siempre es bueno darle una estructura al query como la que yo le di, para tener mas legibilidad de lo que hace.

SELECT 
  name, 
  speciality_id, 
  price 
FROM medics1.doctors 
WHERE price > (
              SELECT AVG(price) 
              FROM medics1.doctors
              );
//Correcto              
              
SELECT doctors.*, speciality.Speciality_name 
FROM medics1.doctors 
INNER JOIN speciality  
ON doctors.speciality_id = speciality.speciality_id;
//Bien :D

DELIMITER //
CREATE procedure fulldata
(
IN idfilter INT

)
BEGIN 
SELECT CONCAT(name, " ", address, " " , price) 
AS fullInfo 
FROM medics1.doctors 
WHERE speciality_id = idFilter;
END //
DELIMITER ;
CALL  fulldata(2);
//Correcto

DELIMITER //
CREATE FUNCTION precioPromedio(id INT)
RETURNS FLOAT DETERMINISTIC
BEGIN
DECLARE promedio FLOAT;
SET promedio = (SELECT AVG(price) from medics1.doctors WHERE speciality_id = id);
RETURN promedio;
END; //
DELIMITER ;
//Bien :D

SELECT distinct precioPromedio(1)  FROM medics1.doctors;
//si solo te va a regresar un resultado, no necesitas usar el Distinct ;)
