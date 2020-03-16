SELECT * FROM medics1.doctors;
SELECT price FROM medics1.doctors as docresult WHERE speciality_id = 1; SELECT AVG(price) FROM doctors AS promedio;
SELECT name, price 
FROM medics1.doctors as docs 
WHERE speciality_id IS NOT NULL 
GROUP BY speciality_id 
HAVING price > 500;
SELECT name, speciality_id, price 
FROM medics1.doctors 
WHERE price > (
SELECT AVG(price) 
FROM medics1.doctors
);
SELECT doctors.*, speciality.Speciality_name 
FROM medics1.doctors 
INNER JOIN speciality  
ON doctors.speciality_id = speciality.speciality_id;
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

DELIMITER //
CREATE FUNCTION precioPromedio(id INT)
RETURNS FLOAT DETERMINISTIC
BEGIN
DECLARE promedio FLOAT;
SET promedio = (SELECT AVG(price) from medics1.doctors WHERE speciality_id = id);
RETURN promedio;
END; //
DELIMITER ;

SELECT distinct precioPromedio(1)  FROM medics1.doctors;
