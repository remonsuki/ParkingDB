-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: parking_db
-- ------------------------------------------------------
-- Server version	8.0.44

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
-- Table structure for table `park_record`
--

DROP TABLE IF EXISTS `park_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `park_record` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `lot_id` int NOT NULL,
  `entry_time` datetime NOT NULL,
  `exit_time` datetime DEFAULT NULL,
  PRIMARY KEY (`record_id`),
  KEY `user_id` (`user_id`),
  KEY `lot_id` (`lot_id`),
  CONSTRAINT `park_record_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT,
  CONSTRAINT `park_record_ibfk_2` FOREIGN KEY (`lot_id`) REFERENCES `parkinglot` (`lot_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `park_record`
--

LOCK TABLES `park_record` WRITE;
/*!40000 ALTER TABLE `park_record` DISABLE KEYS */;
INSERT INTO `park_record` VALUES (1,1,1,'2025-12-09 15:50:42','2025-12-09 15:57:22'),(2,2,2,'2025-12-09 15:57:00','2025-12-09 15:57:13'),(3,4,1,'2025-12-09 15:57:38',NULL),(4,3,2,'2025-12-09 16:01:17',NULL);
/*!40000 ALTER TABLE `park_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parkinglot`
--

DROP TABLE IF EXISTS `parkinglot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parkinglot` (
  `lot_id` int NOT NULL,
  `total_capacity` int NOT NULL,
  PRIMARY KEY (`lot_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parkinglot`
--

LOCK TABLES `parkinglot` WRITE;
/*!40000 ALTER TABLE `parkinglot` DISABLE KEYS */;
INSERT INTO `parkinglot` VALUES (1,150),(2,80);
/*!40000 ALTER TABLE `parkinglot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `student_id` varchar(20) NOT NULL,
  `name` varchar(10) NOT NULL,
  `password` varchar(255) NOT NULL,
  `card_id` varchar(4) NOT NULL,
  `mail` varchar(100) NOT NULL,
  `violation_count` int NOT NULL DEFAULT '0',
  `is_occupied` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `student_id` (`student_id`),
  UNIQUE KEY `card_id` (`card_id`),
  UNIQUE KEY `mail` (`mail`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'A11423050','吳育安','$2y$10$OxSM/OPPLzGsbLOZuyhQ/OLh0cmYnIIr2GbPRnnA2Gsbj63H1LnoW','5637','a11423050@gemail.yuntech.edu.tw',0,0),(2,'A11423001','曾聖允','$2y$10$.iH6SeSosdyW9eSIg4g6peA59YHeft8DY9LKJCDQOaOJPE85JP2om','1234','a11423001@gemail.yuntech.edu.tw',0,0),(3,'A11423010','詹廷峰','$2y$10$CYS0dslw5TlpQ8bUe.mXLOSxfhlsETBLp.3ePrEhKIUTwrwRrkRUC','2345','a11423010@gemail.yuntech.edu.tw',0,1),(4,'A11423012','陳韋勛','$2y$10$u5k.BZ6ck3/C8tnd8OTtKuLW7lZ0jjoDWvYFd86O2Gqns05ElC9qi','3456','a11423012@gemail.yuntech.edu.tw',1,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicle`
--

DROP TABLE IF EXISTS `vehicle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vehicle` (
  `vehicle_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `plate_id` varchar(10) NOT NULL,
  PRIMARY KEY (`vehicle_id`),
  UNIQUE KEY `plate_id` (`plate_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `vehicle_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicle`
--

LOCK TABLES `vehicle` WRITE;
/*!40000 ALTER TABLE `vehicle` DISABLE KEYS */;
INSERT INTO `vehicle` VALUES (1,1,'NSF-5673'),(2,2,'MNU-8207'),(3,3,'EQU-7632'),(4,4,'NXL-3681');
/*!40000 ALTER TABLE `vehicle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `violation_record`
--

DROP TABLE IF EXISTS `violation_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `violation_record` (
  `violation_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `lot_id` int NOT NULL,
  `violation_date` datetime NOT NULL,
  `record_id` int NOT NULL,
  PRIMARY KEY (`violation_id`),
  UNIQUE KEY `record_id` (`record_id`),
  KEY `user_id` (`user_id`),
  KEY `lot_id` (`lot_id`),
  CONSTRAINT `violation_record_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT,
  CONSTRAINT `violation_record_ibfk_2` FOREIGN KEY (`lot_id`) REFERENCES `parkinglot` (`lot_id`) ON DELETE RESTRICT,
  CONSTRAINT `violation_record_ibfk_3` FOREIGN KEY (`record_id`) REFERENCES `park_record` (`record_id`) ON DELETE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `violation_record`
--

LOCK TABLES `violation_record` WRITE;
/*!40000 ALTER TABLE `violation_record` DISABLE KEYS */;
INSERT INTO `violation_record` VALUES (1,4,1,'2025-12-09 16:00:33',3);
/*!40000 ALTER TABLE `violation_record` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-09 23:04:40
