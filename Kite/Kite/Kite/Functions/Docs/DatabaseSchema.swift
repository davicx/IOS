//
//  DatabaseSchema.swift
//  Kite
//
//  Created by David Vasquez on 2/1/26.
//

import Foundation

/*
-- MySQL dump 10.13  Distrib 8.0.41, for macos15 (arm64)
--
-- Host: localhost    Database: shareshare
-- ------------------------------------------------------
-- Server version    8.0.41

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
-- Table structure for table `comment_likes`
--

DROP TABLE IF EXISTS `comment_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_likes` (
  `comment_like_id` int NOT NULL AUTO_INCREMENT,
  `comment_id` int NOT NULL,
  `liked_by` int NOT NULL,
  `liked_by_name` varchar(255) NOT NULL,
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_like_id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_likes`
--

LOCK TABLES `comment_likes` WRITE;
/*!40000 ALTER TABLE `comment_likes` DISABLE KEYS */;
INSERT INTO `comment_likes` VALUES (142,216,1,'frodo','2025-05-06 23:42:14'),(145,231,1,'frodo','2025-05-07 23:06:30'),(182,232,1,'davey','2025-05-10 23:06:37'),(186,229,1,'merry','2025-05-11 23:17:13'),(187,229,1,'pippin','2025-05-11 23:19:57'),(230,230,1,'davey','2025-05-14 23:28:38'),(231,233,1,'davey','2025-05-14 23:28:39'),(248,234,1,'davey','2025-06-08 23:43:31'),(249,229,1,'davey','2025-07-09 23:43:57'),(250,242,1,'pippin','2025-09-24 23:07:26');
/*!40000 ALTER TABLE `comment_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_votes`
--

DROP TABLE IF EXISTS `comment_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_votes` (
  `comment_vote_id` int NOT NULL AUTO_INCREMENT,
  `comment_id` int NOT NULL,
  `up_vote` int NOT NULL,
  `up_vote_user` varchar(255) NOT NULL,
  `down_vote` int NOT NULL,
  `down_vote_user` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_vote_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_votes`
--

LOCK TABLES `comment_votes` WRITE;
/*!40000 ALTER TABLE `comment_votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `comment_id` int unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL DEFAULT '0',
  `group_id` int NOT NULL DEFAULT '0',
  `list_id` int NOT NULL DEFAULT '0',
  `comment` text,
  `comment_type` varchar(256) NOT NULL DEFAULT 'post',
  `comment_from` varchar(255) NOT NULL DEFAULT '',
  `comment_deleted` int NOT NULL DEFAULT '0',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`)
) ENGINE=InnoDB AUTO_INCREMENT=243 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (229,790,72,0,'He loved mountains, or he had loved the thought of them marching on the edge of stories brought from far away; but now he was borne down by the insupportable weight of Middle-earth. He longed to shut out the immensity in a quiet room by a fire.','post','davey',0,'2025-08-03 23:32:37','2025-05-06 23:23:02'),(234,790,72,12,'He loved mountains.','post','davey',0,'2025-08-03 23:32:43','2025-05-17 23:12:54'),(235,790,72,12,'The leaves were long, the grass was green,\nThe hemlock-umbels tall and fair,\nAnd in the glade a light was seen\nOf stars in shadow shimmering.\nTinuviel was dancing there\nTo music of a pipe unseen,\nAnd light of stars was in her hair,\nAnd in her raiment glimmering','post','davey',0,'2025-08-03 23:32:47','2025-07-22 23:44:15'),(236,791,72,12,'The leaves were long, the grass was green,\nThe hemlock-umbels tall and fair,\nAnd in the glade a light was seen\nOf stars in shadow shimmering.','post','davey',0,'2025-08-03 23:32:55','2025-07-22 23:44:15'),(237,791,72,12,'The hemlock-umbels tall and fair, And in the glade a light was seen Of stars in shadow shimmering. The hemlock-umbels tall and fair, And in the glade a light was seen Of stars in shadow shimmering.user_profile','post','davey',0,'2025-08-03 23:33:05','2025-07-22 23:44:16'),(238,796,72,0,'He loved mountains too lets go on a hike!!','post','davey',0,'2025-08-22 23:00:11','2025-08-22 23:00:11'),(239,796,72,0,'Good Morning! said Bilbo, and he meant it. The sun was shining, and the grass was very green. But Gandalf looked at him from under long bushy eyebrows that stuck out further than the brim of his shady hat.','post','davey',0,'2025-08-22 23:01:20','2025-08-22 23:01:20'),(240,723,723,0,'He loved mountains too lets go on a hike!!','post','davey',0,'2025-09-24 23:06:38','2025-09-24 23:06:38'),(241,723,723,0,'He loved mountains too lets go on a hike!!','post','davey',0,'2025-09-24 23:06:53','2025-09-24 23:06:53'),(242,797,723,0,'He loved mountains too lets go on a hike!!','post','davey',0,'2025-09-24 23:07:08','2025-09-24 23:07:08');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files` (
  `file_id` int NOT NULL AUTO_INCREMENT,
  `master_site` varchar(255) NOT NULL,
  `parent_folder` int NOT NULL,
  `current_folder` int NOT NULL,
  `group_id` int NOT NULL,
  `post_id` int NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_image` varchar(255) NOT NULL,
  `file_extension` varchar(255) NOT NULL,
  `file_name_server` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `file_caption` text NOT NULL,
  `file_seen` int NOT NULL,
  `file_status` int NOT NULL,
  `recycle_status` int NOT NULL,
  `unique_id` varchar(255) NOT NULL,
  `file_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `file_last_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
INSERT INTO `files` VALUES (165,'shareshare',0,0,321,0,'background_4','1559690179background_4.png','png','1559690179background_4.png','vasquezd',1,'',0,1,0,'','2019-06-04 23:16:19','2019-06-04 23:16:19'),(166,'shareshare',0,0,321,0,'background_1','1559690242background_1.jpg','jpg','1559690242background_1.jpg','vasquezd',1,'',0,1,0,'','2019-06-04 23:17:22','2019-06-04 23:17:22'),(167,'shareshare',0,0,321,0,'background_1','1559690262background_1.jpg','jpg','1559690262background_1.jpg','vasquezd',1,'',0,1,0,'','2019-06-04 23:17:42','2019-06-04 23:17:42'),(168,'shareshare',0,0,321,0,'background_8','1559690316background_8.jpg','jpg','1559690316background_8.jpg','vasquezd',1,'',0,1,0,'','2019-06-04 23:18:36','2019-06-04 23:18:36'),(169,'shareshare',0,0,321,0,'background_4','1559690321background_4.png','png','1559690321background_4.png','vasquezd',1,'',0,1,0,'','2019-06-04 23:18:41','2019-06-04 23:18:41'),(170,'shareshare',0,0,321,0,'background_1','1559690814background_1.jpg','jpg','1559690814background_1.jpg','vasquezd',1,'',0,1,0,'','2019-06-04 23:26:54','2019-06-04 23:26:54'),(171,'shareshare',0,0,321,0,'background_6','1559690818background_6.jpg','jpg','1559690818background_6.jpg','vasquezd',1,'',0,1,0,'','2019-06-04 23:26:58','2019-06-04 23:26:58'),(172,'shareshare',0,0,321,0,'Dh1XlFBWAAAIYpL','1565899185Dh1XlFBWAAAIYpL.jpg','jpg','1565899185Dh1XlFBWAAAIYpL.jpg','vasquezd',1,'this file has a caption',0,0,1,'','2019-08-15 19:59:45','2019-08-16 22:09:36'),(173,'shareshare',0,0,321,0,'1ZmrLjK','15659018281ZmrLjK.jpg','jpg','15659018281ZmrLjK.jpg','vasquezd',1,'oya',0,0,1,'','2019-08-15 20:43:48','2019-08-16 22:09:40'),(174,'shareshare',0,0,321,0,'178bb1f55eb53b53512165915b540362','1565993383178bb1f55eb53b53512165915b540362.jpg','jpg','1565993383178bb1f55eb53b53512165915b540362.jpg','vasquezd',1,'',0,0,1,'','2019-08-16 22:09:43','2019-08-20 20:12:02'),(175,'shareshare',0,0,321,0,'resize','1565993973resize.jpg','jpg','1565993973resize.jpg','vasquezd',1,'hiya',0,1,0,'','2019-08-16 22:19:33','2019-08-16 22:19:33');
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `folders`
--

DROP TABLE IF EXISTS `folders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `folders` (
  `folder_id` int NOT NULL AUTO_INCREMENT,
  `master_site` varchar(255) NOT NULL,
  `group_id` int NOT NULL,
  `parent_folder` int NOT NULL,
  `folder_name` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `folder_image` varchar(255) NOT NULL,
  `folder_seen` int NOT NULL,
  `folder_status` int NOT NULL,
  `recycle_status` int NOT NULL,
  `folder_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `folder_last_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`folder_id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `folders`
--

LOCK TABLES `folders` WRITE;
/*!40000 ALTER TABLE `folders` DISABLE KEYS */;
INSERT INTO `folders` VALUES (108,'',321,0,'Music','vasquezd',1,'folder.png',0,1,0,'2019-05-10 23:28:57','2019-05-10 23:28:57'),(109,'',321,0,'Movies','vasquezd',1,'folder.png',0,1,0,'2019-05-10 23:29:49','2019-05-10 23:29:49'),(110,'',321,108,'Anberlin','vasquezd',1,'folder.png',0,1,0,'2019-05-10 23:30:45','2019-05-10 23:30:45'),(111,'',321,110,'Cities','vasquezd',1,'folder.png',0,1,0,'2019-05-10 23:30:52','2019-05-10 23:30:52'),(112,'',321,108,'Hammock','vasquezd',1,'folder.png',0,1,0,'2019-05-10 23:56:17','2019-05-10 23:56:17'),(113,'',321,112,'Departure Songs','vasquezd',1,'folder.png',0,1,0,'2019-05-10 23:56:44','2019-05-10 23:56:44'),(114,'',321,112,'Kenotic','vasquezd',1,'folder.png',0,1,0,'2019-05-10 23:56:59','2019-05-10 23:56:59'),(115,'',321,109,'Lost','vasquezd',1,'folder.png',0,1,0,'2019-05-10 23:57:09','2019-05-10 23:57:09'),(116,'',321,0,'Games','vasquezd',1,'folder.png',0,1,0,'2019-05-15 23:43:04','2019-05-24 22:28:47'),(117,'',321,0,'Me','vasquezd',1,'folder.png',0,0,1,'2019-05-22 22:35:22','2019-05-22 22:35:40'),(118,'',321,0,'Hi','vasquezd',1,'folder.png',0,0,1,'2019-05-22 22:36:07','2019-05-22 22:36:10'),(119,'shareshare',321,0,'hi','vasquezd',1,'folder.png',0,0,1,'2019-08-15 22:28:07','2019-08-15 22:28:10');
/*!40000 ALTER TABLE `folders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `following`
--

DROP TABLE IF EXISTS `following`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `following` (
  `follow_id` int NOT NULL AUTO_INCREMENT,
  `following_key` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `following_user` varchar(255) NOT NULL,
  `following_user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`follow_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `following`
--

LOCK TABLES `following` WRITE;
/*!40000 ALTER TABLE `following` DISABLE KEYS */;
INSERT INTO `following` VALUES (38,'davey_frodo','davey',1,'frodo',2,'2025-05-26 22:44:31');
/*!40000 ALTER TABLE `following` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `friends`
--

DROP TABLE IF EXISTS `friends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friends` (
  `friends_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `user_id` int NOT NULL,
  `friend_user_name` varchar(255) NOT NULL,
  `friend_id` int NOT NULL,
  `sent_by` varchar(256) NOT NULL DEFAULT 'empty',
  `sent_to` varchar(256) NOT NULL DEFAULT 'empty',
  `request_pending` int NOT NULL,
  `friend_key` varchar(255) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`friends_id`)
) ENGINE=InnoDB AUTO_INCREMENT=907 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friends`
--

LOCK TABLES `friends` WRITE;
/*!40000 ALTER TABLE `friends` DISABLE KEYS */;
INSERT INTO `friends` VALUES (893,'davey',1,'frodo',2,'davey','frodo',0,'daveyfrodo','2025-09-13 22:40:27'),(894,'frodo',2,'davey',1,'davey','frodo',0,'frododavey','2025-09-13 22:40:27'),(897,'davey',1,'merry',6,'davey','merry',1,'davey_merry','2025-09-16 23:25:02'),(898,'merry',6,'davey',1,'davey','merry',1,'merry_davey','2025-09-16 23:25:02'),(899,'sam',8,'davey',1,'sam','davey',0,'sam_davey','2025-09-17 22:58:43'),(900,'davey',1,'sam',8,'sam','davey',0,'davey_sam','2025-09-17 22:58:43'),(901,'sam',8,'merry',6,'sam','merry',0,'sam_merry','2025-09-17 22:58:43'),(902,'merry',6,'sam',8,'sam','merry',0,'merry_sam','2025-09-17 22:58:43'),(903,'sam',8,'frodo',2,'sam','frodo',0,'sam_frodo','2025-09-17 22:58:43'),(904,'frodo',2,'sam',8,'sam','frodo',0,'frodo_sam','2025-09-17 22:58:43'),(905,'sam',8,'pippin',5,'sam','pippin',0,'sam_pippin','2025-09-17 23:01:47'),(906,'pippin',5,'sam',8,'sam','pippin',0,'pippin_sam','2025-09-17 23:01:47');
/*!40000 ALTER TABLE `friends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_users`
--

DROP TABLE IF EXISTS `group_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_users` (
  `primary_id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `active_member` int NOT NULL,
  `group_last_visit` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_default_group` int NOT NULL DEFAULT '0',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`primary_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2265 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_users`
--

LOCK TABLES `group_users` WRITE;
/*!40000 ALTER TABLE `group_users` DISABLE KEYS */;
INSERT INTO `group_users` VALUES (2039,70,'davey',1,'0000-00-00 00:00:00',0,'2025-07-05 23:52:32'),(2040,70,'sam',1,'0000-00-00 00:00:00',0,'2025-07-05 23:52:32'),(2041,70,'merry',1,'0000-00-00 00:00:00',0,'2025-07-05 23:52:32'),(2042,70,'frodo',1,'0000-00-00 00:00:00',0,'2025-07-05 23:52:32'),(2043,70,'pippin',1,'0000-00-00 00:00:00',0,'2025-07-05 23:52:32'),(2072,72,'merry',1,'0000-00-00 00:00:00',0,'2025-07-07 00:22:53'),(2073,72,'davey',1,'0000-00-00 00:00:00',0,'2025-07-07 00:22:53'),(2074,72,'sam',1,'0000-00-00 00:00:00',0,'2025-07-07 00:24:02'),(2096,690,'davey',1,'0000-00-00 00:00:00',0,'2025-07-18 23:36:38'),(2097,690,'pippin',1,'0000-00-00 00:00:00',0,'2025-07-18 23:36:38'),(2098,690,'merry',1,'0000-00-00 00:00:00',0,'2025-07-18 23:36:38'),(2099,690,'frodo',1,'0000-00-00 00:00:00',0,'2025-07-18 23:36:38'),(2100,690,'sam',1,'0000-00-00 00:00:00',0,'2025-07-18 23:36:38'),(2101,691,'sam',1,'0000-00-00 00:00:00',0,'2025-07-18 23:37:03'),(2102,691,'davey',1,'0000-00-00 00:00:00',0,'2025-07-18 23:37:03'),(2103,691,'merry',1,'0000-00-00 00:00:00',0,'2025-07-18 23:37:03'),(2104,691,'frodo',1,'0000-00-00 00:00:00',0,'2025-07-18 23:37:03'),(2105,691,'pippin',1,'0000-00-00 00:00:00',0,'2025-07-18 23:37:03'),(2106,692,'davey',1,'0000-00-00 00:00:00',0,'2025-07-29 23:08:56'),(2107,692,'pippin',1,'0000-00-00 00:00:00',0,'2025-07-29 23:08:56'),(2108,692,'sam',1,'0000-00-00 00:00:00',0,'2025-07-29 23:08:56'),(2109,692,'merry',1,'0000-00-00 
/*!40000 ALTER TABLE `group_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `groups` (
  `group_id` int NOT NULL AUTO_INCREMENT,
  `group_type` varchar(255) NOT NULL DEFAULT 'normal',
  `created_by` varchar(255) NOT NULL DEFAULT '',
  `group_name` varchar(255) NOT NULL DEFAULT 'name me!',
  `group_image` varchar(255) NOT NULL DEFAULT 'group.png',
  `file_name` varchar(255) DEFAULT NULL,
  `file_name_server` varchar(255) DEFAULT NULL,
  `cloud_key` varchar(255) DEFAULT NULL,
  `cloud_bucket` varchar(255) DEFAULT NULL,
  `storage_type` varchar(255) DEFAULT NULL,
  `group_key` varchar(255) NOT NULL DEFAULT 'nokey',
  `group_private` int NOT NULL DEFAULT '1',
  `group_deleted` int NOT NULL DEFAULT '0',
  `updated` timestamp NOT NULL DEFAULT '1995-07-20 05:06:22',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=724 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (70,'kite','davey','New Group!','the_shire.jpg','fileName','fileNameServer','cloudKey','cloudBucket','local','nokey',1,1,'1995-07-20 05:06:22','2023-11-27 00:26:27'),(72,'kite','davey','Hiking in the Shire','http://localhost:3003/kite-us-west-two/groups/groupImage-1754264482637-64076401-IMG_3737.JPG','group_image.png','groupImage-1754264482637-64076401-IMG_3737.JPG','groups/groupImage-1754264482637-64076401-IMG_3737.JPG','kite-us-west-two','local','nokey',1,1,'1995-07-20 05:06:22','2025-07-07 23:28:32'),(722,'kite','sam','Games Sam Wants','http://localhost:3003/kite-us-west-two/groups/group_image.jpg','group_image.jpg','group_image.jpg','groups/group_image.jpg','kite-us-west-two','local','nokey',1,0,'1995-07-20 05:06:22','2025-08-20 23:25:30'),(723,'kite','davey','Legos I want','http://localhost:3003/kite-us-west-two/groups/group_image.jpg','group_image.jpg','group_image.jpg','groups/group_image.jpg','kite-us-west-two','local','nokey',1,0,'1995-07-20 05:06:22','2025-08-20 23:32:43');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_id` int unsigned NOT NULL AUTO_INCREMENT,
  `post_id` int unsigned NOT NULL,
  `item_name` varchar(255) NOT NULL DEFAULT 'item_name',
  `item_price` decimal(10,2) DEFAULT '0.00',
  `item_description` text,
  `item_category` varchar(255) DEFAULT 'item_category',
  `item_link` varchar(2083) DEFAULT 'item_link',
  `purchased` tinyint(1) DEFAULT '0',
  `purchased_by` varchar(255) DEFAULT 'purchased_by',
  `store` varchar(255) DEFAULT 'store',
  `multiple_stores` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `post_id` (`post_id`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (37,831,'Final Fantasy',40.00,'I really want this cool game~! It is at a lot of stores','video games','www.chronotrigger.com',0,'purchased_by','store',0),(38,835,'Secret of Mana!!!!',50.00,'I want to get Secret of Mana','video_games','www.secretofmana.com',0,'purchased_by','store',0),(39,836,'Secret of Mana',50.00,'I want to get Secret of Mana','video_games','www.secretofmana.com',0,'purchased_by','store',0),(40,837,'Secret of Mana',50.00,'Sam wants to get Secret of Mana too','video_games','www.secretofmana.com',0,'purchased_by','store',0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `master_site` varchar(255) NOT NULL,
  `group_id` int NOT NULL DEFAULT '0',
  `post_id` int NOT NULL DEFAULT '0',
  `comment_id` int NOT NULL DEFAULT '0',
  `notification_from` varchar(255) NOT NULL,
  `notification_to` varchar(255) NOT NULL,
  `notification_type` varchar(255) NOT NULL,
  `notification_message` varchar(255) NOT NULL,
  `notification_time` varchar(255) DEFAULT NULL,
  `notification_link` varchar(255) NOT NULL,
  `notification_seen` int NOT NULL DEFAULT '0',
  `notification_deleted` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`notification_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4278 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (4167,'kite',723,723,0,'davey','pippin','new_post_comment','Made a Comment on your Post',NULL,'http://localhost:3003/posts/group/723',0,0),(4168,'kite',723,723,0,'davey','merry','new_post_comment','Made a Comment on your Post',NULL,'http://localhost:3003/posts/group/723',0,0),(4169,'kite',723,723,0,'davey','frodo','new_post_comment','Made a Comment on your Post',NULL,'http://localhost:3003/posts/group/723',0,0),(4170,'kite',723,723,0,'davey','sam','new_post_comment','Made a Comment on your Post',NULL,'http://localhost:3003/posts/group/723',0,0),(4171,'kite',723,723,0,'davey','merry','new_post_comment','Made a Comment on your Post',NULL,'http://localhost:3003/posts/group/723',0,0),(4172,'kite',723,723,0,'davey','sam','new_post_comment','Made a Comment on your Post',NULL,'http://localhost:3003/posts/group/723',0,0),(4173,'kite',723,723,0,'davey','pippin','new_post_comment','Made a Comment on your Post',NULL,'http://localhost:3003/posts/group/723',0,0),(4174,'kite',723,723,0,'davey','frodo','new_post_comment','Made a Comment on your Post',NULL,'http://localhost:3003/posts/group/723',0,0),(4175,'kite',723,0,0,'davey','797','new_post_comment','Made a Comment on your Post',NULL,'http://localhost:3003/posts/group/723',0,0),(4176,'kite',723,797,242,'pippin','davey','comment_like','pippin liked your comment',NULL,'notification.notificationLink',0,0),(4177,'kite',723,0,0,'davey','sam','new_post_item','posted a new item',NULL,'http://localhost:3003/posts/group/723',0,0),(4178,'kite',723,0,0,'davey','merry','new_post_item','posted a new item',NULL,'http://localhost:3003/posts/group/723',0,0),(4179,'kite',723,0,0,'davey','pippin','new_post_item','posted a new item',NULL,'http://localhost:3003/posts/group/723',0,0),(4180,'kite',723,0,0,'davey','frodo','new_post_item','posted a new
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_email`
--

DROP TABLE IF EXISTS `pending_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pending_email` (
  `primary_id` int NOT NULL AUTO_INCREMENT,
  `codehash` varchar(255) NOT NULL,
  `request_from` varchar(255) NOT NULL,
  `request_to` varchar(255) NOT NULL,
  `request_to_existing_user` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `square_id` int NOT NULL,
  `group_id` int NOT NULL,
  `list_id` int NOT NULL,
  `status` int NOT NULL,
  PRIMARY KEY (`primary_id`),
  UNIQUE KEY `codehash` (`codehash`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_email`
--

LOCK TABLES `pending_email` WRITE;
/*!40000 ALTER TABLE `pending_email` DISABLE KEYS */;
/*!40000 ALTER TABLE `pending_email` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pending_requests`
--

DROP TABLE IF EXISTS `pending_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pending_requests` (
  `request_id` int NOT NULL AUTO_INCREMENT,
  `master_site` varchar(255) NOT NULL,
  `request_type` varchar(255) NOT NULL,
  `request_type_text` varchar(255) NOT NULL,
  `request_is_pending` int NOT NULL,
  `sent_by` varchar(255) NOT NULL,
  `sent_to` varchar(255) NOT NULL,
  `request_key` varchar(255) NOT NULL DEFAULT 'key',
  `sent_to_email` varchar(255) NOT NULL DEFAULT 'false',
  `friend_id` int NOT NULL DEFAULT '0',
  `group_id` int NOT NULL DEFAULT '0',
  `list_id` int NOT NULL DEFAULT '0',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`request_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1978 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pending_requests`
--

LOCK TABLES `pending_requests` WRITE;
/*!40000 ALTER TABLE `pending_requests` DISABLE KEYS */;
INSERT INTO `pending_requests` VALUES (1971,'kite','friend_request','davey invited you to be friends',0,'davey','frodo','key','false',0,0,0,'2025-09-12 23:23:11','2025-09-12 23:23:11'),(1972,'kite','friend_request','merry invited you to be friends',0,'merry','davey','key','false',0,0,0,'2025-09-12 23:34:21','2025-09-12 23:34:21'),(1973,'kite','friend_request','davey invited you to be friends',1,'davey','merry','key','false',0,0,0,'2025-09-16 23:25:02','2025-09-16 23:25:02'),(1974,'kite','friend_request','sam invited you to be friends',1,'sam','davey','key','false',0,0,0,'2025-09-16 23:26:33','2025-09-16 23:26:33'),(1975,'kite','friend_request','sam invited you to be friends',1,'sam','merry','key','false',0,0,0,'2025-09-17 22:28:13','2025-09-17 22:28:13'),(1976,'kite','friend_request','sam invited you to be friends',1,'sam','frodo','key','false',0,0,0,'2025-09-17 22:28:17','2025-09-17 22:28:17'),(1977,'kite','friend_request','sam invited you to be friends',0,'sam','pippin','key','false',0,0,0,'2025-09-17 23:01:25','2025-09-17 23:01:25');
/*!40000 ALTER TABLE `pending_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_likes`
--

DROP TABLE IF EXISTS `post_likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_likes` (
  `post_like_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `liked_by` int NOT NULL,
  `liked_by_name` varchar(255) NOT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_like_id`)
) ENGINE=InnoDB AUTO_INCREMENT=386 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_likes`
--

LOCK TABLES `post_likes` WRITE;
/*!40000 ALTER TABLE `post_likes` DISABLE KEYS */;

/*!40000 ALTER TABLE `post_likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `post_id` int unsigned NOT NULL AUTO_INCREMENT,
  `master_site` varchar(255) DEFAULT 'kite',
  `post_type` varchar(255) DEFAULT 'none',
  `post_status` int NOT NULL DEFAULT '1',
  `group_id` int NOT NULL DEFAULT '0',
  `list_id` int DEFAULT '0',
  `post_from` varchar(255) NOT NULL DEFAULT 'empty',
  `post_to` varchar(2083) NOT NULL DEFAULT 'empty',
  `post_caption` varchar(255) DEFAULT 'emp',
  `file_name` varchar(255) DEFAULT '',
  `file_name_server` varchar(255) DEFAULT 'hiya.jpg',
  `file_url` varchar(255) DEFAULT 'empty',
  `cloud_key` varchar(255) DEFAULT 'no_cloud_key',
  `cloud_bucket` varchar(255) DEFAULT 'no_cloud_bucket',
  `storage_type` varchar(255) DEFAULT 'local',
  `video_url` varchar(255) DEFAULT 'empty',
  `video_code` varchar(255) DEFAULT 'empty',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`)
) ENGINE=InnoDB AUTO_INCREMENT=838 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--


/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refresh_tokens`
--

DROP TABLE IF EXISTS `refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refresh_tokens` (
  `token_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `refresh_token` varchar(255) NOT NULL,
  `device_id` varchar(255) NOT NULL DEFAULT 'device_id',
  `token_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`token_id`)
) ENGINE=MyISAM AUTO_INCREMENT=986 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_tokens`
--

LOCK TABLES `refresh_tokens` WRITE;
/*!40000 ALTER TABLE `refresh_tokens` DISABLE KEYS */;

/*!40000 ALTER TABLE `refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_analytics`
--

DROP TABLE IF EXISTS `user_analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_analytics` (
  `analytics_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) NOT NULL,
  `page_url` varchar(255) NOT NULL,
  `last_visit` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `total_visits` int NOT NULL,
  `group_id` int NOT NULL,
  `icon_id` varchar(255) NOT NULL,
  `last_click` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `total_clicks` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`analytics_id`)
) ENGINE=InnoDB AUTO_INCREMENT=355 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_analytics`
--

LOCK TABLES `user_analytics` WRITE;
/*!40000 ALTER TABLE `user_analytics` DISABLE KEYS */;
INSERT INTO `user_analytics` VALUES (351,'vasquezd','groups.php','2018-02-02 00:19:18',17,0,'','2018-04-02 23:23:16',0,0),(352,'vasquezd','','0000-00-00 00:00:00',0,0,'js-activity-group-icon','2018-02-22 23:34:05',4,0),(353,'vasquezd','','0000-00-00 00:00:00',0,0,'js-notification-header-seen','2018-02-22 23:34:04',4,0),(354,'Vasquezd','group_posts.php','2018-03-27 21:20:28',11,330,'','2018-03-27 21:24:41',0,0);
/*!40000 ALTER TABLE `user_analytics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_login`
--

DROP TABLE IF EXISTS `user_login`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_login` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) NOT NULL DEFAULT 'username',
  `user_email` varchar(255) NOT NULL DEFAULT 'useremail',
  `salt` varchar(255) NOT NULL DEFAULT 'salt',
  `password` varchar(255) NOT NULL DEFAULT 'password',
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_logout` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `login_total` int NOT NULL DEFAULT '0',
  `account_deleted` int NOT NULL DEFAULT '0',
  `password_reset_key` varchar(255) NOT NULL DEFAULT 'null',
  `password_reset_sent` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `password_reset_used` int NOT NULL DEFAULT '0',
  `password_reset_status` varchar(255) NOT NULL DEFAULT 'null',
  UNIQUE KEY `user_id_2` (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  UNIQUE KEY `user_name_2` (`user_name`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_login`
--

LOCK TABLES `user_login` WRITE;
/*!40000 ALTER TABLE `user_login` DISABLE KEYS */;
INSERT INTO `user_login` VALUES (1,'davey','davey@gmail.com','$2b$10$13UTGC/rkiZ/bh/iHZepi.','$2b$10$13UTGC/rkiZ/bh/iHZepi.OgejSH7Mi4azVlb6Sb9zxD8xRVEdSZe','2025-01-28 00:45:08','0000-00-00 00:00:00',0,0,'null','0000-00-00 00:00:00',0,'null'),(2,'frodo','frodo@gmail.com','$2b$10$YbZ.katAPpAfoFeHvkP5Pu','$2b$10$YbZ.katAPpAfoFeHvkP5Pu1ORiZkm.isNnsPP5WS5O2dpqLetb5ye','2025-01-30 00:21:46','0000-00-00 00:00:00',0,0,'null','0000-00-00 00:00:00',0,'null'),(3,'frodo2','frodo@gmail.com','$2b$10$BzcvMlG2PwMowhfeDYr7Ue','$2b$10$BzcvMlG2PwMowhfeDYr7UeGshIQ302sNyQPTA7KFq4RLg0sGQOHt2','2025-02-09 00:25:16','0000-00-00 00:00:00',0,0,'null','0000-00-00 00:00:00',0,'null'),(4,'frodo22','frodo22@gmail.com','$2b$10$227qwVy8LwKUoq2lt86DI.','$2b$10$227qwVy8LwKUoq2lt86DI.ymqZtCf0jpjLSwQsaY/5jky1ltd/Kim','2025-03-24 00:03:47','0000-00-00 00:00:00',0,0,'null','0000-00-00 00:00:00',0,'null'),(5,'pippin','pippin@gmail.com','$2b$10$GxHWnXaFxjC9n968xZsIe.','$2b$10$GxHWnXaFxjC9n968xZsIe.X1YJAI7d0eSdaICXhyE0QOF.D2xdHEm','2025-05-11 23:21:03','0000-00-00 00:00:00',0,0,'null','0000-00-00 00:00:00',0,'null'),(6,'merry','merry@gmail.com','$2b$10$i67oNktNVO70O2SbzltLle','$2b$10$i67oNktNVO70O2SbzltLleXUV0LOoikxAkuvg23v57Pm.EJXyQ.IG','2025-05-11 23:21:12','0000-00-00 00:00:00',0,0,'null','0000-00-00 00:00:00',0,'null'),(7,'bilbo','bilbo@gmail.com','$2b$10$gvxMdDOjl.r1fdCCGyMEGO','$2b$10$gvxMdDOjl.r1fdCCGyMEGOdf998KQWNBUuvX0bLS6b5u0oS294wfK','2025-06-01 23:07:08','0000-00-00 00:00:00',0,0,'null','0000-00-00 00:00:00',0,'null'),(8,'sam','sam@gmail.com','$2b$10$Og4sPYV1ZqnZ6/GS1cXcBu','$2b$10$Og4sPYV1ZqnZ6/GS1cXcBuWt3QG4Ej1ctJ34JAC2lQwp733hsTE0G','2025-06-06 22:06:16','0000-00-00 00:00:00',0,0,'null','0000-00-00 00:00:00',0,'null');
/*!40000 ALTER TABLE `user_login` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_profile`
--

DROP TABLE IF EXISTS `user_profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profile` (
  `user_profile_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL DEFAULT '0',
  `user_name` varchar(50) NOT NULL DEFAULT '"bilbo"',
  `email` varchar(255) NOT NULL DEFAULT '"Email"',
  `image_name` varchar(50) NOT NULL DEFAULT '"bilbo.jpg"',
  `first_name` varchar(50) NOT NULL DEFAULT '"First"',
  `last_name` varchar(50) NOT NULL DEFAULT '"last"',
  `root_folder` varchar(255) NOT NULL DEFAULT '"root"',
  `biography` varchar(255) DEFAULT 'biography',
  `storage_location` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'storage_location',
  `cloud_bucket` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'cloud_bucket',
  `cloud_key` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'cloud_key',
  `image_url` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'image_url',
  `file_name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'file_name',
  `file_name_server` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'file_name_server',
  `university` varchar(50) NOT NULL DEFAULT '"osu"',
  `post_view` varchar(255) NOT NULL DEFAULT '"nada"',
  `account_active` int NOT NULL DEFAULT '1',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_profile_id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_profile`
--

LOCK TABLES `user_profile` WRITE;
/*!40000 ALTER TABLE `user_profile` DISABLE KEYS */;

/*!40000 ALTER TABLE `user_profile` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-01 16:29:15

*/
