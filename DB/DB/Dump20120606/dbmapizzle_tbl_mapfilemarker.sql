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
-- Table structure for table `tbl_mapfilemarker`
--

DROP TABLE IF EXISTS `tbl_mapfilemarker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbl_mapfilemarker` (
  `mfmarkerID` int(11) NOT NULL AUTO_INCREMENT,
  `mfmarkerName` varchar(100) NOT NULL,
  `mfmarkerTitle` varchar(200) DEFAULT NULL,
  `mfmarkerDescription` varchar(300) DEFAULT NULL,
  `mapfileID` int(11) NOT NULL,
  `activeSW` bit(1) NOT NULL,
  `PosRelStgX` decimal(10,0) NOT NULL,
  `PosRelStgY` decimal(10,0) NOT NULL,
  `PosRelmfX` decimal(10,0) NOT NULL,
  `PosRelmfY` decimal(10,0) NOT NULL,
  `dttmMarked` datetime NOT NULL,
  `dttmRemoved` datetime DEFAULT NULL,
  PRIMARY KEY (`mfmarkerID`),
  KEY `FK_mfmarker_mapfile` (`mapfileID`),
  CONSTRAINT `FK_mfmarker_mapfile` FOREIGN KEY (`mapfileID`) REFERENCES `tbl_mapfile` (`mapfileID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_mapfilemarker`
--

LOCK TABLES `tbl_mapfilemarker` WRITE;
/*!40000 ALTER TABLE `tbl_mapfilemarker` DISABLE KEYS */;
INSERT INTO `tbl_mapfilemarker` VALUES (1,'tst','test','test desc',29,'','148','561','50','100','2012-03-29 00:00:00',NULL),(2,'Mrkr_20120401170925299','Title:Mrkr_20120401170925299','Desc:Mrkr_20120401170925299',29,'','209','560','502','219','2012-04-03 01:20:20',NULL),(3,'Mrkr_20120410005840605','Title:Mrkr_20120410005840605','Desc:Mrkr_20120410005840605',29,'','651','474','316','146','2012-04-10 00:58:53',NULL),(4,'Mrkr_20120410005848849','Title:Mrkr_20120410005848849','Desc:Mrkr_20120410005848849',29,'','569','351','675','200','2012-04-10 00:58:53',NULL),(5,'Mrkr_20120523224136305','Title:Mrkr_20120523224136305','Desc:Mrkr_20120523224136305',29,'','209','502','209','151','2012-05-23 22:41:39',NULL),(6,'Mrkr_20120524215446610','Title:Mrkr_20120524215446610','Desc:Mrkr_20120524215446610',29,'','146','502','161','520','2012-05-24 21:54:48',NULL),(7,'Mrkr_20120527214210040','Title:Mrkr_20120527214210040','Desc:Mrkr_20120527214210040',29,'','654','315','669','333','2012-05-27 21:42:12',NULL),(8,'Mrkr_20120529213242477','Title:Mrkr_20120529213242477','Desc:Mrkr_20120529213242477',33,'','498','402','498','402','2012-05-29 21:32:44',NULL);
/*!40000 ALTER TABLE `tbl_mapfilemarker` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-06-06 19:32:16
