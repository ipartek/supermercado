-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         5.1.72-community - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para supermerkado
CREATE DATABASE IF NOT EXISTS `supermerkado` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `supermerkado`;

-- Volcando estructura para tabla supermerkado.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermerkado.categoria: ~9 rows (aproximadamente)
DELETE FROM `categoria`;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` (`id`, `nombre`) VALUES
	(14, '0categoria'),
	(3, 'electrodomesticos'),
	(8, 'fruteria'),
	(1, 'mock1578658677040'),
	(2, 'musica'),
	(4, 'nueva'),
	(5, 'nueva2'),
	(6, 'otra'),
	(7, 'otra333');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;

-- Volcando estructura para tabla supermerkado.historico
CREATE TABLE IF NOT EXISTS `historico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `precio` float NOT NULL DEFAULT '0',
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_producto` (`id_producto`),
  CONSTRAINT `FK_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermerkado.historico: ~10 rows (aproximadamente)
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
	(10, 1, '2020-01-10 08:24:12', 8);
/*!40000 ALTER TABLE `historico` ENABLE KEYS */;

-- Volcando estructura para tabla supermerkado.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `descripcion` mediumtext,
  `precio` float NOT NULL DEFAULT '0',
  `descuento` int(11) DEFAULT '0' COMMENT 'porcentaje descuento de 0 a 100',
  `imagen` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermerkado.producto: ~8 rows (aproximadamente)
DELETE FROM `producto`;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` (`id`, `nombre`, `id_categoria`, `id_usuario`, `descripcion`, `precio`, `descuento`, `imagen`, `validado`, `fecha_baja`, `fecha_alta`, `fecha_modificacion`) VALUES
	(8, 'unicoeeeernioeeeeeee', 1, 1, NULL, 2, 0, NULL, 1, '2020-01-10 10:54:57', '0000-00-00 00:00:00', '2020-01-10 08:24:12'),
	(12, 'hsdfhjkdfhjksdsabor a unicornio', 2, 1, NULL, 0, 0, NULL, 1, NULL, '0000-00-00 00:00:00', '2020-01-09 12:56:42'),
	(21, 'nuevo33333', 1, 4, NULL, 0, 0, NULL, 1, NULL, '0000-00-00 00:00:00', '2020-01-09 13:03:52'),
	(22, 'morcilla', 1, 1, NULL, 0, 2, NULL, 1, NULL, '0000-00-00 00:00:00', '2020-01-09 13:04:17'),
	(29, 'morcilla de burgos', 1, 1, NULL, 0, 0, NULL, 1, NULL, '0000-00-00 00:00:00', '2020-01-09 12:56:42'),
	(30, 'queso de burgos', 1, 1, NULL, 0, 50, NULL, 1, NULL, '0000-00-00 00:00:00', '2020-01-09 12:56:42'),
	(31, 'queso manchego', 1, 1, NULL, 0, 100, NULL, 1, NULL, '0000-00-00 00:00:00', '2020-01-09 12:56:42'),
	(36, 'morcillaeeeeee3333', 1, 1, NULL, 0, 0, NULL, 1, NULL, '0000-00-00 00:00:00', '2020-01-09 13:03:57');
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;

-- Volcando estructura para tabla supermerkado.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '1: Usuario normal   2: Administrador',
  `nombre` varchar(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermerkado.rol: ~2 rows (aproximadamente)
DELETE FROM `rol`;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` (`id`, `nombre`) VALUES
	(2, 'administrador'),
	(1, 'usuario');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;

-- Volcando estructura para tabla supermerkado.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `contrasenia` varchar(255) NOT NULL DEFAULT '0',
  `imagen` varchar(255) DEFAULT 'https://www.instamatico.io/wp-content/uploads/2019/11/Icon-Real-Profiles.png',
  `id_rol` int(11) DEFAULT '0',
  `validado` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FK_rol` (`id_rol`),
  CONSTRAINT `FK_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla supermerkado.usuario: ~2 rows (aproximadamente)
DELETE FROM `usuario`;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` (`id`, `nombre`, `contrasenia`, `imagen`, `id_rol`, `validado`) VALUES
	(1, 'admin', 'admin', NULL, 2, 0),
	(4, 'Dolores', '123456', NULL, 1, 0);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;

-- Volcando estructura para procedimiento supermerkado.pa_categoria_delete
DELIMITER //
CREATE PROCEDURE `pa_categoria_delete`(
	IN `pId` INT
)
BEGIN

	DELETE FROM categoria WHERE id = pId;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_categoria_getall
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

-- Volcando estructura para procedimiento supermerkado.pa_categoria_get_by_id
DELIMITER //
CREATE PROCEDURE `pa_categoria_get_by_id`(
	IN `pId` INT
)
BEGIN

	SELECT id, nombre FROM categoria WHERE id = pId;

END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_categoria_insert
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

-- Volcando estructura para procedimiento supermerkado.pa_categoria_update
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

-- Volcando estructura para procedimiento supermerkado.pa_producto_deletebyuserlogico
DELIMITER //
CREATE PROCEDURE `pa_producto_deletebyuserlogico`(
	IN `p_id` INT,
	IN `p_id_usuario` INT
)
BEGIN
	UPDATE producto SET fecha_baja = CURRENT_TIMESTAMP() WHERE id = p_id AND id_usuario = p_id_usuario;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_producto_deletelogico
DELIMITER //
CREATE PROCEDURE `pa_producto_deletelogico`(
	IN `p_id` INT
)
BEGIN
	UPDATE producto SET fecha_baja = CURRENT_TIMESTAMP() WHERE id = p_id;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_producto_getallactivos
DELIMITER //
CREATE PROCEDURE `pa_producto_getallactivos`()
BEGIN
	SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', fecha_alta, fecha_baja, validado 
	FROM producto p
	JOIN usuario u  
	ON p.id_usuario = u.id
	JOIN categoria c
	ON p.id_categoria = c.id
	WHERE fecha_baja IS NULL
	ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_producto_getallbaja
DELIMITER //
CREATE PROCEDURE `pa_producto_getallbaja`()
BEGIN
		SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', fecha_alta, fecha_baja, validado
		FROM producto p
		JOIN usuario u  
		ON p.id_usuario = u.id
		JOIN categoria c
		ON p.id_categoria = c.id
		WHERE fecha_baja IS NOT NULL
		ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_producto_getallbyuser
DELIMITER //
CREATE PROCEDURE `pa_producto_getallbyuser`(
	IN `p_id_usuario` INT
)
BEGIN
	SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', fecha_alta, fecha_baja, validado 
	FROM producto p
	JOIN usuario u  
	ON p.id_usuario = u.id 
	WHERE  fecha_baja IS NULL AND p.validado = 1 AND p.id_usuario = p_id_usuario
	ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_producto_getallinactivos
DELIMITER //
CREATE PROCEDURE `pa_producto_getallinactivos`()
BEGIN
		SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', fecha_alta, fecha_baja, validado 
		FROM producto p
		JOIN usuario u  
		ON p.id_usuario = u.id
		JOIN categoria c
		ON p.id_categoria = c.id
		WHERE p.validado = 0
		ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_producto_getbyid
DELIMITER //
CREATE PROCEDURE `pa_producto_getbyid`(
	IN `p_id` INT
)
BEGIN
	 SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', fecha_alta, fecha_baja, validado
	 FROM producto p
	 JOIN usuario u 
	 ON p.id_usuario = u.id
	 WHERE p.id = p_id
	 ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_producto_getbyidbyuser
DELIMITER //
CREATE PROCEDURE `pa_producto_getbyidbyuser`(
	IN `p_id_producto` INT,
	IN `p_id_usuario` INT
)
BEGIN
	SELECT p.id 'id_producto', p.nombre 'nombre_producto', c.id 'id_categoria', c.nombre 'nombre_categoria', u.id 'id_usuario', u.nombre 'nombre_usuario', descripcion, precio, descuento, p.imagen 'imagen', fecha_alta, fecha_baja, validado
			FROM producto p, usuario u WHERE p.id_usuario = u.id AND p.id= p_id_producto AND u.id = p_id_usuario
			ORDER BY p.id DESC LIMIT 500;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_producto_insert
DELIMITER //
CREATE PROCEDURE `pa_producto_insert`(
	IN `p_nombre` VARCHAR(50),
	IN `p_id_usuario` INT,
	IN `p_id_categoria` INT,
	IN `p_descripcion` VARCHAR(50),
	IN `p_precio` FLOAT,
	IN `p_descuento` INT,
	IN `p_validado` TINYINT
)
BEGIN
	INSERT INTO producto (nombre, id_usuario, id_categoria, descripcion, precio, descuento, validado) VALUES (p_nombre, p_id_usuario, p_id_categoria, p_descripcion, p_precio, p_descuento, p_validado);
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_producto_update
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

-- Volcando estructura para procedimiento supermerkado.pa_producto_updatebyuser
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

-- Volcando estructura para procedimiento supermerkado.pa_usuario_exist
DELIMITER //
CREATE PROCEDURE `pa_usuario_exist`(
	IN `p_nombre_usuario` VARCHAR(50),
	IN `p_contrasenia` VARCHAR(255)
)
BEGIN
	SELECT u.id 'id_usuario', u.nombre 'nombre_usuario', contrasenia, r.id 'id_rol', r.nombre 'nombre_rol' 
	FROM usuario u
	JOIN rol r
	ON u.id_rol = r.id 
	WHERE u.nombre = p_nombre_usuario AND contrasenia = p_contrasenia AND validado = 1;
END//
DELIMITER ;

-- Volcando estructura para procedimiento supermerkado.pa_usuario_getallactivos
DELIMITER //
CREATE PROCEDURE `pa_usuario_getallactivos`()
BEGIN
	SELECT u.id 'id_usuario', u.nombre 'nombre_usuario', r.id 'id_rol', r.nombre 'nombre_rol', contrasenia, imagen, validado 
	FROM usuario u
	JOIN rol r
	ON u.id_rol = r.id
	WHERE validado = 1;
END//
DELIMITER ;

-- Volcando estructura para función supermerkado.HELLO_WORLD
DELIMITER //
CREATE FUNCTION `HELLO_WORLD`() RETURNS varchar(100) CHARSET utf8
BEGIN

	RETURN "hola mundo";

END//
DELIMITER ;

-- Volcando estructura para función supermerkado.HELLO_WORLD2
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

-- Volcando estructura para disparador supermerkado.tau_producto_historico
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

-- Volcando estructura para disparador supermerkado.tbi_producto
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

-- Volcando estructura para disparador supermerkado.tbu_producto
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
