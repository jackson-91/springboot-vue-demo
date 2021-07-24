/*
Navicat MySQL Data Transfer

Source Server         : 本机
Source Server Version : 50731
Source Host           : 127.0.0.1:3306
Source Database       : springboot_vue

Target Server Type    : MYSQL
Target Server Version : 50731
File Encoding         : 65001

Date: 2021-01-30 21:57:36
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for base_table
-- ----------------------------
DROP TABLE IF EXISTS `base_table`;
CREATE TABLE `base_table` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of base_table
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `blob_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `sched_name` varchar(120) NOT NULL,
  `calendar_name` varchar(200) NOT NULL,
  `calendar` blob NOT NULL,
  PRIMARY KEY (`sched_name`,`calendar_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `cron_expression` varchar(200) NOT NULL,
  `time_zone_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('scheduler', 'triggerJOB1', 'JOB1', '*/1 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `entry_id` varchar(95) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `fired_time` bigint(13) NOT NULL,
  `sched_time` bigint(13) NOT NULL,
  `priority` int(11) NOT NULL,
  `state` varchar(16) NOT NULL,
  `job_name` varchar(200) DEFAULT NULL,
  `job_group` varchar(200) DEFAULT NULL,
  `is_nonconcurrent` varchar(1) DEFAULT NULL,
  `requests_recovery` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`entry_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `sched_name` varchar(120) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `job_class_name` varchar(250) NOT NULL,
  `is_durable` varchar(1) NOT NULL,
  `is_nonconcurrent` varchar(1) NOT NULL,
  `is_update_data` varchar(1) NOT NULL,
  `requests_recovery` varchar(1) NOT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`job_name`,`job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('scheduler', 'JOB1', 'JOB1', '测试任务', 'org.dev.basic.job.Job1', '0', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C770800000010000000017400157363686564756C6572496E7374616E63654E616D6574000F71756172747A5363686564756C65727800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `sched_name` varchar(120) NOT NULL,
  `lock_name` varchar(40) NOT NULL,
  PRIMARY KEY (`sched_name`,`lock_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('scheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `sched_name` varchar(120) NOT NULL,
  `instance_name` varchar(200) NOT NULL,
  `last_checkin_time` bigint(13) NOT NULL,
  `checkin_interval` bigint(13) NOT NULL,
  PRIMARY KEY (`sched_name`,`instance_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `repeat_count` bigint(7) NOT NULL,
  `repeat_interval` bigint(12) NOT NULL,
  `times_triggered` bigint(10) NOT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `str_prop_1` varchar(512) DEFAULT NULL,
  `str_prop_2` varchar(512) DEFAULT NULL,
  `str_prop_3` varchar(512) DEFAULT NULL,
  `int_prop_1` int(11) DEFAULT NULL,
  `int_prop_2` int(11) DEFAULT NULL,
  `long_prop_1` bigint(20) DEFAULT NULL,
  `long_prop_2` bigint(20) DEFAULT NULL,
  `dec_prop_1` decimal(13,4) DEFAULT NULL,
  `dec_prop_2` decimal(13,4) DEFAULT NULL,
  `bool_prop_1` varchar(1) DEFAULT NULL,
  `bool_prop_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `sched_name` varchar(120) NOT NULL,
  `trigger_name` varchar(200) NOT NULL,
  `trigger_group` varchar(200) NOT NULL,
  `job_name` varchar(200) NOT NULL,
  `job_group` varchar(200) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `next_fire_time` bigint(13) DEFAULT NULL,
  `prev_fire_time` bigint(13) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `trigger_state` varchar(16) NOT NULL,
  `trigger_type` varchar(8) NOT NULL,
  `start_time` bigint(13) NOT NULL,
  `end_time` bigint(13) DEFAULT NULL,
  `calendar_name` varchar(200) DEFAULT NULL,
  `misfire_instr` smallint(2) DEFAULT NULL,
  `job_data` blob,
  PRIMARY KEY (`sched_name`,`trigger_name`,`trigger_group`),
  KEY `sched_name` (`sched_name`,`job_name`,`job_group`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('scheduler', 'triggerJOB1', 'JOB1', 'JOB1', 'JOB1', null, '1608298750000', '1608298749000', '5', 'PAUSED', 'CRON', '1597482726000', '0', null, '0', '');

-- ----------------------------
-- Table structure for sys_auth_btn
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_btn`;
CREATE TABLE `sys_auth_btn` (
  `id` varchar(32) DEFAULT NULL COMMENT 'COLUMN_COMMENT',
  `btn_name` varchar(255) DEFAULT NULL COMMENT 'COLUMN_COMMENT',
  `btn_code` varchar(255) DEFAULT NULL COMMENT 'COLUMN_COMMENT',
  `oper_icon` varchar(255) DEFAULT NULL COMMENT 'COLUMN_COMMENT',
  `menu_id` varchar(32) DEFAULT NULL COMMENT 'COLUMN_COMMENT',
  `menu_name` varchar(255) DEFAULT NULL COMMENT 'COLUMN_COMMENT',
  `menu_code` varchar(255) DEFAULT NULL COMMENT 'COLUMN_COMMENT',
  `create_time` datetime(6) DEFAULT NULL COMMENT 'COLUMN_COMMENT',
  `update_time` datetime(6) DEFAULT NULL COMMENT 'COLUMN_COMMENT',
  `project_id` varchar(32) DEFAULT NULL COMMENT 'COLUMN_COMMENT'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_auth_btn
-- ----------------------------
INSERT INTO `sys_auth_btn` VALUES ('20181011111450-ec75a385fc7242d88', '物料模板导出', 'downLoadMaterialAction', 'fa-download', '20170515045617-0bceeda338184b5f8', '物料主数据', 'materialManagement', '2018-10-11 11:14:50.391000', '2018-10-11 11:14:50.391000', null);
INSERT INTO `sys_auth_btn` VALUES ('20181011112331-141d9074a3464a839', '物料导入', 'uploadMaterialSuccess', 'fa-upload', '20170515045617-0bceeda338184b5f8', '物料主数据', 'materialManagement', '2018-10-11 11:23:31.361000', '2018-10-11 11:23:31.361000', null);
INSERT INTO `sys_auth_btn` VALUES ('20181011040220-102e4e49ca794268a', '物料分类模板导出', 'downLoadCategoryAction', 'fa-download', '20170515045617-0bceeda338184b5f8', '物料主数据', 'materialManagement', '2018-10-11 16:02:20.457000', '2018-10-11 16:02:20.457000', null);
INSERT INTO `sys_auth_btn` VALUES ('20181011040306-75041269b8c04485b', '分类数据TXT导入', 'uploadCategorySuccess', 'fa-upload', '20170515045617-0bceeda338184b5f8', '物料主数据', 'materialManagement', '2018-10-11 16:03:06.895000', '2018-10-11 16:03:06.895000', null);
INSERT INTO `sys_auth_btn` VALUES ('20181011040351-6c8b3bfe04ae46629', '自动检验模板导出', 'downLoadExaminationAction', 'fa-download', '20170515045617-0bceeda338184b5f8', '物料主数据', 'materialManagement', '2018-10-11 16:03:51.513000', '2018-10-11 16:03:51.513000', null);
INSERT INTO `sys_auth_btn` VALUES ('20181011040419-4da38c1c60a44bd69', '自动检验数据TXT导入', 'uploadExaminationSuccess', 'fa-upload', '20170515045617-0bceeda338184b5f8', '物料主数据', 'materialManagement', '2018-10-11 16:04:19.511000', '2018-10-11 16:04:19.511000', null);
INSERT INTO `sys_auth_btn` VALUES ('20181017051253-7114cbfbfde245339', '启用物料有效期', 'setDate,set', 'fa-check', '20170515045617-0bceeda338184b5f8', '物料主数据', 'materialManagement', '2018-10-17 17:12:53.791000', '2018-10-17 17:12:53.791000', null);
INSERT INTO `sys_auth_btn` VALUES ('20181017051338-8e2149ef5c7841f7a', '禁用物料有效期', 'setDate,cancel', 'fa-times', '20170515045617-0bceeda338184b5f8', '物料主数据', 'materialManagement', '2018-10-17 17:13:38.291000', '2018-10-17 17:13:38.291000', null);
INSERT INTO `sys_auth_btn` VALUES ('20181126032631-f5a3563b202a4c2bb', '保存', 'save', 'fa-check', '20170622055006-1bde0b0c604743b9a', '供应商主数据', 'supplyCompany', '2018-11-26 15:26:31.079000', '2018-11-26 15:26:31.079000', null);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `dept_code` varchar(20) DEFAULT NULL COMMENT '部门代码',
  `dept_name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `dept_desc` varchar(50) DEFAULT NULL COMMENT '部门描述',
  `parent_id` bigint(32) DEFAULT NULL COMMENT '父级部门',
  `dept_header` bigint(32) DEFAULT NULL COMMENT '部门负责人',
  `dept_header_jobscode` varchar(50) DEFAULT NULL COMMENT '负责人代码',
  `dept_header_jobs` bigint(32) DEFAULT NULL COMMENT '负责人职务',
  `dept_header_jobsname` varchar(50) DEFAULT NULL COMMENT '负责人职务名称',
  `dept_phone` varchar(15) DEFAULT NULL COMMENT '部门电话',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1', '1', 'D001', '公司', null, '-1', '1319972557251690497', 'A005', '1319972557251690497', '营运长', null, '0', null, null, '2021-01-30 08:43:33.259000', null, null);
INSERT INTO `sys_dept` VALUES ('1319993068082016258', null, '1111', '1111', null, '1', '1', null, null, null, null, '1', '2020-10-24 13:24:06.374000', '1', '2020-10-24 13:24:06.374000', '1', null);
INSERT INTO `sys_dept` VALUES ('1321449022619250689', null, 'DT00', '实施一处', null, '1', '1319640560482439169', 'A004', '1319640560482439169', '处长', null, '0', '2020-10-28 13:49:32.985000', '1', '2021-01-30 08:51:49.404000', null, null);
INSERT INTO `sys_dept` VALUES ('1353250973491322881', null, 'DT010', '开发一部', null, '1321449022619250689', '1319640501757988865', 'A003', '1319640501757988865', '部长', null, '0', '2021-01-24 07:59:08.934000', null, '2021-01-30 08:43:38.612000', null, null);
INSERT INTO `sys_dept` VALUES ('1353251092714414081', null, 'DT011', '开发一课', null, '1353250973491322881', '1319640445013250050', 'A002', '1319640445013250050', '课长', null, '0', '2021-01-24 07:59:37.350000', null, '2021-01-30 08:43:41.243000', null, null);
INSERT INTO `sys_dept` VALUES ('1353251202168971265', null, 'DT012', '开发二课', null, '1353250973491322881', '1319640445013250050', 'A002', '1319640445013250050', '课长', null, '0', '2021-01-24 08:00:03.445000', null, '2021-01-30 08:43:44.057000', null, null);

-- ----------------------------
-- Table structure for sys_dic
-- ----------------------------
DROP TABLE IF EXISTS `sys_dic`;
CREATE TABLE `sys_dic` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `dic_code` varchar(100) DEFAULT NULL COMMENT '编码',
  `dic_name` varchar(100) DEFAULT NULL COMMENT '名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据库字典组';

-- ----------------------------
-- Records of sys_dic
-- ----------------------------
INSERT INTO `sys_dic` VALUES ('1279634870106804225', 'USER_TYPE', '用户类型', '数据字典编辑测试', null, '1', '2020-07-04 23:35:02.650000', '1', '2020-07-04 23:36:44.333000', '1', null);
INSERT INTO `sys_dic` VALUES ('1279635464821362689', 'USER_TYPE', '用户类型', '用户类型数据字典', null, '1', '2020-07-04 23:37:23.948000', '1', '2020-07-04 23:37:23.948000', '1', null);
INSERT INTO `sys_dic` VALUES ('1279636532280119298', '111', '111', '11', null, '1', '2020-07-04 23:41:38.449000', '1', '2020-07-04 23:41:38.449000', '1', null);
INSERT INTO `sys_dic` VALUES ('1279664577309265922', null, null, '1', null, '1', '2020-07-05 01:33:04.906000', '1', '2020-07-05 01:33:04.906000', '1', null);
INSERT INTO `sys_dic` VALUES ('1279669012961845249', 'USER_TYPE', '用户类型', '', null, '1', '2020-07-05 01:50:42.448000', '1', '2020-07-05 01:50:42.448000', '1', null);
INSERT INTO `sys_dic` VALUES ('1279680576448258050', '222', '222', '', null, '1', '2020-07-05 02:36:39.398000', '1', '2020-07-05 02:36:39.398000', '1', null);
INSERT INTO `sys_dic` VALUES ('1279715378723446785', 'USER_TYPE', '用户类型', '用户类型', null, '0', '2020-07-05 04:54:56.907000', '1', '2020-07-05 04:54:56.907000', '1', null);
INSERT INTO `sys_dic` VALUES ('1284775224163700737', 'WLFOW_TYPE', '业务单据类型', '', null, '0', '2020-07-19 09:00:58.068000', '1', '2020-07-19 09:00:58.068000', '1', null);
INSERT INTO `sys_dic` VALUES ('1319272974070706177', 'JOBS_LEVEL', '职务等级', '', null, '0', '2020-10-22 13:42:42.583000', '1', '2020-10-22 13:52:35.496000', '1', null);
INSERT INTO `sys_dic` VALUES ('1320279331649470465', 'EDUCATION', '学历', '', null, '0', '2020-10-25 08:21:36.926000', '1', '2020-10-25 08:21:36.926000', '1', null);

-- ----------------------------
-- Table structure for sys_dic_item
-- ----------------------------
DROP TABLE IF EXISTS `sys_dic_item`;
CREATE TABLE `sys_dic_item` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `dic_id` bigint(32) DEFAULT NULL COMMENT '数据字典id',
  `dic_item_code` varchar(100) DEFAULT NULL COMMENT '编码',
  `dic_item_value` varchar(255) DEFAULT NULL COMMENT '值',
  `dic_item_name` varchar(100) DEFAULT NULL COMMENT '名称',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='数据库字典组-子级';

-- ----------------------------
-- Records of sys_dic_item
-- ----------------------------
INSERT INTO `sys_dic_item` VALUES ('1279717028599095298', '1279715378723446785', 'administrator', 'administrator', '系统管理员', 'administrator', null, '0', '2020-07-05 05:01:30.268000', '1', '2020-07-05 05:01:30.268000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1281843241980809217', '1279715378723446785', '111', '11', '111', '1', null, '1', '2020-07-11 01:50:19.042000', '1', '2020-07-11 01:50:19.042000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1284775425855197186', '1284775224163700737', 'holiday', 'holiday', '请假单', '请假单', null, '0', '2020-07-19 09:01:46.157000', '1', '2020-07-19 09:01:46.157000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1319273216262402050', '1319272974070706177', 'A001', '1', '员工', '', null, '0', '2020-10-22 13:43:40.326000', '1', '2020-10-22 13:43:40.326000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1319273307006169090', '1319272974070706177', 'B001', '2', '课级', '', null, '0', '2020-10-22 13:44:01.961000', '1', '2020-10-22 13:44:01.961000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1319273510891286530', '1319272974070706177', 'C001', '3', '部级', '', null, '0', '2020-10-22 13:44:50.570000', '1', '2020-10-22 13:44:50.570000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1319273763686182913', '1319272974070706177', 'D001', '4', '处级', '', null, '0', '2020-10-22 13:45:50.841000', '1', '2020-10-22 13:53:14.489000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1319274718150389761', '1319272974070706177', 'E001', '5', '总经理', '', null, '1', '2020-10-22 13:49:38.404000', '1', '2020-10-22 13:49:38.404000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1319275744983117826', '1319272974070706177', 'E001', '5', '总经理', '', null, '0', '2020-10-22 13:53:43.219000', '1', '2020-10-22 13:53:43.219000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1319275850469863426', '1319272974070706177', 'F001', '6', '总裁', '', null, '0', '2020-10-22 13:54:08.369000', '1', '2020-10-22 13:54:08.369000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1319275991977291778', '1319272974070706177', 'G001', '7', '董事长', '', null, '0', '2020-10-22 13:54:42.108000', '1', '2020-10-22 13:54:42.108000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1320279441242439682', '1320279331649470465', 'college', 'college', '大专及以下', '', null, '0', '2020-10-25 08:22:03.056000', '1', '2020-10-25 08:23:20.861000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1320279564399788034', '1320279331649470465', 'Undergraduate', 'undergraduate', '本科', '', null, '0', '2020-10-25 08:22:32.420000', '1', '2020-11-14 14:12:57.512000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1320279650592735234', '1320279331649470465', 'master', 'master', '硕士', '', null, '0', '2020-10-25 08:22:52.968000', '1', '2020-10-25 08:22:52.968000', '1', null, null);
INSERT INTO `sys_dic_item` VALUES ('1320279723233886210', '1320279331649470465', 'doctor', 'doctor', '博士', '', null, '0', '2020-10-25 08:23:10.287000', '1', '2020-10-25 08:23:10.287000', '1', null, null);

-- ----------------------------
-- Table structure for sys_employe
-- ----------------------------
DROP TABLE IF EXISTS `sys_employe`;
CREATE TABLE `sys_employe` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `work_no` varchar(32) DEFAULT NULL COMMENT '工号',
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `foreign_name` varchar(32) DEFAULT NULL COMMENT '英文名',
  `gender` varchar(10) DEFAULT NULL COMMENT '性别',
  `mobile_phone` varchar(15) DEFAULT NULL COMMENT '手机号',
  `telephone` varchar(30) DEFAULT NULL COMMENT '座机号码',
  `education` varchar(20) DEFAULT NULL COMMENT '学历',
  `email` varchar(32) DEFAULT NULL COMMENT '邮箱',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `dept_id` bigint(32) DEFAULT NULL,
  `dept_code` varchar(20) DEFAULT NULL COMMENT '所属部门',
  `dept_name` varchar(30) DEFAULT NULL,
  `position` varchar(20) DEFAULT NULL COMMENT '职位',
  `status` varchar(5) DEFAULT NULL COMMENT '状态 离职 试用期 在职',
  `entry_date` datetime DEFAULT NULL COMMENT '入职日期',
  `departure_date` datetime DEFAULT NULL COMMENT '离职日期',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `IDX_WORK_NO` (`work_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='员工表';

-- ----------------------------
-- Records of sys_employe
-- ----------------------------
INSERT INTO `sys_employe` VALUES ('1294558619441930241', '1111', '1111', '11', null, '11111111111', '111', '111', '111', '2020-08-06 16:00:00', null, '11', null, '111111', '', '2020-07-31 16:00:00', '2020-07-31 16:00:00', null, '1', '2020-08-15 08:56:41.269000', '1', '2020-08-15 08:56:41.269000', '1', null);
INSERT INTO `sys_employe` VALUES ('1316588941431918594', '2009822117', '刘钦响', 'dean.x.liu', null, '15295171816', '', 'college', '1152232809@qq.com', '2020-10-13 16:00:00', '1353250973491322881', 'DT010', '开发一部', 'A004', '', '2020-10-13 16:00:00', '2020-10-13 16:00:00', null, '0', '2020-10-15 03:57:19.335000', '1', '2021-01-26 04:52:32.694000', null, null);
INSERT INTO `sys_employe` VALUES ('1353252554869760002', '20200001', '营运长', '', null, '15295171810', '', 'doctor', '2@qq.com', '2021-01-01 00:00:00', '1', 'D001', '公司', 'A005', '', null, null, null, '0', '2021-01-24 08:05:25.954000', null, '2021-01-26 04:31:51.892000', null, null);
INSERT INTO `sys_employe` VALUES ('1353253009775583233', '20200002', '处长', '', null, '15295171811', '', 'master', '3@qq.com', '2021-01-01 00:00:00', '1353250973491322881', 'DT010', '开发一部', 'A004', '', null, null, null, '0', '2021-01-24 08:07:14.413000', null, '2021-01-26 04:52:14.141000', null, null);
INSERT INTO `sys_employe` VALUES ('1353253437066108929', '20200003', '部长', '', null, '15295171812', '', 'undergraduate', '4@qq.com', '2021-01-02 00:00:00', '1353250973491322881', 'DT010', '开发一部', 'A003', '', null, null, null, '0', '2021-01-24 08:08:56.286000', null, '2021-01-26 04:52:24.971000', null, null);
INSERT INTO `sys_employe` VALUES ('1353253862792159234', '20200004', '课长', '', null, '15295171815', '', 'undergraduate', '5@qq.com', '2021-01-02 00:00:00', '1353251202168971265', 'DT012', '开发二课', 'A002', '', null, null, null, '0', '2021-01-24 08:10:37.787000', null, '2021-01-26 04:31:34.093000', null, null);

-- ----------------------------
-- Table structure for sys_func
-- ----------------------------
DROP TABLE IF EXISTS `sys_func`;
CREATE TABLE `sys_func` (
  `id` bigint(32) NOT NULL COMMENT '菜单ID',
  `menu_id` bigint(50) DEFAULT NULL COMMENT '菜单id',
  `func_code` varchar(255) DEFAULT NULL COMMENT '方法代码',
  `func_name` varchar(100) DEFAULT NULL COMMENT '方法名称',
  `func_url` varchar(200) DEFAULT NULL COMMENT '方法URL',
  `func_desc` varchar(255) DEFAULT NULL COMMENT '方法描述',
  `sort_no` int(11) DEFAULT NULL COMMENT '方法排序',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_func
-- ----------------------------
INSERT INTO `sys_func` VALUES ('1279284552609193985', '9', 'sysuser-add', '用户新增', '/sysUser/save', '用户新增', '0', '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279290606889926658', '9', 'sysuser-list', '用户列表', '/sysUser/list', '用户列表', '2', '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279290752067371010', '9', 'sysuer-enable', '用户作废/启用', '/sysUser/enable', '用户作废/启用', null, '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279291097967427585', '9', 'sysuser-save', '用户保存', '/sysUser/save', '用户保存', '0', '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279291246219296770', '9', 'sysuser-get', '用户详情', '/sysUser/get', '用户详情', null, '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279291325902684162', '9', 'sysuser-delete', '用户删除', '/sysUser/delete', 'delete', null, '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279291622343507969', '9', 'sysuser-rest-password', '密码重置', '/sysUser/rest-password', '密码重置', '6', '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279291751133806593', '10', 'sysrole-save', '角色保存', '/sysRole/save', '角色保存', null, '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279291881551495169', '10', 'sysrole-list', '角色查询', '/sysRole/list', '角色查询', '2', '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279292157318594561', '10', 'sysrole-get', '角色明细', '/sysRole/get', '角色明细', null, '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279292250792853506', '10', 'sysrole-delete', '删除功能', '/sysRole/delete', '删除功能', '3', '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279292444045410306', '1277971356380254209', 'sysmenu-save', '菜单保存', '/sysMenu/save', '菜单保存', '1', '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279292699939897346', '1277971356380254209', 'sysmenu-delete', '菜单删除', '/sysMenu/delete', '菜单删除', '2', '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279292916915437570', '1277971356380254209', 'sysfunc-menu-func-list', '菜单方法查询', '/sysFunc/menu-func-list', '菜单方法查询', '3', '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279293012860141570', '1277971356380254209', 'sysfunc-save', '方法保存', '/sysFunc/save', '方法保存', null, '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1279293236651425793', '1277971356380254209', 'sysfunc-delete', '方法删除', '/sysFunc/delete', '方法删除', '5', '0', null, null, null, null, null, null);
INSERT INTO `sys_func` VALUES ('1281217135324676097', '1279624648692809729', 'sysdic-save', '数据字典保存', '/sysDic/save', '数据字典保存', null, '0', '2020-07-09 08:22:23.581000', '1', '2020-07-09 08:25:54.000000', '1', null, null);
INSERT INTO `sys_func` VALUES ('1281217507116171265', '1279624648692809729', 'sysdic-list', '数据字典集合', '/sysDic/list', '数据字典集合', null, '0', '2020-07-09 08:23:52.223000', '1', '2020-07-09 08:25:58.508000', '1', null, null);
INSERT INTO `sys_func` VALUES ('1281217627291369474', '1279624648692809729', 'sysdic-delete', '数据字典删除', '/sysDic/delete', '数据字典删除', null, '0', '2020-07-09 08:24:20.875000', '1', '2020-07-09 08:26:03.317000', '1', null, null);
INSERT INTO `sys_func` VALUES ('1281217794157559809', '1279624648692809729', 'sysdicitem-list', '数据字典子项查询', '/sysDicItem/list', '数据字典子项查询', null, '0', '2020-07-09 08:25:00.659000', '1', '2020-07-09 08:25:00.659000', '1', null, null);
INSERT INTO `sys_func` VALUES ('1281218191270068226', '1279624648692809729', 'sysdicitem-save', '数据字典子项保存', '/sysDicItem/save', '', null, '0', '2020-07-09 08:26:35.339000', '1', '2020-07-09 08:26:35.339000', '1', null, null);
INSERT INTO `sys_func` VALUES ('1281218350645231618', '1279624648692809729', 'sysdicitem-delete', '数据字典子项删除', '/sysDicItem/delete', '数据字典子项删除', null, '0', '2020-07-09 08:27:13.337000', '1', '2020-07-09 08:27:13.337000', '1', null, null);
INSERT INTO `sys_func` VALUES ('1281219018881744898', '1280165003439849474', 'syslog-list', '日志查询', '/sysLog/list', '日志查询', null, '0', '2020-07-09 08:29:52.656000', '1', '2020-07-09 08:29:52.656000', '1', null, null);
INSERT INTO `sys_func` VALUES ('1289475686884540417', '1289475306448584706', 'wflowhisinstance-list', '历史流程查询', '/wflowInstance/list', '历史流程查询', null, '0', '2020-08-01 08:18:55.710000', '1', '2020-08-01 08:18:55.710000', '1', null, null);
INSERT INTO `sys_func` VALUES ('1289475979831508993', '1284355693385695233', 'wflowHistory-list', '签核历史查询', '/wflowHistory/list', '签核历史查询', '1', '0', '2020-08-01 08:20:05.555000', '1', '2020-08-01 08:20:05.555000', '1', null, null);

-- ----------------------------
-- Table structure for sys_jobs
-- ----------------------------
DROP TABLE IF EXISTS `sys_jobs`;
CREATE TABLE `sys_jobs` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `code` varchar(32) DEFAULT NULL COMMENT '岗位代码',
  `name` varchar(32) DEFAULT NULL COMMENT '岗位名称',
  `level` int(10) DEFAULT NULL COMMENT '职务等级',
  `is_active` varchar(10) DEFAULT '1' COMMENT '是否有效 1 有效 0 无效',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='岗位管理';

-- ----------------------------
-- Records of sys_jobs
-- ----------------------------
INSERT INTO `sys_jobs` VALUES ('1319640284161691650', null, 'A001', '职员', '1', '1', '1', '2020-10-23 14:02:16.132000', '1', '2020-10-23 14:02:16.132000', '1', null);
INSERT INTO `sys_jobs` VALUES ('1319640445013250050', null, 'A002', '课长', '2', '1', '0', '2020-10-23 14:02:54.482000', '1', '2021-01-19 09:44:28.378000', null, null);
INSERT INTO `sys_jobs` VALUES ('1319640501757988865', null, 'A003', '部长', '3', '1', '0', '2020-10-23 14:03:08.011000', '1', '2020-10-23 14:03:08.011000', '1', null);
INSERT INTO `sys_jobs` VALUES ('1319640560482439169', null, 'A004', '处长', '4', '1', '0', '2020-10-23 14:03:22.013000', '1', '2020-10-23 14:03:22.013000', '1', null);
INSERT INTO `sys_jobs` VALUES ('1319972557251690497', null, 'A005', '营运长', '5', '1', '0', '2020-10-24 12:02:36.210000', '1', '2021-01-18 14:22:42.587000', null, null);
INSERT INTO `sys_jobs` VALUES ('1352514973538349058', null, 'A001', '职员', '1', '1', '1', '2021-01-22 07:14:32.861000', null, '2021-01-22 07:14:32.861000', null, null);

-- ----------------------------
-- Table structure for sys_language
-- ----------------------------
DROP TABLE IF EXISTS `sys_language`;
CREATE TABLE `sys_language` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `language_code` varchar(30) DEFAULT NULL COMMENT '多语言编码',
  `language_cn` varchar(255) DEFAULT NULL COMMENT '中文简体',
  `language_en` varchar(255) DEFAULT NULL COMMENT '英文',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_language
-- ----------------------------

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(32) NOT NULL COMMENT '主键',
  `user_id` bigint(32) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(200) DEFAULT NULL COMMENT '用户名',
  `ip` varchar(255) DEFAULT NULL COMMENT '用户ip',
  `url` varchar(255) DEFAULT NULL COMMENT '原始请求',
  `target` varchar(255) DEFAULT NULL COMMENT '操作目标',
  `description` varchar(255) DEFAULT NULL COMMENT '方法描述',
  `method` varchar(255) DEFAULT NULL COMMENT '操作方法',
  `params` longtext COMMENT '创建时间',
  `result` longtext COMMENT '操作参数',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作记录';

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` bigint(32) NOT NULL COMMENT '菜单ID',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `parent_id` bigint(32) DEFAULT NULL COMMENT '父级节点',
  `menu_type` varchar(50) DEFAULT NULL COMMENT '菜单类型',
  `menu_platform` varchar(50) DEFAULT 'PC' COMMENT '菜单平台 PC pc端 webapp移动端网页 app移动端app',
  `menu_name` varchar(100) DEFAULT NULL COMMENT '菜单名称',
  `menu_code` varchar(255) DEFAULT NULL COMMENT '菜单代码',
  `menu_url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `menu_desc` varchar(255) DEFAULT NULL COMMENT '菜单备注',
  `menu_icon` varchar(100) DEFAULT NULL COMMENT '菜单图标',
  `sort_no` int(11) DEFAULT NULL COMMENT '菜单排序',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', null, '0', 'root', 'PC', '系统菜单管理', 'rootMenu', null, null, null, '0', '0', null, null, null, null, null);
INSERT INTO `sys_menu` VALUES ('2', null, '1', 'module', 'PC', '系统管理', 'sysManager', '', null, 'el-icon-setting', '1', '0', null, null, '2020-08-01 08:14:19.477000', '1', null);
INSERT INTO `sys_menu` VALUES ('9', null, '2', 'menu', 'PC', '账号管理', 'sysuser', '/sysuser', null, 'el-icon-user', '1', '0', null, null, '2020-08-01 08:14:52.821000', '1', null);
INSERT INTO `sys_menu` VALUES ('10', null, '2', 'menu', 'PC', '角色管理', 'sysrole', '/sysrole', null, 'el-icon-star-on', '2', '0', null, null, '2020-08-01 08:15:06.386000', '1', null);
INSERT INTO `sys_menu` VALUES ('1277971356380254209', null, '2', 'menu', 'PC', '菜单管理', 'sysmenu', '/sysmenu', null, 'el-icon-menu', '3', '0', null, null, '2020-08-01 08:15:20.875000', '1', null);
INSERT INTO `sys_menu` VALUES ('1279040738241974274', null, '1', 'menu', 'PC', '应用管理', 'Application', null, null, null, null, '1', null, null, null, null, null);
INSERT INTO `sys_menu` VALUES ('1279624648692809729', null, '2', 'menu', 'PC', '数据字典', 'sysdic', '/sysdic', null, 'el-icon-s-management', '5', '0', '2020-07-04 22:54:25.182000', '1', '2020-08-01 08:16:09.821000', '1', null);
INSERT INTO `sys_menu` VALUES ('1280165003439849474', null, '2', null, 'PC', '日志管理', 'syslog', '/syslog', null, 'el-icon-more-outline', '7', '0', '2020-07-06 10:41:35.792000', '1', '2020-08-01 08:15:47.198000', '1', null);
INSERT INTO `sys_menu` VALUES ('1281215864568004610', null, '2', null, 'PC', '1', 'el-icon-star-on', '1', null, 'el-icon-star-on', '11', '1', '2020-07-09 08:17:20.609000', '1', '2020-07-09 08:17:20.609000', '1', null);
INSERT INTO `sys_menu` VALUES ('1281216516471898113', null, '2', null, 'PC', '流水编码', 'SysSequence', '/syssequence', null, 'el-icon-s-help', '4', '0', '2020-07-09 08:19:56.036000', '1', '2020-08-01 08:15:29.555000', '1', null);
INSERT INTO `sys_menu` VALUES ('1281782550129299457', null, '2', null, 'PC', '定时任务', 'quartz', '/sysjob', null, 'el-icon-alarm-clock', '6', '0', '2020-07-10 21:49:08.977000', '1', '2020-08-01 08:16:02.832000', '1', null);
INSERT INTO `sys_menu` VALUES ('1284349997831172097', null, '1', null, 'PC', '流程管理', 'workflow', '', null, 'el-icon-s-check', '2', '0', '2020-07-18 04:51:16.209000', '1', '2020-08-01 08:14:26.138000', '1', null);
INSERT INTO `sys_menu` VALUES ('1284350309245661185', null, '1284349997831172097', null, 'PC', '流程设计', 'wflowdesign', '/wflowdesign', null, 'el-icon-edit-outline', '1', '0', '2020-07-18 04:52:30.457000', '1', '2020-08-01 08:06:53.631000', '1', null);
INSERT INTO `sys_menu` VALUES ('1284350939137847297', null, '1284349997831172097', null, 'PC', '流程定义', 'wflowdefine', '/wflowdefine', null, 'el-icon-s-order', '2', '0', '2020-07-18 04:55:00.635000', '1', '2020-08-01 08:07:00.828000', '1', null);
INSERT INTO `sys_menu` VALUES ('1284351086005596162', null, '1284349997831172097', null, 'PC', '流程签核', 'wflowtask', '/wflowtask', null, 'el-icon-s-check', '4', '0', '2020-07-18 04:55:35.650000', '1', '2020-08-01 08:07:13.514000', '1', null);
INSERT INTO `sys_menu` VALUES ('1284355693385695233', null, '1284349997831172097', null, 'PC', '签核历史', 'wflowHistory', '/wflowhistory', null, 'el-icon-coin', '5', '0', '2020-07-18 05:13:54.135000', '1', '2020-08-01 08:07:30.291000', '1', null);
INSERT INTO `sys_menu` VALUES ('1284491806838415361', null, '1', null, 'PC', '业务处理', 'business', '', null, 'el-icon-s-platform', '3', '0', '2020-07-18 14:14:46.111000', '1', '2020-08-01 08:14:33.321000', '1', null);
INSERT INTO `sys_menu` VALUES ('1284492077085810689', null, '1284491806838415361', null, 'PC', '单据申请', 'DocumentsApply', '/holiday', null, 'el-icon-s-order', null, '0', '2020-07-18 14:15:50.544000', '1', '2020-07-18 14:15:50.544000', '1', null);
INSERT INTO `sys_menu` VALUES ('1288482736234885122', null, '1284349997831172097', null, 'PC', '流程签收', 'wflowclaim', '/wflowclaim', null, 'el-icon-s-claim', '3', '0', '2020-07-29 14:33:17.827000', '1', '2020-08-01 08:07:21.112000', '1', null);
INSERT INTO `sys_menu` VALUES ('1289475306448584706', null, '1284349997831172097', null, 'PC', '历史流程', 'wflowhisinstance', '/wflowhisinstance', null, 'el-icon-s-order', '7', '0', '2020-08-01 08:17:25.008000', '1', '2020-08-01 12:41:08.680000', '1', null);
INSERT INTO `sys_menu` VALUES ('1289478684243230721', null, '1284349997831172097', null, 'PC', '全部任务', 'wflowalltask', '/wflowalltask', null, 'el-icon-s-order', '6', '0', '2020-08-01 08:30:50.336000', '1', '2020-08-01 12:41:13.261000', '1', null);
INSERT INTO `sys_menu` VALUES ('1289927183745253377', null, '2', null, 'PC', '员工管理', 'sysemploye', '/sysemploye', null, 'el-icon-user-solid', '10', '0', '2020-08-02 14:13:00.951000', '1', '2020-08-02 14:13:00.951000', '1', null);
INSERT INTO `sys_menu` VALUES ('1319276687996874753', null, '2', null, 'PC', '职务管理', 'SysJobs', '/sysjobs', null, 'el-icon-s-check', '11', '0', '2020-10-22 13:57:28.052000', '1', '2020-10-22 14:00:13.969000', '1', null);
INSERT INTO `sys_menu` VALUES ('1319984305509871618', null, '2', null, 'PC', '部门管理', 'sysdept', '/sysdept', null, 'el-icon-menu', '8', '0', '2020-10-24 12:49:17.213000', '1', '2020-10-24 12:49:44.033000', '1', null);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` bigint(32) NOT NULL COMMENT 'COLUMN_COMMENT',
  `role_name` varchar(50) DEFAULT NULL COMMENT '角色名称',
  `role_level` int(11) DEFAULT NULL COMMENT '角色等级',
  `role_code` varchar(20) DEFAULT NULL COMMENT '角色代码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限管理-角色管理';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '系统管理员', '1', 'administrator', '0', '2020-06-27 18:09:37.000000', null, '2020-07-11 01:45:53.551000', '1', null, null);
INSERT INTO `sys_role` VALUES ('1278697713124974593', '普通用户', null, 'normaluser', '1', null, null, '2020-07-10 21:19:36.152000', '1', null, null);
INSERT INTO `sys_role` VALUES ('1322806857248620546', '测试管理员', null, 'adminitsrator-test', '0', '2020-11-01 07:45:05.988000', '1', '2020-11-01 07:45:05.988000', '1', null, null);
INSERT INTO `sys_role` VALUES ('1332229447528493057', 'ces', null, 'ces', '0', '2020-11-27 07:47:06.577000', '1', '2020-11-27 07:47:06.577000', '1', null, null);
INSERT INTO `sys_role` VALUES ('1350075808381009922', '人力资源', null, 'HR_GROUP', '0', '2021-01-15 13:42:10.572000', null, '2021-01-15 13:42:10.572000', null, null, null);

-- ----------------------------
-- Table structure for sys_role_func
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_func`;
CREATE TABLE `sys_role_func` (
  `id` bigint(32) NOT NULL,
  `role_id` bigint(32) NOT NULL COMMENT '权限id',
  `func_id` bigint(32) NOT NULL COMMENT '方法ID',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_role_func
-- ----------------------------
INSERT INTO `sys_role_func` VALUES ('1279575943071580161', '1278697713124974593', '1279284552609193985', '0', '2020-07-04 19:40:52.858000', '1', '2020-07-04 19:40:52.858000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1279575943100940290', '1278697713124974593', '1279290606889926658', '0', '2020-07-04 19:40:52.864000', '1', '2020-07-04 19:40:52.864000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1279575943109328897', '1278697713124974593', '1279290752067371010', '0', '2020-07-04 19:40:52.865000', '1', '2020-07-04 19:40:52.865000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1279575943109328898', '1278697713124974593', '1279291097967427585', '0', '2020-07-04 19:40:52.866000', '1', '2020-07-04 19:40:52.866000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1279575943117717506', '1278697713124974593', '1279291246219296770', '0', '2020-07-04 19:40:52.867000', '1', '2020-07-04 19:40:52.867000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1279575943117717507', '1278697713124974593', '1279291325902684162', '0', '2020-07-04 19:40:52.868000', '1', '2020-07-04 19:40:52.868000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1279575943117717508', '1278697713124974593', '1279291622343507969', '0', '2020-07-04 19:40:52.868000', '1', '2020-07-04 19:40:52.869000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1281842478579732481', '1278697713124974593', '1279291751133806593', '0', '2020-07-11 01:47:17.033000', '1', '2020-07-11 01:47:17.033000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1281842478592315393', '1278697713124974593', '1279291881551495169', '0', '2020-07-11 01:47:17.035000', '1', '2020-07-11 01:47:17.035000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1281842478592315394', '1278697713124974593', '1279292157318594561', '0', '2020-07-11 01:47:17.035000', '1', '2020-07-11 01:47:17.035000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1281842478592315395', '1278697713124974593', '1279292250792853506', '0', '2020-07-11 01:47:17.035000', '1', '2020-07-11 01:47:17.035000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367854227458', '1', '1279284552609193985', '0', '2020-08-02 14:13:44.846000', '1', '2020-08-02 14:13:44.846000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367866810370', '1', '1279290752067371010', '0', '2020-08-02 14:13:44.848000', '1', '2020-08-02 14:13:44.848000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367866810371', '1', '1279291097967427585', '0', '2020-08-02 14:13:44.848000', '1', '2020-08-02 14:13:44.848000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367866810372', '1', '1279291246219296770', '0', '2020-08-02 14:13:44.848000', '1', '2020-08-02 14:13:44.848000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367866810373', '1', '1279291325902684162', '0', '2020-08-02 14:13:44.849000', '1', '2020-08-02 14:13:44.849000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367866810374', '1', '1279290606889926658', '0', '2020-08-02 14:13:44.849000', '1', '2020-08-02 14:13:44.849000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367866810375', '1', '1279291622343507969', '0', '2020-08-02 14:13:44.849000', '1', '2020-08-02 14:13:44.849000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367866810376', '1', '1279291751133806593', '0', '2020-08-02 14:13:44.850000', '1', '2020-08-02 14:13:44.850000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367875198977', '1', '1279292157318594561', '0', '2020-08-02 14:13:44.850000', '1', '2020-08-02 14:13:44.850000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367875198978', '1', '1279291881551495169', '0', '2020-08-02 14:13:44.850000', '1', '2020-08-02 14:13:44.850000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367875198979', '1', '1279292250792853506', '0', '2020-08-02 14:13:44.850000', '1', '2020-08-02 14:13:44.850000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367875198980', '1', '1279293012860141570', '0', '2020-08-02 14:13:44.850000', '1', '2020-08-02 14:13:44.850000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367875198981', '1', '1279292444045410306', '0', '2020-08-02 14:13:44.850000', '1', '2020-08-02 14:13:44.850000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367875198982', '1', '1279292699939897346', '0', '2020-08-02 14:13:44.851000', '1', '2020-08-02 14:13:44.851000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367875198983', '1', '1279292916915437570', '0', '2020-08-02 14:13:44.851000', '1', '2020-08-02 14:13:44.851000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367875198984', '1', '1279293236651425793', '0', '2020-08-02 14:13:44.851000', '1', '2020-08-02 14:13:44.851000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367875198985', '1', '1281217135324676097', '0', '2020-08-02 14:13:44.851000', '1', '2020-08-02 14:13:44.851000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367875198986', '1', '1281217507116171265', '0', '2020-08-02 14:13:44.851000', '1', '2020-08-02 14:13:44.851000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367883587586', '1', '1281217627291369474', '0', '2020-08-02 14:13:44.852000', '1', '2020-08-02 14:13:44.852000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367883587587', '1', '1281217794157559809', '0', '2020-08-02 14:13:44.852000', '1', '2020-08-02 14:13:44.852000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367883587588', '1', '1281218191270068226', '0', '2020-08-02 14:13:44.853000', '1', '2020-08-02 14:13:44.853000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367883587589', '1', '1281218350645231618', '0', '2020-08-02 14:13:44.853000', '1', '2020-08-02 14:13:44.853000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367883587590', '1', '1281219018881744898', '0', '2020-08-02 14:13:44.853000', '1', '2020-08-02 14:13:44.853000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367883587591', '1', '1289475979831508993', '0', '2020-08-02 14:13:44.853000', '1', '2020-08-02 14:13:44.853000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1289927367883587592', '1', '1289475686884540417', '0', '2020-08-02 14:13:44.853000', '1', '2020-08-02 14:13:44.853000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1332229818044919809', '1332229447528493057', '1289475979831508993', '0', '2020-11-27 07:48:34.913000', '1', '2020-11-27 07:48:34.913000', '1', null, null);
INSERT INTO `sys_role_func` VALUES ('1332229818044919810', '1332229447528493057', '1289475686884540417', '0', '2020-11-27 07:48:34.914000', '1', '2020-11-27 07:48:34.914000', '1', null, null);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` bigint(32) NOT NULL,
  `role_id` bigint(32) NOT NULL COMMENT '权限id',
  `menu_id` bigint(32) NOT NULL COMMENT '菜单ID',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('1279035017534279682', '1278697713124974593', '2', '0', '2020-07-03 07:51:26.157000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279035017542668289', '1278697713124974593', '9', '0', '2020-07-03 07:51:26.157000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279049253316718594', '1278697713124974593', '1279040738241974274', '1', '2020-07-03 08:47:58.799000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279050223123636225', '1', '2', '0', '2020-07-03 08:51:50.074000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279050223157190658', '1', '9', '0', '2020-07-03 08:51:50.074000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279050223157190659', '1', '10', '0', '2020-07-03 08:51:50.074000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279050223157190660', '1', '13', '1', '2020-07-03 08:51:50.074000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279050223157190661', '1', '53', '1', '2020-07-03 08:51:50.074000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279050223165579265', '1', '1277971356380254209', '0', '2020-07-03 08:51:50.074000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279050223165579266', '1', '1279040738241974274', '1', '2020-07-03 08:51:50.074000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279050223165579267', '1', '1279040886867136514', '1', '2020-07-03 08:51:50.074000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279050223173967873', '1', '1279041032740835330', '1', '2020-07-03 08:51:50.074000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279335087773306882', '1278697713124974593', '10', '1', '2020-07-04 03:43:47.087000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1279335087802667010', '1278697713124974593', '1277971356380254209', '1', '2020-07-04 03:43:47.087000', null, null, null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1281842478407766018', '1278697713124974593', '10', '0', '2020-07-11 01:47:16.991000', '1', '2020-07-11 01:47:16.991000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1284489065026039810', '1278697713124974593', '1284349997831172097', '0', '2020-07-18 14:03:52.412000', '1', '2020-07-18 14:03:52.412000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1284489065026039811', '1278697713124974593', '1284350309245661185', '1', '2020-07-18 14:03:52.413000', '1', '2020-07-18 14:03:52.413000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1284489065034428418', '1278697713124974593', '1284350939137847297', '1', '2020-07-18 14:03:52.414000', '1', '2020-07-18 14:03:52.414000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1284489065034428419', '1278697713124974593', '1284351086005596162', '0', '2020-07-18 14:03:52.414000', '1', '2020-07-18 14:03:52.414000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1284489065034428420', '1278697713124974593', '1284355693385695233', '0', '2020-07-18 14:03:52.415000', '1', '2020-07-18 14:03:52.415000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1287013983416573954', '1278697713124974593', '1284491806838415361', '0', '2020-07-25 13:16:59.867000', '1', '2020-07-25 13:16:59.867000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1287013983424962561', '1278697713124974593', '1284492077085810689', '0', '2020-07-25 13:16:59.869000', '1', '2020-07-25 13:16:59.869000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1288487521390501889', '1278697713124974593', '1288482736234885122', '0', '2020-07-29 14:52:18.697000', '1279577615655149569', '2020-07-29 14:52:18.697000', '1279577615655149569', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367271219202', '1', '1281216516471898113', '0', '2020-08-02 14:13:44.707000', '1', '2020-08-02 14:13:44.707000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367283802114', '1', '1279624648692809729', '0', '2020-08-02 14:13:44.710000', '1', '2020-08-02 14:13:44.710000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367283802115', '1', '1281782550129299457', '0', '2020-08-02 14:13:44.710000', '1', '2020-08-02 14:13:44.710000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367283802116', '1', '1280165003439849474', '0', '2020-08-02 14:13:44.711000', '1', '2020-08-02 14:13:44.711000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367292190722', '1', '1289927183745253377', '0', '2020-08-02 14:13:44.711000', '1', '2020-08-02 14:13:44.711000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367300579329', '1', '1284349997831172097', '0', '2020-08-02 14:13:44.713000', '1', '2020-08-02 14:13:44.713000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367304773634', '1', '1284350309245661185', '0', '2020-08-02 14:13:44.714000', '1', '2020-08-02 14:13:44.714000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367304773635', '1', '1284350939137847297', '0', '2020-08-02 14:13:44.715000', '1', '2020-08-02 14:13:44.715000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367304773636', '1', '1288482736234885122', '0', '2020-08-02 14:13:44.715000', '1', '2020-08-02 14:13:44.715000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367304773637', '1', '1284351086005596162', '0', '2020-08-02 14:13:44.715000', '1', '2020-08-02 14:13:44.715000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367304773638', '1', '1284355693385695233', '0', '2020-08-02 14:13:44.715000', '1', '2020-08-02 14:13:44.715000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367313162242', '1', '1289478684243230721', '0', '2020-08-02 14:13:44.716000', '1', '2020-08-02 14:13:44.716000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367313162243', '1', '1289475306448584706', '0', '2020-08-02 14:13:44.716000', '1', '2020-08-02 14:13:44.716000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367313162244', '1', '1284491806838415361', '0', '2020-08-02 14:13:44.716000', '1', '2020-08-02 14:13:44.716000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1289927367313162245', '1', '1284492077085810689', '0', '2020-08-02 14:13:44.716000', '1', '2020-08-02 14:13:44.716000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1319277051567534081', '1', '1319276687996874753', '0', '2020-10-22 13:58:54.733000', '1', '2020-10-22 13:58:54.733000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1332229472132280322', '1332229447528493057', '9', '1', '2020-11-27 07:47:12.441000', '1', '2020-11-27 07:47:12.441000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1332229472132280323', '1332229447528493057', '2', '1', '2020-11-27 07:47:12.441000', '1', '2020-11-27 07:47:12.441000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1332229818028142594', '1332229447528493057', '1284349997831172097', '0', '2020-11-27 07:48:34.908000', '1', '2020-11-27 07:48:34.908000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1332229818028142595', '1332229447528493057', '1284350309245661185', '0', '2020-11-27 07:48:34.909000', '1', '2020-11-27 07:48:34.909000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1332229818028142596', '1332229447528493057', '1284350939137847297', '0', '2020-11-27 07:48:34.909000', '1', '2020-11-27 07:48:34.909000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1332229818032336898', '1332229447528493057', '1288482736234885122', '0', '2020-11-27 07:48:34.910000', '1', '2020-11-27 07:48:34.910000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1332229818032336899', '1332229447528493057', '1284351086005596162', '0', '2020-11-27 07:48:34.910000', '1', '2020-11-27 07:48:34.910000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1332229818032336900', '1332229447528493057', '1284355693385695233', '0', '2020-11-27 07:48:34.910000', '1', '2020-11-27 07:48:34.910000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1332229818036531202', '1332229447528493057', '1289478684243230721', '0', '2020-11-27 07:48:34.911000', '1', '2020-11-27 07:48:34.911000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1332229818036531203', '1332229447528493057', '1289475306448584706', '0', '2020-11-27 07:48:34.911000', '1', '2020-11-27 07:48:34.911000', '1', null, null);
INSERT INTO `sys_role_menu` VALUES ('1344586604589215745', '1', '1319984305509871618', '0', '2020-12-31 10:10:02.403000', null, '2020-12-31 10:10:02.403000', null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1347003024239153154', '1322806857248620546', '1288482736234885122', '0', '2021-01-07 02:12:01.743000', null, '2021-01-07 02:12:01.743000', null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1347003024255930370', '1322806857248620546', '1284351086005596162', '0', '2021-01-07 02:12:01.745000', null, '2021-01-07 02:12:01.745000', null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1347003024255930371', '1322806857248620546', '1284355693385695233', '0', '2021-01-07 02:12:01.746000', null, '2021-01-07 02:12:01.746000', null, null, null);
INSERT INTO `sys_role_menu` VALUES ('1347003024264318978', '1322806857248620546', '1284349997831172097', '0', '2021-01-07 02:12:01.747000', null, '2021-01-07 02:12:01.747000', null, null, null);

-- ----------------------------
-- Table structure for sys_role_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user` (
  `id` bigint(32) NOT NULL,
  `user_id` bigint(32) NOT NULL,
  `role_id` bigint(32) NOT NULL,
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色用户关系表';

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES ('20180716073920', '1', '1', null, '1', null, null, null, null, null);
INSERT INTO `sys_role_user` VALUES ('1279362490042073089', '1278687336492371970', '1', null, '0', null, null, null, null, null);
INSERT INTO `sys_role_user` VALUES ('1279362490063044610', '1278687336492371970', '1278697713124974593', null, '0', null, null, null, null, null);
INSERT INTO `sys_role_user` VALUES ('1284489161402757122', '1279577615655149569', '1278697713124974593', null, '1', '2020-07-18 14:04:15.390000', '1', '2020-07-18 14:04:15.390000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1296628285282734081', '1296624483095842817', '1278697713124974593', null, '0', '2020-08-21 02:00:48.057000', '1', '2020-08-21 02:00:48.057000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1296628316358332418', '1296624680504954882', '1278697713124974593', null, '0', '2020-08-21 02:00:55.466000', '1', '2020-08-21 02:00:55.466000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1296628683032776706', '1296624816626896898', '1278697713124974593', null, '0', '2020-08-21 02:02:22.888000', '1', '2020-08-21 02:02:22.888000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1296628702792142849', '1296624964950069250', '1278697713124974593', null, '0', '2020-08-21 02:02:27.600000', '1', '2020-08-21 02:02:27.600000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1331144456711188481', '1', '1', null, '1', '2020-11-24 07:55:44.606000', '1', '2020-11-24 07:55:44.606000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1331144456719577089', '1', '1322806857248620546', null, '1', '2020-11-24 07:55:44.607000', '1', '2020-11-24 07:55:44.607000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1331445750457970690', '1279577615655149569', '1322806857248620546', null, '0', '2020-11-25 03:52:58.633000', '1', '2020-11-25 03:52:58.633000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1332129412077858817', '1', '1', null, '1', '2020-11-27 01:09:36.265000', '1', '2020-11-27 01:09:36.265000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1332229642232279042', '1332229590180966402', '1332229447528493057', null, '1', '2020-11-27 07:47:52.996000', '1', '2020-11-27 07:47:52.996000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1332229681633570818', '1332229590180966402', '1322806857248620546', null, '0', '2020-11-27 07:48:02.392000', '1', '2020-11-27 07:48:02.392000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1332229681633570819', '1332229590180966402', '1332229447528493057', null, '0', '2020-11-27 07:48:02.393000', '1', '2020-11-27 07:48:02.393000', '1', null);
INSERT INTO `sys_role_user` VALUES ('1344586498515267586', '1', '1', null, '0', '2020-12-31 10:09:37.112000', null, '2020-12-31 10:09:37.112000', null, null);
INSERT INTO `sys_role_user` VALUES ('1355438013278691330', '1353256863002976257', '1322806857248620546', null, '0', '2021-01-30 08:49:39.844000', null, '2021-01-30 08:49:39.844000', null, null);

-- ----------------------------
-- Table structure for sys_sequence
-- ----------------------------
DROP TABLE IF EXISTS `sys_sequence`;
CREATE TABLE `sys_sequence` (
  `id` bigint(32) DEFAULT NULL,
  `code` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '序列号代码',
  `name` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT '名称',
  `prefix` varchar(100) CHARACTER SET utf8 DEFAULT NULL COMMENT '前缀',
  `separator` varchar(5) CHARACTER SET utf8 DEFAULT NULL COMMENT '分隔符',
  `date_format` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT '日期格式',
  `num_length` int(5) NOT NULL DEFAULT '4' COMMENT '数字部分长度',
  `init_value` int(5) NOT NULL DEFAULT '1' COMMENT '初始值',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '租户编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='sys_sequence';

-- ----------------------------
-- Records of sys_sequence
-- ----------------------------
INSERT INTO `sys_sequence` VALUES ('1281776518174887938', 'sdsad', 'dsaddsa', 'sd1', '111', '11111', '111', '11', '1', '2020-07-10 21:25:10.846000', '1', '2020-07-10 21:25:10.846000', '1', null, null);
INSERT INTO `sys_sequence` VALUES ('1281777623709536258', '111', '111', '11', '', '', '4', '1', '1', '2020-07-10 21:29:34.427000', '1', '2020-07-10 21:29:42.807000', '1', null, null);
INSERT INTO `sys_sequence` VALUES ('1285226128205770753', 'FLOW_CODE', '请假单流水码', 'H', '', 'yyMMdd', '4', '1', '0', '2020-07-20 14:52:41.969000', '1', '2020-07-25 13:11:47.481000', '1', null, null);

-- ----------------------------
-- Table structure for sys_sequence_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_sequence_log`;
CREATE TABLE `sys_sequence_log` (
  `id` bigint(32) DEFAULT NULL,
  `sequence_id` bigint(32) DEFAULT NULL COMMENT '序列号ID',
  `prefix` varchar(30) DEFAULT NULL COMMENT '自定义前缀',
  `flow_code` varchar(35) DEFAULT NULL COMMENT '流水编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '租户编码'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='生成的队列号';

-- ----------------------------
-- Records of sys_sequence_log
-- ----------------------------
INSERT INTO `sys_sequence_log` VALUES ('1347001678135971841', '1285226128205770753', 'defalut', 'H2101070001', '0', '2021-01-07 02:06:40.805000', null, '2021-01-07 02:06:40.805000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1347002102326906882', '1285226128205770753', 'defalut', 'H2101070002', '0', '2021-01-07 02:08:21.940000', null, '2021-01-07 02:08:21.940000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1347002202663047169', '1285226128205770753', 'defalut', 'H2101070003', '0', '2021-01-07 02:08:45.862000', null, '2021-01-07 02:08:45.863000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1347002319826735105', '1285226128205770753', 'defalut', 'H2101070004', '0', '2021-01-07 02:09:13.797000', null, '2021-01-07 02:09:13.797000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1347004547396460545', '1285226128205770753', 'defalut', 'H2101070005', '0', '2021-01-07 02:18:04.892000', null, '2021-01-07 02:18:04.892000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1347007089417261057', '1285226128205770753', 'defalut', 'H2101070006', '0', '2021-01-07 02:28:10.955000', null, '2021-01-07 02:28:10.955000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1347008407359852546', '1285226128205770753', 'defalut', 'H2101070007', '0', '2021-01-07 02:33:25.178000', null, '2021-01-07 02:33:25.178000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1347041775640285185', '1285226128205770753', 'defalut', 'H2101070008', '0', '2021-01-07 04:46:00.795000', null, '2021-01-07 04:46:00.795000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1347043708123938817', '1285226128205770753', 'defalut', 'H2101070009', '0', '2021-01-07 04:53:41.536000', null, '2021-01-07 04:53:41.536000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349006750097231873', '1285226128205770753', 'defalut', 'H2101120001', '0', '2021-01-12 14:54:07.213000', null, '2021-01-12 14:54:07.213000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349228047095975937', '1285226128205770753', 'defalut', 'H2101130001', '0', '2021-01-13 05:33:28.529000', null, '2021-01-13 05:33:28.529000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349229221417250818', '1285226128205770753', 'defalut', 'H2101130002', '0', '2021-01-13 05:38:08.510000', null, '2021-01-13 05:38:08.510000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349299130398593026', '1285226128205770753', 'defalut', 'H2101130003', '0', '2021-01-13 10:15:56.111000', null, '2021-01-13 10:15:56.111000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349304571522351105', '1285226128205770753', 'defalut', 'H2101130004', '0', '2021-01-13 10:37:33.375000', null, '2021-01-13 10:37:33.375000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349307502594256898', '1285226128205770753', 'defalut', 'H2101130005', '0', '2021-01-13 10:49:12.196000', null, '2021-01-13 10:49:12.196000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349733211640864770', '1285226128205770753', 'defalut', 'H2101140001', '0', '2021-01-14 15:00:49.142000', null, '2021-01-14 15:00:49.142000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349735723957653506', '1285226128205770753', 'defalut', 'H2101140002', '0', '2021-01-14 15:10:48.126000', null, '2021-01-14 15:10:48.126000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349736282810912770', '1285226128205770753', 'defalut', 'H2101140003', '0', '2021-01-14 15:13:01.366000', null, '2021-01-14 15:13:01.366000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349737418905260034', '1285226128205770753', 'defalut', 'H2101140004', '0', '2021-01-14 15:17:32.233000', null, '2021-01-14 15:17:32.233000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349918315633893378', '1285226128205770753', 'defalut', 'H2101150001', '0', '2021-01-15 03:16:21.373000', null, '2021-01-15 03:16:21.373000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349920556348473345', '1285226128205770753', 'defalut', 'H2101150002', '0', '2021-01-15 03:25:15.601000', null, '2021-01-15 03:25:15.601000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1349921117152083970', '1285226128205770753', 'defalut', 'H2101150003', '0', '2021-01-15 03:27:29.307000', null, '2021-01-15 03:27:29.307000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1351103946938548225', '1285226128205770753', 'defalut', 'H2101180001', '0', '2021-01-18 09:47:37.905000', null, '2021-01-18 09:47:37.905000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1351104485499740161', '1285226128205770753', 'defalut', 'H2101180002', '0', '2021-01-18 09:49:46.308000', null, '2021-01-18 09:49:46.308000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1351104618123632642', '1285226128205770753', 'defalut', 'H2101180003', '0', '2021-01-18 09:50:17.927000', null, '2021-01-18 09:50:17.927000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1351104823401259010', '1285226128205770753', 'defalut', 'H2101180004', '0', '2021-01-18 09:51:06.869000', null, '2021-01-18 09:51:06.869000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355436573567066113', '1285226128205770753', 'defalut', 'H2101300001', '0', '2021-01-30 08:43:56.590000', null, '2021-01-30 08:43:56.590000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355441100164792321', '1285226128205770753', 'defalut', 'H2101300002', '0', '2021-01-30 09:01:55.814000', null, '2021-01-30 09:01:55.814000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355442268572057602', '1285226128205770753', 'defalut', 'H2101300003', '0', '2021-01-30 09:06:34.384000', null, '2021-01-30 09:06:34.384000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355442510826668033', '1285226128205770753', 'defalut', 'H2101300004', '0', '2021-01-30 09:07:32.142000', null, '2021-01-30 09:07:32.143000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355444566549250049', '1285226128205770753', 'defalut', 'H2101300005', '0', '2021-01-30 09:15:42.266000', null, '2021-01-30 09:15:42.266000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355444864441303041', '1285226128205770753', 'defalut', 'H2101300006', '0', '2021-01-30 09:16:53.287000', null, '2021-01-30 09:16:53.287000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355446963317153794', '1285226128205770753', 'defalut', 'H2101300007', '0', '2021-01-30 09:25:13.699000', null, '2021-01-30 09:25:13.699000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355449330066411521', '1285226128205770753', 'defalut', 'H2101300008', '0', '2021-01-30 09:34:37.977000', null, '2021-01-30 09:34:37.977000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355449880145186817', '1285226128205770753', 'defalut', 'H2101300009', '0', '2021-01-30 09:36:49.124000', null, '2021-01-30 09:36:49.124000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355450865584328705', '1285226128205770753', 'defalut', 'H2101300010', '0', '2021-01-30 09:40:44.071000', null, '2021-01-30 09:40:44.071000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355458968606466050', '1285226128205770753', 'defalut', 'H2101300011', '0', '2021-01-30 10:12:55.983000', null, '2021-01-30 10:12:55.983000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355459511101874178', '1285226128205770753', 'defalut', 'H2101300012', '0', '2021-01-30 10:15:05.325000', null, '2021-01-30 10:15:05.325000', null, null, null);
INSERT INTO `sys_sequence_log` VALUES ('1355459818728861698', '1285226128205770753', 'defalut', 'H2101300013', '0', '2021-01-30 10:16:18.670000', null, '2021-01-30 10:16:18.670000', null, null, null);

-- ----------------------------
-- Table structure for sys_sequence_queue
-- ----------------------------
DROP TABLE IF EXISTS `sys_sequence_queue`;
CREATE TABLE `sys_sequence_queue` (
  `id` bigint(32) NOT NULL,
  `sequence_id` bigint(32) DEFAULT NULL COMMENT '序列号ID',
  `prefix` varchar(30) DEFAULT 'ALL' COMMENT '自定义前缀 默认是ALL',
  `current_code` varchar(35) DEFAULT NULL COMMENT '当前流水码编号',
  `current_value` bigint(5) DEFAULT NULL COMMENT '当前数值',
  `current_date` varchar(32) DEFAULT NULL COMMENT '当前日期 用于判断属于那个月份　天',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '租户编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='生成的队列号';

-- ----------------------------
-- Records of sys_sequence_queue
-- ----------------------------
INSERT INTO `sys_sequence_queue` VALUES ('1287011302442557441', '1285226128205770753', 'P', 'PH2007250300', '300', '200725', '0', '2020-07-25 13:06:20.673000', '1', '2020-07-25 13:11:32.592000', '1', null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1287012522003619841', '1285226128205770753', 'defalut', 'H2007250100', '100', '200725', '0', '2020-07-25 13:11:11.439000', '1', '2020-07-25 13:11:32.495000', '1', null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1299293592669421570', '1285226128205770753', 'defalut', 'H2008280003', '3', '200828', '0', '2020-08-28 10:31:46.857000', '1', '2020-08-28 10:31:53.866000', '1', null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1319272563666448386', '1285226128205770753', 'defalut', 'H2010220001', '1', '201022', '0', '2020-10-22 13:41:04.734000', '1', '2020-10-22 13:41:04.734000', '1', null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1328940755347058689', '1285226128205770753', 'defalut', 'H2011180001', '1', '201118', '0', '2020-11-18 05:59:01.259000', '1', '2020-11-18 05:59:01.259000', '1', null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1331142455197708289', '1285226128205770753', 'defalut', 'H2011240001', '1', '201124', '0', '2020-11-24 07:47:47.408000', '1', '2020-11-24 07:47:47.408000', '1', null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1347001678010142722', '1285226128205770753', 'defalut', 'H2101070009', '9', '210107', '0', '2021-01-07 02:06:40.777000', null, '2021-01-07 04:53:41.509000', null, null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1349006749979791362', '1285226128205770753', 'defalut', 'H2101120001', '1', '210112', '0', '2021-01-12 14:54:07.186000', null, '2021-01-12 14:54:07.186000', null, null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1349228046991118337', '1285226128205770753', 'defalut', 'H2101130005', '5', '210113', '0', '2021-01-13 05:33:28.504000', null, '2021-01-13 10:49:12.148000', null, null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1349733211506647042', '1285226128205770753', 'defalut', 'H2101140004', '4', '210114', '0', '2021-01-14 15:00:49.111000', null, '2021-01-14 15:17:32.231000', null, null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1349918315537424386', '1285226128205770753', 'defalut', 'H2101150003', '3', '210115', '0', '2021-01-15 03:16:21.350000', null, '2021-01-15 03:27:29.304000', null, null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1351103946837884929', '1285226128205770753', 'defalut', 'H2101180004', '4', '210118', '0', '2021-01-18 09:47:37.882000', null, '2021-01-18 09:51:06.866000', null, null, null);
INSERT INTO `sys_sequence_queue` VALUES ('1355436573495762946', '1285226128205770753', 'defalut', 'H2101300013', '13', '210130', '0', '2021-01-30 08:43:56.573000', null, '2021-01-30 10:16:18.609000', null, null, null);

-- ----------------------------
-- Table structure for sys_structure
-- ----------------------------
DROP TABLE IF EXISTS `sys_structure`;
CREATE TABLE `sys_structure` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `code` varchar(32) DEFAULT NULL COMMENT '节点代码',
  `type` varchar(255) DEFAULT NULL COMMENT '机构类型',
  `name` varchar(32) DEFAULT NULL COMMENT '节点名称',
  `parent_id` bigint(32) DEFAULT NULL COMMENT '父级节点',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='机构管理';

-- ----------------------------
-- Records of sys_structure
-- ----------------------------

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant` (
  `id` bigint(32) NOT NULL,
  `tenant_code` varchar(32) DEFAULT NULL COMMENT '租户编码',
  `tenant_name` varchar(50) DEFAULT NULL COMMENT '租户名称',
  `description` varchar(255) DEFAULT NULL COMMENT '租户描述',
  `tenant_url` varchar(100) DEFAULT NULL COMMENT '租户url地址',
  `tenant_db` varchar(255) DEFAULT NULL COMMENT '租户数据库',
  `start_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '开始时间',
  `expiration_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '服务到期时间',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='租户信息';

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------

-- ----------------------------
-- Table structure for sys_upload
-- ----------------------------
DROP TABLE IF EXISTS `sys_upload`;
CREATE TABLE `sys_upload` (
  `id` bigint(32) NOT NULL DEFAULT '0',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `name` varchar(200) DEFAULT NULL COMMENT '名称',
  `url` varchar(2000) DEFAULT NULL COMMENT '地址',
  `sort` int(64) DEFAULT NULL COMMENT '排序',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0 未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='上传文件';

-- ----------------------------
-- Records of sys_upload
-- ----------------------------
INSERT INTO `sys_upload` VALUES ('1347006526315171841', null, '____ (1).bpmn', '/20210107/d23ce53b-0e98-46c5-87d6-803fd2f0eb22.bpmn', null, '0', '2021-01-07 02:25:56.702000', null, '2021-01-07 02:25:56.702000', null, null);
INSERT INTO `sys_upload` VALUES ('1347006552982556673', null, '____1 (1).bpmn', '/20210107/cb3aa7e1-678e-4b17-8759-fb382a462f7a.bpmn', null, '0', '2021-01-07 02:26:03.060000', null, '2021-01-07 02:26:03.060000', null, null);
INSERT INTO `sys_upload` VALUES ('1347006799171424258', null, '____ (3).bpmn', '/20210107/4f35a187-b02a-4dc4-9a8d-d98f26874f23.bpmn', null, '0', '2021-01-07 02:27:01.756000', null, '2021-01-07 02:27:01.756000', null, null);
INSERT INTO `sys_upload` VALUES ('1347006811976634369', null, '____ (3).bpmn', '/20210107/ffd9e96d-e97c-4b3a-bd6d-56d1ff3a584b.bpmn', null, '0', '2021-01-07 02:27:04.808000', null, '2021-01-07 02:27:04.810000', null, null);
INSERT INTO `sys_upload` VALUES ('1347006917115252738', null, '______ (2).bpmn', '/20210107/c1e67b70-770f-4743-bffa-0d7d72ed9244.bpmn', null, '0', '2021-01-07 02:27:29.876000', null, '2021-01-07 02:27:29.876000', null, null);
INSERT INTO `sys_upload` VALUES ('1347006930956455938', null, '______ (2).bpmn', '/20210107/3b6ad632-40ee-41e7-92ed-628097995918.bpmn', null, '0', '2021-01-07 02:27:33.176000', null, '2021-01-07 02:27:33.176000', null, null);
INSERT INTO `sys_upload` VALUES ('1348544703668748290', null, 'diagram (12).bpmn', '/20210111/1fee6144-bd2d-4011-9312-f9b34a245934.bpmn', null, '0', '2021-01-11 08:18:06.760000', null, '2021-01-11 08:18:06.760000', null, null);
INSERT INTO `sys_upload` VALUES ('1348544718600470530', null, 'diagram (12).bpmn', '/20210111/f05fe443-61d6-4ac5-8f45-ae8a1554276b.bpmn', null, '0', '2021-01-11 08:18:10.320000', null, '2021-01-11 08:18:10.320000', null, null);
INSERT INTO `sys_upload` VALUES ('1348909640385687553', null, 'diagram (59).bpmn', '/20210112/059eaab8-bd35-4a78-b278-99f833eb42dd.bpmn', null, '0', '2021-01-12 08:28:14.454000', null, '2021-01-12 08:28:14.454000', null, null);
INSERT INTO `sys_upload` VALUES ('1348909651160854530', null, 'diagram (59).bpmn', '/20210112/a68895c4-e672-4853-a6a8-550f653989a4.bpmn', null, '0', '2021-01-12 08:28:17.023000', null, '2021-01-12 08:28:17.023000', null, null);
INSERT INTO `sys_upload` VALUES ('1348910015935279105', null, 'diagram (59).bpmn', '/20210112/ead65f58-2cda-4818-b607-6c2338c0f0ea.bpmn', null, '0', '2021-01-12 08:29:43.993000', null, '2021-01-12 08:29:43.993000', null, null);
INSERT INTO `sys_upload` VALUES ('1348910042371977218', null, 'diagram (59).bpmn', '/20210112/c95da2e8-2f40-423a-8169-7b946aec71eb.bpmn', null, '0', '2021-01-12 08:29:50.295000', null, '2021-01-12 08:29:50.295000', null, null);
INSERT INTO `sys_upload` VALUES ('1348910198907596801', null, 'diagram (61).bpmn', '/20210112/2d979e21-ff41-406a-bb1d-647281aae929.bpmn', null, '0', '2021-01-12 08:30:27.617000', null, '2021-01-12 08:30:27.617000', null, null);
INSERT INTO `sys_upload` VALUES ('1348910217719050241', null, 'diagram (61).bpmn', '/20210112/b3f33d39-4c9a-4453-a735-3635ad9fe2c5.bpmn', null, '0', '2021-01-12 08:30:32.101000', null, '2021-01-12 08:30:32.101000', null, null);
INSERT INTO `sys_upload` VALUES ('1348911677835964417', null, 'diagram (62).bpmn', '/20210112/376f30be-043c-4f90-9c70-e3dca5fcf331.bpmn', null, '0', '2021-01-12 08:36:20.220000', null, '2021-01-12 08:36:20.220000', null, null);
INSERT INTO `sys_upload` VALUES ('1348911837882216450', null, 'diagram (62).bpmn', '/20210112/96a7d301-50c9-4287-a092-c37647db3be1.bpmn', null, '0', '2021-01-12 08:36:58.378000', null, '2021-01-12 08:36:58.378000', null, null);
INSERT INTO `sys_upload` VALUES ('1348911942316191746', null, 'diagram (62).bpmn', '/20210112/79a50dd2-6107-4987-87c3-86a520c56d83.bpmn', null, '0', '2021-01-12 08:37:23.277000', null, '2021-01-12 08:37:23.277000', null, null);
INSERT INTO `sys_upload` VALUES ('1348913967296802818', null, 'diagram (66).bpmn', '/20210112/f17fc179-babb-4367-b32e-03b19e7d4928.bpmn', null, '0', '2021-01-12 08:45:26.071000', null, '2021-01-12 08:45:26.071000', null, null);
INSERT INTO `sys_upload` VALUES ('1348996625169010690', null, 'diagram (70).bpmn', '/20210112/303a54fd-3341-433b-907f-3a14bf2c1b7d.bpmn', null, '0', '2021-01-12 14:13:53.243000', null, '2021-01-12 14:13:53.243000', null, null);
INSERT INTO `sys_upload` VALUES ('1348998137819578369', null, 'diagram (73).bpmn', '/20210112/d7fc85f6-0ea8-408c-abc2-fa03d74941d8.bpmn', null, '0', '2021-01-12 14:19:53.887000', null, '2021-01-12 14:19:53.887000', null, null);
INSERT INTO `sys_upload` VALUES ('1349000016939094017', null, 'diagram (73).bpmn', '/20210112/b1e404f9-640f-4683-8b30-c98cf4e8273c.bpmn', null, '0', '2021-01-12 14:27:21.904000', null, '2021-01-12 14:27:21.904000', null, null);
INSERT INTO `sys_upload` VALUES ('1349000670944378881', null, 'diagram (73).bpmn', '/20210112/eea4ffd5-1c04-4b28-958b-c22c6ff2470c.bpmn', null, '0', '2021-01-12 14:29:57.830000', null, '2021-01-12 14:29:57.830000', null, null);
INSERT INTO `sys_upload` VALUES ('1349001235581530113', null, 'diagram (73).bpmn', '/20210112/d48f2238-d34a-4e66-8ba5-76252eb099cc.bpmn', null, '0', '2021-01-12 14:32:12.451000', null, '2021-01-12 14:32:12.451000', null, null);
INSERT INTO `sys_upload` VALUES ('1349002469596196866', null, 'diagram (73).bpmn', '/20210112/09fe0e5e-c511-4093-a9ea-986ee13cd970.bpmn', null, '0', '2021-01-12 14:37:06.663000', null, '2021-01-12 14:37:06.663000', null, null);
INSERT INTO `sys_upload` VALUES ('1349003241863925762', null, 'diagram (73).bpmn', '/20210112/bdcf490b-db1c-4322-9d36-6886d966487c.bpmn', null, '0', '2021-01-12 14:40:10.787000', null, '2021-01-12 14:40:10.787000', null, null);
INSERT INTO `sys_upload` VALUES ('1349003440631992321', null, 'diagram (73).bpmn', '/20210112/2acda540-7c7e-48e9-870b-47948285ed83.bpmn', null, '0', '2021-01-12 14:40:58.175000', null, '2021-01-12 14:40:58.175000', null, null);
INSERT INTO `sys_upload` VALUES ('1349005244862189569', null, 'diagram (75).bpmn', '/20210112/3e50168f-a2db-41e6-a53c-6ade990e000c.bpmn', null, '0', '2021-01-12 14:48:08.338000', null, '2021-01-12 14:48:08.338000', null, null);
INSERT INTO `sys_upload` VALUES ('1349005744944861186', null, 'diagram (76).bpmn', '/20210112/f8df1765-3f7f-443f-b33f-b20070f4c927.bpmn', null, '0', '2021-01-12 14:50:07.567000', null, '2021-01-12 14:50:07.567000', null, null);
INSERT INTO `sys_upload` VALUES ('1349228010127380482', null, 'diagram (77).bpmn', '/20210113/f47d4309-99a7-42fe-8be3-0e0470d04f42.bpmn', null, '0', '2021-01-13 05:33:19.716000', null, '2021-01-13 05:33:19.716000', null, null);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `login_name` varchar(20) DEFAULT NULL COMMENT '登录名',
  `nick_name` varchar(100) DEFAULT NULL COMMENT '昵称',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `gender` varchar(2) DEFAULT NULL COMMENT '性别',
  `email` varchar(32) DEFAULT NULL COMMENT '邮箱',
  `mobile_phone` varchar(15) DEFAULT NULL COMMENT '手机号码',
  `wechat` varchar(65) DEFAULT NULL COMMENT '微信号',
  `qq` varchar(20) DEFAULT NULL COMMENT 'QQ号',
  `fax` varchar(20) DEFAULT NULL COMMENT '传真',
  `last_login_time` datetime(6) DEFAULT NULL COMMENT '最后登录时间',
  `expire_time` datetime(6) DEFAULT NULL COMMENT '有效期',
  `is_enable` int(4) DEFAULT '1' COMMENT '是否禁用 1启用 0禁用',
  `user_img` varchar(500) DEFAULT NULL COMMENT '用户头像',
  `user_skin` text COMMENT '用户皮肤',
  `employe_id` bigint(32) DEFAULT NULL COMMENT '职工ID',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0 未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户基本信息';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '1', 'admin', '超级管理员', '$2a$10$a77gQxtwl/lGAOL9QR2gsuA6eMQ1TIQcLld09I9PoU786YDUAOymG', '1', '1152232809@qq.com', '13025161555', '', '', '', '2018-04-15 10:20:23.000000', '9999-12-31 00:00:00.000000', '1', null, '', '1316588941431918594', '0', '2018-04-15 10:02:55.000000', null, '2021-01-22 08:05:36.939000', null, null);
INSERT INTO `sys_user` VALUES ('1279577531316084738', null, 'user', 'user', '$2a$10$5ARs7OQtCL.2B32rovGYU.wGFU93P4DTN5qCzAnK2mX4M77qwSl5y', null, '1', '1', null, '1', null, null, '9999-12-31 00:00:00.000000', '1', null, null, null, '1', '2020-07-04 19:47:11.525000', '1', '2020-07-04 19:47:11.525000', '1', null);
INSERT INTO `sys_user` VALUES ('1279577615655149569', null, 'user', 'user', '$2a$10$/4m1mbhbm3bY8uXSSW2QIuEzQhyqsDeOAkQqTmYO3yMBTSmgdkkfe', null, '1', '1', null, '1', null, null, '9999-12-31 00:00:00.000000', '1', null, null, '1316588941431918594', '0', '2020-07-04 19:47:31.633000', '1', '2021-01-24 08:11:29.971000', null, null);
INSERT INTO `sys_user` VALUES ('1296624483095842817', null, 'manager', '课长', '$2a$10$Hm4ixl5/o77hMx/jMQneXuJEAwWV5.WcGgHwm/vdPC072klHqj0ta', null, '0000', '0000', null, '000', null, null, null, '1', null, null, '1353253862792159234', '0', '2020-08-21 01:45:41.545000', '1', '2021-01-24 08:21:05.293000', null, null);
INSERT INTO `sys_user` VALUES ('1296624680504954882', null, 'supervisor', '处长', '$2a$10$vsrKNoNXQfJgpcJUJqj3iu0LkK1fwO/esldHzUUaD3MA3ei9ZEM4q', null, '1111', '1111', null, '1111', null, null, null, '1', null, null, '1353253009775583233', '0', '2020-08-21 01:46:28.612000', '1', '2021-01-24 08:21:38.713000', null, null);
INSERT INTO `sys_user` VALUES ('1296624816626896898', null, 'cmanager', '公司经理', '$2a$10$yRdNIOhnMBkylzIzJwoyKOFRi91akuipu3tzudG4eJhYL/Uy0eFMS', null, '333', '2333', null, '33', null, null, null, '1', null, null, '1353252554869760002', '0', '2020-08-21 01:47:01.065000', '1', '2021-01-24 08:22:49.411000', null, null);
INSERT INTO `sys_user` VALUES ('1296624964950069250', null, 'president', '公司总裁', '$2a$10$zBZJxDZpGEAIwryLbxo10.8GBcsxYT2804xSj0m3x8zWE/oc24OwK', null, '000000', '000000', null, '000000', null, null, null, '1', null, null, null, '1', '2020-08-21 01:47:36.428000', '1', '2020-11-27 07:45:44.292000', '1', null);
INSERT INTO `sys_user` VALUES ('1324190583048208385', null, 'asd', 'asd', '$2a$10$NcT1C0OK0Yi/8StNUccEJOouUurneoskDWjtib9wwLpmBJ/gmJKjK', null, 'asd', 'asd', null, 'asd', null, null, null, '1', null, null, null, '1', '2020-11-05 03:23:31.929000', '1', '2020-11-05 03:23:31.929000', '1', null);
INSERT INTO `sys_user` VALUES ('1332229590180966402', null, 'cssss', 'cssss', '$2a$10$2Rn.pOLobxh5BKPgvB3cIO3RpkmiRwplHGfSnb7/zyD3ctrF.mjMe', null, '11@11.com', '11111111111', null, '11111', null, null, null, '1', null, null, null, '0', '2020-11-27 07:47:40.588000', '1', '2020-11-27 07:47:40.588000', '1', null);
INSERT INTO `sys_user` VALUES ('1350076119610949634', null, 'hr_xl', 'HR小刘', '$2a$10$iF1Q6K1UgXj5gaqm.3kc3uxOGbA7hvEG2RXpqhGildBzz0ff8fEUu', null, '1152232809@qq.cm', '18961443673', null, '1152232809', null, null, null, '1', null, null, null, '0', '2021-01-15 13:43:24.773000', null, '2021-01-15 13:43:24.773000', null, null);
INSERT INTO `sys_user` VALUES ('1353256863002976257', null, 'buzhang', '部长', '$2a$10$CR90OZ02OVzGfyEVwflP5uoeuK1Q3a.0iyY97iNTLXgucKykwNSPe', null, '3334', '18961443671', null, '', null, null, null, '1', null, null, '1353253437066108929', '0', '2021-01-24 08:22:33.093000', null, '2021-01-24 08:22:33.093000', null, null);

-- ----------------------------
-- Table structure for sys_user_column
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_column`;
CREATE TABLE `sys_user_column` (
  `id` bigint(32) NOT NULL COMMENT 'ID',
  `user_id` bigint(32) DEFAULT NULL COMMENT '用户ID',
  `model_code` varchar(255) DEFAULT NULL COMMENT '模型',
  `table_columns` text COMMENT '定义的值',
  `defalut` int(1) DEFAULT NULL COMMENT '默认',
  `column_value` text COMMENT '列表值',
  `tenant_id` bigint(32) DEFAULT NULL COMMENT '项目编码',
  `is_del` int(1) DEFAULT '0' COMMENT '是否删除 1已删除 0未删除',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint(32) DEFAULT NULL COMMENT '创建用户',
  `update_time` datetime(6) DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint(20) DEFAULT NULL COMMENT '更新用户',
  `memo` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_user_column
-- ----------------------------
INSERT INTO `sys_user_column` VALUES ('1289546315633623042', '1', 'table_user_-sysuser', '[{\"label\":\"账号\",\"prop\":\"loginName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"昵称\",\"prop\":\"nickName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"手机\",\"prop\":\"mobilePhone\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"邮箱\",\"prop\":\"email\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"QQ\",\"prop\":\"qq\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"是否有效\",\"prop\":\"isEnable\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"到期时间\",\"prop\":\"expireTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"到期时间\",\"prop\":\"expireTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'eca5a637959266b0b6553786a758ab73', null, '0', '2020-08-01 12:59:34.916000', '1', '2021-01-22 08:07:32.118000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546321941856257', '1', 'table_sysrole_-sysrole', '[{\"label\":\"角色代码\",\"prop\":\"roleCode\",\"show\":true,\"fixed\":false,\"sortable\":true},{\"label\":\"角色名称\",\"prop\":\"roleName\",\"show\":true,\"fixed\":false,\"sortable\":true},{\"label\":\"创建时间\",\"prop\":\"createTime\",\"show\":true,\"fixed\":false,\"sortable\":true},{\"label\":\"创建人\",\"prop\":\"createBy\",\"show\":true,\"fixed\":false,\"sortable\":true}]', null, '80360c98c20a7f66464f2a34852cf772', null, '0', '2020-08-01 12:59:36.420000', '1', '2020-12-31 04:30:50.425000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546328082317313', '1', 'table_sysfunc_-sysmenu', '[{\"label\":\"方法名称\",\"prop\":\"funcName\",\"show\":true,\"fixed\":false,\"sortable\":true},{\"label\":\"方法代码\",\"prop\":\"funcCode\",\"show\":true,\"fixed\":false,\"sortable\":true},{\"label\":\"方法URL\",\"prop\":\"funcUrl\",\"show\":true,\"fixed\":false,\"sortable\":true},{\"label\":\"创建时间\",\"prop\":\"createTime\",\"show\":true,\"fixed\":false,\"sortable\":true},{\"label\":\"创建人\",\"prop\":\"createBy\",\"show\":true,\"fixed\":false,\"sortable\":true}]', null, '513a141ca9030d2a7ac8a185b0340373', null, '0', '2020-08-01 12:59:37.885000', '1', '2020-12-30 13:15:47.093000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546334617042945', '1', 'table_sysSequence_-syssequence', '[{\"label\":\"编码\",\"prop\":\"code\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"名称\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"前缀\",\"prop\":\"prefix\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"分隔符\",\"prop\":\"separator\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"日期格式\",\"prop\":\"dateFormat\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"数字长度\",\"prop\":\"numLength\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"初始值\",\"prop\":\"initValue\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'f7617f836d55a2792c581ccefcc2759c', null, '0', '2020-08-01 12:59:39.443000', '1', '2021-01-30 09:00:59.075000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546338966536193', '1', 'table_sysdic_-sysdic', '[{\"label\":\"字典编号\",\"prop\":\"dicCode\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"字典名称\",\"prop\":\"dicName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"字典描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"创建人\",\"prop\":\"createByName\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"创建时间\",\"prop\":\"createTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'f6589e318b8279c59e00fcd14086028b', null, '0', '2020-08-01 12:59:40.479000', '1', '2020-08-01 12:59:40.479000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546345434152961', '1', 'table_sysjob_-sysjob', '[{\"label\":\"任务名称\",\"prop\":\"jobName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"任务分组\",\"prop\":\"jobGroup\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"任务描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"类路径\",\"prop\":\"jobClassName\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"执行频率\",\"prop\":\"cronExpression\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"状态\",\"prop\":\"triggerState\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '05ba46640ef8206cff291b8cda7b65ce', null, '0', '2020-08-01 12:59:42.021000', '1', '2020-08-01 12:59:42.021000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546351222292482', '1', 'table_syslog_-syslog', '[{\"label\":\"用户名称\",\"prop\":\"userName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"IP地址\",\"prop\":\"ip\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"访问URL\",\"prop\":\"url\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"方法描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"方法\",\"prop\":\"method\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"访问时间\",\"prop\":\"createTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '9a20f555a1d1ab5c5494ca11886e0641', null, '0', '2020-08-01 12:59:43.402000', '1', '2020-08-01 12:59:43.402000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546365625532417', '1', 'table_wflowDefine_-wflowdefine', '[{\"label\":\"流程名称\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"流程key\",\"prop\":\"key\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"部署ID\",\"prop\":\"deploymentId\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"版本\",\"prop\":\"version\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程定义id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200}]', null, '22e6c85b24c9d1f2f69fdfa12bf68852', null, '0', '2020-08-01 12:59:46.835000', '1', '2021-01-14 15:06:14.362000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546372177035266', '1', 'table_wlfowClaim_-wflowclaim', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-01 12:59:48.397000', '1', '2020-08-01 12:59:48.397000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546378091003905', '1', 'table_wlfowTask_-wflowtask', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-01 12:59:49.808000', '1', '2020-08-01 12:59:49.808000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546383421964289', '1', 'table_wflowHistroy_-wflowhistory', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"签核节点\",\"prop\":\"activityName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"签核类型\",\"prop\":\"activityType\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"开始时间\",\"prop\":\"startTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"结束时间\",\"prop\":\"endTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"拒绝理由\",\"prop\":\"deleteReason\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'c2510070ff77b9e0c1f23b699e8955da', null, '0', '2020-08-01 12:59:51.078000', '1', '2020-08-01 12:59:51.078000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546389382070273', '1', 'table_wlfowAllTask_-wflowalltask', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-01 12:59:52.500000', '1', '2021-01-07 02:29:36.027000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1289546395086323713', '1', 'table_wflowHisInstance_-wflowhisinstance', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"流程名称\",\"prop\":\"processDefinitionName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"业务单据\",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"发起人\",\"prop\":\"startUserId\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"任务名称\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"开始时间\",\"prop\":\"startTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"结束时间\",\"prop\":\"endTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '8907b8fa69f2df9309e80bf83de80a99', null, '0', '2020-08-01 12:59:53.859000', '1', '2020-08-01 12:59:53.859000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1291732437835038721', '1', 'table_employe_-sysemploye', '[{\"label\":\"工号\",\"prop\":\"workNo\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":100},{\"label\":\"姓名\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":100},{\"label\":\"英文名\",\"prop\":\"foreignName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":100},{\"label\":\"手机\",\"prop\":\"mobilePhone\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":100},{\"label\":\"座机号\",\"prop\":\"telePhone\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":100},{\"label\":\"邮箱\",\"prop\":\"email\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":150},{\"label\":\"生日\",\"prop\":\"birthday\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":120},{\"label\":\"学历\",\"prop\":\"education\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":100},{\"label\":\"部门\",\"prop\":\"deptName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":100},{\"label\":\"职位\",\"prop\":\"position\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":100},{\"label\":\"状态\",\"prop\":\"status\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":80},{\"label\":\"入职日期\",\"prop\":\"entryDate\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":120},{\"label\":\"离职日期\",\"prop\":\"departureDate\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":120}]', null, 'd3065b7fbc6b01127b99b4112ef18393', null, '0', '2020-08-07 13:46:27.065000', '1', '2021-01-26 03:30:20.728000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1294562630173827074', '1', 'table_sysdic_item_-sysdic', '[{\"label\":\"名称\",\"prop\":\"dicItemName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"编码\",\"prop\":\"dicItemCode\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"值\",\"prop\":\"dicItemValue\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'bb9dc05f9c997e8ba59bdfd7770c57a3', null, '0', '2020-08-15 09:12:37.501000', '1', '2020-12-18 13:50:57.203000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1296628358263623682', '1296624483095842817', 'table_wlfowClaim_-wflowclaim', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-21 02:01:05.458000', '1296624483095842817', '2020-08-21 02:01:05.458000', '1296624483095842817', null);
INSERT INTO `sys_user_column` VALUES ('1296628366329270274', '1296624483095842817', 'table_wlfowTask_-wflowtask', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-21 02:01:07.380000', '1296624483095842817', '2020-08-21 02:01:07.380000', '1296624483095842817', null);
INSERT INTO `sys_user_column` VALUES ('1296628605849194497', '1296624680504954882', 'table_wlfowClaim_-wflowclaim', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-21 02:02:04.487000', '1296624680504954882', '2020-08-21 02:02:04.487000', '1296624680504954882', null);
INSERT INTO `sys_user_column` VALUES ('1296628612492972033', '1296624680504954882', 'table_wlfowTask_-wflowtask', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-21 02:02:06.070000', '1296624680504954882', '2020-08-21 02:02:06.070000', '1296624680504954882', null);
INSERT INTO `sys_user_column` VALUES ('1296628722517954561', '1296624816626896898', 'table_wlfowClaim_-wflowclaim', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-21 02:02:32.302000', '1296624816626896898', '2020-08-21 02:02:32.302000', '1296624816626896898', null);
INSERT INTO `sys_user_column` VALUES ('1296628729316921346', '1296624816626896898', 'table_wlfowTask_-wflowtask', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-21 02:02:33.923000', '1296624816626896898', '2020-08-21 02:02:33.923000', '1296624816626896898', null);
INSERT INTO `sys_user_column` VALUES ('1296631670962671617', '1296624964950069250', 'table_user_-sysuser', '[{\"label\":\"账号\",\"prop\":\"loginName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"昵称\",\"prop\":\"nickName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"手机\",\"prop\":\"mobilePhone\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"邮箱\",\"prop\":\"email\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"QQ\",\"prop\":\"qq\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"是否有效\",\"prop\":\"isEnable\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"到期时间\",\"prop\":\"expireTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '87082ebde2420284fabb636228e0f418', null, '0', '2020-08-21 02:14:15.267000', '1296624964950069250', '2020-08-21 02:14:15.267000', '1296624964950069250', null);
INSERT INTO `sys_user_column` VALUES ('1296631680647319553', '1296624964950069250', 'table_sysrole_-sysrole', '[{\"label\":\"角色代码\",\"prop\":\"roleCode\",\"show\":true,\"fixed\":false,\"sortable\":true},{\"label\":\"角色名称\",\"prop\":\"roleName\",\"show\":true,\"fixed\":false,\"sortable\":true},{\"label\":\"创建时间\",\"prop\":\"createTime\",\"show\":true,\"fixed\":false,\"sortable\":true},{\"label\":\"创建人\",\"prop\":\"createBy\",\"show\":true,\"fixed\":false,\"sortable\":true}]', null, '80360c98c20a7f66464f2a34852cf772', null, '0', '2020-08-21 02:14:17.575000', '1296624964950069250', '2020-08-21 02:14:17.575000', '1296624964950069250', null);
INSERT INTO `sys_user_column` VALUES ('1296631695822311426', '1296624964950069250', 'table_wlfowTask_-wflowtask', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-21 02:14:21.193000', '1296624964950069250', '2020-08-21 02:14:21.193000', '1296624964950069250', null);
INSERT INTO `sys_user_column` VALUES ('1296637071871463426', '1296624816626896898', 'table_wflowHistroy_-wflowhistory', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"签核节点\",\"prop\":\"activityName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"签核类型\",\"prop\":\"activityType\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"开始时间\",\"prop\":\"startTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"结束时间\",\"prop\":\"endTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"拒绝理由\",\"prop\":\"deleteReason\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'c2510070ff77b9e0c1f23b699e8955da', null, '0', '2020-08-21 02:35:42.944000', '1296624816626896898', '2020-08-21 02:35:42.944000', '1296624816626896898', null);
INSERT INTO `sys_user_column` VALUES ('1296637156055339010', '1296624680504954882', 'table_wflowHistroy_-wflowhistory', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"签核节点\",\"prop\":\"activityName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"签核类型\",\"prop\":\"activityType\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"开始时间\",\"prop\":\"startTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"结束时间\",\"prop\":\"endTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"拒绝理由\",\"prop\":\"deleteReason\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'c2510070ff77b9e0c1f23b699e8955da', null, '0', '2020-08-21 02:36:03.014000', '1296624680504954882', '2020-08-21 02:36:03.014000', '1296624680504954882', null);
INSERT INTO `sys_user_column` VALUES ('1299293743878275074', '1279577615655149569', 'table_wlfowTask_-wflowtask', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2020-08-28 10:32:22.909000', '1279577615655149569', '2020-08-28 10:32:22.909000', '1279577615655149569', null);
INSERT INTO `sys_user_column` VALUES ('1299293757857890305', '1279577615655149569', 'table_user_-sysuser', '[{\"label\":\"账号\",\"prop\":\"loginName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"昵称\",\"prop\":\"nickName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"手机\",\"prop\":\"mobilePhone\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"邮箱\",\"prop\":\"email\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"QQ\",\"prop\":\"qq\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"是否有效\",\"prop\":\"isEnable\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"到期时间\",\"prop\":\"expireTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '87082ebde2420284fabb636228e0f418', null, '0', '2020-08-28 10:32:26.243000', '1279577615655149569', '2020-08-28 10:32:26.243000', '1279577615655149569', null);
INSERT INTO `sys_user_column` VALUES ('1299294091925815298', '1296624483095842817', 'table_user_-sysuser', '[{\"label\":\"账号\",\"prop\":\"loginName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"昵称\",\"prop\":\"nickName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"手机\",\"prop\":\"mobilePhone\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"邮箱\",\"prop\":\"email\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"QQ\",\"prop\":\"qq\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"是否有效\",\"prop\":\"isEnable\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"到期时间\",\"prop\":\"expireTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"到期时间\",\"prop\":\"expireTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'eca5a637959266b0b6553786a758ab73', null, '0', '2020-08-28 10:33:45.890000', '1296624483095842817', '2021-01-30 08:47:50.569000', '1296624483095842817', null);
INSERT INTO `sys_user_column` VALUES ('1319277404098785282', '1', 'table_sysjob_-sysjobs', '[{\"label\":\"任务名称\",\"prop\":\"jobName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"任务分组\",\"prop\":\"jobGroup\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"任务描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"类路径\",\"prop\":\"jobClassName\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"执行频率\",\"prop\":\"cronExpression\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"状态\",\"prop\":\"triggerState\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '05ba46640ef8206cff291b8cda7b65ce', null, '0', '2020-10-22 14:00:18.783000', '1', '2020-10-22 14:00:18.783000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1319281979367129090', '1', 'table_employe_-sysjobs', '[{\"label\":\"职务编码\",\"prop\":\"code\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"职务名称\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"职务级别\",\"prop\":\"level\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"是否有效\",\"prop\":\"isActive\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"创建时间\",\"prop\":\"createTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'bbf587c5312c162682039f3a12ded06a', null, '0', '2020-10-22 14:18:29.613000', '1', '2020-10-22 14:19:18.035000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1319282485447655426', '1', 'table_job_-sysjobs', '[{\"label\":\"职务编码\",\"prop\":\"code\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"职务名称\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"职务级别\",\"prop\":\"level\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"是否有效\",\"prop\":\"isActive\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"创建时间\",\"prop\":\"createTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'bbf587c5312c162682039f3a12ded06a', null, '0', '2020-10-22 14:20:30.272000', '1', '2020-10-22 14:20:30.272000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1319635505477898241', '1', 'table_sysJobs_-sysjobs', '[{\"label\":\"职务编码\",\"prop\":\"code\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"职务名称\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"职务级别\",\"prop\":\"level\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"创建时间\",\"prop\":\"createTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '26b9e91ea1e59293a4e022698aba87c3', null, '0', '2020-10-23 13:43:16.806000', '1', '2020-10-23 14:09:38.528000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1319984442873327618', '1', 'table_employe_-sysdept', '[{\"label\":\"部门代码\",\"prop\":\"deptCode\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"部门名称\",\"prop\":\"deptName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"负责人\",\"prop\":\"deptHeaderName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"创建时间\",\"prop\":\"createTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'd572f1457efcf0dfcbc831959b65efa6', null, '0', '2020-10-24 12:49:49.963000', '1', '2020-10-24 13:05:08.892000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1327615387348537346', '1', 'table_sysSequenceLog_-syssequence', '[{\"label\":\"流水编码\",\"prop\":\"flowCode\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"创建人\",\"prop\":\"createBy\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"创建时间\",\"prop\":\"createTime\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'd609e32ed8c0ac6c1cd4d1356848d569', null, '0', '2020-11-14 14:12:28.904000', '1', '2020-11-14 14:12:28.904000', '1', null);
INSERT INTO `sys_user_column` VALUES ('1347003110033641473', '1279577615655149569', 'table_wlfowClaim_-wflowclaim', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2021-01-07 02:12:22.196000', null, '2021-01-07 02:12:22.196000', null, null);
INSERT INTO `sys_user_column` VALUES ('1347003387759480834', '1279577615655149569', 'table_wflowHistroy_-wflowhistory', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"签核节点\",\"prop\":\"activityName\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"签核类型\",\"prop\":\"activityType\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"开始时间\",\"prop\":\"startTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"结束时间\",\"prop\":\"endTime\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"拒绝理由\",\"prop\":\"deleteReason\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, 'c2510070ff77b9e0c1f23b699e8955da', null, '0', '2021-01-07 02:13:28.413000', null, '2021-01-07 02:13:28.413000', null, null);
INSERT INTO `sys_user_column` VALUES ('1355438058388430850', '1353256863002976257', 'table_wlfowTask_-wflowtask', '[{\"label\":\"任务id\",\"prop\":\"id\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核节点\",\"prop\":\"name\",\"show\":true,\"fixed\":false,\"sortable\":false,\"width\":200},{\"label\":\"当前签核人\",\"prop\":\"assignee\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"流程分类\",\"prop\":\"category\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"业务单据 \",\"prop\":\"businessKey\",\"show\":true,\"fixed\":false,\"sortable\":false},{\"label\":\"描述\",\"prop\":\"description\",\"show\":true,\"fixed\":false,\"sortable\":false}]', null, '7383a431704d4d8492240bd7c710ed36', null, '0', '2021-01-30 08:49:50.599000', null, '2021-01-30 08:49:50.599000', null, null);
