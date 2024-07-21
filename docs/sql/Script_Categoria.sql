use compra_venta;

-- LISTAR TODOS LOS REGISTROS POR SUCURSAL
DELIMITER //
CREATE PROCEDURE `sp_l_categoria_01`(  
IN i_suc_id INT)
BEGIN  
 SELECT 
	 cat_id,
	 suc_id,
	 cat_nom,
	 DATE_FORMAT(fech_crea,'%d/%m/%Y') AS fech_crea,
	 est 
 FROM 
	tm_categoria
 WHERE  
	 suc_id = i_suc_id
     AND est = 1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_categoria_02`(  
IN i_cat_id INT)
BEGIN  
 SELECT * FROM tm_categoria 
 WHERE  
	 cat_id = i_cat_id;  
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_categoria_01`(  
IN i_cat_id INT)
BEGIN  
 UPDATE tm_categoria
 SET est = 0
 WHERE  
	 cat_id = i_cat_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_categoria_01`(
IN i_suc_id INT,
IN i_cat_nom VARCHAR(150))
BEGIN
	INSERT INTO tm_categoria
	(suc_id,cat_nom,fech_crea,est)
	VALUES
	(i_suc_id,i_cat_nom,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_categoria_01`(
IN i_cat_id INT,
IN i_suc_id INT,
IN i_cat_nom VARCHAR(150))
BEGIN
	UPDATE tm_categoria
	SET
		suc_id = i_suc_id,
		cat_nom = i_cat_nom
	WHERE
		cat_id = i_cat_id;
END //
DELIMITER ;