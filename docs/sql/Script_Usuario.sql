-- LISTAR TODOS LOS REGISTROS POR usuario
DELIMITER //
CREATE PROCEDURE `sp_l_usuario_01`(  
IN i_suc_id INT)
BEGIN  
 SELECT          
tm_usuario.usu_id,   
tm_usuario.suc_id,   
tm_usuario.usu_correo,   
tm_usuario.usu_nom,   
tm_usuario.usu_ape,   
tm_usuario.usu_dni,   
tm_usuario.usu_telf,   
tm_usuario.usu_pass,  
tm_usuario.usu_img, 
tm_usuario.rol_id,   
tm_usuario.fech_crea,  
tm_rol.rol_nom,   
tm_usuario.est  
FROM
 tm_usuario INNER JOIN  
tm_rol ON tm_usuario.rol_id = tm_rol.rol_id  
WHERE    
tm_usuario.suc_id = i_suc_id    
AND tm_usuario.est=1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_usuario_02`(  
IN i_usu_id INT)
BEGIN  
 SELECT * FROM tm_usuario 
 WHERE  
	 usu_id = i_usu_id;  
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_usuario_04`(
IN i_suc_id INT,  
IN i_usu_correo VARCHAR(150),
IN i_usu_pass VARCHAR(50))
BEGIN  
 SELECT            
 tm_usuario.usu_id,     
 tm_usuario.suc_id,     
 tm_usuario.usu_correo,     
 tm_usuario.usu_nom,     
 tm_usuario.usu_ape,     
 tm_usuario.usu_dni,     
 tm_usuario.usu_telf,     
 tm_usuario.usu_pass,     
 tm_usuario.rol_id,    
 tm_usuario.usu_img, 
 tm_sucursal.emp_id,     
 tm_sucursal.suc_nom,    
 tm_empresa.emp_id,    
 tm_empresa.emp_nom,     
 tm_empresa.emp_ruc,     
 tm_empresa.com_id,     
 tm_compania.com_nom    
 FROM      
 tm_usuario INNER JOIN    
 tm_sucursal ON tm_usuario.suc_id = tm_sucursal.suc_id INNER JOIN    
 tm_empresa ON tm_sucursal.emp_id = tm_empresa.emp_id INNER JOIN    
 tm_compania ON tm_empresa.com_id = tm_compania.com_id    
 WHERE    
 tm_usuario.suc_id = i_suc_id     
 AND tm_usuario.usu_correo = i_usu_correo    
 AND tm_usuario.usu_pass = i_usu_pass    
 AND tm_usuario.est = 1; 
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_usuario_01`(  
IN i_usu_id INT)
BEGIN  
 UPDATE tm_usuario
 SET est = 0
 WHERE  
	 usu_id = i_usu_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_usuario_01`(
IN i_suc_id INT,  
IN i_usu_correo VARCHAR(150),  
IN i_usu_nom VARCHAR(150),  
IN i_usu_ape VARCHAR(150),  
IN i_usu_dni VARCHAR(150),  
IN i_usu_telf VARCHAR(150),  
IN i_usu_pass VARCHAR(150),  
IN i_rol_id INT,
IN i_usu_img VARCHAR(150))
BEGIN
	INSERT INTO tm_usuario
	(suc_id,usu_correo,usu_nom,usu_ape,usu_dni,usu_telf,usu_pass,rol_id,usu_img,fech_crea,est)
	VALUES
	(i_suc_id,i_usu_correo,i_usu_nom,i_usu_ape,i_usu_dni,i_usu_telf,i_usu_pass,i_rol_id,i_usu_img,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_usuario_01`(
IN i_usu_id INT,
IN i_suc_id INT,  
IN i_usu_correo VARCHAR(150),  
IN i_usu_nom VARCHAR(150),  
IN i_usu_ape VARCHAR(150),  
IN i_usu_dni VARCHAR(150),  
IN i_usu_telf VARCHAR(150),  
IN i_usu_pass VARCHAR(150),  
IN i_rol_id INT,
IN i_usu_img VARCHAR(150))
BEGIN
	UPDATE tm_usuario
	SET  
  suc_id = i_suc_id,  
  usu_correo = i_usu_correo,  
  usu_nom = i_usu_nom,  
  usu_ape = i_usu_ape,  
  usu_dni = i_usu_dni,  
  usu_telf = i_usu_telf,  
  usu_pass = i_usu_pass,  
  rol_id = i_rol_id,
  usu_img = i_usu_img
 WHERE  
  usu_id = i_usu_id;
END //
DELIMITER ;

-- ACCESO DE USUARIO
DELIMITER //
CREATE PROCEDURE `sp_l_usuario_03`(  
IN i_usu_correo VARCHAR(150),
IN i_usu_pass VARCHAR(50))
BEGIN  
 SELECT * FROM tm_usuario 
 WHERE
	usu_correo = i_usu_correo
	AND usu_pass = i_usu_pass
	AND est=1;
END //
DELIMITER ;

-- CAMBIO DE CONTRASEÑA
DELIMITER //
CREATE PROCEDURE `sp_u_usuario_02`(  
IN i_usu_id INT,
IN i_usu_pass VARCHAR(50))
BEGIN  
 UPDATE tm_usuario
	SET
		usu_pass = i_usu_pass
	WHERE
		usu_id = i_usu_id;
END //
DELIMITER ;