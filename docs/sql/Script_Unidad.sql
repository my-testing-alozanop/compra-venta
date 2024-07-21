-- LISTAR TODOS LOS REGISTROS POR SUCURSAL
DELIMITER //
CREATE PROCEDURE `sp_l_unidad_01`(  
IN i_suc_id INT)
BEGIN  
 SELECT * FROM tm_unidad
 WHERE  
	 suc_id = i_suc_id
     AND est = 1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_unidad_02`(  
IN i_und_id INT)
BEGIN  
 SELECT * FROM tm_unidad 
 WHERE  
	 und_id = i_und_id;  
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_unidad_01`(  
IN i_und_id INT)
BEGIN  
 UPDATE tm_unidad
 SET est = 0
 WHERE  
	 und_id = i_und_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_unidad_01`(
IN i_suc_id INT,
IN i_und_nom VARCHAR(150))
BEGIN
	INSERT INTO tm_unidad
	(suc_id,und_nom,fech_crea,est)
	VALUES
	(i_suc_id,i_und_nom,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_unidad_01`(
IN i_und_id INT,
IN i_suc_id INT,
IN i_und_nom VARCHAR(150))
BEGIN
	UPDATE tm_unidad
	SET
		suc_id = i_suc_id,
		und_nom = i_und_nom
	WHERE
		und_id = i_und_id;
END //
DELIMITER ;