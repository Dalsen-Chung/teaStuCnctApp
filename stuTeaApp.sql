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
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_name` varchar(50) NOT NULL DEFAULT '0',
  `college_id` int(11) NOT NULL DEFAULT '0',
  `major_id` int(11) NOT NULL DEFAULT '0',
  `admin_account` varchar(50) NOT NULL DEFAULT '0',
  `admin_password` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员基础信息表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.notice_tb 结构
CREATE TABLE IF NOT EXISTS `notice_tb` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT,
  `notice_tea_id` int(11) NOT NULL,
  `notice_time` datetime NOT NULL,
  `notice_title` varchar(200) NOT NULL DEFAULT '0',
  `notice_content` text NOT NULL,
  `notice_read_times` int(11) NOT NULL DEFAULT '0' COMMENT '阅读次数',
  `college_id` int(11) NOT NULL,
  `major_id` int(11) NOT NULL,
  PRIMARY KEY (`notice_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='公告表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.priv_resce_tb 结构
CREATE TABLE IF NOT EXISTS `priv_resce_tb` (
  `priv_id` int(11) NOT NULL AUTO_INCREMENT,
  `priv_name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`priv_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='权限资源表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.role_info_tb 结构
CREATE TABLE IF NOT EXISTS `role_info_tb` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色信息表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.role_priv_tb 结构
CREATE TABLE IF NOT EXISTS `role_priv_tb` (
  `role_id` int(11) DEFAULT NULL,
  `priv_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色权限表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.stu_user_tb 结构
CREATE TABLE IF NOT EXISTS `stu_user_tb` (
  `stu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID',
  `stu_account` varchar(50) NOT NULL DEFAULT '0' COMMENT '学号，为登录账号',
  `stu_password` varchar(50) NOT NULL DEFAULT '0' COMMENT '登录密码',
  `stu_name` varchar(50) NOT NULL DEFAULT '0',
  `stu_sex` varchar(50) NOT NULL DEFAULT '0',
  `stu_grade` varchar(50) NOT NULL DEFAULT '0' COMMENT '年级',
  `college_id` int(11) NOT NULL DEFAULT '0' COMMENT '学院id',
  `major_id` int(11) NOT NULL DEFAULT '0' COMMENT '专业id',
  `class_id` int(11) NOT NULL DEFAULT '0' COMMENT '班级id',
  `stu_phone` varchar(50) NOT NULL DEFAULT '0',
  `stu_address` varchar(200) NOT NULL DEFAULT '0' COMMENT '家庭住址',
  PRIMARY KEY (`stu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='学生用户基本信息表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.tea_user_tb 结构
CREATE TABLE IF NOT EXISTS `tea_user_tb` (
  `tea_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色id',
  `tea_account` varchar(50) NOT NULL DEFAULT '0' COMMENT '工号，为登录账号',
  `tea_password` varchar(50) NOT NULL DEFAULT '0' COMMENT '登录密码',
  `tea_name` varchar(50) NOT NULL DEFAULT '0',
  `tea_sex` varchar(50) NOT NULL DEFAULT '0',
  `college_id` int(11) DEFAULT NULL,
  `major_id` int(11) DEFAULT NULL,
  `tea_phone` varchar(50) DEFAULT NULL,
  `tea_course` varchar(200) DEFAULT NULL COMMENT '所有教授课程，以逗号分隔',
  `tea_isInstructor` int(2) DEFAULT NULL COMMENT '是否为辅导员',
  PRIMARY KEY (`tea_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='教师用户基本信息表';

-- 数据导出被取消选择。
-- 导出  表 teastucnct.user_role_tb 结构
CREATE TABLE IF NOT EXISTS `user_role_tb` (
  `user_id` bigint(20) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户角色表';

-- 数据导出被取消选择。
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
