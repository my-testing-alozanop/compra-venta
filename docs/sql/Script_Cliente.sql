-- LISTAR TODOS LOS REGISTROS POR SUCURSAL
DELIMITER //
CREATE PROCEDURE `sp_l_cliente_01`(  
IN i_emp_id INT)
BEGIN  
 SELECT * FROM tm_cliente
	WHERE
	emp_id = i_emp_id
	AND est=1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_cliente_02`(  
IN i_cli_id INT)
BEGIN  
 SELECT * FROM tm_cliente
	WHERE
	cli_ID = i_cli_id;
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_cliente_01`(  
IN i_cli_id INT)
BEGIN  
 UPDATE tm_cliente
 SET est = 0
 WHERE  
	 cli_id = i_cli_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_cliente_01`(
IN i_emp_id INT,    
IN i_cli_nom VARCHAR(150),    
IN i_cli_ruc VARCHAR(15),    
IN i_cli_telf VARCHAR(150),    
IN i_cli_direcc VARCHAR(150),    
IN i_cli_correo VARCHAR(150))
BEGIN
	INSERT INTO tm_cliente
	(cli_nom,emp_id,cli_ruc,cli_telf,cli_direcc,cli_correo,fech_crea,est)
	VALUES
	(i_cli_nom,i_emp_id,i_cli_ruc,i_cli_telf,i_cli_direcc,i_cli_correo,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_cliente_01`(
IN i_cli_id INT,
IN i_cli_nom VARCHAR(150),
IN i_emp_id INT,        
IN i_cli_ruc VARCHAR(150),    
IN i_cli_telf VARCHAR(150),    
IN i_cli_direcc VARCHAR(150),    
IN i_cli_correo VARCHAR(150))
BEGIN
	UPDATE tm_cliente
	SET
		cli_nom = i_cli_nom,
        emp_id = i_emp_id,
		cli_ruc = i_cli_ruc,
		cli_telf = i_cli_telf,
		cli_direcc = i_cli_direcc,
		cli_correo = i_cli_correo
	WHERE
		cli_id = i_cli_id;
END //
DELIMITER ;