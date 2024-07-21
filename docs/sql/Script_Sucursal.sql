-- LISTAR TODOS LOS REGISTROS POR SUCURSAL
DELIMITER //
CREATE PROCEDURE `sp_l_sucursal_01`(  
IN i_emp_id INT)
BEGIN  
 SELECT * FROM tm_sucursal
 WHERE  
	 emp_id = i_emp_id
     AND est = 1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_sucursal_02`(  
IN i_suc_id INT)
BEGIN  
 SELECT * FROM tm_sucursal 
 WHERE  
	 suc_id = i_suc_id;  
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_sucursal_01`(  
IN i_suc_id INT)
BEGIN  
 UPDATE tm_sucursal
 SET est = 0
 WHERE  
	 suc_id = i_suc_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_sucursal_01`(
IN i_emp_id INT,
IN i_suc_nom VARCHAR(150))
BEGIN
	INSERT INTO tm_sucursal
	(emp_id,suc_nom,fech_crea,est)
	VALUES
	(i_emp_id,i_suc_nom,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_sucursal_01`(
IN i_suc_id INT,
IN i_emp_id INT,
IN i_suc_nom VARCHAR(150))
BEGIN
	UPDATE tm_sucursal
	SET
		emp_id = i_emp_id,
		suc_nom = i_suc_nom
	WHERE
		suc_id = i_suc_id;
END //
DELIMITER ;