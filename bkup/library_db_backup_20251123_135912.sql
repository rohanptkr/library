/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.29-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: library_db
-- ------------------------------------------------------
-- Server version	10.5.29-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `members` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `member_id` varchar(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `registration_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `status` enum('ACTIVE','EXPIRED') DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `aadhar` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `member_id` (`member_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `aadhar` (`aadhar`),
  CONSTRAINT `chk_phone_length` CHECK (octet_length(`phone`) = 10 and `phone` regexp '^[0-9]{10}$')
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
INSERT INTO `members` VALUES (1,'PL1','adasdsadz','dildaraaowye@gmail.com','1213123415','2025-11-23','2026-01-23','ACTIVE','2025-11-23 07:06:41',NULL),(2,'PL2','Roal','dildarqcye@gmail.com','8014952792','2025-11-23','2025-12-23','ACTIVE','2025-11-23 07:07:08',NULL),(3,'PL3','Rohan','dildaraaoye@gmail.com','8010952792','2025-11-23','2025-12-23','ACTIVE','2025-11-23 07:07:37',NULL),(9,'PL4','Rohan','asdasdadadszxczcz@gmail.com','8010952792','2025-11-23','2025-12-23','ACTIVE','2025-11-23 12:28:49',NULL),(10,'PL5','hul vbruce','avengers@gmail.com','8010952792','2025-11-23','2026-01-23','ACTIVE','2025-11-23 12:32:24',NULL),(11,'MEM1763904457290','ram','vaibhav@gmail.com','8862078702','2025-11-23','2025-12-23','ACTIVE','2025-11-23 13:27:37','436095167555'),(12,'PL6','vaibhav','ram@gmail.com','9422758545','2025-11-23','2025-12-23','ACTIVE','2025-11-23 13:40:03','436095552355'),(13,'PL7','gajar','garaj@gmail.com','1235446877','2025-11-23','2025-12-23','ACTIVE','2025-11-23 13:43:21','436095552323'),(14,'PL8','tony','stark@gmail.com','3322116655','2025-11-23','2025-12-23','ACTIVE','2025-11-23 13:48:26','436095115465'),(15,'PL9','jagga','jassos@gmail.com','1213121233','2025-11-23','2025-12-23','ACTIVE','2025-11-23 13:59:12','436095167559');
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-23 13:59:12
