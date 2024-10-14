-- MySQL dump 10.13  Distrib 8.0.27, for macos11 (x86_64)
--
-- Host: localhost    Database: smiut
-- ------------------------------------------------------
-- Server version	5.7.34

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
-- Table structure for table `empresas`
--

DROP TABLE IF EXISTS `empresas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `super_administrador` int(1) DEFAULT '0',
  `username` varchar(250) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  `password_salt` varchar(10) DEFAULT NULL,
  `cod_recupera` varchar(255) DEFAULT NULL,
  `roles` int(2) DEFAULT '1',
  `primeiro_nome` varchar(255) DEFAULT NULL,
  `ultimo_nome` varchar(255) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `funcao` varchar(40) DEFAULT NULL,
  `observacoes` text,
  `imagem` varchar(250) DEFAULT NULL,
  `last_activity` datetime DEFAULT CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  `notif_from` datetime DEFAULT NULL,
  `lingua` varchar(20) DEFAULT 'pt',
  `slug` varchar(255) DEFAULT NULL,
  `ativo` int(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas`
--

LOCK TABLES `empresas` WRITE;
/*!40000 ALTER TABLE `empresas` DISABLE KEYS */;
INSERT INTO `empresas` VALUES (1,1,'admin','a31328e1b6df31425f6e97467e5993e5e7d3cfcce7322ec7cf2d1267a6d04954','7f5',NULL,1,'EAS','Suporte',NULL,'contato@eastecnologia.com','1332','343','563','//localhost/smiut/webservice/uploads/users/1674325759.webp','2015-10-12 15:19:06','2015-10-12 15:18:53','2015-10-12 15:18:53','pt',NULL,1),(2,0,'emerson.eho@gmail.com','519407930eac01658f2cc7900731d3f135a1b2ab6d85b6046bddabb692f35c95','82e',NULL,1,'Empresa 1',NULL,'av gisele martihns','emerson.eho@gmail.com','2938472345',NULL,NULL,NULL,'2021-12-24 00:47:55',NULL,NULL,'pt','empresa_1',1);
/*!40000 ALTER TABLE `empresas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresas_funcionarios`
--

DROP TABLE IF EXISTS `empresas_funcionarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresas_funcionarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` int(11) DEFAULT '0',
  `nome` varchar(45) DEFAULT NULL,
  `telefone` varchar(45) DEFAULT NULL,
  `cargo` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `ativo` int(1) DEFAULT '1',
  `password` varchar(255) DEFAULT NULL,
  `password_salt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresas_funcionarios`
--

LOCK TABLES `empresas_funcionarios` WRITE;
/*!40000 ALTER TABLE `empresas_funcionarios` DISABLE KEYS */;
INSERT INTO `empresas_funcionarios` VALUES (1,2,'asdf','234234','1','emerson.eho@gmail.com',1,NULL,NULL),(2,1,'Teste funcionario','982734987234','teste cargo','emerson.eho@gmail.com',1,'dae59251316cdd4d78c0d0c8d3cd7c7492cb3de49279981b53be71a6adc105e9','86f'),(3,2,'Teste funcionário Émerson','1039u01923','teste cargo novo','emerson.eho123123@asdfasdf.com',1,'df317239c4eeed514e5d6784b731beb6289085141b6204b1dd7f134c219fa506','4c2');
/*!40000 ALTER TABLE `empresas_funcionarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `funcao` varchar(100) DEFAULT NULL,
  `pagina` varchar(45) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `id_user` int(3) DEFAULT NULL,
  `id_item` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
INSERT INTO `logs` VALUES (1,'login','login',NULL,1,0),(2,'login','login','2021-12-24 11:12:15',1,0),(3,'login','login','2021-12-24 11:12:12',1,0),(4,'login','login','2021-12-24 11:22:15',1,0),(5,'criacao','sensores','2021-12-26 02:21:29',1,NULL),(6,'criacao','sensores','2021-12-26 02:21:41',1,NULL),(7,'criacao','sensores','2021-12-26 02:22:24',1,NULL),(8,'criacao','sensores','2021-12-26 02:22:35',1,NULL),(9,'criacao','sensores','2021-12-26 02:23:13',1,4),(10,'edicao','sensores','2021-12-26 02:23:17',1,4),(11,'criacao','sensores','2021-12-26 02:23:30',1,5),(12,'criacao','sensores','2021-12-26 02:23:43',1,6),(13,'criacao','sensores','2021-12-26 02:23:54',1,7),(14,'edicao','sensores','2021-12-26 02:23:55',1,5),(15,'edicao','sensores','2021-12-26 02:23:56',1,6),(16,'edicao','sensores','2021-12-26 02:23:57',1,7),(17,'edicao','empresas','2021-12-26 04:22:31',1,2),(18,'edicao','empresas','2021-12-26 04:22:47',1,2),(19,'edicao','empresas','2021-12-26 04:23:31',1,2),(20,'login','login','2021-12-27 11:24:10',1,0),(21,'login','login','2021-12-28 09:01:58',1,0),(22,'criacao','empresas','2021-12-28 10:53:54',1,3),(23,'edicao','empresas','2021-12-28 11:14:43',1,3),(24,'edicao','empresas','2021-12-28 11:16:35',1,3),(25,'edicao','empresas','2021-12-28 11:16:48',1,3),(26,'criacao','empresas','2021-12-28 11:17:06',1,4),(27,'criacao','empresas','2021-12-28 11:40:37',1,5),(28,'apagar','empresas','2021-12-28 11:44:31',1,5),(29,'apagar','empresas','2021-12-28 11:44:54',1,4),(30,'apagar','empresas','2021-12-28 11:45:26',1,3),(31,'criacao','empresas','2021-12-28 11:45:42',1,6),(32,'apagar','empresas','2021-12-28 11:45:45',1,6),(33,'criacao','empresas','2021-12-28 11:46:37',1,7),(34,'apagar','empresas','2021-12-28 11:46:40',1,7),(35,'criacao','empresas','2021-12-28 11:47:51',1,8),(36,'criacao','empresas','2021-12-28 11:48:02',1,9),(37,'apagar','empresas','2021-12-28 11:48:07',1,8),(38,'apagar','empresas','2021-12-28 11:48:48',1,9),(39,'login','login','2021-12-28 11:58:05',2,0),(40,'criacao','sensores','2021-12-29 12:17:37',2,8),(41,'apagar','sensores','2021-12-29 12:27:58',2,8),(42,'login','login','2021-12-29 12:28:08',1,0),(43,'login','login','2021-12-29 12:29:30',1,0),(44,'login','login','2021-12-29 12:29:50',1,0),(45,'login','login','2021-12-29 12:36:08',1,0),(46,'login','login','2021-12-29 12:48:06',2,0),(47,'edicao','sensores','2021-12-29 12:48:18',2,4),(48,'edicao','sensores','2021-12-29 12:48:22',2,4),(49,'edicao','sensores','2021-12-29 12:50:48',2,4),(50,'login','login','2021-12-29 10:16:38',1,0),(51,'edicao','empresas','2022-01-03 10:42:16',1,2);
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensores`
--

DROP TABLE IF EXISTS `sensores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensores` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_empresa` int(11) NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  `deviceid` varchar(50) DEFAULT NULL,
  `temp_ativo` int(1) DEFAULT '1',
  `temp_maior_igual` varchar(5) DEFAULT NULL,
  `temp_menor_igual` varchar(5) DEFAULT NULL,
  `umid_ativo` int(1) DEFAULT '1',
  `umid_maior_igual` varchar(5) DEFAULT NULL,
  `umid_menor_igual` varchar(5) DEFAULT NULL,
  `ativo` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensores`
--

LOCK TABLES `sensores` WRITE;
/*!40000 ALTER TABLE `sensores` DISABLE KEYS */;
INSERT INTO `sensores` VALUES (4,2,'Teste 06','1000973fee',1,'24','3',1,'4','5',1),(5,4,'Teste 03','10006d5f32',1,NULL,NULL,1,NULL,NULL,1),(6,2,'Teste 02','10006d3b76',1,NULL,NULL,1,NULL,NULL,1),(7,4,'Teste 07','10007c1076',1,NULL,NULL,1,NULL,NULL,1);
/*!40000 ALTER TABLE `sensores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sensores_data`
--

DROP TABLE IF EXISTS `sensores_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sensores_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceid` varchar(50) NOT NULL,
  `valor_umidade` double DEFAULT '0',
  `valor_temperatura` double DEFAULT '0',
  `data` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sensores_data`
--

LOCK TABLES `sensores_data` WRITE;
/*!40000 ALTER TABLE `sensores_data` DISABLE KEYS */;
INSERT INTO `sensores_data` VALUES (1,'10006d3b76',57,23.5,'2021-12-26 06:14:53'),(2,'10006d5f32',78,18.7,'2021-12-26 06:14:53'),(3,'1000973fee',75,20.5,'2021-12-26 06:14:53'),(4,'10007c1076',48,20.1,'2021-12-26 06:14:53'),(5,'10006d3b76',46,23.7,'2021-12-27 23:53:27'),(6,'10006d5f32',75,20.6,'2021-12-27 23:53:27'),(7,'1000973fee',75,21.7,'2021-12-27 23:53:27'),(8,'10007c1076',48,20.1,'2021-12-27 23:53:27');
/*!40000 ALTER TABLE `sensores_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-01-15 22:52:04
