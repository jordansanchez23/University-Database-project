CREATE DATABASE  IF NOT EXISTS `universitydb` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `universitydb`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: universitydb
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `college`
--

DROP TABLE IF EXISTS `college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college` (
  `college_id` int NOT NULL AUTO_INCREMENT,
  `college_name` varchar(45) NOT NULL,
  PRIMARY KEY (`college_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college`
--

LOCK TABLES `college` WRITE;
/*!40000 ALTER TABLE `college` DISABLE KEYS */;
INSERT INTO `college` VALUES (1,'College of Physical Science and Engineering'),(2,'College of Business and Communication'),(3,'College of Language and Letters');
/*!40000 ALTER TABLE `college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_num` int NOT NULL,
  `course_title` varchar(45) NOT NULL,
  `credits` int NOT NULL,
  `department_id` int NOT NULL,
  `college_id` int NOT NULL,
  PRIMARY KEY (`course_num`,`department_id`,`college_id`),
  KEY `fk_course_department1_idx` (`department_id`,`college_id`),
  CONSTRAINT `fk_course_department1` FOREIGN KEY (`department_id`, `college_id`) REFERENCES `department` (`department_id`, `college_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES (111,'Intro to Databases',3,1,1),(150,'Micro Economics',3,2,2),(376,'Classical Heritage',2,3,3),(388,'Econometrics',4,2,2);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(45) NOT NULL,
  `department_code` varchar(45) NOT NULL,
  `college_id` int NOT NULL,
  PRIMARY KEY (`department_id`,`college_id`),
  KEY `fk_department_college_idx` (`college_id`),
  CONSTRAINT `fk_department_college` FOREIGN KEY (`college_id`) REFERENCES `college` (`college_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'Computer Information Technology','ITM',1),(2,'Economics','ECON',2),(3,'Humanities and Philosophy','HUM',3);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enrollment_record`
--

DROP TABLE IF EXISTS `enrollment_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enrollment_record` (
  `section_id` int NOT NULL,
  `course_num` int NOT NULL,
  `faculty_id` int NOT NULL,
  `term_id` int NOT NULL,
  `student_id` int NOT NULL,
  PRIMARY KEY (`section_id`,`course_num`,`faculty_id`,`term_id`,`student_id`),
  KEY `fk_section_has_student_student1_idx` (`student_id`),
  KEY `fk_section_has_student_section1_idx` (`section_id`,`course_num`,`faculty_id`,`term_id`),
  CONSTRAINT `fk_section_has_student_section1` FOREIGN KEY (`section_id`, `course_num`, `faculty_id`, `term_id`) REFERENCES `section` (`section_id`, `course_num`, `faculty_id`, `term_id`),
  CONSTRAINT `fk_section_has_student_student1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enrollment_record`
--

LOCK TABLES `enrollment_record` WRITE;
/*!40000 ALTER TABLE `enrollment_record` DISABLE KEYS */;
INSERT INTO `enrollment_record` VALUES (1,111,1,3,1),(3,150,2,3,1),(4,388,3,3,2),(4,388,3,3,3),(5,376,4,3,4),(4,388,3,3,5),(5,376,4,3,5),(7,111,5,2,6),(6,111,1,2,7),(8,150,2,2,7),(10,376,4,2,7),(9,150,2,2,8),(9,150,2,2,9),(6,111,1,2,10);
/*!40000 ALTER TABLE `enrollment_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty`
--

DROP TABLE IF EXISTS `faculty`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty` (
  `faculty_id` int NOT NULL AUTO_INCREMENT,
  `faculty_fname` varchar(45) NOT NULL,
  `faculty_lname` varchar(45) NOT NULL,
  PRIMARY KEY (`faculty_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty`
--

LOCK TABLES `faculty` WRITE;
/*!40000 ALTER TABLE `faculty` DISABLE KEYS */;
INSERT INTO `faculty` VALUES (1,'Marty','Morring'),(2,'Nate','Norris'),(3,'Ben','Barrus'),(4,'Jhon','Jensen'),(5,'Bill','Barney');
/*!40000 ALTER TABLE `faculty` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section`
--

DROP TABLE IF EXISTS `section`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section` (
  `section_id` int NOT NULL AUTO_INCREMENT,
  `section_number` int NOT NULL,
  `section_capacity` int NOT NULL,
  `course_num` int NOT NULL,
  `faculty_id` int NOT NULL,
  `term_id` int NOT NULL,
  PRIMARY KEY (`section_id`,`course_num`,`faculty_id`,`term_id`),
  KEY `fk_section_course1_idx` (`course_num`),
  KEY `fk_section_faculty1_idx` (`faculty_id`),
  KEY `fk_section_term1_idx` (`term_id`),
  CONSTRAINT `fk_section_course1` FOREIGN KEY (`course_num`) REFERENCES `course` (`course_num`),
  CONSTRAINT `fk_section_faculty1` FOREIGN KEY (`faculty_id`) REFERENCES `faculty` (`faculty_id`),
  CONSTRAINT `fk_section_term1` FOREIGN KEY (`term_id`) REFERENCES `term` (`term_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section`
--

LOCK TABLES `section` WRITE;
/*!40000 ALTER TABLE `section` DISABLE KEYS */;
INSERT INTO `section` VALUES (1,1,30,111,1,3),(2,1,50,150,2,3),(3,2,50,150,2,3),(4,1,35,388,3,3),(5,1,30,376,4,3),(6,2,30,111,1,2),(7,3,35,111,5,2),(8,1,50,150,2,2),(9,2,50,150,2,2),(10,1,30,376,4,2);
/*!40000 ALTER TABLE `section` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` char(2) NOT NULL,
  `birthdate` date NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES (1,'Paul','Miller','M','Dallas','TX','1996-02-22'),(2,'Katie','Smith','F','Provo','UT','1995-07-22'),(3,'Kelly','Jones','F','Provo','UT','1998-06-22'),(4,'Devon','Merrill','M','Mesa','AZ','2000-07-22'),(5,'Mandy','Murdock','F','Topeka','KS','1996-11-22'),(6,'Alece','Adams','F','Rigby','ID','1997-05-22'),(7,'Bryce','Carlson','M','Bozeman','MT','1997-11-22'),(8,'Preston','Larsen','M','Decatur','TN','1996-09-22'),(9,'Julia','Madsen','F','Rexburg','ID','1998-09-22'),(10,'Susan','Sorensen','F','Mesa','AZ','1998-08-09');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `term`
--

DROP TABLE IF EXISTS `term`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `term` (
  `term_id` int NOT NULL AUTO_INCREMENT,
  `term_name` enum('Fall','Winter') NOT NULL,
  `year` year NOT NULL,
  PRIMARY KEY (`term_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `term`
--

LOCK TABLES `term` WRITE;
/*!40000 ALTER TABLE `term` DISABLE KEYS */;
INSERT INTO `term` VALUES (1,'Fall',2018),(2,'Winter',2018),(3,'Fall',2019),(4,'Winter',2019);
/*!40000 ALTER TABLE `term` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-19 10:54:14
