/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : gezhi

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2020-07-09 18:28:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for date
-- ----------------------------
DROP TABLE IF EXISTS `date`;
CREATE TABLE `date` (
  `userid` int(11) NOT NULL COMMENT '用户id',
  `date` date NOT NULL,
  `tag` varchar(255) DEFAULT NULL COMMENT '标签',
  `weather` char(255) DEFAULT NULL COMMENT '天气',
  KEY `userid` (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of date
-- ----------------------------
INSERT INTO `date` VALUES ('1', '2020-07-08', null, '晴');
INSERT INTO `date` VALUES ('2', '2020-07-09', null, '雨');

-- ----------------------------
-- Table structure for diary
-- ----------------------------
DROP TABLE IF EXISTS `diary`;
CREATE TABLE `diary` (
  `userid` int(11) NOT NULL COMMENT '外键',
  `diary` mediumtext,
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of diary
-- ----------------------------
INSERT INTO `diary` VALUES ('1', '');

-- ----------------------------
-- Table structure for tiplibrary
-- ----------------------------
DROP TABLE IF EXISTS `tiplibrary`;
CREATE TABLE `tiplibrary` (
  `date` char(255) NOT NULL,
  `tip` varchar(255) DEFAULT NULL,
  `userid` int(11) NOT NULL,
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tiplibrary
-- ----------------------------
INSERT INTO `tiplibrary` VALUES ('日', '今天你好吗？', '0');
INSERT INTO `tiplibrary` VALUES ('年', '今年还好吗？', '0');
INSERT INTO `tiplibrary` VALUES ('月', '这个月还好吗？', '0');
INSERT INTO `tiplibrary` VALUES ('日', '有什么想说？', '0');
INSERT INTO `tiplibrary` VALUES ('周', '周计划是什么？', '0');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `name` varchar(255) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `isVIP` tinyint(4) DEFAULT NULL,
  `userid` int(11) NOT NULL AUTO_INCREMENT,
  `auth` char(255) NOT NULL,
  `password` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('dl', '2020-07-08', 'http://ppe.oss-cn-shenzhen.aliyuncs.com/collections/182/2/thumb.jpg', '1', '1', '121212', '12');
