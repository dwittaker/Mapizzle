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
  `ObjID` int(11) NOT NULL AUTO_INCREMENT,
  `ObjName` varchar(100) DEFAULT NULL,
  `Title` varchar(65) DEFAULT NULL,
  `Description` varchar(300) DEFAULT NULL,
  `Priority` int(11) DEFAULT NULL,
  `Area` varchar(200) DEFAULT NULL,
  `CreatorID` int(11) DEFAULT NULL,
  `LayerID` int(11) DEFAULT NULL,
  `RelObjID` int(11) DEFAULT NULL,
  `HasAttach` bit(1) DEFAULT b'0',
  `HasSchedule` bit(1) DEFAULT b'0',
  `HasShare` bit(1) DEFAULT b'0',
  `HasNotes` bit(1) DEFAULT b'0',
  `HasTasks` bit(1) DEFAULT b'0',
  `HasConvo` bit(1) DEFAULT b'0',
  `dttmCreated` datetime DEFAULT NULL,
  `dttmRemoved` datetime DEFAULT NULL,
  `remSW` bit(1) DEFAULT b'0',
  PRIMARY KEY (`ObjID`),
  KEY `ObjPriority` (`Priority`),
  KEY `mapObj` (`LayerID`),
  KEY `LayerObj` (`LayerID`),
  CONSTRAINT `LayerObj` FOREIGN KEY (`LayerID`) REFERENCES `tbl_maplayer` (`layerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `ObjPriority` FOREIGN KEY (`Priority`) REFERENCES `tbl_priority` (`priorityID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_mapobject`
--

LOCK TABLES `tbl_mapobject` WRITE;
/*!40000 ALTER TABLE `tbl_mapobject` DISABLE KEYS */;
INSERT INTO `tbl_mapobject` VALUES (1,'Block1','Maintenance','Just a maintenance activity test',1,'Somewhere',1,1,NULL,'\0','\0','\0','\0','\0','\0','2010-10-25 04:00:00','2011-04-25 14:03:45',''),(2,'Circle1','Recon','Recon Test',3,'Over yonder',1,1,NULL,'\0','\0','\0','\0','\0','\0','2010-10-26 09:00:00','2011-04-25 14:03:45',''),(3,'Poly1','Work Area','Where it is to be done',5,'Right there',1,1,NULL,'\0','\0','\0','\0','\0','\0','2010-10-28 08:00:00','2011-04-25 14:01:15',''),(37,'Block_20101210234029842','feafe','feafae',5,'feafaef',1,1,0,'\0','\0','\0','\0','\0','\0','2010-12-10 23:40:47',NULL,'\0'),(38,'Circle_20110314221619220','rnd','test',5,'round new',1,1,0,'\0','\0','\0','\0','\0','\0','2011-03-14 22:16:51','2011-04-25 14:03:45',''),(41,'Block_20110316000528362','tttttt','iyfrjd',3,'jhhhhh',1,1,0,'\0','\0','\0','\0','\0','\0','2011-03-16 00:06:30','2011-03-16 21:17:00',''),(43,'Poly_20110316003438386','grgr','feeee',1,'grefe',1,1,0,'\0','\0','\0','\0','\0','\0','2011-03-16 00:35:12','2011-03-16 21:17:00',''),(44,'Block_20110316003944227','dd','jeduttd',3,'kf',1,1,0,'\0','\0','\0','\0','\0','\0','2011-03-16 00:40:11','2011-03-16 21:17:00',''),(46,'Block_20110316182412143','ee','aadda',3,'',1,1,0,'\0','\0','\0','\0','\0','\0','2011-03-16 18:24:29','2011-03-16 21:17:00',''),(47,'Block_20110316183250259','dvvz','nbdz',1,'dzvzd',1,1,0,'\0','\0','\0','\0','\0','\0','2011-03-16 18:34:35','2011-03-16 21:17:00',''),(48,'Block_20110316212731305','gerga','gea',5,'feafea',1,1,0,'\0','\0','\0','\0','\0','\0','2011-03-16 21:28:01','2011-04-26 06:27:36',''),(49,'Block_20110320165501082','fgaef','feafa',5,'feafa',1,1,0,'\0','\0','\0','\0','\0','\0','2011-03-20 16:55:19','2011-04-25 14:11:30',''),(51,'Poly_20110426165641541','testpolydel','test',5,'',1,1,0,'\0','\0','\0','\0','\0','\0','2011-04-26 16:57:09',NULL,'\0'),(52,'Block_20110426170322389','ge','gewaa',5,'weafa',1,1,0,'\0','\0','\0','\0','\0','\0','2011-04-26 17:04:18',NULL,'\0');
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

-- Dump completed on 2012-06-06 19:32:07
