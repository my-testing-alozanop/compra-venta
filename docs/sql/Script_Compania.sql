-- LISTAR TODOS LOS REGISTROS POR SUCURSAL
DELIMITER //
CREATE PROCEDURE `sp_l_compania_01`()
BEGIN  
 SELECT * FROM tm_compania
 WHERE  
	 est = 1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_compania_02`(  
IN i_com_id INT)
BEGIN  
 SELECT * FROM tm_compania 
 WHERE  
	 com_id = i_com_id;  
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_compania_01`(  
IN i_com_id INT)
BEGIN  
 UPDATE tm_compania
 SET est = 0
 WHERE  
	 com_id = i_com_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_compania_01`(
IN i_com_nom VARCHAR(150))
BEGIN
	INSERT INTO tm_compania
	(com_nom,fech_crea,est)
	VALUES
	(i_com_nom,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_compania_01`(
IN i_com_id INT,
IN i_com_nom VARCHAR(150))
BEGIN
	UPDATE tm_compania
	SET
		com_nom = i_com_nom
	WHERE
		com_id = i_com_id;
END //
DELIMITER ;