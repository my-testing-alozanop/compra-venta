DELIMITER //
CREATE PROCEDURE `sp_l_venta_01`(
IN i_vent_id INT)
BEGIN  
 SELECT          
 td_venta_detalle.detv_id,   
 tm_categoria.cat_nom,   
 tm_producto.prod_nom,
 tm_producto.prod_img,
 tm_unidad.und_nom,   
 td_venta_detalle.prod_pventa,  
 td_venta_detalle.detv_cant,   
 td_venta_detalle.detv_total,   
 td_venta_detalle.vent_id,   
 td_venta_detalle.prod_id  
 FROM              
 td_venta_detalle INNER JOIN  
 tm_producto ON td_venta_detalle.prod_id = tm_producto.prod_id INNER JOIN  
 tm_categoria ON tm_producto.cat_id = tm_categoria.cat_id INNER JOIN  
 tm_unidad ON tm_producto.und_id = tm_unidad.und_id  
 WHERE  
 td_venta_detalle.vent_id = i_vent_id  
 AND td_venta_detalle.est=1;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_l_venta_02`(
IN i_vent_id INT)
BEGIN  
 SELECT        
tm_venta.vent_id, 
tm_venta.suc_id, 
tm_venta.pag_id, 
tm_venta.cli_id, 
tm_venta.cli_ruc, 
tm_venta.cli_direcc, 
tm_venta.cli_correo, 
tm_venta.vent_subtotal, 
tm_venta.vent_igv, 
tm_venta.vent_total, 
tm_venta.vent_coment, 
tm_cliente.usu_id, 
tm_venta.mon_id, 
tm_venta.fech_crea, 
tm_venta.est, 
tm_sucursal.suc_nom, 
tm_empresa.emp_nom, 
tm_empresa.emp_ruc, 
tm_empresa.emp_correo, 
tm_empresa.emp_telf, 
tm_empresa.emp_direcc, 
tm_empresa.emp_pag, 
tm_compania.com_nom, 
tm_usuario.usu_correo, 
tm_usuario.usu_nom, 
tm_usuario.usu_ape, 
tm_usuario.usu_dni, 
tm_usuario.usu_telf, 
tm_rol.rol_nom, 
tm_pago.pag_nom, 
tm_moneda.mon_nom,
tm_cliente.cli_nom
FROM            
tm_venta INNER JOIN
tm_sucursal ON tm_venta.suc_id = tm_sucursal.suc_id INNER JOIN
tm_empresa ON tm_sucursal.emp_id = tm_empresa.emp_id INNER JOIN
tm_compania ON tm_empresa.com_id = tm_compania.com_id INNER JOIN
tm_usuario ON tm_venta.usu_id = tm_usuario.usu_id INNER JOIN
tm_rol ON tm_usuario.rol_id = tm_rol.rol_id INNER JOIN
tm_pago ON tm_venta.pag_id = tm_pago.pag_id INNER JOIN
tm_moneda ON tm_venta.mon_id = tm_moneda.mon_id INNER JOIN
tm_cliente ON tm_venta.cli_id = tm_cliente.cli_id
WHERE  
tm_venta.vent_id = i_vent_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_l_venta_03`(
IN i_suc_id INT)
BEGIN  
 SELECT        
tm_venta.vent_id, 
tm_venta.suc_id, 
tm_venta.pag_id, 
tm_venta.cli_id, 
tm_venta.cli_ruc, 
tm_venta.cli_direcc, 
tm_venta.cli_correo, 
tm_venta.vent_subtotal, 
tm_venta.vent_igv, 
tm_venta.vent_total, 
tm_venta.vent_coment, 
tm_venta.usu_id, 
tm_venta.mon_id, 
tm_venta.fech_crea, 
tm_venta.est, 
tm_sucursal.suc_nom, 
tm_empresa.emp_nom, 
tm_empresa.emp_ruc, 
tm_empresa.emp_correo, 
tm_empresa.emp_telf, 
tm_empresa.emp_direcc, 
tm_empresa.emp_pag, 
tm_compania.com_nom, 
tm_usuario.usu_correo, 
tm_usuario.usu_nom, 
tm_usuario.usu_ape, 
tm_usuario.usu_dni, 
tm_usuario.usu_telf,
tm_usuario.usu_img, 
tm_rol.rol_nom, 
tm_pago.pag_nom, 
tm_moneda.mon_nom,
tm_cliente.cli_nom,
tm_documento.doc_nom
FROM            
tm_venta INNER JOIN
tm_sucursal ON tm_venta.suc_id = tm_sucursal.suc_id INNER JOIN
tm_empresa ON tm_sucursal.emp_id = tm_empresa.emp_id INNER JOIN
tm_compania ON tm_empresa.com_id = tm_compania.com_id INNER JOIN
tm_usuario ON tm_venta.usu_id = tm_usuario.usu_id INNER JOIN
tm_rol ON tm_usuario.rol_id = tm_rol.rol_id INNER JOIN
tm_pago ON tm_venta.pag_id = tm_pago.pag_id INNER JOIN
tm_moneda ON tm_venta.mon_id = tm_moneda.mon_id INNER JOIN
tm_cliente ON tm_venta.cli_id = tm_cliente.cli_id INNER JOIN
tm_documento ON tm_venta.doc_id = tm_documento.doc_id
WHERE  
tm_venta.est=1    
 AND tm_venta.suc_id = i_suc_id; 
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_i_venta_01`(
IN i_suc_id INT,
IN i_usu_id INT)
BEGIN  
 INSERT INTO tm_venta 
	(suc_id,usu_id,est)
	VALUES
	(i_suc_id,i_usu_id,2);
    
    SELECT vent_id FROM tm_venta WHERE vent_id=LAST_INSERT_ID();
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_i_venta_02`(
IN i_vent_id INT,
IN i_prod_id INT,
IN i_prod_pventa DECIMAL(18,2),
IN i_detv_cant INT)
BEGIN  
 INSERT td_venta_detalle
	(vent_id,prod_id,prod_pventa,detv_cant,detv_total,fech_crea,est)
	VALUES
	(i_vent_id,i_prod_id,i_prod_pventa,i_detv_cant,i_prod_pventa * i_detv_cant,NOW(),1);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_d_venta_01`(
IN i_detv_id INT)
BEGIN  
 UPDATE td_venta_detalle
	SET
		est=0
	WHERE
		detv_id = i_detv_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_u_venta_01`(
IN i_vent_id INT)
BEGIN  
 UPDATE tm_venta
	SET
		vent_subtotal = (SELECT SUM(detv_TOTAL) AS vent_subtotal FROM td_venta_detalle WHERE vent_id=i_vent_id AND est=1),
		vent_igv = (SELECT SUM(detv_TOTAL) AS vent_subtotal FROM td_venta_detalle WHERE vent_id=i_vent_id AND est=1) * 0.18,
		vent_total = (SELECT SUM(detv_TOTAL) AS vent_subtotal FROM td_venta_detalle WHERE vent_id=i_vent_id AND est=1) +((SELECT SUM(detv_total) AS vent_subtotal FROM td_venta_detalle WHERE vent_id=i_vent_id AND est=1) * 0.18)
	WHERE
		vent_id = i_vent_id;
        
        SELECT 
		vent_subtotal,
		vent_igv,
		vent_total 
	FROM 
		tm_venta
	WHERE
		vent_id = i_vent_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_u_venta_02`(
IN i_vent_id INT)
BEGIN  
 DECLARE NOT_FOUND INT DEFAULT 0;
	DECLARE v_id_registro INT;
	DECLARE v_prod_id INT;
	DECLARE v_cant INT;
    
    DECLARE CUR CURSOR FOR SELECT detv_id FROM td_venta_detalle WHERE vent_id=i_vent_id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET NOT_FOUND = 1;
	OPEN CUR;
	FETCH NEXT FROM CUR INTO v_id_registro;
	WHILE NOT_FOUND=0
		DO
			SELECT prod_id INTO v_prod_id FROM td_venta_detalle WHERE detv_id = v_id_registro;
			
			SELECT detv_cant INTO v_cant FROM td_venta_detalle WHERE detv_id = v_id_registro;

			UPDATE tm_producto
			SET
				prod_stock = prod_stock + v_cant
			WHERE
				prod_id = v_prod_id;

			FETCH NEXT FROM CUR INTO v_id_registro;
		END WHILE;
	CLOSE CUR;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_u_venta_03`(
IN i_vent_id INT,  
IN i_pag_id INT,  
IN i_cli_id INT,  
IN i_cli_ruc VARCHAR(20),  
IN i_cli_direcc VARCHAR(150),  
IN i_cli_correo VARCHAR(150),  
IN i_vent_coment VARCHAR(250),  
IN i_mon_id INT,
IN i_doc_id INT)
BEGIN  
DECLARE v_id_registro INT;
DECLARE v_prod_id INT;
DECLARE v_cant INT;
DECLARE NOT_FOUND INT DEFAULT 0;  

DECLARE CUR CURSOR FOR SELECT detv_id FROM td_venta_detalle WHERE vent_id=i_vent_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET NOT_FOUND = 1;  

 UPDATE tm_venta  
 SET  
  pag_id = i_pag_id,  
  cli_id = i_cli_id,  
  cli_ruc = i_cli_ruc,  
  cli_direcc = i_cli_direcc,  
  cli_correo = i_cli_correo,  
  vent_coment = i_vent_coment,  
  mon_id = i_mon_id,  
  doc_id = i_doc_id,
  fech_crea = NOW(),  
  est = 1  
 WHERE  
  vent_id = i_vent_id;
  
OPEN CUR;  
 FETCH NEXT FROM CUR INTO v_id_registro;  
 WHILE NOT_FOUND=0  
  DO
			SELECT prod_id INTO v_prod_id FROM td_venta_detalle WHERE detv_id = v_id_registro;
			
			SELECT detv_cant INTO v_cant FROM td_venta_detalle WHERE detv_id = v_id_registro;

			UPDATE tm_producto
			SET
				prod_stock = prod_stock - v_cant
			WHERE
				prod_id = v_prod_id;

			FETCH NEXT FROM CUR INTO v_id_registro;
		END WHILE;
	CLOSE CUR;
END //
DELIMITER ;