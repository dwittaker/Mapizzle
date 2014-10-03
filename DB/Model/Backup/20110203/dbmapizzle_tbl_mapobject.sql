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
-- Table structure for table `tbl_mapobject`
--

DROP TABLE IF EXISTS `tbl_mapobject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_mapobject` (
  `ObjID` int(11) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Title` varchar(65) DEFAULT NULL,
  `Description` varchar(300) DEFAULT NULL,
  `Priority` int(11) DEFAULT NULL,
  `Area` varchar(200) DEFAULT NULL,
  `CreatorID` int(11) DEFAULT NULL,
  `MapID` int(11) DEFAULT NULL,
  `RelObjID` int(11) DEFAULT NULL,
  PRIMARY KEY (`ObjID`),
  KEY `ObjPriority` (`Priority`),
  KEY `mapObj` (`MapID`),
  CONSTRAINT `mapObj` FOREIGN KEY (`MapID`) REFERENCES `tbl_map` (`mapID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ObjPriority` FOREIGN KEY (`Priority`) REFERENCES `tbl_priority` (`priorityID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_mapobject`
--

LOCK TABLES `tbl_mapobject` WRITE;
/*!40000 ALTER TABLE `tbl_mapobject` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_mapobject` ENABLE KEYS */;
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
