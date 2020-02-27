-- --------------------------------------------------------
-- Host:                         192.168.0.50
-- Versión del servidor:         5.7.29-log - MySQL Community Server (GPL)
-- SO del servidor:              Win32
-- HeidiSQL Versión:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para supermercado_aiken
CREATE DATABASE IF NOT EXISTS `supermercado_aiken` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `supermercado_aiken`;

-- Volcando estructura para tabla supermercado_aiken.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermercado_aiken.categoria: ~12 rows (aproximadamente)
DELETE FROM `categoria`;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` (`id`, `nombre`) VALUES
	(13, '0categoria'),
	(11, 'ALIMENTACION'),
	(1, 'CARNE'),
	(10, 'CERVEZAS'),
	(5, 'CHARCUTERIA'),
	(8, 'DULCES Y DESAYUNO'),
	(3, 'FRUTAS'),
	(4, 'PANADERIA, BOLLERIA Y PASTELERIA'),
	(2, 'PESCADO'),
	(7, 'QUESOS'),
	(6, 'VERDURAS Y HORTALIZAS'),
	(9, 'VINOS');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;

-- Volcando estructura para tabla supermercado_aiken.historico
CREATE TABLE IF NOT EXISTS `historico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `precio` float NOT NULL DEFAULT '0',
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_producto` (`id_producto`),
  CONSTRAINT `FK_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermercado_aiken.historico: ~10 rows (aproximadamente)
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
	(11, 0, '2020-01-14 10:55:20', 12);
/*!40000 ALTER TABLE `historico` ENABLE KEYS */;

-- Volcando estructura para tabla supermercado_aiken.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `descripcion` mediumtext,
  `precio` float NOT NULL DEFAULT '0',
  `descuento` int(11) DEFAULT '0' COMMENT 'porcentaje descuento de 0 a 100',
  `imagen` varchar(255) DEFAULT 'https://image.flaticon.com/icons/png/512/372/372627.png',
  `validado` tinyint(4) NOT NULL DEFAULT '0',
  `fecha_baja` timestamp NULL DEFAULT NULL,
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fecha_modificacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FK_usuario` (`id_usuario`),
  KEY `FK_categoria` (`id_categoria`),
  CONSTRAINT `FK_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`),
  CONSTRAINT `FK_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermercado_aiken.producto: ~28 rows (aproximadamente)
DELETE FROM `producto`;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` (`id`, `nombre`, `id_categoria`, `id_usuario`, `descripcion`, `precio`, `descuento`, `imagen`, `validado`, `fecha_baja`, `fecha_alta`, `fecha_modificacion`) VALUES
	(1, 'Turron duro', 8, 1, 'Turron duro, caja 250 g', 10.95, 90, 'https://supermercado.eroski.es/images/17930009.jpg', 1, NULL, '2020-01-09 13:42:33', NULL),
	(2, 'Langostino crudo', 2, 1, 'Langostino crudo 35/42, caja 700 g', 21, 70, 'https://supermercado.eroski.es/images/16550501.jpg', 1, NULL, '2020-01-09 13:42:34', NULL),
	(3, 'Vino Tinto', 9, 1, 'Vino Tinto Crianza, botella 75 cl\\r\\n', 20, 70, 'https://supermercado.eroski.es/images/2026631.jpg', 1, NULL, '2020-01-09 13:42:35', NULL),
	(4, 'La gula del norte 430 g', 2, 1, 'Gulas del norte congeladas, bandeja 430 g', 20, 70, 'https://supermercado.eroski.es/images/19780345.jpg', 1, NULL, '2020-01-09 13:42:36', NULL),
	(5, 'EL ALMENDRO, 280 g', 8, 1, 'Turrón crujiente de chocolate negro, tableta 280 g', 20, 70, 'https://supermercado.eroski.es/images/22615017.jpg', 1, NULL, '2020-01-09 13:42:37', NULL),
	(6, 'BAQUÉ 2x250g', 8, 1, 'Café molido natural, pack', 20, 70, 'https://supermercado.eroski.es/images/2679173.jpg', 1, NULL, '2020-01-09 13:42:38', NULL),
	(7, 'COOSUR', 11, 1, 'Aceite oliva virgen extra', 20, 50, 'https://supermercado.eroski.es/images/15923279.jpg', 1, NULL, '2020-01-09 13:42:39', NULL),
	(8, 'unicoeeeernioeeeeeee', 1, 1, ':)', 2, 0, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, '2020-01-10 10:54:57', '2020-01-13 09:01:39', '2020-01-10 08:24:12'),
	(9, 'ZÜ PREMIUM 2L', 11, 1, 'Zumo de naranja exprimido sin pulpa', 20, 70, 'https://supermercado.eroski.es/images/13899539.jpg', 1, NULL, '2020-01-09 13:42:40', NULL),
	(10, 'CODORNIU2222', 9, 1, 'Cava Brut Reserva, botella 75 cl', 20, 50, 'https://supermercado.eroski.es/images/399691.jpg', 1, NULL, '2020-01-09 13:42:41', NULL),
	(12, 'hsdfhj a unicornio', 2, 4, 'bdfgdggdfg', 50, 20, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-13 09:01:39', '2020-01-09 12:56:42'),
	(14, 'aaaa', 5, 1, 'aaaa', 5.5, 0, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-09 13:42:42', NULL),
	(15, 'AAAAAe', 3, 1, 'AAAAAAAAAAAAAA', 5, 10, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-09 13:42:42', NULL),
	(16, 'AAAAAAAAAA', 4, 1, 'EEEEEEEEE', 25, 15, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-09 13:42:43', NULL),
	(17, 'prueba', 1, 1, 'prueba', 42, 10, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-09 13:42:44', NULL),
	(18, 'aaaaaa', 7, 1, 'aaaaa', 20, 12, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-09 13:42:45', NULL),
	(20, 'morcilla1', 1, 1, ':)', 50, 0, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-09 13:42:45', NULL),
	(21, 'nuevo33333', 1, 4, ':)', 0, 0, 'https://image.flaticon.com/icons/png/512/372/372627.png', 0, NULL, '2020-01-13 09:01:39', '2020-01-09 13:03:52'),
	(22, 'morcilla', 1, 1, ':)', 0, 2, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-13 09:01:39', '2020-01-09 13:04:17'),
	(23, 'morcilla2', 1, 1, ':)', 50, 100, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-09 13:42:46', NULL),
	(24, 'morcilla4', 1, 1, ':)', 50, 100, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-09 13:42:47', NULL),
	(29, 'morcilla de burgos', 1, 1, ':)', 0, 0, 'https://image.flaticon.com/icons/png/512/372/372627.png', 0, NULL, '2020-01-13 09:01:39', '2020-01-09 12:56:42'),
	(30, 'queso de burgos', 1, 1, ':)', 0, 50, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-13 09:01:39', '2020-01-09 12:56:42'),
	(31, 'queso manchegoa', 1, 1, ':)', 0, 100, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-13 09:01:39', '2020-01-09 12:56:42'),
	(36, 'morcillaeeeeee3333a', 1, 1, ':)', 0, 0, 'https://image.flaticon.com/icons/png/512/372/372627.png', 0, NULL, '2020-01-13 09:01:39', '2020-01-09 13:03:57'),
	(37, 'aaaaaaaa', 3, 4, 'aaaaaaaa', 20, 10, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, '2020-01-13 12:07:01', '2020-01-13 12:01:26', NULL),
	(43, 'verdura', 1, 4, 'verdura fresca', 2, 0, 'https://image.flaticon.com/icons/png/512/372/372627.png', 0, NULL, '2020-01-14 12:26:01', NULL),
	(45, 'aaaaaaaaaaaaaaaaaaaaaa', 13, 4, 'aaaaaaaaaaaaaaaaaa', 50, 10, 'https://image.flaticon.com/icons/png/512/372/372627.png', 1, NULL, '2020-01-14 12:31:05', NULL);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;

-- Volcando estructura para tabla supermercado_aiken.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '1: Usuario normal   2: Administrador',
  `nombre` varchar(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermercado_aiken.rol: ~2 rows (aproximadamente)
DELETE FROM `rol`;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` (`id`, `nombre`) VALUES
	(2, 'administrador'),
	(1, 'usuario');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;

-- Volcando estructura para tabla supermercado_aiken.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `contrasenia` varchar(255) NOT NULL DEFAULT '0',
  `imagen` varchar(255) DEFAULT 'https://www.instamatico.io/wp-content/uploads/2019/11/Icon-Real-Profiles.png',
  `id_rol` int(11) DEFAULT '0',
  `validado` tinyint(4) NOT NULL DEFAULT '0',
  `fecha_baja` timestamp NULL DEFAULT NULL,
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FK_rol` (`id_rol`),
  CONSTRAINT `FK_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermercado_aiken.usuario: ~8 rows (aproximadamente)
DELETE FROM `usuario`;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id`, `nombre`, `contrasenia`, `imagen`, `id_rol`, `validado`, `fecha_baja`, `fecha_alta`) VALUES
	(1, 'admin', 'f6fdffe48c908deb0f4c3bd36c032e72', 'https://www.instamatico.io/wp-content/uploads/2019/11/Icon-Real-Profiles.png', 2, 1, NULL, '2020-01-13 13:08:22'),
	(4, 'Dolores', '123456', 'https://www.instamatico.io/wp-content/uploads/2019/11/Icon-Real-Profiles.png', 1, 1, NULL, '2020-01-13 13:08:22'),
	(5, 'prueba2', 'prueba2', 'https://www.instamatico.io/wp-content/uploads/2019/11/Icon-Real-Profiles.png', 1, 1, '2020-01-13 13:39:16', '2020-01-13 13:08:22'),
	(7, 'prueba455', 'prueba4', 'https://www.instamatico.io/wp-content/uploads/2019/11/Icon-Real-Profiles.png', 1, 1, NULL, '2020-01-13 13:08:22'),
	(8, 'prueba666', 'prueba666', 'https://i.pinimg.com/originals/a1/30/86/a130864e6d6db6899ca996b0691113f8.jpg', 1, 1, NULL, '2020-01-13 13:47:49'),
	(9, 'aang', 'aang', 'https://i.pinimg.com/originals/a1/30/86/a130864e6d6db6899ca996b0691113f8.jpg', 1, 1, '2020-01-13 13:57:58', '2020-01-13 13:54:58'),
	(10, 'Admin2', 'db76c517695cb6c7c8a4dbd22a3a46d1', 'https://www.instamatico.io/wp-content/uploads/2019/11/Icon-Real-Profiles.png', 1, 1, NULL, '2020-01-14 13:23:53'),
	(11, 'usuario1', '3f2955bdb66891effe40bcf2203dc5de', 'https://www.instamatico.io/wp-content/uploads/2019/11/Icon-Real-Profiles.png', 1, 1, NULL, '2020-01-14 13:25:23');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

-- Volcando estructura para procedimiento supermercado_aiken.pa_categoria_delete
DELIMITER //
CREATE PROCEDURE `pa_categoria_delete`(
	IN `pId` INT
)
BEGIN

	DELETE FROM categoria WHERE id = pId;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_categoria_getall
DELIMITER //
CREATE PROCEDURE `pa_categoria_getall`()
BEGIN

   	-- nuestro primer PA
   	/*  tiene pinta que tambien comentarios de bloque */
    SELECT id, nombre FROM categoria ORDER BY nombre ASC LIMIT 500;
    
    -- desde java executeQuery
    -- retorna ResultSet

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_categoria_get_by_id
DELIMITER //
CREATE PROCEDURE `pa_categoria_get_by_id`(
	IN `pId` INT
)
BEGIN

	SELECT id, nombre FROM categoria WHERE id = pId;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_categoria_insert
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

-- Volcando estructura para procedimiento supermercado_aiken.pa_categoria_update
DELIMITER //
CREATE PROCEDURE `pa_categoria_update`(
	IN `pId` INT,
	IN `pNombre` VARCHAR(100)
)
BEGIN


	UPDATE categoria SET nombre = pNombre WHERE id = pId;
	
	-- desde java executeUpdate, retorna affectedRows int

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_busqueda
DELIMITER //
CREATE PROCEDURE `pa_producto_busqueda`(
	IN `p_idcategoria` INT,
	IN `p_nombreproducto` VARCHAR(50)
)
BEGIN
	IF STRCMP(p_nombreproducto, "")=0 && p_idcategoria<=0  THEN
		SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', p.fecha_alta 'fecha_alta', p.fecha_baja 'fecha_baja', p.validado 'validado'
		FROM producto p
		JOIN usuario u  
		ON p.id_usuario = u.id
		JOIN categoria c
		ON p.id_categoria = c.id
		WHERE p.fecha_baja IS NULL AND p.validado = 1
		ORDER BY p.id DESC LIMIT 500;	
	ELSEIF STRCMP(p_nombreproducto, "")=0 && p_idcategoria>0 THEN
		SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', p.fecha_alta 'fecha_alta', p.fecha_baja 'fecha_baja', p.validado 'validado'
		FROM producto p
		JOIN usuario u  
		ON p.id_usuario = u.id
		JOIN categoria c
		ON p.id_categoria = c.id
		WHERE p.fecha_baja IS NULL AND p.validado = 1 AND c.id = p_idcategoria 
		ORDER BY p.id DESC LIMIT 500;	
	ELSEIF STRCMP(p_nombreproducto, "")!=0 && p_idcategoria>0 THEN
		SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', p.fecha_alta 'fecha_alta', p.fecha_baja 'fecha_baja', p.validado 'validado'
		FROM producto p
		JOIN usuario u  
		ON p.id_usuario = u.id
		JOIN categoria c
		ON p.id_categoria = c.id
		WHERE p.fecha_baja IS NULL AND p.validado = 1 AND c.id = p_idcategoria AND p.nombre LIKE CONCAT('%',p_nombreproducto,'%') 
		ORDER BY p.id DESC LIMIT 500;
	ELSEIF STRCMP(p_nombreproducto, "")!=0 && p_idcategoria<=0 THEN
		SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', p.fecha_alta 'fecha_alta', p.fecha_baja 'fecha_baja', p.validado 'validado'
		FROM producto p
		JOIN usuario u  
		ON p.id_usuario = u.id
		JOIN categoria c
		ON p.id_categoria = c.id
		WHERE p.fecha_baja IS NULL AND p.validado = 1 AND p.nombre LIKE CONCAT('%',p_nombreproducto,'%')
		ORDER BY p.id DESC LIMIT 500;
	END IF;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_deletebyuserlogico
DELIMITER //
CREATE PROCEDURE `pa_producto_deletebyuserlogico`(
	IN `p_id` INT,
	IN `p_id_usuario` INT
)
BEGIN
	UPDATE producto SET fecha_baja = CURRENT_TIMESTAMP() WHERE id = p_id AND id_usuario = p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_deletelogico
DELIMITER //
CREATE PROCEDURE `pa_producto_deletelogico`(
	IN `p_id` INT
)
BEGIN
	UPDATE producto SET fecha_baja = CURRENT_TIMESTAMP() WHERE id = p_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_getallactivos
DELIMITER //
CREATE PROCEDURE `pa_producto_getallactivos`()
BEGIN
	SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', p.fecha_alta 'fecha_alta', p.fecha_baja 'fecha_baja', p.validado 'validado' 
	FROM producto p
	JOIN usuario u  
	ON p.id_usuario = u.id
	JOIN categoria c
	ON p.id_categoria = c.id
	WHERE p.fecha_baja IS NULL AND p.validado=1
	ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_getallbaja
DELIMITER //
CREATE PROCEDURE `pa_producto_getallbaja`()
BEGIN
		SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', p.fecha_alta 'fecha_alta', p.fecha_baja 'fecha_baja', p.validado 'validado'
		FROM producto p
		JOIN usuario u  
		ON p.id_usuario = u.id
		JOIN categoria c
		ON p.id_categoria = c.id
		WHERE p.fecha_baja IS NOT NULL
		ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_getallbyuser
DELIMITER //
CREATE PROCEDURE `pa_producto_getallbyuser`(
	IN `p_id_usuario` INT
)
BEGIN
	SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', p.fecha_alta 'fecha_alta', p.fecha_baja 'fecha_baja', p.validado 'validado' 
	FROM producto p
	JOIN usuario u  
	ON p.id_usuario = u.id 
	JOIN categoria c
	ON p.id_categoria = c.id
	WHERE  p.fecha_baja IS NULL AND p.validado = 1 AND p.id_usuario = p_id_usuario
	ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_getallinactivos
DELIMITER //
CREATE PROCEDURE `pa_producto_getallinactivos`()
BEGIN
		SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', p.fecha_alta 'fecha_alta', p.fecha_baja 'fecha_baja', p.validado 'validado' 
		FROM producto p
		JOIN usuario u  
		ON p.id_usuario = u.id
		JOIN categoria c
		ON p.id_categoria = c.id
		WHERE p.validado = 0
		ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_getbyid
DELIMITER //
CREATE PROCEDURE `pa_producto_getbyid`(
	IN `p_id` INT
)
BEGIN
	 SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', p.fecha_alta 'fecha_alta', p.fecha_baja 'fecha_baja', p.validado 'validado'
	 FROM producto p
	 JOIN usuario u 
	 ON p.id_usuario = u.id
	 JOIN categoria c
	 ON c.id = p.id_categoria
	 WHERE p.id = p_id
	 ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_getbyidbyuser
DELIMITER //
CREATE PROCEDURE `pa_producto_getbyidbyuser`(
	IN `p_id_producto` INT,
	IN `p_id_usuario` INT
)
BEGIN
	SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', p.fecha_alta 'fecha_alta', p.fecha_baja 'fecha_baja', p.validado 'validado'
	FROM producto p
	JOIN usuario u 
	ON p.id_usuario = u.id 
	JOIN categoria c
	ON c.id = p.id_categoria
	WHERE p.id= p_id_producto AND u.id = p_id_usuario
	ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_insert
DELIMITER //
CREATE PROCEDURE `pa_producto_insert`(
	IN `p_nombre` VARCHAR(50),
	IN `p_id_usuario` INT,
	IN `p_id_categoria` INT,
	IN `p_descripcion` MEDIUMTEXT,
	IN `p_precio` FLOAT,
	IN `p_descuento` INT,
	IN `p_validado` TINYINT
)
BEGIN
	INSERT INTO producto (nombre, id_usuario, id_categoria, descripcion, precio, descuento, validado) VALUES (p_nombre, p_id_usuario, p_id_categoria, p_descripcion, p_precio, p_descuento, p_validado);
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_update
DELIMITER //
CREATE PROCEDURE `pa_producto_update`(
	IN `p_id_producto` INT,
	IN `p_id_usuario` INT,
	IN `p_id_categoria` INT,
	IN `p_nombre` VARCHAR(50),
	IN `p_descripcion` MEDIUMTEXT,
	IN `p_precio` FLOAT,
	IN `p_descuento` INT,
	IN `p_imagen` VARCHAR(255),
	IN `p_validado` TINYINT
)
BEGIN
	UPDATE producto SET nombre = p_nombre , id_categoria = p_id_categoria, id_usuario = p_id_usuario, descripcion = p_descripcion, precio = p_precio, descuento = p_descuento, imagen = p_imagen, validado = p_validado  WHERE id = p_id_producto;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_producto_updatebyuser
DELIMITER //
CREATE PROCEDURE `pa_producto_updatebyuser`(
	IN `p_id_producto` INT,
	IN `p_id_usuario` INT,
	IN `p_nombre` VARCHAR(50),
	IN `p_id_categoria` INT,
	IN `p_descripcion` MEDIUMTEXT,
	IN `p_precio` FLOAT,
	IN `p_descuento` INT,
	IN `p_imagen` VARCHAR(255),
	IN `p_validado` TINYINT
)
BEGIN
	UPDATE producto SET nombre = p_nombre , id_categoria = p_id_categoria, descripcion = p_descripcion, precio = p_precio, descuento = p_descuento, imagen = p_imagen, validado = p_validado  WHERE id = p_id_producto AND id_usuario = p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_usuario_deletelogico
DELIMITER //
CREATE PROCEDURE `pa_usuario_deletelogico`(
	IN `p_id` INT
)
BEGIN
	UPDATE usuario SET fecha_baja = CURRENT_TIMESTAMP() WHERE id=p_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_usuario_exist
DELIMITER //
CREATE PROCEDURE `pa_usuario_exist`(
	IN `p_nombre_usuario` VARCHAR(50),
	IN `p_contrasenia` VARCHAR(255)
)
BEGIN
	SELECT u.id 'id_usuario', u.nombre 'nombre_usuario', contrasenia, r.id 'id_rol', r.nombre 'nombre_rol', imagen, validado, fecha_baja, fecha_alta 
	FROM usuario u
	JOIN rol r
	ON u.id_rol = r.id 
	WHERE u.nombre = p_nombre_usuario AND contrasenia = p_contrasenia AND validado = 1;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_usuario_getallactivos
DELIMITER //
CREATE PROCEDURE `pa_usuario_getallactivos`()
BEGIN
	SELECT u.id 'id_usuario', u.nombre 'nombre_usuario', r.id 'id_rol', r.nombre 'nombre_rol', contrasenia, imagen, validado, fecha_baja, fecha_alta 
	FROM usuario u
	JOIN rol r
	ON u.id_rol = r.id
	WHERE validado = 1 AND fecha_baja IS NULL;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_usuario_getallbaja
DELIMITER //
CREATE PROCEDURE `pa_usuario_getallbaja`()
BEGIN
	SELECT u.id 'id_usuario', u.nombre 'nombre_usuario', r.id 'id_rol', r.nombre 'nombre_rol', contrasenia, imagen, validado, fecha_baja, fecha_alta 
	FROM usuario u
	JOIN rol r
	ON u.id_rol = r.id
	WHERE validado = 1 AND fecha_baja IS NOT NULL;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_usuario_getallinactivos
DELIMITER //
CREATE PROCEDURE `pa_usuario_getallinactivos`()
BEGIN
	SELECT u.id 'id_usuario', u.nombre 'nombre_usuario', r.id 'id_rol', r.nombre 'nombre_rol', contrasenia, imagen, validado, fecha_baja, fecha_alta 
	FROM usuario u
	JOIN rol r
	ON u.id_rol = r.id
	WHERE validado = 0;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_usuario_getbyid
DELIMITER //
CREATE PROCEDURE `pa_usuario_getbyid`(
	IN `p_id_usuario` INT
)
BEGIN
	SELECT u.id 'id_usuario', u.nombre 'nombre_usuario', r.id 'id_rol', r.nombre 'nombre_rol', contrasenia, imagen, validado, fecha_baja, fecha_alta 
	FROM usuario u
	JOIN rol r
	ON u.id_rol = r.id
	WHERE u.id=p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_usuario_registro
DELIMITER //
CREATE PROCEDURE `pa_usuario_registro`(
	IN `p_nombre` VARCHAR(50),
	IN `p_contrasenia` VARCHAR(255),
	IN `p_imagen` VARCHAR(255)
)
BEGIN
	INSERT INTO usuario (nombre, contrasenia, imagen, id_rol, validado) VALUES (p_nombre, p_contrasenia, p_imagen, 1, 0);
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_usuario_registrobyadmin
DELIMITER //
CREATE PROCEDURE `pa_usuario_registrobyadmin`(
	IN `p_nombre` VARCHAR(50),
	IN `p_contrasenia` VARCHAR(255),
	IN `p_imagen` VARCHAR(255),
	IN `p_id_rol` INT
)
BEGIN
	INSERT INTO usuario (nombre, contrasenia, imagen, id_rol, validado) VALUES (p_nombre, p_contrasenia, p_imagen, p_id_rol, 1);
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermercado_aiken.pa_usuario_update
DELIMITER //
CREATE PROCEDURE `pa_usuario_update`(
	IN `p_id_usuario` INT,
	IN `p_nombre` VARCHAR(50),
	IN `p_contrasenia` VARCHAR(255),
	IN `p_imagen` VARCHAR(255),
	IN `p_id_rol` INT,
	IN `p_validado` TINYINT
)
BEGIN
	UPDATE usuario SET nombre=p_nombre, contrasenia=p_contrasenia, imagen=p_imagen, id_rol=p_id_rol, validado=p_validado WHERE id=p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para disparador supermercado_aiken.tau_producto_historico
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
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

-- Volcando estructura para disparador supermercado_aiken.tbi_producto
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

-- Volcando estructura para disparador supermercado_aiken.tbu_producto
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `tbu_producto` BEFORE UPDATE ON `producto` FOR EACH ROW BEGIN

	IF NEW.descuento < 0 THEN 
		SET NEW.descuento = 0; 
	END IF;
	

	IF NEW.descuento > 100 THEN 
		SET NEW.descuento = 100; 
	END IF;	

	-- INSERT INTO categoria (nombre) VALUE ( CONCAT(NEW.descuento, 'categoria'));

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
