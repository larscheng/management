/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50144
Source Host           : localhost:3306
Source Database       : management

Target Server Type    : MYSQL
Target Server Version : 50144
File Encoding         : 65001

Date: 2018-05-30 16:51:18
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for man_apply
-- ----------------------------
DROP TABLE IF EXISTS `man_apply`;
CREATE TABLE `man_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `o_id` int(11) DEFAULT NULL COMMENT '社团id',
  `u_id` int(11) DEFAULT NULL COMMENT '用户id',
  `apply_reason` text COMMENT '申请理由',
  `audit_status` tinyint(1) DEFAULT '1' COMMENT '审核状态1未处理2审核通过3审核不通过',
  `audit_content` text COMMENT '审核意见',
  `gmt_create` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_apply
-- ----------------------------
INSERT INTO `man_apply` VALUES ('18', '1', '24', 'dasdasdas', '1', null, '2018-05-29 16:53:50');
INSERT INTO `man_apply` VALUES ('19', '2', '24', 'asdasdasd', '2', null, '2018-05-29 17:15:11');

-- ----------------------------
-- Table structure for man_notice
-- ----------------------------
DROP TABLE IF EXISTS `man_notice`;
CREATE TABLE `man_notice` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告id',
  `notice_title` varchar(50) DEFAULT NULL COMMENT '公告标题',
  `notice_auth` int(11) DEFAULT NULL COMMENT '公告作者',
  `org_id` int(11) DEFAULT NULL COMMENT '社团id',
  `notice_content` text COMMENT '公告内容',
  `gmt_create` datetime DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_notice
-- ----------------------------
INSERT INTO `man_notice` VALUES ('1', '公告', '1', '2', '阿四阿四阿四阿四', '2018-05-30 13:26:27');
INSERT INTO `man_notice` VALUES ('2', '最新公告', '23', '2', '<p><img src=\"http://localhost:8080/layui-admin/layui/images/face/1.gif\" alt=\"[嘻嘻]\"></p><p><img src=\"http://localhost:8080/layui-admin/layui/images/face/28.gif\" alt=\"[馋嘴]\"><br></p>', '2018-05-30 13:27:54');

-- ----------------------------
-- Table structure for man_org
-- ----------------------------
DROP TABLE IF EXISTS `man_org`;
CREATE TABLE `man_org` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `org_name` varchar(30) DEFAULT NULL COMMENT '社团名称',
  `org_founder` int(11) DEFAULT NULL COMMENT '社团创始人',
  `org_num` int(11) DEFAULT NULL COMMENT '社团额定人数',
  `org_type` tinyint(1) DEFAULT NULL COMMENT '社团类型',
  `org_info` text COMMENT '社团介绍',
  `org_status` tinyint(1) DEFAULT '1' COMMENT '社团状态 1启用0禁用',
  `audit_content` text COMMENT '审核意见',
  `audit_status` tinyint(1) DEFAULT '1' COMMENT '审核状态 1未处理2审核通过3审核不通过',
  `operator_id` int(11) DEFAULT NULL COMMENT '审核人',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modify` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_org
-- ----------------------------
INSERT INTO `man_org` VALUES ('1', '街舞社', '1', '50', '1', ',姐呜呜呜u&nbsp;', '1', null, '2', null, '2018-05-29 14:25:30', '2018-05-29 14:25:41');
INSERT INTO `man_org` VALUES ('2', '轮滑社', '23', '50', '2', ',阿三大苏打', '1', null, '2', null, '2018-05-29 14:26:14', '2018-05-29 14:26:25');
INSERT INTO `man_org` VALUES ('3', '青龙社', '23', '50', '3', ',阿斯顿啊', '1', 'sadasdasd', '3', null, '2018-05-29 14:28:31', '2018-05-29 17:16:54');
INSERT INTO `man_org` VALUES ('4', '计算机社', '23', '50', '1', ',asda是', '1', null, '1', null, '2018-05-29 18:11:40', null);

-- ----------------------------
-- Table structure for man_user
-- ----------------------------
DROP TABLE IF EXISTS `man_user`;
CREATE TABLE `man_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `user_sex` tinyint(1) DEFAULT NULL COMMENT '性别 1男2女',
  `user_code` varchar(8) DEFAULT NULL COMMENT '账号',
  `user_password` varchar(20) DEFAULT NULL COMMENT '密码',
  `user_mail` varchar(30) DEFAULT NULL COMMENT '邮箱',
  `user_phone` varchar(15) DEFAULT NULL COMMENT '电话',
  `user_birthday` varchar(20) DEFAULT NULL COMMENT '生日',
  `user_address` varchar(30) DEFAULT NULL COMMENT '家庭地址',
  `user_hobby` varchar(30) DEFAULT NULL COMMENT '兴趣爱好',
  `user_evaluate` text COMMENT '自我评价',
  `user_type` tinyint(1) DEFAULT NULL COMMENT '用户类型，1超管2社长3社团管理4社员',
  `user_status` tinyint(1) DEFAULT '1' COMMENT '1启用0禁用',
  `user_org` int(11) DEFAULT NULL COMMENT '所属社团id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modify` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_user
-- ----------------------------
INSERT INTO `man_user` VALUES ('1', '杨瑞', '2', '14098221', '123456789', '489671435@qq.com', '18329891939', '2018-05-08', null, null, '哈哈哈哈哈哈', '1', '1', '1', '2018-05-22 18:28:34', '2018-05-28 14:26:44');
INSERT INTO `man_user` VALUES ('5', '杨瑞4', '1', '14098225', '123456', '489671435@qq.com', '13108018752', '2018-05-08', '', '', 'wqeqweqweasdasdas', '1', '1', '2', '2018-05-22 18:28:34', '2018-05-28 14:26:45');
INSERT INTO `man_user` VALUES ('8', '杨瑞7', '1', '14098228', '123456', '489671435@qq.com', '13108018752', '2018-05-08', '', '', 'wqeqweqweasdasdas', '1', '1', '3', '2018-05-22 18:28:34', '2018-05-28 14:26:46');
INSERT INTO `man_user` VALUES ('9', '杨瑞8', '1', '14098229', '123456', '489671435@qq.com', '13108018752', '2018-05-08', '', '', 'wqeqweqweasdasdas', '1', '0', '4', '2018-05-22 18:28:34', '2018-05-28 14:26:47');
INSERT INTO `man_user` VALUES ('22', 'qweqweqw', '1', 'qweqw', '123456', '2113@wwe.qwe', null, null, null, null, 'qweqwe', '4', '0', '11', null, '2018-05-29 12:44:46');
INSERT INTO `man_user` VALUES ('23', '郑其龙', '1', '14098125', '123456', '123456789@qq.com', '13108018752', '2011-05-19', null, null, '撒大苏打上', '4', '1', null, '2018-05-29 12:42:36', '2018-05-29 12:47:41');
INSERT INTO `man_user` VALUES ('24', '刘璇', '1', '14098124', '123456', '545646546@qq.bj', null, null, null, null, '56456', '4', '1', null, '2018-05-29 16:16:33', null);

-- ----------------------------
-- Table structure for man_user_org
-- ----------------------------
DROP TABLE IF EXISTS `man_user_org`;
CREATE TABLE `man_user_org` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` int(11) DEFAULT NULL,
  `o_id` int(11) DEFAULT NULL,
  `gmt_create` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of man_user_org
-- ----------------------------
INSERT INTO `man_user_org` VALUES ('1', '1', '1', null);
INSERT INTO `man_user_org` VALUES ('2', '23', '2', null);
INSERT INTO `man_user_org` VALUES ('4', '24', '2', '2018-05-29 18:20:37');
