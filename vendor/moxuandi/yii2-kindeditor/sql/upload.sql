-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2017-04-10 01:32:23
-- 服务器版本： 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `yii2advanced`
--

-- --------------------------------------------------------

--
-- 表的结构 `upload`
--

CREATE TABLE `upload` (
  `id` int(11) UNSIGNED NOT NULL COMMENT 'ID',
  `real_name` varchar(255) DEFAULT NULL COMMENT '原始文件名称',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `thumb_name` varchar(255) DEFAULT NULL COMMENT '缩略图',
  `file_ext` varchar(255) DEFAULT NULL COMMENT '扩展名称',
  `file_mime` varchar(255) DEFAULT NULL COMMENT 'MIME类型',
  `file_size` int(11) UNSIGNED DEFAULT '0' COMMENT '文件大小',
  `md5` text COMMENT 'MD5',
  `sha1` text COMMENT 'SHA1',
  `down_count` int(11) UNSIGNED DEFAULT '0' COMMENT '下载次数',
  `created_at` int(11) DEFAULT NULL COMMENT '添加时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件';

--
-- 转存表中的数据 `upload`
--

INSERT INTO `upload` (`id`, `real_name`, `file_name`, `thumb_name`, `file_ext`, `file_mime`, `file_size`, `md5`, `sha1`, `down_count`, `created_at`, `updated_at`) VALUES
(1, 'img_3.jpg', 'uploads/image/201704/170410_093213_7943.jpg', 'uploads/thumb/201704/170410_093213_7943.jpg', 'jpg', 'image/jpeg', 200913, '338a8d7c37f895e7aff3be9ad409b817', 'bc784edb77fb52c7144acc45aa52f2885049e21f', 0, 1491787933, 1491787933);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `upload`
--
ALTER TABLE `upload`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `upload`
--
ALTER TABLE `upload`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
