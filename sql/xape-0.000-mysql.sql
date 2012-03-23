-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Fri Mar 23 14:07:31 2012
-- 
SET foreign_key_checks=0;

CREATE TABLE `languages` (
  `id` char(2) NOT NULL,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
);

--
-- Table: `phrases`
--
CREATE TABLE `phrases` (
  `id` integer(11) NOT NULL auto_increment,
  `phrase` varchar(128) NOT NULL,
  `language` char(2) NOT NULL,
  `enum` integer(11) NOT NULL,
  INDEX `phrases_k1` (`phrase`),
  INDEX `phrases_k2` (`enum`),
  PRIMARY KEY (`id`),
  UNIQUE KEY `phrase` (`phrase`),
  CONSTRAINT `phrases_fk1` FOREIGN KEY (`language`) REFERENCES `languages` (`id`)
);

SET foreign_key_checks=1;

