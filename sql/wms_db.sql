/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50550
Source Host           : localhost:3306
Source Database       : wms_db

Target Server Type    : MYSQL
Target Server Version : 50550
File Encoding         : 65001

Date: 2019-09-05 09:50:34
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wms_access_record
-- ----------------------------
DROP TABLE IF EXISTS `wms_access_record`;
CREATE TABLE `wms_access_record` (
  `RECORD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL COMMENT '用户id',
  `USER_NAME` varchar(50) NOT NULL COMMENT '用户名',
  `ACCESS_TYPE` varchar(30) NOT NULL COMMENT '类型',
  `ACCESS_TIME` datetime NOT NULL COMMENT '登录时间',
  `ACCESS_IP` varchar(45) NOT NULL COMMENT 'IP',
  PRIMARY KEY (`RECORD_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8 COMMENT='登陆日志';

-- ----------------------------
-- Records of wms_access_record
-- ----------------------------
INSERT INTO `wms_access_record` VALUES ('1', '1001', 'admin', 'login', '2019-08-05 16:01:04', '0:0:0:0:0:0:0:1');
INSERT INTO `wms_access_record` VALUES ('2', '1001', 'admin', 'login', '2019-08-05 16:02:39', '0:0:0:0:0:0:0:1');
INSERT INTO `wms_access_record` VALUES ('3', '1001', 'admin', 'login', '2019-08-05 16:07:57', '0:0:0:0:0:0:0:1');
INSERT INTO `wms_access_record` VALUES ('4', '1001', 'admin', 'login', '2019-08-06 17:12:57', '0:0:0:0:0:0:0:1');
INSERT INTO `wms_access_record` VALUES ('5', '1001', 'admin', 'logout', '2019-08-06 17:54:12', '-');
INSERT INTO `wms_access_record` VALUES ('6', '1001', 'admin', 'login', '2019-08-14 09:44:44', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('7', '1001', 'admin', 'logout', '2019-08-14 10:19:52', '-');
INSERT INTO `wms_access_record` VALUES ('8', '1001', 'admin', 'login', '2019-08-14 19:09:36', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('9', '1001', 'admin', 'logout', '2019-08-14 20:03:16', '-');
INSERT INTO `wms_access_record` VALUES ('10', '1001', 'admin', 'login', '2019-08-15 09:14:53', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('11', '1001', 'admin', 'logout', '2019-08-15 10:12:45', '-');
INSERT INTO `wms_access_record` VALUES ('12', '1018', '王皓', 'login', '2019-08-15 10:12:59', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('13', '1018', '王皓', 'logout', '2019-08-15 10:13:11', '-');
INSERT INTO `wms_access_record` VALUES ('14', '1001', 'admin', 'login', '2019-08-15 10:13:23', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('15', '1001', 'admin', 'logout', '2019-08-15 11:07:03', '-');
INSERT INTO `wms_access_record` VALUES ('16', '1001', 'admin', 'login', '2019-08-15 16:29:38', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('17', '1001', 'admin', 'logout', '2019-08-15 17:17:06', '-');
INSERT INTO `wms_access_record` VALUES ('18', '1001', 'admin', 'login', '2019-08-15 18:10:50', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('19', '1001', 'admin', 'login', '2019-08-15 18:31:55', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('20', '1001', 'admin', 'login', '2019-08-15 18:40:37', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('21', '1001', 'admin', 'login', '2019-08-15 18:43:39', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('22', '1001', 'admin', 'logout', '2019-08-15 19:16:23', '-');
INSERT INTO `wms_access_record` VALUES ('23', '1001', 'admin', 'login', '2019-08-16 10:11:48', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('24', '1001', 'admin', 'login', '2019-08-16 10:15:39', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('25', '1001', 'admin', 'logout', '2019-08-16 10:46:16', '-');
INSERT INTO `wms_access_record` VALUES ('26', '1001', 'admin', 'login', '2019-08-16 10:46:58', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('27', '1001', 'admin', 'logout', '2019-08-16 11:47:16', '-');
INSERT INTO `wms_access_record` VALUES ('28', '1001', 'admin', 'login', '2019-08-16 17:25:54', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('29', '1001', 'admin', 'logout', '2019-08-16 17:57:20', '-');
INSERT INTO `wms_access_record` VALUES ('30', '1001', 'admin', 'login', '2019-08-16 18:18:44', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('31', '1001', 'admin', 'login', '2019-08-16 18:30:28', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('32', '1001', 'admin', 'login', '2019-08-16 18:47:39', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('33', '1001', 'admin', 'login', '2019-08-19 14:01:42', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('34', '1001', 'admin', 'login', '2019-08-19 14:17:50', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('35', '1001', 'admin', 'login', '2019-08-19 14:36:53', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('36', '1001', 'admin', 'logout', '2019-08-19 15:07:41', '-');
INSERT INTO `wms_access_record` VALUES ('37', '1001', 'admin', 'login', '2019-08-19 15:46:18', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('38', '1001', 'admin', 'logout', '2019-08-19 16:17:41', '-');
INSERT INTO `wms_access_record` VALUES ('39', '1001', 'admin', 'login', '2019-08-20 14:10:08', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('40', '1001', 'admin', 'login', '2019-08-20 14:54:12', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('41', '1001', 'admin', 'login', '2019-08-20 15:37:44', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('42', '1001', 'admin', 'login', '2019-08-20 15:53:29', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('43', '1001', 'admin', 'login', '2019-08-20 16:43:05', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('44', '1001', 'admin', 'login', '2019-08-20 16:44:09', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('45', '1001', 'admin', 'login', '2019-08-20 16:45:34', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('46', '1001', 'admin', 'login', '2019-08-20 16:46:25', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('47', '1001', 'admin', 'login', '2019-08-20 16:48:56', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('48', '1001', 'admin', 'logout', '2019-08-20 17:21:43', '-');
INSERT INTO `wms_access_record` VALUES ('49', '1001', 'admin', 'login', '2019-08-20 17:30:50', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('50', '1001', 'admin', 'logout', '2019-08-20 18:01:43', '-');
INSERT INTO `wms_access_record` VALUES ('51', '1001', 'admin', 'login', '2019-08-20 18:10:15', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('52', '1001', 'admin', 'login', '2019-08-20 18:38:09', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('53', '1001', 'admin', 'login', '2019-08-20 18:40:33', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('54', '1001', 'admin', 'logout', '2019-08-20 19:11:12', '-');
INSERT INTO `wms_access_record` VALUES ('55', '1001', 'admin', 'login', '2019-08-21 09:35:47', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('56', '1001', 'admin', 'logout', '2019-08-21 10:09:12', '-');
INSERT INTO `wms_access_record` VALUES ('57', '1001', 'admin', 'login', '2019-08-21 10:37:17', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('58', '1001', 'admin', 'logout', '2019-08-21 11:08:12', '-');
INSERT INTO `wms_access_record` VALUES ('59', '1001', 'admin', 'login', '2019-08-21 16:11:41', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('60', '1001', 'admin', 'login', '2019-08-21 16:36:21', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('61', '1001', 'admin', 'login', '2019-08-21 16:50:50', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('62', '1001', 'admin', 'login', '2019-08-21 16:58:42', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('63', '1001', 'admin', 'login', '2019-08-21 17:01:26', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('64', '1001', 'admin', 'login', '2019-08-21 17:22:49', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('65', '1001', 'admin', 'login', '2019-08-21 17:37:31', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('66', '1001', 'admin', 'login', '2019-08-21 18:23:15', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('67', '1001', 'admin', 'login', '2019-08-21 18:29:46', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('68', '1001', 'admin', 'login', '2019-08-21 18:41:51', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('69', '1001', 'admin', 'login', '2019-08-21 18:47:14', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('70', '1001', 'admin', 'logout', '2019-08-21 19:18:58', '-');
INSERT INTO `wms_access_record` VALUES ('71', '1001', 'admin', 'login', '2019-08-21 19:48:12', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('72', '1001', 'admin', 'login', '2019-08-21 19:54:39', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('73', '1001', 'admin', 'logout', '2019-08-21 20:53:14', '-');
INSERT INTO `wms_access_record` VALUES ('74', '1001', 'admin', 'login', '2019-08-22 10:15:57', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('75', '1001', 'admin', 'logout', '2019-08-22 10:46:14', '-');
INSERT INTO `wms_access_record` VALUES ('76', '1001', 'admin', 'login', '2019-08-22 10:46:44', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('77', '1001', 'admin', 'login', '2019-08-22 11:20:23', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('78', '1001', 'admin', 'login', '2019-08-22 11:26:46', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('79', '1001', 'admin', 'login', '2019-08-22 11:37:03', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('80', '1001', 'admin', 'login', '2019-08-22 11:39:00', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('81', '1001', 'admin', 'login', '2019-08-22 11:43:23', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('82', '1001', 'admin', 'logout', '2019-08-22 12:13:57', '-');
INSERT INTO `wms_access_record` VALUES ('83', '1001', 'admin', 'login', '2019-08-22 14:40:59', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('84', '1001', 'admin', 'logout', '2019-08-22 15:36:58', '-');
INSERT INTO `wms_access_record` VALUES ('85', '1001', 'admin', 'login', '2019-08-22 16:12:22', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('86', '1001', 'admin', 'login', '2019-08-22 16:42:19', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('87', '1001', 'admin', 'login', '2019-08-22 16:55:47', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('88', '1001', 'admin', 'login', '2019-08-22 17:02:51', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('89', '1001', 'admin', 'login', '2019-08-22 17:15:26', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('90', '1001', 'admin', 'login', '2019-08-22 17:19:09', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('91', '1001', 'admin', 'login', '2019-08-22 17:20:38', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('92', '1001', 'admin', 'login', '2019-08-22 17:30:52', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('93', '1001', 'admin', 'login', '2019-08-22 17:35:40', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('94', '1001', 'admin', 'logout', '2019-08-22 18:26:23', '-');
INSERT INTO `wms_access_record` VALUES ('95', '1001', 'admin', 'login', '2019-08-23 09:44:45', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('96', '1001', 'admin', 'logout', '2019-08-23 10:16:24', '-');
INSERT INTO `wms_access_record` VALUES ('97', '1001', 'admin', 'login', '2019-08-23 14:51:29', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('98', '1001', 'admin', 'login', '2019-08-23 15:41:05', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('99', '1001', 'admin', 'login', '2019-08-23 15:42:46', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('100', '1001', 'admin', 'login', '2019-08-23 16:25:26', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('101', '1001', 'admin', 'login', '2019-08-23 16:28:03', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('102', '1001', 'admin', 'login', '2019-08-23 16:29:40', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('103', '1001', 'admin', 'login', '2019-08-23 16:33:56', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('104', '1001', 'admin', 'login', '2019-08-23 16:39:41', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('105', '1001', 'admin', 'login', '2019-08-23 16:56:38', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('106', '1001', 'admin', 'logout', '2019-08-23 17:29:24', '-');
INSERT INTO `wms_access_record` VALUES ('107', '1001', 'admin', 'login', '2019-08-26 15:40:59', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('108', '1001', 'admin', 'logout', '2019-08-26 16:48:24', '-');
INSERT INTO `wms_access_record` VALUES ('109', '1001', 'admin', 'login', '2019-08-27 09:39:02', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('110', '1001', 'admin', 'logout', '2019-08-27 10:31:24', '-');
INSERT INTO `wms_access_record` VALUES ('111', '1001', 'admin', 'login', '2019-08-27 17:22:27', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('112', '1001', 'admin', 'logout', '2019-08-27 18:02:42', '-');
INSERT INTO `wms_access_record` VALUES ('113', '1001', 'admin', 'login', '2019-08-27 18:18:31', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('114', '1001', 'admin', 'login', '2019-08-27 18:44:04', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('115', '1001', 'admin', 'login', '2019-08-27 18:45:53', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('116', '1001', 'admin', 'login', '2019-08-27 19:06:04', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('117', '1001', 'admin', 'login', '2019-08-27 19:08:00', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('118', '1001', 'admin', 'login', '2019-08-27 19:15:23', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('119', '1001', 'admin', 'login', '2019-08-27 19:17:28', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('120', '1001', 'admin', 'logout', '2019-08-27 19:57:52', '-');
INSERT INTO `wms_access_record` VALUES ('121', '1001', 'admin', 'login', '2019-08-29 16:00:31', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('122', '1001', 'admin', 'login', '2019-08-29 16:02:50', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('123', '1001', 'admin', 'login', '2019-08-29 16:07:24', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('124', '1001', 'admin', 'logout', '2019-08-29 16:46:00', '-');
INSERT INTO `wms_access_record` VALUES ('125', '1001', 'admin', 'login', '2019-08-29 16:48:15', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('126', '1001', 'admin', 'login', '2019-08-29 17:01:06', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('127', '1001', 'admin', 'login', '2019-08-29 17:18:49', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('128', '1001', 'admin', 'login', '2019-08-29 17:44:16', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('129', '1001', 'admin', 'login', '2019-08-29 18:06:44', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('130', '1001', 'admin', 'logout', '2019-08-29 18:39:46', '-');
INSERT INTO `wms_access_record` VALUES ('131', '1001', 'admin', 'logout', '2019-08-30 15:57:38', '-');
INSERT INTO `wms_access_record` VALUES ('132', '1001', 'admin', 'login', '2019-09-04 10:04:25', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('133', '1001', 'admin', 'logout', '2019-09-04 10:46:02', '-');
INSERT INTO `wms_access_record` VALUES ('134', '1018', '王皓', 'login', '2019-09-04 14:24:50', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('135', '1001', 'admin', 'login', '2019-09-04 14:32:34', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('136', '1001', 'admin', 'login', '2019-09-04 14:33:59', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('137', '1001', 'admin', 'login', '2019-09-04 14:35:45', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('138', '1001', 'admin', 'login', '2019-09-04 14:36:59', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('139', '1001', 'admin', 'login', '2019-09-04 15:13:58', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('140', '1001', 'admin', 'logout', '2019-09-04 15:53:35', '-');
INSERT INTO `wms_access_record` VALUES ('141', '1001', 'admin', 'login', '2019-09-04 16:06:59', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('142', '1001', 'admin', 'login', '2019-09-04 16:09:26', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('143', '1001', 'admin', 'login', '2019-09-04 16:40:15', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('144', '1001', 'admin', 'login', '2019-09-04 16:46:08', '127.0.0.1');
INSERT INTO `wms_access_record` VALUES ('145', '1001', 'admin', 'logout', '2019-09-04 17:37:51', '-');

-- ----------------------------
-- Table structure for wms_action
-- ----------------------------
DROP TABLE IF EXISTS `wms_action`;
CREATE TABLE `wms_action` (
  `ACTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ACTION_NAME` varchar(30) NOT NULL,
  `ACTION_DESC` varchar(30) DEFAULT NULL,
  `ACTION_PARAM` varchar(50) NOT NULL,
  PRIMARY KEY (`ACTION_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COMMENT='权限表';

-- ----------------------------
-- Records of wms_action
-- ----------------------------
INSERT INTO `wms_action` VALUES ('1', 'addSupplier', null, '/supplierManage/addSupplier');
INSERT INTO `wms_action` VALUES ('2', 'deleteSupplier', null, '/supplierManage/deleteSupplier');
INSERT INTO `wms_action` VALUES ('3', 'updateSupplier', null, '/supplierManage/updateSupplier');
INSERT INTO `wms_action` VALUES ('4', 'selectSupplier', null, '/supplierManage/getSupplierList');
INSERT INTO `wms_action` VALUES ('5', 'getSupplierInfo', null, '/supplierManage/getSupplierInfo');
INSERT INTO `wms_action` VALUES ('6', 'importSupplier', null, '/supplierManage/importSupplier');
INSERT INTO `wms_action` VALUES ('7', 'exportSupplier', null, '/supplierManage/exportSupplier');
INSERT INTO `wms_action` VALUES ('8', 'selectCustomer', null, '/customerManage/getCustomerList');
INSERT INTO `wms_action` VALUES ('9', 'addCustomer', null, '/customerManage/addCustomer');
INSERT INTO `wms_action` VALUES ('10', 'getCustomerInfo', null, '/customerManage/getCustomerInfo');
INSERT INTO `wms_action` VALUES ('11', 'updateCustomer', null, '/customerManage/updateCustomer');
INSERT INTO `wms_action` VALUES ('12', 'deleteCustomer', null, '/customerManage/deleteCustomer');
INSERT INTO `wms_action` VALUES ('13', 'importCustomer', null, '/customerManage/importCustomer');
INSERT INTO `wms_action` VALUES ('14', 'exportCustomer', null, '/customerManage/exportCustomer');
INSERT INTO `wms_action` VALUES ('15', 'selectGoods', null, '/goodsManage/getGoodsList');
INSERT INTO `wms_action` VALUES ('16', 'addGoods', null, '/goodsManage/addGoods');
INSERT INTO `wms_action` VALUES ('17', 'getGoodsInfo', null, '/goodsManage/getGoodsInfo');
INSERT INTO `wms_action` VALUES ('18', 'updateGoods', null, '/goodsManage/updateGoods');
INSERT INTO `wms_action` VALUES ('19', 'deleteGoods', null, '/goodsManage/deleteGoods');
INSERT INTO `wms_action` VALUES ('20', 'importGoods', null, '/goodsManage/importGoods');
INSERT INTO `wms_action` VALUES ('21', 'exportGoods', null, '/goodsManage/exportGoods');
INSERT INTO `wms_action` VALUES ('22', 'selectRepository', null, '/repositoryManage/getRepositoryList');
INSERT INTO `wms_action` VALUES ('23', 'addRepository', null, '/repositoryManage/addRepository');
INSERT INTO `wms_action` VALUES ('24', 'getRepositoryInfo', null, '/repositoryManage/getRepository');
INSERT INTO `wms_action` VALUES ('25', 'updateRepository', null, '/repositoryManage/updateRepository');
INSERT INTO `wms_action` VALUES ('26', 'deleteRepository', null, '/repositoryManage/deleteRepository');
INSERT INTO `wms_action` VALUES ('27', 'importRepository', null, '/repositoryManage/importRepository');
INSERT INTO `wms_action` VALUES ('28', 'exportRepository', null, '/repositoryManage/exportRepository');
INSERT INTO `wms_action` VALUES ('29', 'selectRepositoryAdmin', null, '/repositoryAdminManage/getRepositoryAdminList');
INSERT INTO `wms_action` VALUES ('30', 'addRepositoryAdmin', null, '/repositoryAdminManage/addRepositoryAdmin');
INSERT INTO `wms_action` VALUES ('31', 'getRepositoryAdminInfo', null, '/repositoryAdminManage/getRepositoryAdminInfo');
INSERT INTO `wms_action` VALUES ('32', 'updateRepositoryAdmin', null, '/repositoryAdminManage/updateRepositoryAdmin');
INSERT INTO `wms_action` VALUES ('33', 'deleteRepositoryAdmin', null, '/repositoryAdminManage/deleteRepositoryAdmin');
INSERT INTO `wms_action` VALUES ('34', 'importRepositoryAd,om', null, '/repositoryAdminManage/importRepositoryAdmin');
INSERT INTO `wms_action` VALUES ('35', 'exportRepository', null, '/repositoryAdminManage/exportRepositoryAdmin');
INSERT INTO `wms_action` VALUES ('36', 'getUnassignRepository', null, '/repositoryManage/getUnassignRepository');
INSERT INTO `wms_action` VALUES ('37', 'getStorageListWithRepository', null, '/storageManage/getStorageListWithRepository');
INSERT INTO `wms_action` VALUES ('38', 'getStorageList', null, '/storageManage/getStorageList');
INSERT INTO `wms_action` VALUES ('39', 'addStorageRecord', null, '/storageManage/addStorageRecord');
INSERT INTO `wms_action` VALUES ('40', 'updateStorageRecord', null, '/storageManage/updateStorageRecord');
INSERT INTO `wms_action` VALUES ('41', 'deleteStorageRecord', null, '/storageManage/deleteStorageRecord');
INSERT INTO `wms_action` VALUES ('42', 'importStorageRecord', null, '/storageManage/importStorageRecord');
INSERT INTO `wms_action` VALUES ('43', 'exportStorageRecord', null, '/storageManage/exportStorageRecord');
INSERT INTO `wms_action` VALUES ('44', ' stockIn', null, '/stockRecordManage/stockIn');
INSERT INTO `wms_action` VALUES ('45', 'stockOut', null, '/stockRecordManage/stockOut');
INSERT INTO `wms_action` VALUES ('46', 'searchStockRecord', null, '/stockRecordManage/searchStockRecord');
INSERT INTO `wms_action` VALUES ('47', 'getAccessRecords', null, '/systemLog/getAccessRecords');
INSERT INTO `wms_action` VALUES ('48', 'selectUserOperationRecords', null, '/systemLog/selectUserOperationRecords');

-- ----------------------------
-- Table structure for wms_category
-- ----------------------------
DROP TABLE IF EXISTS `wms_category`;
CREATE TABLE `wms_category` (
  `CATEGORY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CATEGORY_NAME` varchar(25) NOT NULL COMMENT '货物类型名称',
  PRIMARY KEY (`CATEGORY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='货物类型表';

-- ----------------------------
-- Records of wms_category
-- ----------------------------
INSERT INTO `wms_category` VALUES ('2', '瓷器');
INSERT INTO `wms_category` VALUES ('4', '电器');
INSERT INTO `wms_category` VALUES ('5', '饮料');

-- ----------------------------
-- Table structure for wms_check_record
-- ----------------------------
DROP TABLE IF EXISTS `wms_check_record`;
CREATE TABLE `wms_check_record` (
  `CHECK_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '盘点记录id',
  `REPO_ID` int(11) NOT NULL COMMENT '仓库id',
  `SHELVES_ID` int(11) NOT NULL COMMENT '货架编号',
  `GOOD_ID` int(11) NOT NULL COMMENT '货物id',
  `RECORD_NUM` int(11) NOT NULL COMMENT '记录数量',
  `REAL_NUM` int(11) NOT NULL COMMENT '实际数量',
  `PERSON` varchar(50) NOT NULL COMMENT '操作人',
  `CHECK_TIME` datetime NOT NULL COMMENT '盘点时间',
  PRIMARY KEY (`CHECK_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8 COMMENT='盘点记录';

-- ----------------------------
-- Records of wms_check_record
-- ----------------------------
INSERT INTO `wms_check_record` VALUES ('100', '1004', '2', '105', '2000', '2000', 'admin', '2019-08-23 16:29:52');
INSERT INTO `wms_check_record` VALUES ('101', '1003', '1', '104', '1750', '1750', 'admin', '2019-08-23 16:40:14');

-- ----------------------------
-- Table structure for wms_customer
-- ----------------------------
DROP TABLE IF EXISTS `wms_customer`;
CREATE TABLE `wms_customer` (
  `CUSTOMER_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '客户id',
  `CUSTOMER_NAME` varchar(30) NOT NULL COMMENT '客户名称',
  `CUSTOMER_PERSON` varchar(10) NOT NULL COMMENT '负责人',
  `CUSTOMER_TEL` varchar(20) NOT NULL COMMENT '联系电话',
  `CUSTOMER_EMAIL` varchar(20) NOT NULL COMMENT '电子邮件',
  `CUSTOMER_ADDRESS` varchar(30) NOT NULL COMMENT '联系地址',
  PRIMARY KEY (`CUSTOMER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1217 DEFAULT CHARSET=utf8 COMMENT='客户信息表';

-- ----------------------------
-- Records of wms_customer
-- ----------------------------
INSERT INTO `wms_customer` VALUES ('1214', '醴陵荣旗瓷业有限公司', '陈娟', '17716786888', '23369888@136.com', '中国 湖南 醴陵市 嘉树乡玉茶村柏树组');
INSERT INTO `wms_customer` VALUES ('1215', '深圳市松林达电子有限公司', '刘明', '85263335-820', '85264958@126.com', '中国 广东 深圳市宝安区 深圳市宝安区福永社区桥头村桥塘路育');
INSERT INTO `wms_customer` VALUES ('1216', '郑州绿之源饮品有限公司 ', '赵志敬', '87094196', '87092165@qq.com', '中国 河南 郑州市 郑州市嘉亿东方大厦609');

-- ----------------------------
-- Table structure for wms_goods
-- ----------------------------
DROP TABLE IF EXISTS `wms_goods`;
CREATE TABLE `wms_goods` (
  `GOOD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GOOD_NAME` varchar(30) NOT NULL COMMENT '货物名称',
  `GOOD_SIZE` varchar(20) DEFAULT NULL COMMENT '货物尺寸',
  `GOOD_VALUE` double(11,2) NOT NULL COMMENT '货物价值',
  `CATEGORY_ID` int(11) NOT NULL COMMENT '货物类型id',
  `WARNING_VALUE` int(11) NOT NULL DEFAULT '0' COMMENT '预警值',
  PRIMARY KEY (`GOOD_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=109 DEFAULT CHARSET=utf8 COMMENT='货物信息表';

-- ----------------------------
-- Records of wms_goods
-- ----------------------------
INSERT INTO `wms_goods` VALUES ('103', '五孔插座西门子墙壁开关', '86*86', '1.85', '4', '100');
INSERT INTO `wms_goods` VALUES ('104', '陶瓷马克杯', '9*9*11', '3.50', '2', '1000');
INSERT INTO `wms_goods` VALUES ('105', '精酿苹果醋', '312ml', '3.00', '5', '10000');
INSERT INTO `wms_goods` VALUES ('106', '百事可乐', '600ml', '3.50', '5', '2000');
INSERT INTO `wms_goods` VALUES ('107', '雪碧', '650ml', '3.50', '5', '500');

-- ----------------------------
-- Table structure for wms_msg
-- ----------------------------
DROP TABLE IF EXISTS `wms_msg`;
CREATE TABLE `wms_msg` (
  `MSG_ID` int(10) NOT NULL AUTO_INCREMENT,
  `MSG_TITLE` varchar(50) NOT NULL COMMENT '标题',
  `MSG_CONTENT` varchar(255) NOT NULL COMMENT '内容',
  `MSG_STATUS` int(2) NOT NULL COMMENT '状态(0-未读;1-已读)',
  `MSG_TIME` datetime DEFAULT NULL,
  PRIMARY KEY (`MSG_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_msg
-- ----------------------------
INSERT INTO `wms_msg` VALUES ('2', '库存预警', '商品精酿苹果醋库存已经不足10000,请注意查看', '0', '2019-09-04 16:54:15');

-- ----------------------------
-- Table structure for wms_operation_record
-- ----------------------------
DROP TABLE IF EXISTS `wms_operation_record`;
CREATE TABLE `wms_operation_record` (
  `RECORD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `USER_NAME` varchar(50) NOT NULL COMMENT '用户名',
  `OPERATION_NAME` varchar(30) NOT NULL COMMENT '操作',
  `OPERATION_TIME` datetime NOT NULL COMMENT '时间',
  `OPERATION_RESULT` varchar(15) NOT NULL COMMENT '结果',
  PRIMARY KEY (`RECORD_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COMMENT='用户系统操作记录表';

-- ----------------------------
-- Records of wms_operation_record
-- ----------------------------
INSERT INTO `wms_operation_record` VALUES ('1', '1001', 'admin', '添加仓库管理员信息', '2019-08-06 17:17:00', '成功');
INSERT INTO `wms_operation_record` VALUES ('2', '1001', 'admin', '修改仓库管理员信息', '2019-08-06 17:23:24', '成功');
INSERT INTO `wms_operation_record` VALUES ('3', '1001', 'admin', '删除仓库管理员信息', '2019-08-15 09:57:06', '失败');
INSERT INTO `wms_operation_record` VALUES ('4', '1001', 'admin', '删除仓库管理员信息', '2019-08-15 09:57:31', '失败');
INSERT INTO `wms_operation_record` VALUES ('5', '1001', 'admin', '删除仓库管理员信息', '2019-08-15 10:00:01', '失败');
INSERT INTO `wms_operation_record` VALUES ('6', '1001', 'admin', '删除仓库管理员信息', '2019-08-15 10:02:11', '失败');
INSERT INTO `wms_operation_record` VALUES ('7', '1001', 'admin', '修改仓库管理员信息', '2019-08-15 10:02:27', '成功');
INSERT INTO `wms_operation_record` VALUES ('8', '1001', 'admin', '删除仓库管理员信息', '2019-08-15 10:02:53', '成功');
INSERT INTO `wms_operation_record` VALUES ('9', '1001', 'admin', '修改货物信息', '2019-08-16 18:39:44', '成功');
INSERT INTO `wms_operation_record` VALUES ('10', '1001', 'admin', '修改货物信息', '2019-08-16 18:40:08', '成功');
INSERT INTO `wms_operation_record` VALUES ('11', '1001', 'admin', '修改货物信息', '2019-08-16 18:40:16', '成功');
INSERT INTO `wms_operation_record` VALUES ('12', '1001', 'admin', '添加货物信息', '2019-08-16 18:48:05', '成功');
INSERT INTO `wms_operation_record` VALUES ('13', '1001', 'admin', '修改货物信息', '2019-08-19 14:08:30', '成功');
INSERT INTO `wms_operation_record` VALUES ('14', '1001', 'admin', '修改仓库信息', '2019-08-19 15:46:48', '成功');
INSERT INTO `wms_operation_record` VALUES ('15', '1001', 'admin', '修改仓库信息', '2019-08-19 15:47:17', '成功');
INSERT INTO `wms_operation_record` VALUES ('16', '1001', 'admin', '修改仓库信息', '2019-08-19 15:47:28', '成功');
INSERT INTO `wms_operation_record` VALUES ('17', '1001', 'admin', '添加库存记录', '2019-08-21 18:26:10', '失败');
INSERT INTO `wms_operation_record` VALUES ('18', '1001', 'admin', '添加库存记录', '2019-08-21 18:27:18', '失败');
INSERT INTO `wms_operation_record` VALUES ('19', '1001', 'admin', '添加库存记录', '2019-08-21 18:28:56', '失败');
INSERT INTO `wms_operation_record` VALUES ('20', '1001', 'admin', '添加库存记录', '2019-08-21 18:32:42', '成功');
INSERT INTO `wms_operation_record` VALUES ('21', '1001', 'admin', '修改库存记录', '2019-08-21 18:33:03', '成功');
INSERT INTO `wms_operation_record` VALUES ('22', '1001', 'admin', '删除库存记录', '2019-08-21 18:47:24', '成功');
INSERT INTO `wms_operation_record` VALUES ('23', '1001', 'admin', '货物入库', '2019-08-22 14:58:23', '成功');
INSERT INTO `wms_operation_record` VALUES ('24', '1001', 'admin', '货物入库', '2019-08-22 15:02:45', '成功');
INSERT INTO `wms_operation_record` VALUES ('25', '1001', 'admin', '货物入库', '2019-08-22 15:03:10', '成功');
INSERT INTO `wms_operation_record` VALUES ('26', '1001', 'admin', '货物出库', '2019-08-22 16:42:48', '成功');
INSERT INTO `wms_operation_record` VALUES ('27', '1001', 'admin', '添加盘点记录', '2019-08-23 16:29:52', '成功');
INSERT INTO `wms_operation_record` VALUES ('28', '1001', 'admin', '添加盘点记录', '2019-08-23 16:40:14', '成功');
INSERT INTO `wms_operation_record` VALUES ('29', '1001', 'admin', '导出库存记录', '2019-08-29 16:07:39', '-');
INSERT INTO `wms_operation_record` VALUES ('30', '1001', 'admin', '导出仓库管理员信息', '2019-08-29 16:09:09', '-');
INSERT INTO `wms_operation_record` VALUES ('31', '1001', 'admin', '导出供应商信息', '2019-08-29 16:09:34', '-');
INSERT INTO `wms_operation_record` VALUES ('32', '1001', 'admin', '导出客户信息', '2019-08-29 16:09:41', '-');
INSERT INTO `wms_operation_record` VALUES ('33', '1001', 'admin', '导出货物信息', '2019-08-29 16:09:55', '-');
INSERT INTO `wms_operation_record` VALUES ('34', '1001', 'admin', '导出仓库信息', '2019-08-29 16:10:07', '-');
INSERT INTO `wms_operation_record` VALUES ('35', '1001', 'admin', '导出货架信息', '2019-08-29 17:04:47', '-');
INSERT INTO `wms_operation_record` VALUES ('36', '1001', 'admin', '导出货架信息', '2019-08-29 17:19:03', '-');
INSERT INTO `wms_operation_record` VALUES ('37', '1001', 'admin', '导出盘点记录', '2019-08-29 17:44:30', '-');
INSERT INTO `wms_operation_record` VALUES ('38', '1001', 'admin', '修改货物信息', '2019-09-04 15:06:27', '成功');
INSERT INTO `wms_operation_record` VALUES ('39', '1001', 'admin', '修改货物信息', '2019-09-04 15:06:53', '成功');
INSERT INTO `wms_operation_record` VALUES ('40', '1001', 'admin', '修改货物信息', '2019-09-04 15:07:01', '成功');
INSERT INTO `wms_operation_record` VALUES ('41', '1001', 'admin', '修改货物信息', '2019-09-04 15:07:08', '成功');
INSERT INTO `wms_operation_record` VALUES ('42', '1001', 'admin', '添加货物信息', '2019-09-04 15:07:37', '成功');
INSERT INTO `wms_operation_record` VALUES ('43', '1001', 'admin', '修改货物信息', '2019-09-04 15:08:06', '成功');
INSERT INTO `wms_operation_record` VALUES ('44', '1001', 'admin', '添加货物信息', '2019-09-04 15:10:21', '成功');
INSERT INTO `wms_operation_record` VALUES ('45', '1001', 'admin', '删除货物信息', '2019-09-04 15:10:34', '成功');
INSERT INTO `wms_operation_record` VALUES ('46', '1001', 'admin', '货物出库', '2019-09-04 15:14:30', '成功');
INSERT INTO `wms_operation_record` VALUES ('47', '1001', 'admin', '货物出库', '2019-09-04 16:54:15', '成功');

-- ----------------------------
-- Table structure for wms_record_in
-- ----------------------------
DROP TABLE IF EXISTS `wms_record_in`;
CREATE TABLE `wms_record_in` (
  `RECORD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RECORD_SUPPLIERID` int(11) NOT NULL COMMENT '供应商id',
  `RECORD_GOODID` int(11) NOT NULL COMMENT '货物id',
  `RECORD_NUMBER` int(11) NOT NULL COMMENT '入库数量',
  `RECORD_TIME` datetime NOT NULL COMMENT '入库时间',
  `RECORD_PERSON` varchar(10) NOT NULL COMMENT '操作人员',
  `RECORD_REPOSITORYID` int(11) NOT NULL COMMENT '仓库id',
  `RECORD_SHELVESID` int(11) NOT NULL COMMENT '货架id',
  PRIMARY KEY (`RECORD_ID`),
  KEY `RECORD_SUPPLIERID` (`RECORD_SUPPLIERID`),
  KEY `RECORD_GOODID` (`RECORD_GOODID`),
  KEY `RECORD_REPOSITORYID` (`RECORD_REPOSITORYID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='入库记录表';

-- ----------------------------
-- Records of wms_record_in
-- ----------------------------
INSERT INTO `wms_record_in` VALUES ('15', '1015', '105', '1000', '2016-12-31 00:00:00', 'admin', '1004', '0');
INSERT INTO `wms_record_in` VALUES ('16', '1015', '105', '200', '2017-01-02 00:00:00', 'admin', '1004', '0');
INSERT INTO `wms_record_in` VALUES ('17', '1013', '105', '3000', '2019-08-22 14:58:23', 'admin', '1003', '1');
INSERT INTO `wms_record_in` VALUES ('18', '1013', '106', '500', '2019-08-22 15:02:45', 'admin', '1003', '1');
INSERT INTO `wms_record_in` VALUES ('19', '1013', '106', '1500', '2019-08-22 15:03:10', 'admin', '1004', '2');

-- ----------------------------
-- Table structure for wms_record_out
-- ----------------------------
DROP TABLE IF EXISTS `wms_record_out`;
CREATE TABLE `wms_record_out` (
  `RECORD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RECORD_CUSTOMERID` int(11) NOT NULL COMMENT '客户id',
  `RECORD_GOODID` int(11) NOT NULL COMMENT '货物id',
  `RECORD_NUMBER` int(11) NOT NULL COMMENT '出库数量',
  `RECORD_TIME` datetime NOT NULL COMMENT '出库时间',
  `RECORD_PERSON` varchar(10) NOT NULL COMMENT '操作人员',
  `RECORD_REPOSITORYID` int(11) NOT NULL COMMENT '仓库编号',
  `RECORD_SHELVESID` int(11) NOT NULL COMMENT '货架id',
  PRIMARY KEY (`RECORD_ID`),
  KEY `RECORD_CUSTOMERID` (`RECORD_CUSTOMERID`),
  KEY `RECORD_GOODID` (`RECORD_GOODID`),
  KEY `RECORD_REPOSITORYID` (`RECORD_REPOSITORYID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='出库记录表';

-- ----------------------------
-- Records of wms_record_out
-- ----------------------------
INSERT INTO `wms_record_out` VALUES ('7', '1214', '104', '750', '2019-06-01 16:47:50', 'admin', '1003', '0');
INSERT INTO `wms_record_out` VALUES ('8', '1216', '105', '500', '2019-08-22 16:42:48', 'admin', '1003', '1');
INSERT INTO `wms_record_out` VALUES ('9', '1214', '104', '750', '2019-08-29 16:47:50', 'admin', '1003', '0');
INSERT INTO `wms_record_out` VALUES ('10', '1216', '105', '500', '2019-07-01 16:42:48', 'admin', '1003', '1');
INSERT INTO `wms_record_out` VALUES ('12', '1216', '106', '500', '2019-09-04 15:14:30', 'admin', '1003', '1');
INSERT INTO `wms_record_out` VALUES ('13', '1216', '105', '500', '2019-09-04 16:54:15', 'admin', '1003', '1');

-- ----------------------------
-- Table structure for wms_record_storage
-- ----------------------------
DROP TABLE IF EXISTS `wms_record_storage`;
CREATE TABLE `wms_record_storage` (
  `RECORD_GOODID` int(11) NOT NULL COMMENT '货物id',
  `RECORD_REPOSITORY` int(11) NOT NULL COMMENT '仓库',
  `RECORD_SHELVES` int(11) NOT NULL COMMENT '货架编号',
  `RECORD_NUMBER` int(11) NOT NULL COMMENT '数量',
  PRIMARY KEY (`RECORD_GOODID`,`RECORD_REPOSITORY`,`RECORD_SHELVES`),
  KEY `RECORD_REPOSITORY` (`RECORD_REPOSITORY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存记录表';

-- ----------------------------
-- Records of wms_record_storage
-- ----------------------------
INSERT INTO `wms_record_storage` VALUES ('103', '1005', '4', '10000');
INSERT INTO `wms_record_storage` VALUES ('104', '1003', '1', '1750');
INSERT INTO `wms_record_storage` VALUES ('105', '1003', '1', '2000');
INSERT INTO `wms_record_storage` VALUES ('105', '1004', '2', '2000');
INSERT INTO `wms_record_storage` VALUES ('106', '1003', '1', '0');
INSERT INTO `wms_record_storage` VALUES ('106', '1004', '2', '1500');

-- ----------------------------
-- Table structure for wms_repo_admin
-- ----------------------------
DROP TABLE IF EXISTS `wms_repo_admin`;
CREATE TABLE `wms_repo_admin` (
  `REPO_ADMIN_ID` int(11) NOT NULL AUTO_INCREMENT,
  `REPO_ADMIN_NAME` varchar(10) NOT NULL COMMENT '仓库管理员姓名',
  `REPO_ADMIN_SEX` varchar(10) NOT NULL COMMENT '仓库管理员性别',
  `REPO_ADMIN_TEL` varchar(20) NOT NULL COMMENT '联系电话',
  `REPO_ADMIN_ADDRESS` varchar(30) NOT NULL COMMENT '联系地址',
  `REPO_ADMIN_BIRTH` datetime NOT NULL COMMENT '出生日期',
  `REPO_ADMIN_REPOID` int(11) DEFAULT NULL COMMENT '所属仓库ID',
  PRIMARY KEY (`REPO_ADMIN_ID`),
  KEY `REPO_ADMIN_REPOID` (`REPO_ADMIN_REPOID`)
) ENGINE=InnoDB AUTO_INCREMENT=1020 DEFAULT CHARSET=utf8 COMMENT='仓库管理员信息表';

-- ----------------------------
-- Records of wms_repo_admin
-- ----------------------------
INSERT INTO `wms_repo_admin` VALUES ('1018', '王皓', '女', '12345874526', '中国佛山', '2016-12-09 00:00:00', '1004');
INSERT INTO `wms_repo_admin` VALUES ('1019', '李富荣', '男', '1234', '广州', '2016-12-07 00:00:00', '1003');

-- ----------------------------
-- Table structure for wms_respository
-- ----------------------------
DROP TABLE IF EXISTS `wms_respository`;
CREATE TABLE `wms_respository` (
  `REPO_ID` int(11) NOT NULL AUTO_INCREMENT,
  `REPO_ADDRESS` varchar(30) NOT NULL COMMENT '仓库地址',
  `REPO_STATUS` varchar(20) NOT NULL COMMENT '状态(0-废弃;1-启用)',
  `REPO_AREA` varchar(20) NOT NULL COMMENT '仓库地址',
  `REPO_DESC` varchar(50) DEFAULT NULL COMMENT '仓库描述',
  `REPO_NAME` varchar(20) NOT NULL COMMENT '仓库名称',
  PRIMARY KEY (`REPO_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8 COMMENT='仓库信息表';

-- ----------------------------
-- Records of wms_respository
-- ----------------------------
INSERT INTO `wms_respository` VALUES ('1003', '北京顺义南彩工业园区彩祥西路9号', '可用', '11000㎡', '提供服务完整', '1号仓库');
INSERT INTO `wms_respository` VALUES ('1004', '广州白云石井石潭路大基围工业区', '可用', '1000㎡', '物流极为便利', '2号仓库');
INSERT INTO `wms_respository` VALUES ('1005', ' 香港北区文锦渡路（红桥新村）', '可用', '5000.00㎡', '', '5号仓库');

-- ----------------------------
-- Table structure for wms_roles
-- ----------------------------
DROP TABLE IF EXISTS `wms_roles`;
CREATE TABLE `wms_roles` (
  `ROLE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(20) NOT NULL COMMENT '角色名称',
  `ROLE_DESC` varchar(30) DEFAULT NULL COMMENT '角色描述',
  `ROLE_URL_PREFIX` varchar(20) NOT NULL,
  PRIMARY KEY (`ROLE_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- ----------------------------
-- Records of wms_roles
-- ----------------------------
INSERT INTO `wms_roles` VALUES ('1', 'systemAdmin', null, 'systemAdmin');
INSERT INTO `wms_roles` VALUES ('2', 'commonsAdmin', null, 'commonsAdmin');

-- ----------------------------
-- Table structure for wms_role_action
-- ----------------------------
DROP TABLE IF EXISTS `wms_role_action`;
CREATE TABLE `wms_role_action` (
  `ACTION_ID` int(11) NOT NULL COMMENT '权限id',
  `ROLE_ID` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`ACTION_ID`,`ROLE_ID`),
  KEY `ROLE_ID` (`ROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色 - URL权限关联表';

-- ----------------------------
-- Records of wms_role_action
-- ----------------------------
INSERT INTO `wms_role_action` VALUES ('1', '1');
INSERT INTO `wms_role_action` VALUES ('2', '1');
INSERT INTO `wms_role_action` VALUES ('3', '1');
INSERT INTO `wms_role_action` VALUES ('4', '1');
INSERT INTO `wms_role_action` VALUES ('5', '1');
INSERT INTO `wms_role_action` VALUES ('6', '1');
INSERT INTO `wms_role_action` VALUES ('7', '1');
INSERT INTO `wms_role_action` VALUES ('8', '1');
INSERT INTO `wms_role_action` VALUES ('9', '1');
INSERT INTO `wms_role_action` VALUES ('10', '1');
INSERT INTO `wms_role_action` VALUES ('11', '1');
INSERT INTO `wms_role_action` VALUES ('12', '1');
INSERT INTO `wms_role_action` VALUES ('13', '1');
INSERT INTO `wms_role_action` VALUES ('14', '1');
INSERT INTO `wms_role_action` VALUES ('15', '1');
INSERT INTO `wms_role_action` VALUES ('16', '1');
INSERT INTO `wms_role_action` VALUES ('17', '1');
INSERT INTO `wms_role_action` VALUES ('18', '1');
INSERT INTO `wms_role_action` VALUES ('19', '1');
INSERT INTO `wms_role_action` VALUES ('20', '1');
INSERT INTO `wms_role_action` VALUES ('21', '1');
INSERT INTO `wms_role_action` VALUES ('22', '1');
INSERT INTO `wms_role_action` VALUES ('23', '1');
INSERT INTO `wms_role_action` VALUES ('24', '1');
INSERT INTO `wms_role_action` VALUES ('25', '1');
INSERT INTO `wms_role_action` VALUES ('26', '1');
INSERT INTO `wms_role_action` VALUES ('27', '1');
INSERT INTO `wms_role_action` VALUES ('28', '1');
INSERT INTO `wms_role_action` VALUES ('29', '1');
INSERT INTO `wms_role_action` VALUES ('30', '1');
INSERT INTO `wms_role_action` VALUES ('31', '1');
INSERT INTO `wms_role_action` VALUES ('32', '1');
INSERT INTO `wms_role_action` VALUES ('33', '1');
INSERT INTO `wms_role_action` VALUES ('34', '1');
INSERT INTO `wms_role_action` VALUES ('35', '1');
INSERT INTO `wms_role_action` VALUES ('36', '1');
INSERT INTO `wms_role_action` VALUES ('37', '1');
INSERT INTO `wms_role_action` VALUES ('39', '1');
INSERT INTO `wms_role_action` VALUES ('40', '1');
INSERT INTO `wms_role_action` VALUES ('41', '1');
INSERT INTO `wms_role_action` VALUES ('42', '1');
INSERT INTO `wms_role_action` VALUES ('43', '1');
INSERT INTO `wms_role_action` VALUES ('44', '1');
INSERT INTO `wms_role_action` VALUES ('45', '1');
INSERT INTO `wms_role_action` VALUES ('46', '1');
INSERT INTO `wms_role_action` VALUES ('47', '1');
INSERT INTO `wms_role_action` VALUES ('48', '1');
INSERT INTO `wms_role_action` VALUES ('4', '2');
INSERT INTO `wms_role_action` VALUES ('38', '2');
INSERT INTO `wms_role_action` VALUES ('43', '2');

-- ----------------------------
-- Table structure for wms_shelves
-- ----------------------------
DROP TABLE IF EXISTS `wms_shelves`;
CREATE TABLE `wms_shelves` (
  `SHELVES_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT '货架id',
  `SHELVES_NAME` varchar(25) NOT NULL COMMENT '货架名称',
  `REPO_ID` int(11) NOT NULL COMMENT '所属仓库',
  `GOOD_IDS` varchar(255) DEFAULT NULL COMMENT '货架支持存放的货物类型',
  PRIMARY KEY (`SHELVES_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='货架表';

-- ----------------------------
-- Records of wms_shelves
-- ----------------------------
INSERT INTO `wms_shelves` VALUES ('1', '货架A', '1003', '103,104,105,106');
INSERT INTO `wms_shelves` VALUES ('2', '货架C', '1004', '105,106');
INSERT INTO `wms_shelves` VALUES ('4', '货架B', '1005', '103');

-- ----------------------------
-- Table structure for wms_supplier
-- ----------------------------
DROP TABLE IF EXISTS `wms_supplier`;
CREATE TABLE `wms_supplier` (
  `SUPPLIER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SUPPLIER_NAME` varchar(30) NOT NULL COMMENT '供应商名称',
  `SUPPLIER_PERSON` varchar(10) NOT NULL COMMENT '负责人姓名',
  `SUPPLIER_TEL` varchar(20) NOT NULL COMMENT '联系电话',
  `SUPPLIER_EMAIL` varchar(20) NOT NULL COMMENT '电子邮件',
  `SUPPLIER_ADDRESS` varchar(30) NOT NULL COMMENT '联系地址',
  PRIMARY KEY (`SUPPLIER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1016 DEFAULT CHARSET=utf8 COMMENT='供应商信息表';

-- ----------------------------
-- Records of wms_supplier
-- ----------------------------
INSERT INTO `wms_supplier` VALUES ('1013', '浙江奇同电器有限公司', '王泽伟', '13777771126', '86827868@126.com', '中国 浙江 温州市龙湾区 龙湾区永强大道1648号');
INSERT INTO `wms_supplier` VALUES ('1014', '醴陵春天陶瓷实业有限公司', '温仙容', '13974167256', '23267999@126.com', '中国 湖南 醴陵市 东正街15号');
INSERT INTO `wms_supplier` VALUES ('1015', '洛阳嘉吉利饮品有限公司', '郑绮云', '26391678', '22390898@qq.com', '中国 广东 佛山市顺德区 北滘镇怡和路2号怡和中心14楼');

-- ----------------------------
-- Table structure for wms_user
-- ----------------------------
DROP TABLE IF EXISTS `wms_user`;
CREATE TABLE `wms_user` (
  `USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_USERNAME` varchar(30) NOT NULL,
  `USER_PASSWORD` varchar(40) NOT NULL,
  PRIMARY KEY (`USER_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1020 DEFAULT CHARSET=utf8 COMMENT='系统用户信息表';

-- ----------------------------
-- Records of wms_user
-- ----------------------------
INSERT INTO `wms_user` VALUES ('1001', 'admin', '5714249b586ccc50bacecc3a9dde9c8b');
INSERT INTO `wms_user` VALUES ('1018', '王皓', '50f202f4862360e55635b0a9616ded13');
INSERT INTO `wms_user` VALUES ('1019', '李富荣', 'c4b3af5a5ab3e3d5aac4c5a5436201b8');

-- ----------------------------
-- Table structure for wms_user_role
-- ----------------------------
DROP TABLE IF EXISTS `wms_user_role`;
CREATE TABLE `wms_user_role` (
  `ROLE_ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  PRIMARY KEY (`ROLE_ID`,`USER_ID`),
  KEY `USER_ID` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户 - 角色关联表';

-- ----------------------------
-- Records of wms_user_role
-- ----------------------------
INSERT INTO `wms_user_role` VALUES ('1', '1001');
INSERT INTO `wms_user_role` VALUES ('2', '1018');
INSERT INTO `wms_user_role` VALUES ('2', '1019');

-- ----------------------------
-- View structure for year_month_view
-- ----------------------------
DROP VIEW IF EXISTS `year_month_view`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER  VIEW `year_month_view` AS select date_format(curdate(),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 1 month),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 2 month),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 3 month),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 4 month),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 5 month),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 6 month),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 7 month),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 8 month),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 9 month),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 10 month),'%Y-%m') AS `year_month` union select date_format((curdate() - interval 11 month),'%Y-%m') AS `year_month` ;
