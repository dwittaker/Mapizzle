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
-- Table structure for table `tbl_map`
--

DROP TABLE IF EXISTS `tbl_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_map` (
  `mapID` int(11) NOT NULL AUTO_INCREMENT,
  `mapName` varchar(100) DEFAULT NULL,
  `mapTitle` varchar(100) DEFAULT NULL,
  `mapDescription` varchar(300) DEFAULT NULL,
  `mapCreatorID` int(11) DEFAULT NULL,
  `mapActiveFileID` int(11) DEFAULT NULL,
  PRIMARY KEY (`mapID`),
  KEY `MapFile_Key` (`mapActiveFileID`),
  CONSTRAINT `MapFile_Key` FOREIGN KEY (`mapActiveFileID`) REFERENCES `tbl_mapfile` (`mapfileID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_map`
--

LOCK TABLES `tbl_map` WRITE;
/*!40000 ALTER TABLE `tbl_map` DISABLE KEYS */;
INSERT INTO `tbl_map` VALUES (1,'TEST','Test of Sys','This is just a test map',1,29),(2,'test','test title','desc test',1,NULL),(3,'nametest','titletest','desctest',1,NULL),(4,'n','t','d',1,NULL),(5,'n2','t2','d2',1,NULL),(6,'n2','t2','d2',1,NULL),(7,'n3','t3','d3',1,NULL),(8,'n4','t4','d4',1,NULL),(9,'aaa','bbb','ccc',1,NULL),(10,'faf','fagg','gee',1,NULL),(11,'fea','hgg','aaa',1,30),(12,'BMWn','BMWt','BMWD',1,31);
/*!40000 ALTER TABLE `tbl_map` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-25 23:34:04
