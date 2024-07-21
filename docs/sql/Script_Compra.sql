DELIMITER //
CREATE PROCEDURE `sp_l_compra_01`(
IN i_compr_id INT)
BEGIN  
 SELECT          
 td_compra_detalle.detc_id,   
 tm_categoria.cat_nom,   
 tm_producto.prod_nom,
 tm_producto.prod_img,
 tm_unidad.und_nom,   
 td_compra_detalle.prod_pcompra,  
 td_compra_detalle.detc_cant,   
 td_compra_detalle.detc_total,   
 td_compra_detalle.compr_id,   
 td_compra_detalle.prod_id  
 FROM              
 td_compra_detalle INNER JOIN  
 tm_producto ON td_compra_detalle.prod_id = tm_producto.prod_id INNER JOIN  
 tm_categoria ON tm_producto.cat_id = tm_categoria.cat_id INNER JOIN  
 tm_unidad ON tm_producto.und_id = tm_unidad.und_id  
 WHERE  
 td_compra_detalle.compr_id = i_compr_id  
 AND td_compra_detalle.est=1;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_l_compra_02`(
IN i_compr_id INT)
BEGIN  
 SELECT        
tm_compra.compr_id, 
tm_compra.suc_id, 
tm_compra.pag_id, 
tm_compra.prov_id, 
tm_compra.prov_ruc, 
tm_compra.prov_direcc, 
tm_compra.prov_correo, 
tm_compra.compr_subtotal, 
tm_compra.compr_igv, 
tm_compra.compr_total, 
tm_compra.compr_coment, 
tm_compra.usu_id, 
tm_compra.mon_id, 
tm_compra.fech_crea, 
tm_compra.est, 
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
tm_proveedor.prov_nom
FROM            
tm_compra INNER JOIN
tm_sucursal ON tm_compra.suc_id = tm_sucursal.suc_id INNER JOIN
tm_empresa ON tm_sucursal.emp_id = tm_empresa.emp_id INNER JOIN
tm_compania ON tm_empresa.com_id = tm_compania.com_id INNER JOIN
tm_usuario ON tm_compra.usu_id = tm_usuario.usu_id INNER JOIN
tm_rol ON tm_usuario.rol_id = tm_rol.rol_id INNER JOIN
tm_pago ON tm_compra.pag_id = tm_pago.pag_id INNER JOIN
tm_moneda ON tm_compra.mon_id = tm_moneda.mon_id INNER JOIN
tm_proveedor ON tm_compra.prov_id = tm_proveedor.prov_id
WHERE  
tm_compra.compr_id = i_compr_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_l_compra_03`(
IN i_suc_id INT)
BEGIN  
 SELECT        
tm_compra.compr_id, 
tm_compra.suc_id, 
tm_compra.pag_id, 
tm_compra.prov_id, 
tm_compra.prov_ruc, 
tm_compra.prov_direcc, 
tm_compra.prov_correo, 
tm_compra.compr_subtotal, 
tm_compra.compr_igv, 
tm_compra.compr_total, 
tm_compra.compr_coment, 
tm_compra.usu_id, 
tm_compra.mon_id, 
tm_compra.fech_crea, 
tm_compra.est, 
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
tm_proveedor.prov_nom,
tm_documento.doc_nom
FROM            
tm_compra INNER JOIN
tm_sucursal ON tm_compra.suc_id = tm_sucursal.suc_id INNER JOIN
tm_empresa ON tm_sucursal.emp_id = tm_empresa.emp_id INNER JOIN
tm_compania ON tm_empresa.com_id = tm_compania.com_id INNER JOIN
tm_usuario ON tm_compra.usu_id = tm_usuario.usu_id INNER JOIN
tm_rol ON tm_usuario.rol_id = tm_rol.rol_id INNER JOIN
tm_pago ON tm_compra.pag_id = tm_pago.pag_id INNER JOIN
tm_moneda ON tm_compra.mon_id = tm_moneda.mon_id INNER JOIN
tm_proveedor ON tm_compra.prov_id = tm_proveedor.prov_id INNER JOIN
tm_documento ON tm_compra.doc_id = tm_documento.doc_id
WHERE  
tm_compra.est=1    
 AND tm_compra.suc_id = i_suc_id; 
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_i_compra_01`(
IN i_suc_id INT,
IN i_usu_id INT)
BEGIN  
 INSERT INTO tm_compra 
	(suc_id,usu_id,est)
	VALUES
	(i_suc_id,i_usu_id,2);
    
    SELECT compr_id FROM tm_compra WHERE compr_id=LAST_INSERT_ID();
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_i_compra_02`(
IN i_compr_id INT,
IN i_prod_id INT,
IN i_prod_pcompra DECIMAL(18,2),
IN i_detc_cant INT)
BEGIN  
 INSERT td_compra_detalle
	(compr_id,prod_id,prod_pcompra,detc_cant,detc_total,fech_crea,est)
	VALUES
	(i_compr_id,i_prod_id,i_prod_pcompra,i_detc_cant,i_prod_pcompra * i_detc_cant,NOW(),1);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_d_compra_01`(
IN i_detc_id INT)
BEGIN  
 UPDATE td_compra_detalle
	SET
		est=0
	WHERE
		detc_id = i_detc_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_u_compra_01`(
IN i_compr_id INT)
BEGIN  
 UPDATE tm_compra
	SET
		compr_subtotal = (SELECT SUM(detc_TOTAL) AS compr_subtotal FROM td_compra_detalle WHERE compr_id=i_compr_id AND est=1),
		compr_igv = (SELECT SUM(detc_TOTAL) AS compr_subtotal FROM td_compra_detalle WHERE compr_id=i_compr_id AND est=1) * 0.18,
		compr_total = (SELECT SUM(detc_TOTAL) AS compr_subtotal FROM td_compra_detalle WHERE compr_id=i_compr_id AND est=1) +((SELECT SUM(detc_total) AS compr_subtotal FROM td_compra_detalle WHERE compr_id=i_compr_id AND est=1) * 0.18)
	WHERE
		compr_id = i_compr_id;
        
        SELECT 
		compr_subtotal,
		compr_igv,
		compr_total 
	FROM 
		tm_compra
	WHERE
		compr_id = i_compr_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_u_compra_02`(
IN i_compr_id INT)
BEGIN  
 DECLARE NOT_FOUND INT DEFAULT 0;
	DECLARE v_id_registro INT;
	DECLARE v_prod_id INT;
	DECLARE v_cant INT;
    
    DECLARE CUR CURSOR FOR SELECT detc_id FROM td_compra_detalle WHERE compr_id=i_compr_id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET NOT_FOUND = 1;
	OPEN CUR;
	FETCH NEXT FROM CUR INTO v_id_registro;
	WHILE NOT_FOUND=0
		DO
			SELECT prod_id INTO v_prod_id FROM td_compra_detalle WHERE detc_id = v_id_registro;
			
			SELECT detc_cant INTO v_cant FROM td_compra_detalle WHERE detc_id = v_id_registro;

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
CREATE PROCEDURE `sp_u_compra_03`(
IN i_compr_id INT,  
IN i_pag_id INT,  
IN i_prov_id INT,  
IN i_prov_ruc VARCHAR(20),  
IN i_prov_direcc VARCHAR(150),  
IN i_prov_correo VARCHAR(150),  
IN i_compr_coment VARCHAR(250),  
IN i_mon_id INT,
IN i_doc_id INT)
BEGIN  
DECLARE v_id_registro INT;
DECLARE v_prod_id INT;
DECLARE v_cant INT;
DECLARE NOT_FOUND INT DEFAULT 0;  

DECLARE CUR CURSOR FOR SELECT detc_id FROM td_compra_detalle WHERE compr_id=i_compr_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET NOT_FOUND = 1;  

 UPDATE tm_compra  
 SET  
  pag_id = i_pag_id,  
  prov_id = i_prov_id,  
  prov_ruc = i_prov_ruc,  
  prov_direcc = i_prov_direcc,  
  prov_correo = i_prov_correo,  
  compr_coment = i_compr_coment,  
  mon_id = i_mon_id,  
  doc_id = i_doc_id,
  fech_crea = NOW(),  
  est = 1  
 WHERE  
  compr_id = i_compr_id;
  
OPEN CUR;  
 FETCH NEXT FROM CUR INTO v_id_registro;  
 WHILE NOT_FOUND=0  
  DO
			SELECT prod_id INTO v_prod_id FROM td_compra_detalle WHERE detc_id = v_id_registro;
			
			SELECT detc_cant INTO v_cant FROM td_compra_detalle WHERE detc_id = v_id_registro;

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