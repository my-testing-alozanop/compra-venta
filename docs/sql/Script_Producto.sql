-- LISTAR TODOS LOS REGISTROS POR SUCURSAL
DELIMITER //
CREATE PROCEDURE `sp_l_producto_01`(  
IN i_suc_id INT)
BEGIN  
 SELECT        
tm_producto.prod_id, 
tm_producto.suc_id, 
tm_producto.cat_id, 
tm_producto.prod_nom, 
tm_producto.prod_descrip, 
tm_producto.und_id, 
tm_producto.mon_id, 
tm_producto.prod_pcompra, 
tm_producto.Prod_pventa, 
tm_producto.prod_stock, 
tm_producto.prod_fechaven, 
tm_producto.prod_img, 
tm_producto.fech_crea, 
tm_producto.est, 
tm_categoria.cat_nom, 
tm_moneda.mon_nom, 
tm_unidad.und_nom
FROM            
tm_producto INNER JOIN
tm_categoria ON tm_producto.cat_id = tm_categoria.cat_id INNER JOIN
tm_moneda ON tm_producto.mon_id = tm_moneda.mon_id INNER JOIN
tm_unidad ON tm_producto.und_id = tm_unidad.und_id
 WHERE  
 tm_producto.suc_id = i_suc_id  
 AND tm_producto.est=1;
END //
DELIMITER ;

-- OBTENER REGISTRO POR ID
DELIMITER //
CREATE PROCEDURE `sp_l_producto_02`(  
IN i_prod_id INT)
BEGIN  
 SELECT        
tm_producto.prod_id, 
tm_producto.suc_id, 
tm_producto.cat_id, 
tm_producto.prod_nom, 
tm_producto.prod_descrip, 
tm_producto.und_id, 
tm_producto.mon_id, 
tm_producto.prod_pcompra, 
tm_producto.Prod_pventa, 
tm_producto.prod_stock, 
tm_producto.prod_fechaven, 
tm_producto.prod_img, 
tm_producto.fech_crea, 
tm_producto.est, 
tm_categoria.cat_nom, 
tm_moneda.mon_nom, 
tm_unidad.und_nom
FROM            
tm_producto INNER JOIN
tm_categoria ON tm_producto.cat_id = tm_categoria.cat_id INNER JOIN
tm_moneda ON tm_producto.mon_id = tm_moneda.mon_id INNER JOIN
tm_unidad ON tm_producto.und_id = tm_unidad.und_id
 WHERE  
 tm_producto.prod_id = i_prod_id;  
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_l_producto_03`(  
IN i_cat_id INT)
BEGIN  
 SELECT        
tm_producto.prod_id, 
tm_producto.suc_id, 
tm_producto.cat_id, 
tm_producto.prod_nom, 
tm_producto.prod_descrip, 
tm_producto.und_id, 
tm_producto.mon_id, 
tm_producto.prod_pcompra, 
tm_producto.Prod_pventa, 
tm_producto.prod_stock, 
tm_producto.prod_fechaven, 
tm_producto.prod_img, 
tm_producto.fech_crea, 
tm_producto.est, 
tm_categoria.cat_nom, 
tm_moneda.mon_nom, 
tm_unidad.und_nom
FROM            
tm_producto INNER JOIN
tm_categoria ON tm_producto.cat_id = tm_categoria.cat_id INNER JOIN
tm_moneda ON tm_producto.mon_id = tm_moneda.mon_id INNER JOIN
tm_unidad ON tm_producto.und_id = tm_unidad.und_id
 WHERE  
 tm_producto.cat_id = i_cat_id
 AND tm_producto.est = 1;  
END //
DELIMITER ;

-- ELIMINAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_d_producto_01`(  
IN i_prod_id INT)
BEGIN  
 UPDATE tm_producto
 SET est = 0
 WHERE  
	 prod_id = i_prod_id;  
END //
DELIMITER ;

-- REGISTRAR NUEVO REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_i_producto_01`(
IN i_suc_id INT,
IN i_cat_id INT,
IN i_prod_nom VARCHAR(150),
IN i_prod_descrip LONGTEXT,
IN i_und_id INT,
IN i_mon_id INT,
IN i_prod_pcompra NUMERIC(18,2),
IN i_prod_pventa NUMERIC(18,2),
IN i_prod_stock INT,
IN i_prod_fechaven DATE,
IN i_prod_img VARCHAR(150))
BEGIN
	INSERT INTO tm_producto
	(suc_id,cat_id,prod_nom,prod_descrip,und_id,mon_id,prod_pcompra,prod_pventa,prod_stock,prod_fechaven,prod_img,fech_crea,est)
	VALUES
	(i_suc_id,i_cat_id,i_prod_nom,i_prod_descrip,i_und_id,i_mon_id,i_prod_pcompra,i_prod_pventa,i_prod_stock,i_prod_fechaven,i_prod_img,NOW(),1);  
END //
DELIMITER ;

-- ACTUALIZAR REGISTRO
DELIMITER //
CREATE PROCEDURE `sp_u_producto_01`(
IN i_prod_id INT,
IN i_suc_id INT,
IN i_cat_id INT,
IN i_prod_nom VARCHAR(150),
IN i_prod_descrip LONGTEXT,
IN i_und_id INT,
IN i_mon_id INT,
IN i_prod_pcompra NUMERIC(18,2),
IN i_prod_pventa NUMERIC(18,2),
IN i_prod_stock INT,
IN i_prod_fechaven DATE,
IN i_prod_img VARCHAR(150))
BEGIN
	UPDATE tm_producto
	SET
		suc_id = i_suc_id,
		cat_id = i_cat_id,
		prod_nom = i_prod_nom,
		prod_descrip = i_prod_descrip,
		und_id = i_und_id,
		mon_id = i_mon_id,
		prod_pcompra = i_prod_pcompra,
		prod_pventa = i_prod_pventa,
		prod_stock = i_prod_stock,
		prod_fechaven = i_prod_fechaven,
		prod_img = i_prod_img
	WHERE
		prod_id = i_prod_id;
END //
DELIMITER ;