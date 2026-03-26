-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: media_base
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `media_id` int unsigned NOT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`media_id`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (3,'Little, Brown and Company'),(12,'Kodansha');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `media_id` int unsigned DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`),
  KEY `media_id` (`media_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,4,3,'I love this song so much'),(2,5,3,'The Slow Development of a Masterpiece'),(3,5,7,'Great serial killer drama');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('book','movie','music','tv') NOT NULL,
  `title` varchar(128) NOT NULL,
  `description` text,
  `release_date` date DEFAULT NULL,
  `create_time` timestamp NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
INSERT INTO `media` VALUES (1,'movie','No Country for Old Men','a thriller movie in 2007','2007-11-21','2026-01-15 20:14:25'),(2,'tv','Breaking Bad',NULL,'2008-07-15','2026-01-16 02:56:36'),(3,'book','The Catcher in the Rye','American coming-of-age novel','1951-07-16','2026-01-16 03:24:58'),(4,'music','十万嬉皮',NULL,'2010-11-12','2026-01-16 03:38:29'),(5,'movie','Memories of Murder',NULL,'2003-05-02','2026-01-23 21:22:29'),(8,'movie','Oppenheimer','A dramatization of the life story of J. Robert Oppenheimer, the physicist who had a large hand in the development of the atomic bombs that brought an end to World War II.','2023-07-19','2026-03-10 23:16:16'),(10,'movie','Yi Yi','','2000-09-20','2026-03-11 22:18:20'),(12,'book','Norwegian Wood','','1987-09-04','2026-03-12 21:11:06');
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_person`
--

DROP TABLE IF EXISTS `media_person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `media_person` (
  `person_id` int unsigned NOT NULL,
  `media_id` int unsigned NOT NULL,
  `role` enum('author','director','writer','cast','artist','composer','lyricist','creator') NOT NULL,
  `character_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`person_id`,`media_id`,`role`),
  KEY `media_person_ibfk_2` (`media_id`),
  CONSTRAINT `media_person_ibfk_1` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`) ON DELETE CASCADE,
  CONSTRAINT `media_person_ibfk_2` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_person`
--

LOCK TABLES `media_person` WRITE;
/*!40000 ALTER TABLE `media_person` DISABLE KEYS */;
INSERT INTO `media_person` VALUES (9,2,'creator',NULL),(10,2,'cast',NULL),(11,2,'cast',NULL),(12,2,'cast',NULL),(13,1,'director',NULL),(13,1,'writer',NULL),(14,1,'director',NULL),(14,1,'writer',NULL),(15,1,'cast',NULL),(16,1,'cast',NULL),(17,1,'cast',NULL),(18,1,'writer',NULL),(19,3,'author',NULL),(20,4,'artist',NULL),(21,4,'lyricist',NULL),(22,4,'composer',NULL),(23,5,'director',NULL),(23,5,'writer',NULL),(24,5,'cast',NULL),(25,5,'cast',NULL),(26,8,'director',NULL),(26,8,'writer',NULL),(27,8,'cast','J. Robert Oppenheimer'),(28,8,'cast','Kitty Oppenheimer'),(30,10,'director',NULL),(30,10,'writer',NULL),(31,10,'cast','null'),(32,10,'cast','Min-Min'),(33,12,'author',NULL);
/*!40000 ALTER TABLE `media_person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movie` (
  `media_id` int unsigned NOT NULL,
  `duration_minutes` int DEFAULT NULL,
  `rating` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`media_id`),
  CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (1,122,'R'),(5,132,'Not Rated'),(8,180,'R'),(10,173,'Not Rated');
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `music`
--

DROP TABLE IF EXISTS `music`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `music` (
  `media_id` int unsigned NOT NULL,
  `album` varchar(255) DEFAULT NULL,
  `duration_seconds` int DEFAULT NULL,
  PRIMARY KEY (`media_id`),
  CONSTRAINT `music_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `music`
--

LOCK TABLES `music` WRITE;
/*!40000 ALTER TABLE `music` DISABLE KEYS */;
INSERT INTO `music` VALUES (4,'万能青年旅店',284);
/*!40000 ALTER TABLE `music` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `person` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `bio` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES (9,'Vince Gilligan',NULL),(10,'Bryan Cranston',NULL),(11,'Aaron Paul',NULL),(12,'Anna Gunn',NULL),(13,'Joel Coen',NULL),(14,'Ethan Coen',NULL),(15,'Tommy Lee Jones',NULL),(16,'Josh Brolin',NULL),(17,'Javier Bardem',NULL),(18,'Cormac McCarthy',NULL),(19,'J. D. Salinger','An American author, 1919 - 2010'),(20,'万能青年旅店',NULL),(21,'姬赓',NULL),(22,'董亚千',NULL),(23,'Bong Joon Ho',NULL),(24,'Song Kang-ho',NULL),(25,'Kim Sang-kyung',NULL),(26,'Christopher Nolan',NULL),(27,'Cillian Murphy',NULL),(28,'Emily Blunt',NULL),(30,'Edward Yang','One of the most talented international filmmakers from China'),(31,'Nien-Jen Wu',''),(32,'Elaine Jin',''),(33,'Haruki Murakami','Japanese writer');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rate`
--

DROP TABLE IF EXISTS `rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rate` (
  `media_id` int unsigned NOT NULL,
  `user_id` int unsigned NOT NULL,
  `score` int DEFAULT NULL,
  PRIMARY KEY (`media_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `rate_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rate_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rate`
--

LOCK TABLES `rate` WRITE;
/*!40000 ALTER TABLE `rate` DISABLE KEYS */;
INSERT INTO `rate` VALUES (1,3,9),(1,7,8),(3,3,9),(4,3,10),(5,3,9);
/*!40000 ALTER TABLE `rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `user_id` int unsigned NOT NULL,
  `role` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ADMIN');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tv`
--

DROP TABLE IF EXISTS `tv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tv` (
  `media_id` int unsigned NOT NULL,
  `seasons` int DEFAULT NULL,
  PRIMARY KEY (`media_id`),
  CONSTRAINT `tv_ibfk_1` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tv`
--

LOCK TABLES `tv` WRITE;
/*!40000 ALTER TABLE `tv` DISABLE KEYS */;
INSERT INTO `tv` VALUES (2,5);
/*!40000 ALTER TABLE `tv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL DEFAULT 'user',
  `password` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `avatar` varchar(128) DEFAULT NULL,
  `create_time` timestamp NOT NULL,
  `update_time` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'admin','$2a$10$SedOHTMhAJ1k88FFdg0Kxu7UoDzWD3vsGStj1u.tYkY6OvigN1QkC','admin@mediabase.com',NULL,'2026-03-10 14:16:46','2026-03-10 14:16:46'),(3,'Yuki','$2a$10$9gVR.kRnnENr8NbvCzPlBe8KZzwCK./U71rphuHgx0tAgPEQu27R6','18923461402@163.com','https://media-base-191022261411.s3.amazonaws.com/6fb38bca-ba3f-4e8a-ab91-2ded72f20eb1_joker.jpg','2026-01-08 16:27:43','2026-03-04 15:33:48'),(7,'Yongqi','$2a$10$PFdkZa3PzeLM./DovN06OOLueQOl7GmLea.M6DZm4w2Sm3vSLkFPK','yongqi451@gmail.com',NULL,'2026-01-08 18:10:13','2026-01-09 05:36:20');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-26  8:47:19
