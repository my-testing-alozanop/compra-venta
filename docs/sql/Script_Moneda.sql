-- LISTAR TODOS LOS REGISTROS POR SUCURSAL
DELIMITER //
CREATE PROCEDURE `sp_l_moneda_01`(  
IN i_suc_id INT)
BEGIN  
 SELECT 
 mon_id,
 suc_id,
 mon_nom,
 DATE_FORMAT(fech_crea,'%d/%m/%Y') AS fech_crea,
 est
 FROM tm_moneda
 WHERE  
	 suc_id = i_suc_id
     AND est = 1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_moneda_02`(  
IN i_mon_id INT)
BEGIN  
 SELECT * FROM tm_moneda 
 WHERE  
	 mon_id = i_mon_id;  
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_moneda_01`(  
IN i_mon_id INT)
BEGIN  
 UPDATE tm_moneda
 SET est = 0
 WHERE  
	 mon_id = i_mon_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_moneda_01`(
IN i_suc_id INT,
IN i_mon_nom VARCHAR(150))
BEGIN
	INSERT INTO tm_moneda
	(suc_id,mon_nom,fech_crea,est)
	VALUES
	(i_suc_id,i_mon_nom,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_moneda_01`(
IN i_mon_id INT,
IN i_suc_id INT,
IN i_mon_nom VARCHAR(150))
BEGIN
	UPDATE tm_moneda
	SET
		suc_id = i_suc_id,
		mon_nom = i_mon_nom
	WHERE
		mon_id = i_mon_id;
END //
DELIMITER ;