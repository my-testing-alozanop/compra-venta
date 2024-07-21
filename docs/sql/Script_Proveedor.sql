-- LISTAR TODOS LOS REGISTROS POR SUCURSAL
DELIMITER //
CREATE PROCEDURE `sp_l_proveedor_01`(  
IN i_emp_id INT)
BEGIN  
 SELECT * FROM tm_proveedor
	WHERE
	emp_id = i_emp_id
	AND est=1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_proveedor_02`(  
IN i_prov_id INT)
BEGIN  
 SELECT * FROM tm_proveedor
	WHERE
	prov_ID = i_prov_id;
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_proveedor_01`(  
IN i_prov_id INT)
BEGIN  
 UPDATE tm_proveedor
 SET est = 0
 WHERE  
	 prov_id = i_prov_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_proveedor_01`(
IN i_emp_id INT,    
IN i_prov_nom VARCHAR(150),    
IN i_prov_ruc VARCHAR(150),    
IN i_prov_telf VARCHAR(150),    
IN i_prov_direcc VARCHAR(150),    
IN i_prov_correo VARCHAR(150))
BEGIN
	INSERT INTO tm_proveedor
	(emp_id,prov_nom,prov_ruc,prov_telf,prov_direcc,prov_correo,fech_crea,est)
	VALUES
	(i_emp_id,i_prov_nom,i_prov_ruc,i_prov_telf,i_prov_direcc,i_prov_correo,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_proveedor_01`(
IN i_prov_id INT,
IN i_emp_id INT,    
IN i_prov_nom VARCHAR(150),    
IN i_prov_ruc VARCHAR(150),    
IN i_prov_telf VARCHAR(150),    
IN i_prov_direcc VARCHAR(150),    
IN i_prov_correo VARCHAR(150))
BEGIN
	UPDATE tm_proveedor
	SET
		emp_id = i_emp_id,
		prov_nom = i_prov_nom,
		prov_ruc = i_prov_ruc,
		prov_telf = i_prov_telf,
		prov_direcc = i_prov_direcc,
		prov_correo = i_prov_correo
	WHERE
		prov_id = i_prov_id;
END //
DELIMITER ;