/*
Navicat MySQL Data Transfer

Source Server         : 本机
Source Server Version : 50731
Source Host           : 127.0.0.1:3306
Source Database       : springboot_vue

Target Server Type    : MYSQL
Target Server Version : 50731
File Encoding         : 65001

Date: 2021-05-19 22:34:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_parameter
-- ----------------------------
DROP TABLE IF EXISTS `sys_parameter`;
CREATE TABLE `sys_parameter` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `p_code` varchar(20) DEFAULT NULL COMMENT '参数代码',
  `p_name` varchar(50) DEFAULT NULL COMMENT '参数名称',
  `p_desc` varchar(255) DEFAULT NULL COMMENT '参数描述',
  `p_value` varchar(255) DEFAULT NULL COMMENT '参数值',
  `p_value1` varchar(255) DEFAULT NULL COMMENT '参数值1',
  `p_value2` varchar(255) DEFAULT NULL COMMENT '参数值2',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `P_CODE_INDEX` (`p_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统参数';
