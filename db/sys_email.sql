/*
Navicat MySQL Data Transfer

Source Server         : 本机
Source Server Version : 50731
Source Host           : 127.0.0.1:3306
Source Database       : springboot_vue

Target Server Type    : MYSQL
Target Server Version : 50731
File Encoding         : 65001

Date: 2022-01-28 10:41:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_email
-- ----------------------------
DROP TABLE IF EXISTS `sys_email`;
CREATE TABLE `sys_email` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `smtp_server` varchar(100) DEFAULT NULL COMMENT '邮件服务器',
  `smtp_port` varchar(10) DEFAULT NULL COMMENT '邮件服务器端口',
  `smtp_username` varchar(20) DEFAULT NULL COMMENT '邮件账号',
  `smtp_password` varchar(64) DEFAULT NULL COMMENT '邮件服务器密码',
  `smtp_email` varchar(64) DEFAULT NULL COMMENT '发件人邮箱',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_email
-- ----------------------------
INSERT INTO `sys_email` VALUES ('1486876059611062274', null, '0', '2022-01-28 01:37:32.089000', null, '2022-01-28 01:37:56.330000', null, null, 'smtp.qq.com', '465', 'dean.x.liu@qq.com', '1', 'dean.x.liu@qq.com');
