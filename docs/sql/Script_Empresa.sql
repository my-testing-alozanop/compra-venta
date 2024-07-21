-- LISTAR TODOS LOS REGISTROS POR SUCURSAL
DELIMITER //
CREATE PROCEDURE `sp_l_empresa_01`(
IN i_com_id INT)
BEGIN  
 SELECT * FROM tm_empresa
 WHERE  
	 com_id = i_com_id
	AND est=1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_empresa_02`(  
IN i_emp_id INT)
BEGIN  
 SELECT * FROM tm_empresa 
 WHERE  
	 emp_id = i_emp_id;  
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_empresa_01`(  
IN i_emp_id INT)
BEGIN  
 UPDATE tm_empresa
 SET est = 0
 WHERE  
	 emp_id = i_emp_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_empresa_01`(
IN i_com_id INT,
IN i_emp_nom VARCHAR(150),
IN i_emp_ruc VARCHAR(150))
BEGIN
	INSERT INTO tm_empresa
	(com_id,emp_nom,emp_ruc,fech_crea,est)
	VALUES
	(i_com_id,i_emp_nom,i_emp_ruc,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_empresa_01`(
IN i_emp_id INT,
IN i_com_id INT,
IN i_emp_nom VARCHAR(150),
IN i_emp_ruc VARCHAR(150))
BEGIN
	UPDATE tm_empresa
	SET
		com_id = i_com_id,
		emp_nom = i_emp_nom,
		emp_ruc = i_emp_ruc
	WHERE
		emp_id = i_emp_id;
END //
DELIMITER ;