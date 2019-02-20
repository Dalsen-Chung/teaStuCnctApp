-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.15 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- 导出 teastucnct 的数据库结构
CREATE DATABASE IF NOT EXISTS `teastucnct` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `teastucnct`;

-- 导出  表 teastucnct.admin_user_tb 结构
CREATE TABLE IF NOT EXISTS `admin_user_tb` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员用户ID',
  `admin_name` varchar(50) NOT NULL DEFAULT '0' COMMENT '管理员姓名',
  `college_id` int(11) NOT NULL DEFAULT '0' COMMENT '管理员所属学院的ID',
  `major_id` int(11) NOT NULL DEFAULT '0' COMMENT '管理员所属专业的ID',
  `admin_account` varchar(50) NOT NULL DEFAULT '0' COMMENT '管理员账号',
  `admin_password` varchar(50) NOT NULL DEFAULT '0' COMMENT '管理员密码',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员基础信息表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.apply_record_tb 结构
CREATE TABLE IF NOT EXISTS `apply_record_tb` (
  `apply_id` int(11) NOT NULL COMMENT '申请ID',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  `apply_type` int(11) NOT NULL COMMENT '申请类型（1与2两类值）',
  `apply_reason` varchar(500) NOT NULL COMMENT '申请理由',
  `apply_user_id` int(11) NOT NULL COMMENT '申请用户ID',
  `apply_user_type` int(11) NOT NULL COMMENT '申请用户的角色类型',
  `check_user_id` int(11) NOT NULL COMMENT '被查看用户ID',
  `check_user_type` int(11) NOT NULL COMMENT '被查看用户的角色类型',
  `apply_result` int(11) NOT NULL COMMENT '申请结果',
  PRIMARY KEY (`apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通讯录查看申请记录表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.college_info_tb 结构
CREATE TABLE IF NOT EXISTS `college_info_tb` (
  `college_id` int(11) NOT NULL COMMENT '学院id',
  `college_name` varchar(200) NOT NULL COMMENT '学院名称',
  `college_icon` varchar(100) NOT NULL COMMENT '学院图标',
  `college_address` varchar(300) NOT NULL COMMENT '学院地址',
  `college_introduction` varchar(300) NOT NULL COMMENT '学院简介',
  PRIMARY KEY (`college_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学院基础信息表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.major_info_tb 结构
CREATE TABLE IF NOT EXISTS `major_info_tb` (
  `major_id` int(11) NOT NULL COMMENT '专业id',
  `college_id` int(11) NOT NULL COMMENT '所属学院id',
  `major_name` varchar(50) NOT NULL COMMENT '专业名称',
  `major_introduction` varchar(300) NOT NULL COMMENT '专业简介',
  PRIMARY KEY (`major_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='专业信息表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.notice_tb 结构
CREATE TABLE IF NOT EXISTS `notice_tb` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_tea_id` int(11) NOT NULL COMMENT '发布公告教师的ID',
  `notice_time` datetime NOT NULL COMMENT '发布公告的时间',
  `notice_title` varchar(200) NOT NULL DEFAULT '0' COMMENT '公告标题',
  `notice_content` text NOT NULL COMMENT '公告内容',
  `notice_read_times` int(11) NOT NULL DEFAULT '0' COMMENT '公告被浏览次数',
  `college_id` int(11) NOT NULL COMMENT '可查看的学院ID',
  `major_id` int(11) NOT NULL COMMENT '可查看的专业ID',
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公告表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.priv_resce_tb 结构
CREATE TABLE IF NOT EXISTS `priv_resce_tb` (
  `priv_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '权限ID',
  `priv_name` varchar(50) NOT NULL DEFAULT '0' COMMENT '权限名称',
  PRIMARY KEY (`priv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限资源表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.role_info_tb 结构
CREATE TABLE IF NOT EXISTS `role_info_tb` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(50) DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.role_priv_tb 结构
CREATE TABLE IF NOT EXISTS `role_priv_tb` (
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `priv_id` int(11) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`role_id`,`priv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.stu_user_tb 结构
CREATE TABLE IF NOT EXISTS `stu_user_tb` (
  `stu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '学生用户ID',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '学生角色ID',
  `stu_account` varchar(50) NOT NULL DEFAULT '0' COMMENT '学号，为登录账号',
  `stu_password` varchar(50) NOT NULL DEFAULT '0' COMMENT '登录密码',
  `stu_name` varchar(50) NOT NULL DEFAULT '0' COMMENT '学生姓名',
  `stu_sex` varchar(50) NOT NULL DEFAULT '0' COMMENT '学生性别',
  `stu_grade` varchar(50) NOT NULL DEFAULT '0' COMMENT '年级',
  `college_id` int(11) NOT NULL DEFAULT '0' COMMENT '学院Id',
  `major_id` int(11) NOT NULL DEFAULT '0' COMMENT '专业Id',
  `class_id` varchar(50) NOT NULL DEFAULT '0' COMMENT '班级',
  `stu_phone` varchar(50) NOT NULL DEFAULT '0' COMMENT '电话',
  `stu_address` varchar(200) NOT NULL DEFAULT '0' COMMENT '家庭住址',
  PRIMARY KEY (`stu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生用户基本信息表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.tea_user_tb 结构
CREATE TABLE IF NOT EXISTS `tea_user_tb` (
  `tea_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '教师用户ID',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `tea_account` varchar(50) NOT NULL DEFAULT '0' COMMENT '工号，为登录账号',
  `tea_password` varchar(50) NOT NULL DEFAULT '0' COMMENT '登录密码',
  `tea_name` varchar(50) NOT NULL DEFAULT '0' COMMENT '教师姓名',
  `tea_sex` varchar(50) NOT NULL DEFAULT '0' COMMENT '教师性别',
  `college_id` int(11) DEFAULT NULL COMMENT '学院ID',
  `major_id` int(11) DEFAULT NULL COMMENT '专业ID',
  `tea_phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `tea_course` varchar(200) DEFAULT NULL COMMENT '所有教授课程，以逗号分隔',
  `tea_isInstructor` int(2) DEFAULT NULL COMMENT '是否为辅导员',
  PRIMARY KEY (`tea_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师用户基本信息表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.user_role_tb 结构
CREATE TABLE IF NOT EXISTS `user_role_tb` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` int(11) NOT NULL COMMENT '用户角色ID',
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- 数据导出被取消选择。
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
