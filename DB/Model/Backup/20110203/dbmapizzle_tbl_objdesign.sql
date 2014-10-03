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
-- Table structure for table `tbl_objdesign`
--

DROP TABLE IF EXISTS `tbl_objdesign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_objdesign` (
  `idobjDesign` int(11) NOT NULL,
  `ObjID` int(11) NOT NULL,
  `Type` varchar(15) DEFAULT NULL,
  `FillColour` int(11) DEFAULT NULL,
  `FillAlpha` decimal(5,2) DEFAULT NULL,
  `StrokeColour` int(11) DEFAULT NULL,
  `StrokeAlpha` decimal(5,2) DEFAULT NULL,
  `StrokeWidth` decimal(6,2) DEFAULT NULL,
  `PosRelStgX` decimal(6,0) DEFAULT NULL,
  `PosRelStgY` decimal(6,0) DEFAULT NULL,
  `PosRelObjX` decimal(6,0) DEFAULT NULL,
  `PosRelObjY` decimal(6,0) DEFAULT NULL,
  `SizeRadius` decimal(6,2) DEFAULT NULL,
  `SizeWidth` decimal(6,2) DEFAULT NULL,
  `SizeHeight` decimal(6,2) DEFAULT NULL,
  `FirstPosX` decimal(6,2) DEFAULT NULL,
  `FirstPosY` decimal(6,2) DEFAULT NULL,
  `NodeCnt` int(11) DEFAULT NULL,
  `Block_topLeftX` decimal(6,2) DEFAULT NULL,
  `Block_topLeftY` decimal(6,2) DEFAULT NULL,
  `Block_botRightX` decimal(6,2) DEFAULT NULL,
  `Block_botRightY` decimal(6,2) DEFAULT NULL,
  `Circle_centreX` decimal(6,2) DEFAULT NULL,
  `Circle_centreY` decimal(6,2) DEFAULT NULL,
  `Circle_circumX` decimal(6,2) DEFAULT NULL,
  `Circle_circumY` decimal(6,2) DEFAULT NULL,
  `Circle_radius` decimal(6,2) DEFAULT NULL,
  `Poly_firstX` decimal(6,2) DEFAULT NULL,
  `Poly_firstY` decimal(6,2) DEFAULT NULL,
  `Poly_lastX` decimal(6,2) DEFAULT NULL,
  `Poly_lastY` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`idobjDesign`),
  KEY `mapObjId` (`ObjID`),
  CONSTRAINT `mapObjId` FOREIGN KEY (`ObjID`) REFERENCES `tbl_mapobject` (`ObjID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_objdesign`
--

LOCK TABLES `tbl_objdesign` WRITE;
/*!40000 ALTER TABLE `tbl_objdesign` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_objdesign` ENABLE KEYS */;
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
