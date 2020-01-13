-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para supermercado
DROP DATABASE IF EXISTS `supermercado`;
CREATE DATABASE IF NOT EXISTS `supermercado` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `supermercado`;

-- Volcando estructura para tabla supermercado.categoria
DROP TABLE IF EXISTS `categoria`;
CREATE TABLE IF NOT EXISTS `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL DEFAULT '0',
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_baja` timestamp NULL DEFAULT NULL,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermercado.categoria: ~9 rows (aproximadamente)
DELETE FROM `categoria`;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` (`id`, `nombre`, `fecha_alta`, `fecha_baja`, `fecha_modificacion`) VALUES
	(1, 'mock1578903973768', '2020-01-13 12:55:48', NULL, NULL),
	(2, 'musica', '2020-01-13 12:55:48', NULL, NULL),
	(3, 'electrodomesticos', '2020-01-13 12:55:48', NULL, NULL),
	(4, 'nueva', '2020-01-13 12:55:48', NULL, NULL),
	(5, 'nueva2', '2020-01-13 12:55:48', NULL, NULL),
	(6, 'otra', '2020-01-13 12:55:48', '2020-01-13 13:19:06', NULL),
	(7, 'otra333', '2020-01-13 12:55:48', NULL, NULL),
	(8, 'fruteria', '2020-01-13 12:55:48', NULL, NULL),
	(14, '0categoria', '2020-01-13 12:55:48', NULL, NULL);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;

-- Volcando estructura para tabla supermercado.historico
DROP TABLE IF EXISTS `historico`;
CREATE TABLE IF NOT EXISTS `historico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `precio` float NOT NULL DEFAULT '0',
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_producto` (`id_producto`),
  CONSTRAINT `FK_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermercado.historico: ~13 rows (aproximadamente)
DELETE FROM `historico`;
/*!40000 ALTER TABLE `historico` DISABLE KEYS */;
INSERT INTO `historico` (`id`, `precio`, `fecha`, `id_producto`) VALUES
	(1, 12, '2020-01-10 08:21:25', 8),
	(2, 12, '2020-01-10 08:21:34', 8),
	(3, 56, '2020-01-10 08:21:40', 8),
	(4, 100, '2020-01-10 08:21:52', 8),
	(5, 400, '2020-01-10 08:22:15', 8),
	(6, 400, '2020-01-10 08:22:23', 8),
	(7, 400, '2020-01-10 08:22:25', 8),
	(8, 400, '2020-01-10 08:24:02', 8),
	(9, 0, '2020-01-10 08:24:06', 8),
	(10, 1, '2020-01-10 08:24:12', 8),
	(11, 2, '2020-01-10 12:18:09', 8),
	(12, 0.2, '2020-01-10 12:29:14', 8),
	(13, 12, '2020-01-10 12:53:06', 37),
	(14, 0, '2020-01-10 13:57:49', 8);
/*!40000 ALTER TABLE `historico` ENABLE KEYS */;

-- Volcando estructura para tabla supermercado.producto
DROP TABLE IF EXISTS `producto`;
CREATE TABLE IF NOT EXISTS `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `precio` float NOT NULL DEFAULT '0',
  `descuento` int(11) DEFAULT '0' COMMENT 'porcentaje descuento de 0 a 100',
  `fecha_modificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_baja` timestamp NULL DEFAULT NULL,
  `imagen` varchar(100) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FK_usuario` (`id_usuario`),
  KEY `FK_categoria` (`id_categoria`),
  CONSTRAINT `FK_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`),
  CONSTRAINT `FK_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermercado.producto: ~13 rows (aproximadamente)
DELETE FROM `producto`;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` (`id`, `nombre`, `id_categoria`, `id_usuario`, `precio`, `descuento`, `fecha_modificacion`, `fecha_alta`, `fecha_baja`, `imagen`, `descripcion`) VALUES
	(8, 'uni', 1, 1, 123, 11, '2020-01-13 10:29:09', '2020-01-10 11:35:36', '2020-01-13 10:29:09', 'https://image.flaticon.com/icons/png/512/372/372627.png', 'uni'),
	(12, 'hsdfhjkdfhjksdsabor a unicornio', 2, 1, 0, 0, '2020-01-10 12:13:40', '2020-01-10 11:35:36', '2020-01-10 12:13:40', 'https://www.ombushop.com/blog/wp-content/uploads/2015/06/new-product-seal_23-2147503128.jpg', 'un producto sin descripcion'),
	(21, 'nuevo33334', 14, 4, 0, 0, '2020-01-13 10:50:52', '2020-01-10 11:35:36', NULL, 'https://www.ombushop.com/blog/wp-content/uploads/2015/06/new-product-seal_23-2147503128.jpg', 'un producto sin descripcion'),
	(22, 'morcilla', 1, 1, 0, 2, '2020-01-10 09:48:29', '2020-01-10 11:35:36', NULL, 'https://www.ombushop.com/blog/wp-content/uploads/2015/06/new-product-seal_23-2147503128.jpg', 'un producto sin descripcion'),
	(29, 'morcilla de burgos', 1, 1, 0, 0, '2020-01-10 09:48:29', '2020-01-10 11:35:36', NULL, 'https://www.ombushop.com/blog/wp-content/uploads/2015/06/new-product-seal_23-2147503128.jpg', 'un producto sin descripcion'),
	(30, 'queso de burgos', 8, 1, 0, 50, '2020-01-13 08:49:17', '2020-01-10 11:35:36', NULL, 'https://www.ombushop.com/blog/wp-content/uploads/2015/06/new-product-seal_23-2147503128.jpg', 'un producto sin descripcion'),
	(31, 'queso manchego', 3, 1, 0, 100, '2020-01-13 08:49:42', '2020-01-10 11:35:36', NULL, 'https://www.ombushop.com/blog/wp-content/uploads/2015/06/new-product-seal_23-2147503128.jpg', 'un producto sin descripcion'),
	(36, 'morcillaeeeeee3333', 3, 1, 0, 0, '2020-01-13 08:49:15', '2020-01-10 11:35:36', NULL, 'https://www.ombushop.com/blog/wp-content/uploads/2015/06/new-product-seal_23-2147503128.jpg', 'un producto sin descripcion'),
	(37, 'not aa', 14, 4, 0, 12, '2020-01-13 08:49:13', '2020-01-10 12:00:30', '2020-01-10 13:03:51', 'https://image.flaticon.com/icons/png/512/372/372627.png', ''),
	(38, 'procoikopk', 1, 4, 0, 1, '2020-01-10 13:03:29', '2020-01-10 12:41:28', NULL, 'https://image.flaticon.com/icons/png/512/372/372627.png', ''),
	(48, 'nuevo producto', 7, 7, 12, 12, '2020-01-13 10:50:41', '2020-01-13 10:50:30', '2020-01-13 10:50:41', 'https://image.flaticon.com/icons/png/512/372/372627.png', 'ddadsasd'),
	(49, 'cdvdxv', 14, 7, 0, 0, '2020-01-13 11:24:59', '2020-01-13 11:24:59', NULL, 'https://image.flaticon.com/icons/png/512/372/372627.png', ''),
	(51, 'sasasa', 14, 7, 0, 0, '2020-01-13 11:27:08', '2020-01-13 11:26:49', '2020-01-13 11:27:08', 'https://image.flaticon.com/icons/png/512/372/372627.png', '');
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;

-- Volcando estructura para tabla supermercado.rol
DROP TABLE IF EXISTS `rol`;
CREATE TABLE IF NOT EXISTS `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '1: Usuario normal   2: Administrador',
  `nombre` varchar(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermercado.rol: ~2 rows (aproximadamente)
DELETE FROM `rol`;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` (`id`, `nombre`) VALUES
	(2, 'administrador'),
	(1, 'usuario');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;

-- Volcando estructura para tabla supermercado.usuario
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `contrasenia` varchar(50) NOT NULL DEFAULT '0',
  `id_rol` int(11) DEFAULT '0',
  `fecha_baja` timestamp NULL DEFAULT NULL,
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FK_rol` (`id_rol`),
  CONSTRAINT `FK_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermercado.usuario: ~4 rows (aproximadamente)
DELETE FROM `usuario`;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id`, `nombre`, `contrasenia`, `id_rol`, `fecha_baja`, `fecha_alta`, `fecha_modificacion`) VALUES
	(1, 'aa', 'aa', 2, NULL, '2020-01-10 13:45:04', '2020-01-10 13:45:04'),
	(4, 'dd', 'dd', 1, NULL, '2020-01-10 13:45:04', '2020-01-10 13:45:04'),
	(7, 'ssess', 'sssss', 1, NULL, '2020-01-10 13:50:41', '2020-01-10 13:56:42'),
	(10, 'usuarioBorraado', 'usuarioBorrado', 1, '2020-01-13 13:28:14', '2020-01-13 12:58:42', '2020-01-13 13:28:14');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

-- Volcando estructura para procedimiento supermercado.pa_categoria_delete
DROP PROCEDURE IF EXISTS `pa_categoria_delete`;
DELIMITER //
CREATE PROCEDURE `pa_categoria_delete`(
	IN `pId` INT
)
BEGIN
DECLARE numero_productos INT;
SET numero_productos = (SELECT COUNT(*) FROM producto p WHERE p.id_categoria = pId);

IF numero_productos = 0 THEN
	UPDATE categoria c SET c.fecha_baja = CURRENT_TIMESTAMP() WHERE c.id = pId;
END IF;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_categoria_getall
DROP PROCEDURE IF EXISTS `pa_categoria_getall`;
DELIMITER //
CREATE PROCEDURE `pa_categoria_getall`()
BEGIN

   	-- nuestro primer PA
   	/*  tiene pinta que tambien comentarios de bloque */
    SELECT id, nombre FROM categoria c WHERE c.fecha_baja IS NULL ORDER BY nombre ASC LIMIT 500;

    -- desde java executeQuery
    -- retorna ResultSet

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_categoria_get_by_id
DROP PROCEDURE IF EXISTS `pa_categoria_get_by_id`;
DELIMITER //
CREATE PROCEDURE `pa_categoria_get_by_id`(
	IN `pId` INT
)
BEGIN

	SELECT id, nombre FROM categoria c WHERE c.id = pId AND c.fecha_baja IS NULL ;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_categoria_insert
DROP PROCEDURE IF EXISTS `pa_categoria_insert`;
DELIMITER //
CREATE PROCEDURE `pa_categoria_insert`(
	IN `p_nombre` VARCHAR(100),
	OUT `p_id` INT
)
BEGIN

	-- crear nuevo registro
	INSERT INTO categoria ( nombre ) VALUES ( p_nombre );

	-- obtener el ID generado y SETearlo al parametro salida p_id
	SET p_id = LAST_INSERT_ID();


END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_categoria_update
DROP PROCEDURE IF EXISTS `pa_categoria_update`;
DELIMITER //
CREATE PROCEDURE `pa_categoria_update`(
	IN `pId` INT,
	IN `pNombre` VARCHAR(100)
)
BEGIN


	UPDATE categoria c SET c.nombre = pNombre AND c.fecha_modificacion = CURRENT_TIMESTAMP() WHERE id = pId;

	-- desde java executeUpdate, retorna affectedRows int

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_productos_busqueda
DROP PROCEDURE IF EXISTS `pa_productos_busqueda`;
DELIMITER //
CREATE PROCEDURE `pa_productos_busqueda`(
	IN `p_id_categoria` INT,
	IN `p_nombre` VARCHAR(100)
)
BEGIN
SET p_nombre = TRIM(p_nombre);
IF p_id_categoria > 0 AND p_nombre <> '' THEN
	SELECT
	 p.id 'id_producto',p.imagen 'imagen_producto', p.precio 'precio_producto', p.descuento 'descuento_producto', p.descripcion 'descripcion_producto', p.nombre 'nombre_producto',
	 u.id 'id_usuario', u.nombre 'nombre_usuario',
	 c.id 'id_categoria', c.nombre 'nombre_categoria'
	 FROM producto p, usuario u, categoria c
	 WHERE
	 p.id_categoria = c.id AND p.id_usuario = u.id AND
	 p.id_categoria = p_id_categoria AND p.nombre LIKE CONCAT('%', p_nombre ,'%') AND p.fecha_baja IS NULL;
ELSEIF p_id_categoria > 0 AND p_nombre = '' THEN
	SELECT
	 p.id 'id_producto',p.imagen 'imagen_producto', p.precio 'precio_producto', p.descuento 'descuento_producto', p.descripcion 'descripcion_producto', p.nombre 'nombre_producto',
	 u.id 'id_usuario', u.nombre 'nombre_usuario',
	 c.id 'id_categoria', c.nombre 'nombre_categoria'
	 FROM producto p, usuario u, categoria c
	 WHERE
	 p.id_categoria = c.id AND p.id_usuario = u.id AND
	 p.id_categoria = p_id_categoria AND p.fecha_baja IS NULL;
ELSEIF p_id_categoria <= 0 AND p_nombre <> '' THEN
	SELECT
	 p.id 'id_producto',p.imagen 'imagen_producto', p.precio 'precio_producto', p.descuento 'descuento_producto', p.descripcion 'descripcion_producto', p.nombre 'nombre_producto',
	 u.id 'id_usuario', u.nombre 'nombre_usuario',
	 c.id 'id_categoria', c.nombre 'nombre_categoria'
	 FROM producto p, usuario u, categoria c
	 WHERE
	 p.id_categoria = c.id AND p.id_usuario = u.id AND
	 p.nombre LIKE CONCAT('%', p_nombre ,'%') AND p.fecha_baja IS NULL;
ELSE
	CALL pa_producto_getall();
END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_producto_delete_logico
DROP PROCEDURE IF EXISTS `pa_producto_delete_logico`;
DELIMITER //
CREATE PROCEDURE `pa_producto_delete_logico`(
	IN `p_Id` INT
)
BEGIN

UPDATE producto SET fecha_baja = CURRENT_TIMESTAMP() WHERE  id = p_Id;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_producto_delete_logico_byuser
DROP PROCEDURE IF EXISTS `pa_producto_delete_logico_byuser`;
DELIMITER //
CREATE PROCEDURE `pa_producto_delete_logico_byuser`(
	IN `p_pId` INT,
	IN `p_uId` INT
)
BEGIN

UPDATE producto SET fecha_baja = CURRENT_TIMESTAMP() WHERE  id = p_pId AND id_usuario = p_uId;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_producto_getall
DROP PROCEDURE IF EXISTS `pa_producto_getall`;
DELIMITER //
CREATE PROCEDURE `pa_producto_getall`()
BEGIN
	SELECT p.id 'id_producto',p.imagen 'imagen_producto', p.precio 'precio_producto', p.descuento 'descuento_producto', p.descripcion 'descripcion_producto', p.nombre 'nombre_producto',
	 u.id 'id_usuario', u.nombre 'nombre_usuario',
	 c.id 'id_categoria', c.nombre 'nombre_categoria'
	FROM producto p, usuario u, categoria c
	WHERE p.id_categoria = c.id AND p.id_usuario = u.id AND p.fecha_baja IS NULL
	ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_producto_getall_byuser
DROP PROCEDURE IF EXISTS `pa_producto_getall_byuser`;
DELIMITER //
CREATE PROCEDURE `pa_producto_getall_byuser`(
	IN `p_id` INT
)
BEGIN
	SELECT p.id 'id_producto',p.imagen 'imagen_producto', p.precio 'precio_producto', p.descuento 'descuento_producto', p.descripcion 'descripcion_producto', p.nombre 'nombre_producto',
		u.id 'id_usuario', u.nombre 'nombre_usuario',
		c.id 'id_categoria', c.nombre 'nombre_categoria'
	FROM producto p, usuario u , categoria c
	WHERE p.id_usuario = u.id AND u.id = p_id AND p.id_categoria = c.id AND p.fecha_baja IS NULL
	ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_producto_get_byid
DROP PROCEDURE IF EXISTS `pa_producto_get_byid`;
DELIMITER //
CREATE PROCEDURE `pa_producto_get_byid`(
	IN `pId` INT
)
BEGIN


SELECT	p.id 'id_producto',
			p.imagen 'imagen_producto',
			p.precio 'precio_producto',
			p.descuento 'descuento_producto' ,
			p.descripcion 'descripcion_producto',
			p.nombre 'nombre_producto',
			u.id 'id_usuario',
			u.nombre 'nombre_usuario',
			c.id 'id_categoria',
			c.nombre 'nombre_categoria'
			FROM producto p, usuario u , categoria c
			WHERE p.id_usuario = u.id AND p.id = pId AND p.id_categoria = c.id AND p.fecha_baja IS NULL
			ORDER BY p.id DESC LIMIT 500;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_producto_get_byid_byuser
DROP PROCEDURE IF EXISTS `pa_producto_get_byid_byuser`;
DELIMITER //
CREATE PROCEDURE `pa_producto_get_byid_byuser`(
	IN `p_id_producto` INT,
	IN `p_id_usuario` INT
)
BEGIN
SELECT p.id 'id_producto',p.imagen 'imagen_producto', p.precio 'precio_producto', p.descuento 'descuento_producto', p.descripcion 'descripcion_producto', p.nombre 'nombre_producto',
u.id 'id_usuario', u.nombre 'nombre_usuario',
c.id 'id_categoria', c.nombre 'nombre_categoria'
FROM producto p, usuario u, categoria c
WHERE p.id_usuario = u.id AND p.id= p_id_producto AND u.id = p_id_usuario AND p.id_categoria = c.id AND p.fecha_baja IS NULL
ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_producto_insert
DROP PROCEDURE IF EXISTS `pa_producto_insert`;
DELIMITER //
CREATE PROCEDURE `pa_producto_insert`(
	IN `p_nombre` VARCHAR(100),
	IN `p_id_categoria` INT,
	IN `p_id_usuario` INT,
	IN `p_precio` FLOAT,
	IN `p_descuento` INT,
	IN `p_imagen` VARCHAR(100),
	IN `p_descripcion` VARCHAR(100),
	OUT `po_id` INT
)
BEGIN

INSERT INTO `supermercado`.`producto` (`nombre`, `id_categoria`, `id_usuario`, `precio`, `descuento`, `imagen`, `descripcion`) VALUES (p_nombre, p_id_categoria, p_id_usuario, p_precio, p_descuento, p_imagen, p_descripcion);

SET po_id = LAST_INSERT_ID();
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_producto_update
DROP PROCEDURE IF EXISTS `pa_producto_update`;
DELIMITER //
CREATE PROCEDURE `pa_producto_update`(
	IN `p_id` INT,
	IN `p_nombre` VARCHAR(50),
	IN `p_id_categoria` INT,
	IN `p_id_usuario` INT,
	IN `p_precio` FLOAT,
	IN `p_descuento` INT,
	IN `p_imagen` VARCHAR(100),
	IN `p_descripcion` VARCHAR(100)
)
BEGIN
	UPDATE producto p SET p.nombre=p_nombre, id_categoria = p_id_categoria, id_usuario = p_id_usuario, precio = p_precio, descuento = p_descuento, imagen = p_imagen , descripcion = p_descripcion  WHERE  id= p_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_producto_update_byuser
DROP PROCEDURE IF EXISTS `pa_producto_update_byuser`;
DELIMITER //
CREATE PROCEDURE `pa_producto_update_byuser`(
	IN `p_id` INT,
	IN `p_id_usuario` INT,
	IN `p_nombre` VARCHAR(50),
	IN `p_id_categoria` INT,
	IN `p_id_usuario_propietario` INT,
	IN `p_precio` FLOAT,
	IN `p_descuento` INT,
	IN `p_imagen` VARCHAR(100),
	IN `p_descripcion` VARCHAR(100)
)
BEGIN
	UPDATE producto p SET p.nombre=p_nombre, id_categoria = p_id_categoria, id_usuario = p_id_usuario_propietario, precio = p_precio, descuento = p_descuento, imagen = p_imagen , descripcion = p_descripcion
	WHERE  id= p_id AND id_usuario = p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_user_exist
DROP PROCEDURE IF EXISTS `pa_user_exist`;
DELIMITER //
CREATE PROCEDURE `pa_user_exist`(
	IN `p_nombre_usuario` VARCHAR(50),
	IN `p_contrasenia` VARCHAR(50)
)
BEGIN

SELECT 	u.id 'id_usuario',
			u.nombre 'nombre_usuario',
			contrasenia,
			r.id 'id_rol',
			r.nombre 'nombre_rol'
			FROM usuario u, rol r
			WHERE u.id_rol = r.id AND u.nombre = p_nombre_usuario AND contrasenia = p_contrasenia ;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_usuario_delete_logico
DROP PROCEDURE IF EXISTS `pa_usuario_delete_logico`;
DELIMITER //
CREATE PROCEDURE `pa_usuario_delete_logico`(
	IN `p_uId` INT
)
BEGIN

UPDATE usuario SET fecha_baja = CURRENT_TIMESTAMP() WHERE  id = p_uId;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_usuario_getall
DROP PROCEDURE IF EXISTS `pa_usuario_getall`;
DELIMITER //
CREATE PROCEDURE `pa_usuario_getall`()
BEGIN

SELECT 	u.id 'id_usuario',
			u.nombre 'nombre_usuario',
			contrasenia, r.id 'id_rol',
			r.nombre 'nombre_rol'
FROM usuario u, rol r
WHERE u.id_rol = r.id
ORDER BY u.id DESC LIMIT 500;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_usuario_get_byid
DROP PROCEDURE IF EXISTS `pa_usuario_get_byid`;
DELIMITER //
CREATE PROCEDURE `pa_usuario_get_byid`(
	IN `p_uId` INT
)
BEGIN

SELECT 	u.id 'id_usario',
			u.nombre 'nombre_usuario' ,
			u.contrasenia 'contrasenia_usuario' ,
			r.id 'id_rol',
			r.nombre 'nombre_rol'

FROM usuario u , rol r
WHERE u.id_rol = r.id  AND u.id = p_uId;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_usuario_insert
DROP PROCEDURE IF EXISTS `pa_usuario_insert`;
DELIMITER //
CREATE PROCEDURE `pa_usuario_insert`(
	IN `p_nombre_usuario` VARCHAR(50),
	IN `p_contrasenia` VARCHAR(50),
	IN `p_id_rol` INT,
	OUT `po_id` INT
)
BEGIN

INSERT INTO usuario (nombre , contrasenia , id_rol) VALUES ( p_nombre_usuario  ,  p_contrasenia , p_id_rol );

SET po_id = LAST_INSERT_ID();

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado.pa_usuario_update
DROP PROCEDURE IF EXISTS `pa_usuario_update`;
DELIMITER //
CREATE PROCEDURE `pa_usuario_update`(
	IN `p_nombre` VARCHAR(50),
	IN `p_contrasenia` VARCHAR(50),
	IN `p_rId` INT,
	IN `p_uId` INT
)
BEGIN

UPDATE usuario SET nombre = p_nombre , contrasenia = p_contrasenia , id_rol = p_rId WHERE  id = p_uId;

END//
DELIMITER ;

-- Volcando estructura para función supermercado.HELLO_WORLD
DROP FUNCTION IF EXISTS `HELLO_WORLD`;
DELIMITER //
CREATE FUNCTION `HELLO_WORLD`() RETURNS varchar(100) CHARSET utf8
BEGIN

	RETURN "hola mundo";

END//
DELIMITER ;

-- Volcando estructura para función supermercado.HELLO_WORLD2
DROP FUNCTION IF EXISTS `HELLO_WORLD2`;
DELIMITER //
CREATE FUNCTION `HELLO_WORLD2`(
	`pNombre` VARCHAR(50)
) RETURNS varchar(100) CHARSET utf8
BEGIN

	DECLARE nombre VARCHAR(100) DEFAULT 'anonimo';

   IF( TRIM(pNombre) != '' ) THEN
   	SET nombre = TRIM(pNombre);
   END IF;

	--	RETURN "Hello" +  pNombre;
	RETURN CONCAT("hello"," ",nombre);

END//
DELIMITER ;

-- Volcando estructura para disparador supermercado.tau_producto_historico
DROP TRIGGER IF EXISTS `tau_producto_historico`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tau_producto_historico` AFTER UPDATE ON `producto` FOR EACH ROW BEGIN

	-- meter un registro en la tabla historico con el precio del producto cambiado

	-- comprobar que inserte solo si cambia el precio

	IF ( NEW.precio <> OLD.precio ) THEN

		INSERT INTO historico (precio, id_producto ) VALUES ( OLD.precio , OLD.id );

	END IF;


END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador supermercado.tbi_producto
DROP TRIGGER IF EXISTS `tbi_producto`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tbi_producto` BEFORE INSERT ON `producto` FOR EACH ROW BEGIN

	/*
		comprobar que el descuento sea entre 0 y 100
		si descuento < 0 = 0
		si descuento > 100 = 100
	*/

	IF NEW.descuento < 0 THEN
		SET NEW.descuento = 0;
	END IF;

	IF NEW.descuento > 100 THEN
		SET NEW.descuento = 100;
	END IF;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador supermercado.tbu_producto
DROP TRIGGER IF EXISTS `tbu_producto`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER';
DELIMITER //
CREATE TRIGGER `tbu_producto` BEFORE UPDATE ON `producto` FOR EACH ROW BEGIN

	IF NEW.descuento < 0 THEN
		SET NEW.descuento = 0;
	END IF;


	IF NEW.descuento > 100 THEN
		SET NEW.descuento = 100;
	END IF;

	SET NEW.fecha_modificacion = CURRENT_TIMESTAMP();

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador supermercado.tbu_usuario
DROP TRIGGER IF EXISTS `tbu_usuario`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER';
DELIMITER //
CREATE TRIGGER `tbu_usuario` BEFORE INSERT ON `usuario` FOR EACH ROW BEGIN

SET NEW.fecha_modificacion = CURRENT_TIMESTAMP();

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
