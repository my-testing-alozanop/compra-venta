use compra_venta;

SELECT * FROM tm_sucursal;

SELECT * FROM tm_categoria;

UPDATE tm_categoria
SET
fech_crea = NOW();

SELECT * FROM tm_moneda;

UPDATE tm_moneda
SET
fech_crea = NOW();

SELECT * FROM tm_unidad;

UPDATE tm_unidad
SET
fech_crea = NOW();

SELECT * FROM tm_cliente;

UPDATE tm_cliente
SET
fech_crea = NOW();

SELECT * FROM tm_proveedor;

UPDATE tm_proveedor
SET
fech_crea = NOW();

SELECT * FROM tm_producto;

UPDATE tm_producto
SET
fech_crea = NOW();

SELECT * FROM tm_rol;

UPDATE tm_rol
SET
fech_crea = NOW();

SELECT * FROM tm_usuario;

SELECT * FROM tm_menu;

UPDATE tm_menu
SET
fech_crea = NOW();

SELECT * FROM td_menu;

UPDATE td_menu
SET
fech_crea = NOW();

UPDATE tm_menu
SET
fech_crea = NOW()
WHERE
fech_crea is null;

SELECT * FROM tm_pago;

UPDATE tm_pago
SET
fech_crea = NOW();

SELECT * FROM tm_compra;

SELECT * FROM td_compra_detalle;

SELECT * FROM tm_empresa;

SELECT * FROM tm_venta;

SELECT * FROM tm_usuario;