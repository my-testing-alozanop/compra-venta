DELIMITER //
CREATE PROCEDURE `sp_l_menu_01`(  
IN i_rol_id INT)
BEGIN  
 SELECT        
	td_menu.mend_id, 
	td_menu.men_id, 
	td_menu.rol_id, 
	td_menu.mend_permi, 
	td_menu.fech_crea, 
	td_menu.est, 
	tm_menu.men_nom, 
	tm_menu.men_ruta, 
	tm_menu.men_identi,
	tm_menu.men_grupo
	FROM            
	td_menu INNER JOIN
	tm_menu ON td_menu.men_id = tm_menu.men_id
	WHERE 
	td_menu.rol_id = i_rol_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_l_menu_03`(  
IN i_usu_id INT,
IN i_men_identi VARCHAR(100))
BEGIN  
 SELECT        
	td_menu.mend_id, 
	td_menu.men_id, 
	td_menu.rol_id, 
	td_menu.mend_permi, 
	td_menu.fech_crea, 
	td_menu.est, 
	tm_menu.men_nom, 
	tm_menu.men_ruta, 
	tm_menu.men_identi,
	tm_menu.men_grupo,
    tm_usuario.usu_id, 
	tm_rol.rol_nom
	FROM            
	td_menu INNER JOIN
	tm_menu ON td_menu.men_id = tm_menu.men_id INNER JOIN
	tm_rol ON td_menu.rol_id = tm_rol.rol_id INNER JOIN
	tm_usuario ON tm_rol.rol_id = tm_usuario.rol_id
 WHERE   
	tm_usuario.usu_id=1  
	AND mend_permi ='Si'
	AND tm_menu.men_identi = 'mntsucursal';
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_u_menu_01`(  
IN i_mend_id INT)
BEGIN  
 UPDATE td_menu
	SET
		mend_permi = 'Si'
	WHERE
		mend_id = i_mend_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_u_menu_02`(  
IN i_mend_id INT)
BEGIN  
 UPDATE td_menu
	SET
		mend_permi = 'No'
	WHERE
		mend_id = i_mend_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE `sp_i_menu_02`(  
IN i_rol_id INT)
BEGIN  
 IF (SELECT COUNT(*) FROM td_menu WHERE rol_id=i_rol_id)=0
	THEN
		INSERT INTO td_menu
		(men_id,rol_id,mend_permi,fech_crea,est)
		(SELECT men_id,i_rol_id,'No',NOW(),1 FROM tm_menu WHERE est=1);
	ELSE
		INSERT INTO td_menu
		(men_id,rol_id,mend_permi,fech_crea,est)
		(SELECT men_id,i_rol_id,'No',NOW(),1 FROM tm_menu WHERE est=1 AND men_id NOT IN (SELECT men_id FROM td_menu WHERE rol_id=i_rol_id));
	END IF;
END //
DELIMITER ;