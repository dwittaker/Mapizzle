CREATE DATABASE  IF NOT EXISTS `dbmapizzle` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `dbmapizzle`;
-- MySQL dump 10.13  Distrib 5.1.40, for Win32 (ia32)
--
-- Host: localhost    Database: dbmapizzle
-- ------------------------------------------------------
-- Server version	5.1.51-community

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_objdesign_nodes`
--

DROP TABLE IF EXISTS `tbl_objdesign_nodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_objdesign_nodes` (
  `objnodeID` int(11) NOT NULL,
  `objdesignID` int(11) DEFAULT NULL,
  `pointNum` int(11) DEFAULT NULL,
  `pointX` decimal(6,2) DEFAULT NULL,
  `pointY` decimal(6,2) DEFAULT NULL,
  `nodeName` varchar(45) DEFAULT NULL,
  `nodeRadius` decimal(6,2) DEFAULT NULL,
  `nodeFillColour` int(11) DEFAULT NULL,
  `nodeFillAlpha` decimal(6,2) DEFAULT NULL,
  `nodeStrokeColour` int(11) DEFAULT NULL,
  `nodeStrokeAlpha` decimal(6,2) DEFAULT NULL,
  `nodeStrokeWidth` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`objnodeID`),
  KEY `objNodes` (`objdesignID`),
  CONSTRAINT `objNodes` FOREIGN KEY (`objdesignID`) REFERENCES `tbl_objdesign` (`idobjDesign`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_objdesign_nodes`
--

LOCK TABLES `tbl_objdesign_nodes` WRITE;
/*!40000 ALTER TABLE `tbl_objdesign_nodes` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_objdesign_nodes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-10-16  2:36:02
