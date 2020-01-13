CREATE DATABASE  IF NOT EXISTS `supermercado` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `supermercado`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: supermercado
-- ------------------------------------------------------
-- Server version	8.0.16

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (8,'bebida'),(2,'embutido'),(1,'fruta'),(4,'lacteo');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historico`
--

DROP TABLE IF EXISTS `historico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historico` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `precio` float NOT NULL DEFAULT '0',
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_producto` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_producto` (`id_producto`),
  CONSTRAINT `FK_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historico`
--

LOCK TABLES `historico` WRITE;
/*!40000 ALTER TABLE `historico` DISABLE KEYS */;
INSERT INTO `historico` VALUES (1,12,'2020-01-10 07:21:25',8),(2,12,'2020-01-10 07:21:34',8),(3,56,'2020-01-10 07:21:40',8),(4,100,'2020-01-10 07:21:52',8),(5,400,'2020-01-10 07:22:15',8),(6,400,'2020-01-10 07:22:23',8),(7,400,'2020-01-10 07:22:25',8),(8,400,'2020-01-10 07:24:02',8),(9,0,'2020-01-10 07:24:06',8),(10,1,'2020-01-10 07:24:12',8),(11,2,'2020-01-10 09:38:18',8),(12,0,'2020-01-10 09:38:21',12),(13,0,'2020-01-10 09:38:22',21),(14,0,'2020-01-10 09:38:22',22),(15,0,'2020-01-10 09:38:23',29),(16,0,'2020-01-10 09:38:24',30),(17,0,'2020-01-10 09:38:25',31),(18,10.95,'2020-01-10 09:38:27',12),(19,10.95,'2020-01-10 09:38:30',21),(20,10.95,'2020-01-10 09:38:33',22),(21,10.95,'2020-01-10 09:38:35',29),(22,10.95,'2020-01-10 09:38:38',30),(23,10.95,'2020-01-10 09:38:43',31);
/*!40000 ALTER TABLE `historico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(100) NOT NULL,
  `imagen` varchar(200) NOT NULL,
  `precio` float NOT NULL DEFAULT '0',
  `descuento` int(11) DEFAULT '0' COMMENT 'porcentaje descuento de 0 a 100',
  `fecha_modificacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fecha_alta` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `validado` tinyint(4) NOT NULL DEFAULT '0',
  `id_categoria` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FK_usuario` (`id_usuario`),
  KEY `FK_categoria` (`id_categoria`),
  CONSTRAINT `FK_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id`),
  CONSTRAINT `FK_usuario` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (8,'vodka','bebida alcoholica','https://images-na.ssl-images-amazon.com/images/I/71Ym%2B8ykpZL._SY445_.jpg',10.95,0,'2020-01-10 10:05:13','2020-01-10 09:28:05',1,8,1),(12,'puerto de indias','bebida alcoholica','https://images-na.ssl-images-amazon.com/images/I/41K1viacZSL._SX342_.jpg',11.95,5,'2020-01-10 10:05:15','2020-01-10 09:28:05',1,8,1),(21,'manzana','fruta sana','https://image.freepik.com/foto-gratis/monton-manzanas-verdes-vividas-foto-vertical-fondo_76000-518.jpg',12.95,10,'2020-01-10 11:43:00','2020-01-10 09:28:05',1,1,4),(22,'platano','fruta sana','https://previews.123rf.com/images/peterm/peterm0708/peterm070800014/1364838-pl%C3%A1tano-amarillo-sobre-fondo-blanco-formato-vertical-.jpg',13.95,15,'2020-01-10 11:42:34','2020-01-10 09:28:05',1,1,1),(29,'morcilla de burgos','producto de burgos','https://www.hermeneus.es/Files/Images/References/2018/10/96589e46-6984-4ed8-bebd-ab70b48adda0/8ac22c10-33e1-41ca-81b6-033060ae2455.jpg',14.95,20,'2020-01-10 10:05:06','2020-01-10 09:28:05',0,2,1),(30,'queso de burgos','producto de burgos','https://www.oviespana.com/media/k2/items/cache/743f4450c9faa8de04503aff73f0437e_XL.jpg',15.95,25,'2020-01-10 10:04:56','2020-01-10 09:28:05',0,4,1),(31,'queso manchego','producto de castilla','https://www.hallamohe.com/1263-large_default/queso-manchego-marantona-18-meses-cremoso.jpg',16.95,30,'2020-01-10 10:05:00','2020-01-10 09:28:05',0,4,1);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '1: Usuario normal   2: Administrador',
  `nombre` varchar(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (2,'administrador'),(1,'usuario');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL DEFAULT '0',
  `contrasenia` varchar(50) NOT NULL DEFAULT '0',
  `avatar` varchar(200) NOT NULL DEFAULT 'http://www.fmacia.net/images/stories/virtuemart/product/no-imagen.jpg',
  `id_rol` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `FK_rol` (`id_rol`),
  CONSTRAINT `FK_rol` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'admin','admin','https://iesmiguelhernandez.es/moodle2/pluginfile.php/28093/mod_page/content/8/admin.png',2),(4,'dolores','dolores','https://image.flaticon.com/icons/png/512/44/44948.png',1),(12,'miu','miu','http://www.fmacia.net/images/stories/virtuemart/product/no-imagen.jpg',1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-13 10:08:42
