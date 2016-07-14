CREATE DATABASE  IF NOT EXISTS `donation_votes` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `donation_votes`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: donation_votes
-- ------------------------------------------------------
-- Server version	5.7.13-log

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
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bills` (
  `BILL_ID` varchar(16) NOT NULL,
  `BILL_NAME` varchar(255) DEFAULT NULL,
  `Summary` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`BILL_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donations`
--

DROP TABLE IF EXISTS `donations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `donations` (
  `DON_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `ENT_ID` int(3) DEFAULT NULL,
  `OFF_ID` int(3) DEFAULT NULL,
  `Date` date NOT NULL,
  `Amount` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`DON_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donations`
--

LOCK TABLES `donations` WRITE;
/*!40000 ALTER TABLE `donations` DISABLE KEYS */;
/*!40000 ALTER TABLE `donations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elected_officials`
--

DROP TABLE IF EXISTS `elected_officials`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elected_officials` (
  `OFF_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `LastName` char(25) NOT NULL,
  `FirstName` char(25) NOT NULL,
  `District` int(11) NOT NULL,
  `Office` enum('Senate','Representative','other') DEFAULT NULL,
  `Position` enum('1','2') DEFAULT NULL,
  `Party` enum('D','R','I','L','S','T','O') DEFAULT NULL,
  PRIMARY KEY (`OFF_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elected_officials`
--

LOCK TABLES `elected_officials` WRITE;
/*!40000 ALTER TABLE `elected_officials` DISABLE KEYS */;
/*!40000 ALTER TABLE `elected_officials` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entity`
--

DROP TABLE IF EXISTS `entity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entity` (
  `ENT_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Name` char(255) NOT NULL,
  `Location` char(255) DEFAULT NULL,
  `ROLE_ID` enum('elected_officials','industry','private_citizen','non_profit','interest_group','PAC','OTHER') DEFAULT NULL,
  `Party` enum('D','R','I','L','S','T','O') DEFAULT NULL,
  PRIMARY KEY (`ENT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entity`
--

LOCK TABLES `entity` WRITE;
/*!40000 ALTER TABLE `entity` DISABLE KEYS */;
/*!40000 ALTER TABLE `entity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keyword`
--

DROP TABLE IF EXISTS `keyword`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keyword` (
  `KW_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `BILL_NAME` varchar(255) DEFAULT NULL,
  `Keyword` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`KW_ID`),
  KEY `BILL_NAME_idx` (`BILL_NAME`),
  CONSTRAINT `BILL_NAME` FOREIGN KEY (`BILL_NAME`) REFERENCES `bills` (`BILL_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keyword`
--

LOCK TABLES `keyword` WRITE;
/*!40000 ALTER TABLE `keyword` DISABLE KEYS */;
/*!40000 ALTER TABLE `keyword` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `ROLE_ID` enum('elected_officials','industry','private_citizen','non_profit','interest_group','PAC','OTHER') NOT NULL,
  `Chamber` enum('H','S','none') DEFAULT NULL,
  `Type` enum('private','public-elected','profit','non-profit','ngo') DEFAULT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sponsor`
--

DROP TABLE IF EXISTS `sponsor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sponsor` (
  `SPONSOR_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `BILL_NAME` varchar(255) NOT NULL,
  `ENT_ID` int(3) NOT NULL,
  PRIMARY KEY (`SPONSOR_ID`),
  KEY `BILL_NAME` (`BILL_NAME`),
  CONSTRAINT `BILL_ID` FOREIGN KEY (`BILL_NAME`) REFERENCES `bills` (`BILL_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sponsor`
--

LOCK TABLES `sponsor` WRITE;
/*!40000 ALTER TABLE `sponsor` DISABLE KEYS */;
/*!40000 ALTER TABLE `sponsor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votes` (
  `VOTE_ID` int(3) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `BILL_NAME` varchar(255) DEFAULT NULL,
  `ENT_ID` int(3) DEFAULT NULL,
  `Vote` enum('yeas','nays','absent','excused') DEFAULT NULL,
  PRIMARY KEY (`VOTE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votes`
--

LOCK TABLES `votes` WRITE;
/*!40000 ALTER TABLE `votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'donation_votes'
--

--
-- Dumping routines for database 'donation_votes'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-07-13 20:54:03
