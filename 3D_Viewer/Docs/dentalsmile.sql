/*
SQLyog Community v8.61 
MySQL - 5.0.22-community-nt : Database - dentalsmile
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dentalsmile` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `dentalsmile`;

/*Table structure for table `appointments` */

DROP TABLE IF EXISTS `appointments`;

CREATE TABLE `appointments` (
  `id` int(11) NOT NULL auto_increment,
  `appointment_date` date default NULL,
  `appointment_time` varchar(10) default NULL,
  `patient` varchar(13) default NULL,
  `dentist` varchar(13) default NULL,
  `room` varchar(50) default NULL,
  `created` datetime default NULL,
  `createdBy` varchar(13) default NULL,
  `modified` datetime default NULL,
  `modifiedBy` varchar(13) default NULL,
  `notes` varchar(255) default NULL,
  `subject` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `appointments` */

insert  into `appointments`(`id`,`appointment_date`,`appointment_time`,`patient`,`dentist`,`room`,`created`,`createdBy`,`modified`,`modifiedBy`,`notes`,`subject`) values (1,'2013-05-15','10:00','SUN0104130001','SUN0104130001','1','2013-01-01 00:00:00',NULL,NULL,NULL,NULL,'Test'),(2,'2013-05-10','13:00','SUN0104130001','SUN0104130001','1','2013-01-01 00:00:00',NULL,NULL,NULL,NULL,'Appointment');

/*Table structure for table `dentist` */

DROP TABLE IF EXISTS `dentist`;

CREATE TABLE `dentist` (
  `userid` varchar(15) NOT NULL,
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) default NULL,
  `birthdate` date default NULL,
  `birthplace` varchar(45) default NULL,
  `address1` varchar(45) default NULL,
  `address2` varchar(45) default NULL,
  `city` varchar(45) default NULL,
  `phone` varchar(15) default NULL,
  `created` date default NULL,
  `createdBy` varchar(45) default NULL,
  `modified` timestamp NULL default NULL,
  `modifiedBy` varchar(45) default NULL,
  `gender` varchar(6) default NULL,
  PRIMARY KEY  (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `dentist` */

insert  into `dentist`(`userid`,`fname`,`lname`,`birthdate`,`birthplace`,`address1`,`address2`,`city`,`phone`,`created`,`createdBy`,`modified`,`modifiedBy`,`gender`) values ('DWIM','DWIm','MII','1984-05-19','GK','yk','yk','yk','0921',NULL,NULL,NULL,NULL,'M'),('root','root',NULL,'2013-05-05',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),('x','x','x','2013-05-05','x',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `measurement` */

DROP TABLE IF EXISTS `measurement`;

CREATE TABLE `measurement` (
  `id` int(11) NOT NULL auto_increment,
  `patient` varchar(13) default NULL,
  `treatment` varchar(16) default NULL,
  `pfile` varchar(16) default NULL,
  `type` varchar(45) default NULL,
  `created` datetime default NULL,
  `createdBy` varchar(45) default NULL,
  `modified` datetime default NULL,
  `modifiedBy` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `measurement` */

/*Table structure for table `measurement_detail` */

DROP TABLE IF EXISTS `measurement_detail`;

CREATE TABLE `measurement_detail` (
  `measurement_detail_id` int(7) NOT NULL auto_increment,
  `measurement_id` int(7) NOT NULL,
  `tooth_id` int(2) default NULL,
  PRIMARY KEY  (`measurement_detail_id`,`measurement_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `measurement_detail` */

/*Table structure for table `measurementteeth` */

DROP TABLE IF EXISTS `measurementteeth`;

CREATE TABLE `measurementteeth` (
  `id` int(11) NOT NULL auto_increment,
  `measurementid` int(11) default NULL,
  `teethid` varchar(255) default NULL,
  `length` double default NULL,
  `spoint` varchar(45) default NULL,
  `epoint` varchar(45) default NULL,
  `type` varchar(5) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `measurementteeth` */

/*Table structure for table `patient` */

DROP TABLE IF EXISTS `patient`;

CREATE TABLE `patient` (
  `id` varchar(13) NOT NULL COMMENT 'auto-increment has a limit;\nor generated with format SUN0104130001',
  `fname` varchar(45) NOT NULL,
  `lname` varchar(45) default NULL,
  `birthdate` date NOT NULL,
  `birthplace` varchar(50) NOT NULL,
  `gender` varchar(6) NOT NULL default '' COMMENT 'M;F',
  `address1` varchar(100) NOT NULL,
  `address2` varchar(100) default NULL,
  `city` varchar(45) default NULL,
  `phone` varchar(15) NOT NULL,
  `created` date default NULL,
  `createdBy` varchar(45) default NULL,
  `modified` timestamp NULL default NULL,
  `modifiedBy` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `patient` */

insert  into `patient`(`id`,`fname`,`lname`,`birthdate`,`birthplace`,`gender`,`address1`,`address2`,`city`,`phone`,`created`,`createdBy`,`modified`,`modifiedBy`) values ('SUN0104130001','DWI','MIYANTO','2013-05-19','GK','Male','yk','yk','yk','0821',NULL,NULL,NULL,NULL),('Tue0705130001','dr.wewe','asas','2013-05-07','5/7/2013','Female','asasa','sasa','sasa','1212','2013-05-07','USER','2013-05-10 09:17:42','USER'),('Fri1005130001','qwqwq','wqwq','2013-05-09','wqwq','Male','qwqw','wqwq','wqwq','12121','2013-05-10','USER',NULL,NULL);

/*Table structure for table `pfile` */

DROP TABLE IF EXISTS `pfile`;

CREATE TABLE `pfile` (
  `PATIENT` varchar(13) NOT NULL,
  `id` varchar(16) NOT NULL,
  `filename` varchar(35) NOT NULL,
  `description` varchar(255) default NULL,
  `type` tinyint(5) NOT NULL default '0',
  `refId` varchar(16) default NULL,
  `created` date default NULL COMMENT 'uploaded',
  `createdBy` varchar(50) default NULL,
  `modified` timestamp NULL default NULL,
  `modifiedBy` varchar(50) default NULL,
  `screenshot` varchar(50) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_PFILE_PATIENT` (`PATIENT`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `pfile` */

insert  into `pfile`(`PATIENT`,`id`,`filename`,`description`,`type`,`refId`,`created`,`createdBy`,`modified`,`modifiedBy`,`screenshot`) values ('SUN0104130001','SUN0104130001001','sdefault.obj',NULL,2,NULL,NULL,NULL,NULL,NULL,'default.jpg');

/*Table structure for table `phase` */

DROP TABLE IF EXISTS `phase`;

CREATE TABLE `phase` (
  `id` int(1) NOT NULL,
  `name` varchar(25) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `phase` */

insert  into `phase`(`id`,`name`) values (1,'REGISTERED'),(2,'SCANNING'),(3,'MANIPULATION'),(4,'TREATMENT I'),(5,'TREATMENT II'),(6,'TREATMENT III'),(7,'BRACES'),(8,'WIRING'),(9,'PRINTING');

/*Table structure for table `smileuser` */

DROP TABLE IF EXISTS `smileuser`;

CREATE TABLE `smileuser` (
  `userid` varchar(25) NOT NULL,
  `password` varchar(35) NOT NULL default '',
  `admin` tinyint(1) NOT NULL default '0',
  `created` datetime default NULL,
  `createdBy` varchar(45) default NULL,
  `modified` timestamp NULL default NULL,
  `modifiedBy` varchar(45) default NULL,
  PRIMARY KEY  (`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `smileuser` */

insert  into `smileuser`(`userid`,`password`,`admin`,`created`,`createdBy`,`modified`,`modifiedBy`) values ('DWIM','900150983CD24FB0D6963F7D28E17F72',0,NULL,NULL,NULL,NULL),('root','202CB962AC59075B964B07152D234B70',1,'2013-05-09 10:20:02','DENTALSMILE',NULL,NULL),('x','D41D8CD98F00B204E9800998ECF8427E',0,'2013-05-12 01:35:09','USER',NULL,NULL);

/*Table structure for table `tooth` */

DROP TABLE IF EXISTS `tooth`;

CREATE TABLE `tooth` (
  `number` int(2) NOT NULL,
  `type` int(1) default NULL COMMENT '1:upper ; 2:lower',
  `name` varchar(25) NOT NULL,
  PRIMARY KEY  (`number`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `tooth` */

/*Table structure for table `treatment` */

DROP TABLE IF EXISTS `treatment`;

CREATE TABLE `treatment` (
  `id` varchar(16) NOT NULL,
  `PHASE` int(1) default NULL,
  `PATIENT` varchar(13) default NULL,
  `DENTIST` varchar(15) default NULL,
  `tdate` date default NULL,
  `ttime` varchar(10) default NULL,
  `room` varchar(45) default NULL,
  `refId` varchar(16) default NULL,
  `created` date default NULL,
  `createdBy` varchar(45) default NULL,
  `modified` timestamp NULL default NULL,
  `modifiedBy` varchar(45) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_TREATMENT_PATIENT` (`PATIENT`),
  KEY `fk_TREATMENT_DOCTOR` (`DENTIST`),
  KEY `fk_TREATMENT_PHASE` (`PHASE`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `treatment` */

insert  into `treatment`(`id`,`PHASE`,`PATIENT`,`DENTIST`,`tdate`,`ttime`,`room`,`refId`,`created`,`createdBy`,`modified`,`modifiedBy`) values ('SUN0104130001001',1,'SUN0104130001','DWIM','2013-04-05','10:00:00','1',NULL,NULL,NULL,NULL,NULL),('SUN0104130001002',2,'SUN0104130001','DWIM','2013-04-05','10:20:00','1','SUN0104130001001',NULL,NULL,NULL,NULL),('Fri1005130001001',1,'Fri1005130001','DWIM','0001-01-01','','001','','2013-05-10','USER',NULL,NULL),('SUN0104130001005',4,'SUN0104130001','root','2013-05-13','12:00:18','2','','2013-05-13','root',NULL,NULL);

/*Table structure for table `treatment_notes` */

DROP TABLE IF EXISTS `treatment_notes`;

CREATE TABLE `treatment_notes` (
  `id` int(11) NOT NULL auto_increment,
  `TREATMENT` varchar(16) default NULL,
  `PFILE` varchar(16) default NULL,
  `notes` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `created` datetime default NULL,
  `createdBy` varchar(45) default NULL,
  PRIMARY KEY  (`id`),
  KEY `fk_TREATMENT_NOTES_TREATMENT_PFILE` (`TREATMENT`,`PFILE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `treatment_notes` */

insert  into `treatment_notes`(`id`,`TREATMENT`,`PFILE`,`notes`,`description`,`created`,`createdBy`) values (1,'SUN0104130001005','','sww','sa','2013-05-13 12:00:18','root');

/*Table structure for table `treatment_pfile` */

DROP TABLE IF EXISTS `treatment_pfile`;

CREATE TABLE `treatment_pfile` (
  `TREATMENT` varchar(16) NOT NULL,
  `PFILE` varchar(16) NOT NULL,
  PRIMARY KEY  (`TREATMENT`,`PFILE`),
  KEY `fk_TREATMENT_has_PFILE_PFILE` (`PFILE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `treatment_pfile` */

insert  into `treatment_pfile`(`TREATMENT`,`PFILE`) values ('SUN0104130001002','SUN0104130001001');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
