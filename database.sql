-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: ticketing_system_lab3
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `artist`
--

DROP TABLE IF EXISTS `artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(100) NOT NULL,
  `artist_type` enum('singer','band','actor','train_operator','airline') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artist`
--

LOCK TABLES `artist` WRITE;
/*!40000 ALTER TABLE `artist` DISABLE KEYS */;
INSERT INTO `artist` VALUES (1,'The Rock Band','band'),(2,'John Doe','singer'),(3,'The Actors Group','actor'),(4,'Train Operator A','train_operator'),(5,'Airline B','airline'),(6,'The Jazz Trio','band'),(7,'Theater Ensemble','actor'),(8,'Classical Symphony','band'),(9,'Train Operator B','train_operator'),(10,'Airline C','airline'),(11,'The Rock Band','band'),(12,'Sarah Connor','singer'),(13,'Mr. Bean','actor'),(14,'Train Operator Co.','train_operator'),(15,'Airline XYZ','airline');
/*!40000 ALTER TABLE `artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (2,'UpdatedName','UpdatedSurname','updated.email@example.com','9876543210'),(3,'Alice','Smith','alice.smith@example.com','111222333'),(4,'Bob','Brown','bob.brown@example.com','222333444'),(5,'Charlie','Black','charlie.black@example.com','333444555'),(6,'Eve','White','eve.white@example.com','444555666'),(7,'Frank','Green','frank.green@example.com','555666777'),(8,'Grace','Adams','grace.adams@example.com','666777888'),(9,'Henry','Clark','henry.clark@example.com','777888999'),(10,'Ivy','Jones','ivy.jones@example.com','888999000'),(11,'Anna','Ivanova','anna.ivanova@example.com','2345678901'),(12,'Anna','Ivanova','anna.ivanova@example.com','2345678901'),(13,'Anna','Ivanova','anna.ivanova@example.com','2345678901'),(14,'John','Doe','john.doe@example.com','1234567890'),(15,'Jane','Smith','jane.smith@example.com','2345678901'),(16,'Alice','Johnson','alice.johnson@example.com','3456789012'),(17,'Bob','Brown','bob.brown@example.com','4567890123'),(18,'Charlie','Davis','charlie.davis@example.com','5678901234'),(19,'Anna','Ivanova','anna.ivanova@example.com','2345678901'),(20,'Anna','Ivanova','anna.ivanova@example.com','2345678901'),(21,'Anna','Ivanova','anna.ivanova@example.com','2345678901');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_phone_format` BEFORE INSERT ON `customer` FOR EACH ROW BEGIN
    IF NEW.phone LIKE '%00' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phone number cannot end with two zeros';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `delivery_option`
--

DROP TABLE IF EXISTS `delivery_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_option` (
  `id` int NOT NULL AUTO_INCREMENT,
  `delivery_type` enum('email','sms','pickup','mail') NOT NULL,
  `cost` decimal(5,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_option`
--

LOCK TABLES `delivery_option` WRITE;
/*!40000 ALTER TABLE `delivery_option` DISABLE KEYS */;
INSERT INTO `delivery_option` VALUES (1,'email',0.00),(2,'sms',0.50),(3,'pickup',1.00),(4,'mail',2.50),(5,'email',0.00),(6,'sms',0.00),(7,'pickup',5.00),(8,'mail',10.00);
/*!40000 ALTER TABLE `delivery_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event`
--

DROP TABLE IF EXISTS `event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event` (
  `id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) NOT NULL,
  `event_date` date NOT NULL,
  `event_time` time NOT NULL,
  `location` varchar(100) NOT NULL,
  `event_type` enum('concert','theater','train','flight') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event`
--

LOCK TABLES `event` WRITE;
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
INSERT INTO `event` VALUES (1,'Rock Concert','2024-11-01','19:00:00','City Stadium','concert'),(2,'Theater Play','2024-11-02','18:00:00','Drama Theater','theater'),(3,'Train Ride','2024-11-03','08:00:00','Central Station','train'),(4,'Jazz Concert','2024-11-04','20:00:00','Jazz Club','concert'),(5,'Flight to Paris','2024-11-05','09:00:00','Airport','flight'),(6,'Rock Concert','2024-11-06','19:00:00','Music Hall','concert'),(7,'Comedy Show','2024-11-07','20:00:00','City Arena','theater'),(8,'Classical Concert','2024-11-08','18:00:00','Grand Theater','concert'),(9,'Train Ride','2024-11-09','08:30:00','North Station','train'),(10,'Flight to New York','2024-11-10','07:00:00','Airport','flight'),(11,'Concert of the Year','2024-11-01','19:00:00','Stadium','concert'),(12,'Theater Show','2024-11-05','20:00:00','City Theater','theater'),(13,'Flight to New York','2024-11-10','15:00:00','Airport','flight'),(14,'Train Journey','2024-11-12','08:00:00','Train Station','train');
/*!40000 ALTER TABLE `event` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prevent_delete_event` BEFORE DELETE ON `event` FOR EACH ROW BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Deleting rows from the event table is not allowed';
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `event_artist`
--

DROP TABLE IF EXISTS `event_artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_artist` (
  `event_id` int NOT NULL,
  `artist_id` int NOT NULL,
  PRIMARY KEY (`event_id`,`artist_id`),
  KEY `fk_event_artist_artist` (`artist_id`),
  CONSTRAINT `fk_event_artist_artist` FOREIGN KEY (`artist_id`) REFERENCES `artist` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_event_artist_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_artist`
--

LOCK TABLES `event_artist` WRITE;
/*!40000 ALTER TABLE `event_artist` DISABLE KEYS */;
INSERT INTO `event_artist` VALUES (1,1),(2,1),(1,2),(2,2),(3,2),(2,3),(3,4),(1,5),(4,5),(1,15),(2,15),(3,15);
/*!40000 ALTER TABLE `event_artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_venue`
--

DROP TABLE IF EXISTS `event_venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_venue` (
  `event_id` int NOT NULL,
  `venue_id` int NOT NULL,
  PRIMARY KEY (`event_id`,`venue_id`),
  KEY `fk_event_venue_venue` (`venue_id`),
  CONSTRAINT `fk_event_venue_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_event_venue_venue` FOREIGN KEY (`venue_id`) REFERENCES `venue` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_venue`
--

LOCK TABLES `event_venue` WRITE;
/*!40000 ALTER TABLE `event_venue` DISABLE KEYS */;
INSERT INTO `event_venue` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
/*!40000 ALTER TABLE `event_venue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extra_table`
--

DROP TABLE IF EXISTS `extra_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `extra_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_id` int DEFAULT NULL,
  `description` varchar(255) DEFAULT 'Default Description',
  `column_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extra_table`
--

LOCK TABLES `extra_table` WRITE;
/*!40000 ALTER TABLE `extra_table` DISABLE KEYS */;
INSERT INTO `extra_table` VALUES (1,1,'Default Description','Noname1'),(2,2,'Default Description','Noname2'),(3,3,'Default Description','Noname3'),(4,4,'Default Description','Noname4'),(5,5,'Default Description','Noname5'),(6,6,'Default Description','Noname6'),(7,7,'Default Description','Noname7'),(8,8,'Default Description','Noname8'),(9,9,'Default Description','Noname9'),(10,10,'Default Description','Noname10'),(11,1,'SomeAdditionalValue',NULL),(12,1,'Default Description','Noname1'),(13,2,'Default Description','Noname2'),(14,3,'Default Description','Noname3'),(15,4,'Default Description','Noname4'),(16,5,'Default Description','Noname5'),(17,6,'Default Description','Noname6'),(18,7,'Default Description','Noname7'),(19,8,'Default Description','Noname8'),(20,9,'Default Description','Noname9'),(21,10,'Default Description','Noname10'),(22,1,'SOMEADDITIONALVALUE',NULL),(23,1,'Default Description','Noname1'),(24,2,'Default Description','Noname2'),(25,3,'Default Description','Noname3'),(26,4,'Default Description','Noname4'),(27,5,'Default Description','Noname5'),(28,6,'Default Description','Noname6'),(29,7,'Default Description','Noname7'),(30,8,'Default Description','Noname8'),(31,9,'Default Description','Noname9'),(32,10,'Default Description','Noname10'),(33,1,'SOMEADDITIONALVALUE',NULL),(34,2,'SOMEADDITIONALVALUE',NULL),(35,1,'Default Description','Noname1'),(36,2,'Default Description','Noname2'),(37,3,'Default Description','Noname3'),(38,4,'Default Description','Noname4'),(39,5,'Default Description','Noname5'),(40,6,'Default Description','Noname6'),(41,7,'Default Description','Noname7'),(42,8,'Default Description','Noname8'),(43,9,'Default Description','Noname9'),(44,10,'Default Description','Noname10'),(45,10,'normal',NULL);
/*!40000 ALTER TABLE `extra_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `extra_table_artist_fk` BEFORE INSERT ON `extra_table` FOR EACH ROW BEGIN
    DECLARE artist_exists INT;
    SELECT COUNT(*) INTO artist_exists
    FROM artist
    WHERE id = NEW.artist_id;
    
    IF artist_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'artist_id does not exist in artist table';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `order_date` date NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `payment_status` enum('paid','pending','cancelled') NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_order_customer` (`customer_id`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (2,2,'2024-11-02',70.00,'pending'),(3,3,'2024-11-03',50.00,'paid'),(4,4,'2024-11-04',90.00,'cancelled'),(5,5,'2024-11-05',150.00,'paid'),(6,6,'2024-11-06',200.00,'pending'),(7,7,'2024-11-07',75.00,'paid'),(8,8,'2024-11-08',125.00,'paid'),(9,9,'2024-11-09',100.00,'pending'),(10,10,'2024-11-10',250.00,'paid'),(11,1,'2024-10-15',200.00,'paid'),(12,2,'2024-10-16',100.00,'pending'),(13,3,'2024-10-17',150.00,'cancelled');
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_delivery`
--

DROP TABLE IF EXISTS `order_delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_delivery` (
  `order_id` int NOT NULL,
  `delivery_option_id` int NOT NULL,
  PRIMARY KEY (`order_id`,`delivery_option_id`),
  KEY `fk_order_delivery_delivery_option` (`delivery_option_id`),
  CONSTRAINT `fk_order_delivery_delivery_option` FOREIGN KEY (`delivery_option_id`) REFERENCES `delivery_option` (`id`),
  CONSTRAINT `fk_order_delivery_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_delivery`
--

LOCK TABLES `order_delivery` WRITE;
/*!40000 ALTER TABLE `order_delivery` DISABLE KEYS */;
INSERT INTO `order_delivery` VALUES (5,1),(9,1),(2,2),(6,2),(10,2),(3,3),(7,3),(4,4),(8,4);
/*!40000 ALTER TABLE `order_delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `order_id` int NOT NULL,
  `ticket_id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`order_id`,`ticket_id`),
  KEY `fk_order_details_ticket` (`ticket_id`),
  CONSTRAINT `fk_order_details_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_order_details_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
INSERT INTO `order_details` VALUES (1,1,2),(1,2,1),(2,2,1),(2,3,1),(3,3,1),(4,4,2),(5,5,1),(6,6,2),(7,7,1),(8,8,1),(9,9,1),(10,10,3);
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `random_table`
--

DROP TABLE IF EXISTS `random_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `random_table` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_id` int DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `random_table`
--

LOCK TABLES `random_table` WRITE;
/*!40000 ALTER TABLE `random_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `random_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `random_table1_20241123215210`
--

DROP TABLE IF EXISTS `random_table1_20241123215210`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `random_table1_20241123215210` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(100) NOT NULL,
  `artist_type` enum('singer','band','actor','train_operator','airline') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `random_table1_20241123215210`
--

LOCK TABLES `random_table1_20241123215210` WRITE;
/*!40000 ALTER TABLE `random_table1_20241123215210` DISABLE KEYS */;
INSERT INTO `random_table1_20241123215210` VALUES (2,'John Doe','singer'),(3,'The Actors Group','actor'),(9,'Train Operator B','train_operator'),(14,'Train Operator Co.','train_operator'),(15,'Airline XYZ','airline');
/*!40000 ALTER TABLE `random_table1_20241123215210` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `random_table1_20241123220124`
--

DROP TABLE IF EXISTS `random_table1_20241123220124`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `random_table1_20241123220124` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(100) NOT NULL,
  `artist_type` enum('singer','band','actor','train_operator','airline') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `random_table1_20241123220124`
--

LOCK TABLES `random_table1_20241123220124` WRITE;
/*!40000 ALTER TABLE `random_table1_20241123220124` DISABLE KEYS */;
INSERT INTO `random_table1_20241123220124` VALUES (2,'John Doe','singer'),(3,'The Actors Group','actor'),(7,'Theater Ensemble','actor'),(11,'The Rock Band','band'),(14,'Train Operator Co.','train_operator');
/*!40000 ALTER TABLE `random_table1_20241123220124` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `random_table2_20241123215210`
--

DROP TABLE IF EXISTS `random_table2_20241123215210`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `random_table2_20241123215210` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(100) NOT NULL,
  `artist_type` enum('singer','band','actor','train_operator','airline') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `random_table2_20241123215210`
--

LOCK TABLES `random_table2_20241123215210` WRITE;
/*!40000 ALTER TABLE `random_table2_20241123215210` DISABLE KEYS */;
INSERT INTO `random_table2_20241123215210` VALUES (1,'The Rock Band','band'),(4,'Train Operator A','train_operator'),(5,'Airline B','airline'),(6,'The Jazz Trio','band'),(7,'Theater Ensemble','actor'),(8,'Classical Symphony','band'),(10,'Airline C','airline'),(11,'The Rock Band','band'),(12,'Sarah Connor','singer'),(13,'Mr. Bean','actor');
/*!40000 ALTER TABLE `random_table2_20241123215210` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `random_table2_20241123220124`
--

DROP TABLE IF EXISTS `random_table2_20241123220124`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `random_table2_20241123220124` (
  `id` int NOT NULL AUTO_INCREMENT,
  `artist_name` varchar(100) NOT NULL,
  `artist_type` enum('singer','band','actor','train_operator','airline') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `random_table2_20241123220124`
--

LOCK TABLES `random_table2_20241123220124` WRITE;
/*!40000 ALTER TABLE `random_table2_20241123220124` DISABLE KEYS */;
INSERT INTO `random_table2_20241123220124` VALUES (1,'The Rock Band','band'),(4,'Train Operator A','train_operator'),(5,'Airline B','airline'),(6,'The Jazz Trio','band'),(8,'Classical Symphony','band'),(9,'Train Operator B','train_operator'),(10,'Airline C','airline'),(12,'Sarah Connor','singer'),(13,'Mr. Bean','actor'),(15,'Airline XYZ','airline');
/*!40000 ALTER TABLE `random_table2_20241123220124` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ticket_number` varchar(50) NOT NULL,
  `event_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `seat_number` varchar(10) DEFAULT NULL,
  `class` enum('economy','business','VIP') NOT NULL,
  `is_available` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `fk_ticket_event` (`event_id`),
  CONSTRAINT `fk_ticket_event` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,'TCK001',1,50.00,'A1','VIP',1),(2,'TCK002',2,35.00,'B2','economy',1),(3,'TCK003',3,20.00,'C3','business',1),(4,'TCK004',4,45.00,'A4','VIP',1),(5,'TCK005',5,150.00,'B5','economy',1),(6,'TCK006',6,50.00,'C6','VIP',1),(7,'TCK007',7,35.00,'D7','business',1),(8,'TCK008',8,100.00,'E8','VIP',1),(9,'TCK009',9,25.00,'F9','economy',1),(10,'TCK010',10,200.00,'G10','VIP',1),(11,'TCKT001',1,100.00,'A1','VIP',1),(12,'TCKT002',1,75.00,'A2','business',1),(13,'TCKT003',2,50.00,'B1','economy',1),(14,'TCKT004',3,200.00,NULL,'VIP',1),(15,'TCKT005',4,30.00,'C1','economy',1);
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `venue`
--

DROP TABLE IF EXISTS `venue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `venue` (
  `id` int NOT NULL AUTO_INCREMENT,
  `venue_name` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `capacity` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `venue`
--

LOCK TABLES `venue` WRITE;
/*!40000 ALTER TABLE `venue` DISABLE KEYS */;
INSERT INTO `venue` VALUES (1,'City Stadium','Downtown',5000),(2,'Drama Theater','Main Square',800),(3,'Central Station','City Center',3000),(4,'Jazz Club','Old Town',300),(5,'Airport','East Side',2000),(6,'Music Hall','West Side',1500),(7,'City Arena','North End',4000),(8,'Grand Theater','East End',1200),(9,'North Station','Northern District',2500),(10,'International Airport','Suburbs',5000);
/*!40000 ALTER TABLE `venue` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `prevent_update_venue` BEFORE UPDATE ON `venue` FOR EACH ROW BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Updates are not allowed on the venue table';
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'ticketing_system_lab3'
--

--
-- Dumping routines for database 'ticketing_system_lab3'
--
/*!50003 DROP FUNCTION IF EXISTS `ColumnStatFunction` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `ColumnStatFunction`(stat_type VARCHAR(10)) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE result DECIMAL(10,2);

    IF stat_type = 'MAX' THEN
        SELECT MAX(total_price) INTO result FROM `order`;
    ELSEIF stat_type = 'MIN' THEN
        SELECT MIN(total_price) INTO result FROM `order`;
    ELSEIF stat_type = 'SUM' THEN
        SELECT SUM(total_price) INTO result FROM `order`;
    ELSEIF stat_type = 'AVG' THEN
        SELECT AVG(total_price) INTO result FROM `order`;
    ELSE
        SET result = NULL;
    END IF;

    RETURN result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CalculateDynamicStatistic` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CalculateDynamicStatistic`(
    IN table_name VARCHAR(64), 
    IN column_name VARCHAR(64), 
    IN stat_type VARCHAR(10), 
    OUT result DECIMAL(10,2)
)
BEGIN
    DECLARE dynamic_result DECIMAL(10,2);

    -- Побудова динамічного запиту
    SET @sql_query = CONCAT('SELECT ', stat_type, '(', column_name, ') INTO @dynamic_result FROM ', table_name);

    -- Виконання запиту
    PREPARE stmt FROM @sql_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Використання функції ColumnStatFunction для обчислення статистики
    IF table_name = 'order' AND column_name = 'total_price' THEN
        SET dynamic_result = ColumnStatFunction(stat_type);
    ELSE
        SET dynamic_result = @dynamic_result;
    END IF;

    -- Присвоєння результату вихідному параметру
    SET result = dynamic_result;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CopyToRandomTables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CopyToRandomTables`(IN source_table_name VARCHAR(255))
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE column_list TEXT;
    DECLARE id_value INT;
    DECLARE artist_name_value VARCHAR(255);
    DECLARE artist_type_value VARCHAR(255);  
    DECLARE cur CURSOR FOR SELECT id, artist_name, artist_type FROM artist;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- Генерація унікальних імен таблиць із міткою часу
    SET @timestamp = DATE_FORMAT(NOW(), '%Y%m%d%H%i%s');
    SET @table1_name = CONCAT('random_table1_', @timestamp);
    SET @table2_name = CONCAT('random_table2_', @timestamp);

    -- Отримання списку колонок із батьківської таблиці
    SET @column_query = CONCAT('SELECT GROUP_CONCAT(COLUMN_NAME) INTO @column_list FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = \'', source_table_name, '\' AND TABLE_SCHEMA = DATABASE()');
    PREPARE stmt FROM @column_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Створення нових таблиць зі структурою батьківської таблиці
    SET @create_table1_query = CONCAT('CREATE TABLE ', @table1_name, ' LIKE ', source_table_name);
    SET @create_table2_query = CONCAT('CREATE TABLE ', @table2_name, ' LIKE ', source_table_name);
    PREPARE stmt FROM @create_table1_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    PREPARE stmt FROM @create_table2_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Ініціалізація курсора для отримання даних з батьківської таблиці
    SET @select_query = CONCAT('SELECT * FROM ', source_table_name);
    PREPARE stmt FROM @select_query;
    OPEN cur;

    -- Цикл для розподілу даних між таблицями
    read_loop: LOOP
        FETCH cur INTO id_value, artist_name_value, artist_type_value;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Випадкове визначення таблиці для вставки
        IF FLOOR(1 + (RAND() * 2)) = 1 THEN
            SET @insert_query = CONCAT('INSERT INTO ', @table1_name, ' VALUES (', id_value, ', \'', artist_name_value, '\', \'', artist_type_value, '\')');
        ELSE
            SET @insert_query = CONCAT('INSERT INTO ', @table2_name, ' VALUES (', id_value, ', \'', artist_name_value, '\', \'', artist_type_value, '\')');
        END IF;

        PREPARE stmt FROM @insert_query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END LOOP;

    CLOSE cur;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertBatchToExtraTable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertBatchToExtraTable`()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 10 DO
        INSERT INTO extra_table (artist_id, column_value)
        VALUES (i, CONCAT('Noname', i));
        
        SET i = i + 1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertIntoExtraTable` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertIntoExtraTable`(IN p_artist_id INT, IN p_description VARCHAR(255))
BEGIN
    INSERT INTO extra_table (artist_id, description)
    VALUES (p_artist_id, p_description);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `LinkArtistToEvent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `LinkArtistToEvent`(IN artist_id INT, IN event_id INT)
BEGIN
    INSERT INTO event_artist (event_id, artist_id)
    SELECT event.id, artist.id
    FROM artist
    JOIN event ON event.id = event_id AND artist.id = artist_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-11-23 22:12:32
