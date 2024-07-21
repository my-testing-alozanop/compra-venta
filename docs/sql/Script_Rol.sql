-- LISTAR TODOS LOS REGISTROS POR SUCURSAL
DELIMITER //
CREATE PROCEDURE `sp_l_rol_01`(  
IN i_suc_id INT)
BEGIN  
 SELECT * FROM tm_rol
 WHERE  
	 suc_id = i_suc_id
     AND est = 1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_rol_02`(  
IN i_rol_id INT)
BEGIN  
 SELECT * FROM tm_rol 
 WHERE  
	 rol_id = i_rol_id;  
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_rol_01`(  
IN i_rol_id INT)
BEGIN  
 UPDATE tm_rol
 SET est = 0
 WHERE  
	 rol_id = i_rol_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_rol_01`(
IN i_suc_id INT,
IN i_rol_nom VARCHAR(150))
BEGIN
	INSERT INTO tm_rol
	(suc_id,rol_nom,fech_crea,est)
	VALUES
	(i_suc_id,i_rol_nom,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_rol_01`(
IN i_rol_id INT,
IN i_suc_id INT,
IN i_rol_nom VARCHAR(150))
BEGIN
	UPDATE tm_rol
	SET
		suc_id = i_suc_id,
		rol_nom = i_rol_nom
	WHERE
		rol_id = i_rol_id;
END //
DELIMITER ;