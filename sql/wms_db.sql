/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50550
Source Host           : localhost:3306
Source Database       : wms_db

Target Server Type    : MYSQL
Target Server Version : 50550
File Encoding         : 65001

Date: 2019-08-16 18:49:34
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COMMENT='登陆日志';

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
  `CHECK_ID` int(11) NOT NULL COMMENT '盘点记录id',
  `REPO_ID` int(11) NOT NULL COMMENT '仓库id',
  `SHELVES_ID` int(11) NOT NULL COMMENT '货架编号',
  `GOOD_ID` int(11) NOT NULL COMMENT '货物id',
  `RECORD_NUM` int(11) NOT NULL COMMENT '记录数量',
  `REAL_NUM` int(11) NOT NULL COMMENT '实际数量',
  `USER_ID` int(11) NOT NULL COMMENT '用户id',
  `CHECK_TIME` datetime NOT NULL COMMENT '盘点时间',
  PRIMARY KEY (`CHECK_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wms_check_record
-- ----------------------------

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
  `GOOD_RYPE` varchar(20) DEFAULT NULL COMMENT '货物类型',
  `GOOD_SIZE` varchar(20) DEFAULT NULL COMMENT '货物尺寸',
  `GOOD_VALUE` double(11,2) NOT NULL COMMENT '货物价值',
  `CATEGORY_ID` int(11) NOT NULL COMMENT '货物类型id',
  PRIMARY KEY (`GOOD_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8 COMMENT='货物信息表';

-- ----------------------------
-- Records of wms_goods
-- ----------------------------
INSERT INTO `wms_goods` VALUES ('103', '五孔插座西门子墙壁开关', '电器', '86*86', '1.85', '2');
INSERT INTO `wms_goods` VALUES ('104', '陶瓷马克杯', '陶瓷', '9*9*11', '3.50', '2');
INSERT INTO `wms_goods` VALUES ('105', '精酿苹果醋', '饮料', '312ml', '300.00', '5');
INSERT INTO `wms_goods` VALUES ('106', '百事可乐', null, '600ml', '3.50', '5');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='用户系统操作记录表';

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='入库记录表';

-- ----------------------------
-- Records of wms_record_in
-- ----------------------------
INSERT INTO `wms_record_in` VALUES ('15', '1015', '105', '1000', '2016-12-31 00:00:00', 'admin', '1004', '0');
INSERT INTO `wms_record_in` VALUES ('16', '1015', '105', '200', '2017-01-02 00:00:00', 'admin', '1004', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='出库记录表';

-- ----------------------------
-- Records of wms_record_out
-- ----------------------------
INSERT INTO `wms_record_out` VALUES ('7', '1214', '104', '750', '2016-12-31 00:00:00', 'admin', '1003', '0');

-- ----------------------------
-- Table structure for wms_record_storage
-- ----------------------------
DROP TABLE IF EXISTS `wms_record_storage`;
CREATE TABLE `wms_record_storage` (
  `RECORD_GOODID` int(11) NOT NULL AUTO_INCREMENT COMMENT '货物id',
  `RECORD_REPOSITORY` int(11) NOT NULL COMMENT '仓库',
  `RECORD_NUMBER` int(11) NOT NULL COMMENT '数量',
  PRIMARY KEY (`RECORD_GOODID`),
  KEY `RECORD_REPOSITORY` (`RECORD_REPOSITORY`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8 COMMENT='库存记录表';

-- ----------------------------
-- Records of wms_record_storage
-- ----------------------------
INSERT INTO `wms_record_storage` VALUES ('103', '1005', '10000');
INSERT INTO `wms_record_storage` VALUES ('104', '1003', '1750');
INSERT INTO `wms_record_storage` VALUES ('105', '1004', '2000');

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
) ENGINE=InnoDB AUTO_INCREMENT=1021 DEFAULT CHARSET=utf8 COMMENT='仓库管理员信息表';

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
INSERT INTO `wms_respository` VALUES ('1003', '北京顺义南彩工业园区彩祥西路9号', '可用', '11000㎡', '提供服务完整', '');
INSERT INTO `wms_respository` VALUES ('1004', '广州白云石井石潭路大基围工业区', '可用', '1000㎡', '物流极为便利', '');
INSERT INTO `wms_respository` VALUES ('1005', ' 香港北区文锦渡路（红桥新村）', '可用', '5000.00㎡', null, '');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='货架表';

-- ----------------------------
-- Records of wms_shelves
-- ----------------------------

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
) ENGINE=InnoDB AUTO_INCREMENT=1021 DEFAULT CHARSET=utf8 COMMENT='系统用户信息表';

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
