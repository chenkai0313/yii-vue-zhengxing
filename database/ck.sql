-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 2017-09-16 07:19:59
-- 服务器版本： 5.7.14
-- PHP Version: 7.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ck`
--

-- --------------------------------------------------------

--
-- 表的结构 `adminuser`
--

CREATE TABLE `adminuser` (
  `id` int(11) NOT NULL,
  `username` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `nickname` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `profile` text COLLATE utf8_unicode_ci,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `adminuser`
--

INSERT INTO `adminuser` (`id`, `username`, `nickname`, `password`, `email`, `profile`, `auth_key`, `password_hash`, `password_reset_token`) VALUES
(7, 'admin', '管理员', '*', 'admin@qq.com', '最大权限所有者', '9fWACxHyjr7Wj6E-UXj9yg13ynoKM0-Y', '$2y$13$DuxhcfRPrsWBBiAGx7MBOu0IFSyhGxrUZdRFWsZPWb/mMM6k1BeDq', NULL),
(8, 'article', '文章发布员', '*', '123@qq.com', '文章发布员', 'lfw5v4ZREepvuRGgoZw_IYFvWAfPmT0b', '$2y$13$TzINnFGiuFyEMW671VwveOukyahNXXzLb/YAJ.OrWJ.UlON2hymK2', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `auth_assignment`
--

CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `auth_assignment`
--

INSERT INTO `auth_assignment` (`item_name`, `user_id`, `created_at`) VALUES
('admin', '7', 1505532566),
('commentAuditor', '1', 1505483257),
('commentAuditor', '4', 1465177361),
('commentAuditor', '6', 1505484530),
('commentAuditor', '7', 1505532566),
('postAdmin', '1', 1505483257),
('postAdmin', '2', 1477816632),
('postAdmin', '7', 1505532566),
('postAdmin', '8', 1505539758),
('postOperator', '1', 1505483257),
('postOperator', '3', 1465177361),
('postOperator', '7', 1505532565);

-- --------------------------------------------------------

--
-- 表的结构 `auth_item`
--

CREATE TABLE `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `auth_item`
--

INSERT INTO `auth_item` (`name`, `type`, `description`, `rule_name`, `data`, `created_at`, `updated_at`) VALUES
('admin', 1, '系统管理员', NULL, NULL, 1465177361, 1465177361),
('approveComment', 2, '审核评论', NULL, NULL, 1465177361, 1465177361),
('createPost', 2, '新增文章', NULL, NULL, 1465177361, 1465177361),
('deletePost', 2, '删除文章', NULL, NULL, 1465177361, 1465177361),
('postAdmin', 1, '文章管理员', NULL, NULL, 1465177361, 1465177361),
('updatePost', 2, '修改文章', NULL, NULL, 1465177361, 1465177361);

-- --------------------------------------------------------

--
-- 表的结构 `auth_item_child`
--

CREATE TABLE `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `auth_item_child`
--

INSERT INTO `auth_item_child` (`parent`, `child`) VALUES
('postAdmin', 'createPost'),
('postAdmin', 'deletePost'),
('admin', 'postAdmin'),
('postAdmin', 'updatePost');

-- --------------------------------------------------------

--
-- 表的结构 `auth_rule`
--

CREATE TABLE `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `category`
--

CREATE TABLE `category` (
  `id` int(10) UNSIGNED NOT NULL,
  `pid` int(10) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `bgimage` varchar(255) NOT NULL,
  `display` int(10) NOT NULL,
  `weight` int(10) NOT NULL DEFAULT '0',
  `create_at` int(20) NOT NULL,
  `update_at` int(20) NOT NULL,
  `list_type` int(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `category`
--

INSERT INTO `category` (`id`, `pid`, `name`, `bgimage`, `display`, `weight`, `create_at`, `update_at`, `list_type`) VALUES
(84, 83, '2', '', 1, 0, 1505543599, 1505543599, 0),
(83, 83, '1', 'uploads/image/201709/170916_143244_3489.png', 1, 1, 1505543571, 1505543571, 4);

-- --------------------------------------------------------

--
-- 表的结构 `display`
--

CREATE TABLE `display` (
  `id` int(11) NOT NULL,
  `title` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `display`
--

INSERT INTO `display` (`id`, `title`) VALUES
(1, '发布'),
(2, '不发布'),
(3, '草稿');

-- --------------------------------------------------------

--
-- 表的结构 `images`
--

CREATE TABLE `images` (
  `id` int(10) NOT NULL,
  `img` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_at` int(50) NOT NULL,
  `update_at` int(50) NOT NULL,
  `type` int(10) NOT NULL,
  `weight` int(10) DEFAULT NULL,
  `display` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- 转存表中的数据 `images`
--

INSERT INTO `images` (`id`, `img`, `url`, `create_at`, `update_at`, `type`, `weight`, `display`) VALUES
(11, 'uploads/image/201709/170916_141002_9008.png', 'qwe', 1505542205, 1505542923, 2, 0, 1),
(12, 'uploads/image/201709/170916_141843_9343.jpg', '1', 1505542727, 1505542727, 1, 0, 1),
(13, 'uploads/image/201709/170916_142139_3253.jpg', '1', 1505542901, 1505542901, 2, 0, 1);

-- --------------------------------------------------------

--
-- 表的结构 `message`
--

CREATE TABLE `message` (
  `id` int(10) NOT NULL,
  `theme` varchar(255) NOT NULL,
  `replyway` int(10) NOT NULL,
  `linkman` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `display` int(10) NOT NULL,
  `create_at` int(50) NOT NULL,
  `linkway` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `migration`
--

CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1500537632),
('m130524_201442_init', 1500537635);

-- --------------------------------------------------------

--
-- 表的结构 `news`
--

CREATE TABLE `news` (
  `id` int(10) NOT NULL,
  `title` text NOT NULL,
  `remark` text NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `source` int(11) NOT NULL,
  `create_at` varchar(200) NOT NULL,
  `update_at` int(11) NOT NULL,
  `weight` int(10) NOT NULL,
  `pid` int(10) NOT NULL,
  `cid` int(10) NOT NULL,
  `display` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `reply`
--

CREATE TABLE `reply` (
  `id` int(10) NOT NULL,
  `pid_theme` int(10) NOT NULL,
  `content` text NOT NULL,
  `reply_people` varchar(50) NOT NULL,
  `create_time` int(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `reply`
--

INSERT INTO `reply` (`id`, `pid_theme`, `content`, `reply_people`, `create_time`) VALUES
(5, 5, '4556', '管理员', 1501030645);

-- --------------------------------------------------------

--
-- 表的结构 `replyway`
--

CREATE TABLE `replyway` (
  `id` int(10) NOT NULL,
  `title` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `replyway`
--

INSERT INTO `replyway` (`id`, `title`) VALUES
(1, 'E-MAIL'),
(2, '腾讯QQ'),
(3, '电话或者手机');

-- --------------------------------------------------------

--
-- 表的结构 `rongyi`
--

CREATE TABLE `rongyi` (
  `35` varchar(255) DEFAULT NULL,
  `351` varchar(255) DEFAULT NULL,
  `测试一` varchar(255) DEFAULT NULL,
  `backend/web/` varchar(255) DEFAULT NULL,
  `1` varchar(255) DEFAULT NULL,
  `11` varchar(255) DEFAULT NULL,
  `1500774326` varchar(255) DEFAULT NULL,
  `1500858739` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 表的结构 `slide`
--

CREATE TABLE `slide` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `weight` int(10) NOT NULL,
  `create_at` int(50) NOT NULL,
  `update_at` int(50) NOT NULL,
  `display` int(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `slide`
--

INSERT INTO `slide` (`id`, `title`, `img`, `url`, `weight`, `create_at`, `update_at`, `display`) VALUES
(6, '幻灯片一', 'uploads/image/201707/170727_174311_8008.jpg', '#', 1, 1501148597, 1501149389, 1),
(7, '幻灯片二', 'uploads/image/201707/170727_174344_4571.jpg', '#', 0, 1501148631, 1501149355, 1);

-- --------------------------------------------------------

--
-- 表的结构 `source`
--

CREATE TABLE `source` (
  `id` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `crate_at` int(20) NOT NULL,
  `update_at` int(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `source`
--

INSERT INTO `source` (`id`, `name`, `crate_at`, `update_at`) VALUES
(4, 'admin', 1500883462, 1500883462);

-- --------------------------------------------------------

--
-- 表的结构 `test`
--

CREATE TABLE `test` (
  `id` int(10) NOT NULL,
  `test` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `test`
--

INSERT INTO `test` (`id`, `test`) VALUES
(1, '123');

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `upload`
--

INSERT INTO `upload` (`id`, `real_name`, `file_name`, `thumb_name`, `file_ext`, `file_mime`, `file_size`, `md5`, `sha1`, `down_count`, `created_at`, `updated_at`) VALUES
(1, 'img_3.jpg', 'uploads/image/201704/170410_093213_7943.jpg', 'uploads/thumb/201704/170410_093213_7943.jpg', 'jpg', 'image/jpeg', 200913, '338a8d7c37f895e7aff3be9ad409b817', 'bc784edb77fb52c7144acc45aa52f2885049e21f', 0, 1491787933, 1491787933),
(2, '123.jpg', 'uploads/image/201707/170722_220928_2294.jpg', 'uploads/thumb/201707/170722_220928_2294.jpg', 'jpg', 'image/jpeg', 30226, '9f8344c89c4e7d50b70e8c636d4ebe6a', 'f955c737b33db9cf3d3fc4844a4c97248d177918', 0, 1500732568, 1500732568),
(3, '123.jpg', 'uploads/image/201707/170722_221016_7552.jpg', 'uploads/thumb/201707/170722_221016_7552.jpg', 'jpg', 'image/jpeg', 30226, '9f8344c89c4e7d50b70e8c636d4ebe6a', 'f955c737b33db9cf3d3fc4844a4c97248d177918', 0, 1500732616, 1500732616),
(4, '123.jpg', 'uploads/image/201707/170722_221248_7235.jpg', 'uploads/thumb/201707/170722_221248_7235.jpg', 'jpg', 'image/jpeg', 30226, '9f8344c89c4e7d50b70e8c636d4ebe6a', 'f955c737b33db9cf3d3fc4844a4c97248d177918', 0, 1500732768, 1500732768),
(5, '123.jpg', 'uploads/image/201707/170722_221747_7106.jpg', 'uploads/thumb/201707/170722_221747_7106.jpg', 'jpg', 'image/jpeg', 30226, '9f8344c89c4e7d50b70e8c636d4ebe6a', 'f955c737b33db9cf3d3fc4844a4c97248d177918', 0, 1500733067, 1500733067),
(6, '123.jpg', 'uploads/image/201707/170722_222213_5416.jpg', 'uploads/thumb/201707/170722_222213_5416.jpg', 'jpg', 'image/jpeg', 30226, '9f8344c89c4e7d50b70e8c636d4ebe6a', 'f955c737b33db9cf3d3fc4844a4c97248d177918', 0, 1500733333, 1500733333),
(7, '123.jpg', 'uploads/image/201707/170722_222239_2557.jpg', 'uploads/thumb/201707/170722_222239_2557.jpg', 'jpg', 'image/jpeg', 30226, '9f8344c89c4e7d50b70e8c636d4ebe6a', 'f955c737b33db9cf3d3fc4844a4c97248d177918', 0, 1500733359, 1500733359),
(8, '123.jpg', 'uploads/image/201707/170722_222612_5676.jpg', 'uploads/thumb/201707/170722_222612_5676.jpg', 'jpg', 'image/jpeg', 30226, '9f8344c89c4e7d50b70e8c636d4ebe6a', 'f955c737b33db9cf3d3fc4844a4c97248d177918', 0, 1500733572, 1500733572),
(9, '123.jpg', 'uploads/image/201707/170722_222651_1989.jpg', 'uploads/thumb/201707/170722_222651_1989.jpg', 'jpg', 'image/jpeg', 30226, '9f8344c89c4e7d50b70e8c636d4ebe6a', 'f955c737b33db9cf3d3fc4844a4c97248d177918', 0, 1500733611, 1500733611),
(10, '123.jpg', 'uploads/image/201707/170722_222828_7665.jpg', 'uploads/thumb/201707/170722_222828_7665.jpg', 'jpg', 'image/jpeg', 30226, '9f8344c89c4e7d50b70e8c636d4ebe6a', 'f955c737b33db9cf3d3fc4844a4c97248d177918', 0, 1500733708, 1500733708),
(11, '123.jpg', 'uploads/image/201707/170722_222843_2394.jpg', 'uploads/thumb/201707/170722_222843_2394.jpg', 'jpg', 'image/jpeg', 30226, '9f8344c89c4e7d50b70e8c636d4ebe6a', 'f955c737b33db9cf3d3fc4844a4c97248d177918', 0, 1500733723, 1500733723),
(12, '1题.png', 'uploads/image/201707/170724_130005_4943.png', 'uploads/thumb/201707/170724_130005_4943.png', 'png', 'image/png', 1324352, '9ba9231e67d817b8174f2ccaa922cb08', 'c80c4c55c471f9dc9d2dd6af533c5c8d96dab369', 0, 1500872405, 1500872405),
(13, '藏云logo.jpg', 'uploads/image/201707/170724_130110_7226.jpg', 'uploads/thumb/201707/170724_130110_7226.jpg', 'jpg', 'image/jpeg', 323170, '830e37a876863d5e5419e6cc2dbc7cc4', '896e34d454c2b5b71376aa9374a7d4cde26fe4cc', 0, 1500872470, 1500872470),
(14, '藏云logo.jpg', 'uploads/image/201707/170724_130214_3594.jpg', 'uploads/thumb/201707/170724_130214_3594.jpg', 'jpg', 'image/jpeg', 323170, '830e37a876863d5e5419e6cc2dbc7cc4', '896e34d454c2b5b71376aa9374a7d4cde26fe4cc', 0, 1500872534, 1500872534),
(15, '藏云logo.jpg', 'uploads/image/201707/170724_130239_8620.jpg', 'uploads/thumb/201707/170724_130239_8620.jpg', 'jpg', 'image/jpeg', 323170, '830e37a876863d5e5419e6cc2dbc7cc4', '896e34d454c2b5b71376aa9374a7d4cde26fe4cc', 0, 1500872559, 1500872559),
(16, '藏云logo.jpg', 'uploads/image/201707/170724_130310_9043.jpg', 'uploads/thumb/201707/170724_130310_9043.jpg', 'jpg', 'image/jpeg', 323170, '830e37a876863d5e5419e6cc2dbc7cc4', '896e34d454c2b5b71376aa9374a7d4cde26fe4cc', 0, 1500872590, 1500872590),
(17, 'rwft.jpg', 'uploads/image/201707/170724_143638_5456.jpg', 'uploads/thumb/201707/170724_143638_5456.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500878198, 1500878198),
(18, 'bg1.png', 'uploads/image/201707/170724_144058_1635.png', 'uploads/thumb/201707/170724_144058_1635.png', 'png', 'image/png', 70284, '873e2c72ea9e0b3247fefef86ae12f91', '5a69f749cd554029df9bb6e536c6667deaf5d6e0', 0, 1500878458, 1500878458),
(19, 'rwft.jpg', 'uploads/image/201707/170724_144214_3996.jpg', 'uploads/thumb/201707/170724_144214_3996.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500878534, 1500878534),
(20, 'rwft.jpg', 'uploads/image/201707/170724_144318_4154.jpg', 'uploads/thumb/201707/170724_144318_4154.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500878598, 1500878598),
(21, 'rwft.jpg', 'uploads/image/201707/170724_144427_2278.jpg', 'uploads/thumb/201707/170724_144427_2278.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500878667, 1500878667),
(22, 'rwft.jpg', 'uploads/image/201707/170724_144442_2852.jpg', 'uploads/thumb/201707/170724_144442_2852.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500878682, 1500878682),
(23, 'rwft.jpg', 'uploads/image/201707/170724_144523_6984.jpg', 'uploads/thumb/201707/170724_144523_6984.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500878723, 1500878723),
(24, 'rwft.jpg', 'uploads/image/201707/170724_144603_2291.jpg', 'uploads/thumb/201707/170724_144603_2291.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500878763, 1500878763),
(25, 'rwft.jpg', 'uploads/image/201707/170724_144621_3741.jpg', 'uploads/thumb/201707/170724_144621_3741.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500878781, 1500878781),
(26, 'rwft.jpg', 'uploads/image/201707/170724_144652_6576.jpg', 'uploads/thumb/201707/170724_144652_6576.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500878812, 1500878812),
(27, 'rwft.jpg', 'uploads/image/201707/170724_144715_1193.jpg', 'uploads/thumb/201707/170724_144715_1193.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500878835, 1500878835),
(28, 'bg1.png', 'uploads/image/201707/170724_145439_8034.png', 'uploads/thumb/201707/170724_145439_8034.png', 'png', 'image/png', 70284, '873e2c72ea9e0b3247fefef86ae12f91', '5a69f749cd554029df9bb6e536c6667deaf5d6e0', 0, 1500879280, 1500879280),
(29, '0ef71cf5a299412cbbd32f85898ceb52.PNG', 'uploads/image/201707/170724_145602_9368.png', 'uploads/thumb/201707/170724_145602_9368.png', 'png', 'image/png', 1931, '37a8e4da546a1f3fe24f6cdb9d11da8f', '1ec6f3406f7acfa79ed2b3a475fa487ea9b55e0d', 0, 1500879362, 1500879362),
(30, 'rwft.jpg', 'uploads/image/201707/170724_145612_4960.jpg', 'uploads/thumb/201707/170724_145612_4960.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500879372, 1500879372),
(31, 'rwft.jpg', 'uploads/image/201707/170724_145624_1987.jpg', 'uploads/thumb/201707/170724_145624_1987.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500879384, 1500879384),
(32, 'bg1.png', 'uploads/image/201707/170724_153139_4131.png', 'uploads/thumb/201707/170724_153139_4131.png', 'png', 'image/png', 70284, '873e2c72ea9e0b3247fefef86ae12f91', '5a69f749cd554029df9bb6e536c6667deaf5d6e0', 0, 1500881499, 1500881499),
(33, 'bg1.png', 'uploads/image/201707/170724_154548_7867.png', 'uploads/thumb/201707/170724_154548_7867.png', 'png', 'image/png', 70284, '873e2c72ea9e0b3247fefef86ae12f91', '5a69f749cd554029df9bb6e536c6667deaf5d6e0', 0, 1500882348, 1500882348),
(34, 'rwft.jpg', 'uploads/image/201707/170724_155544_2499.jpg', 'uploads/thumb/201707/170724_155544_2499.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500882945, 1500882945),
(35, 'rwft.jpg', 'uploads/image/201707/170724_161730_4814.jpg', 'uploads/thumb/201707/170724_161730_4814.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500884250, 1500884250),
(36, '0ef71cf5a299412cbbd32f85898ceb52.PNG', 'uploads/image/201707/170724_174819_2353.png', 'uploads/thumb/201707/170724_174819_2353.png', 'png', 'image/png', 1931, '37a8e4da546a1f3fe24f6cdb9d11da8f', '1ec6f3406f7acfa79ed2b3a475fa487ea9b55e0d', 0, 1500889699, 1500889699),
(37, 'bg1.png', 'uploads/image/201707/170724_174819_9993.png', 'uploads/thumb/201707/170724_174819_9993.png', 'png', 'image/png', 70284, '873e2c72ea9e0b3247fefef86ae12f91', '5a69f749cd554029df9bb6e536c6667deaf5d6e0', 0, 1500889699, 1500889699),
(38, 'rwft.jpg', 'uploads/image/201707/170724_174819_4895.jpg', 'uploads/thumb/201707/170724_174819_4895.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500889699, 1500889699),
(39, 'rwft.jpg', 'uploads/image/201707/170724_174947_1169.jpg', 'uploads/thumb/201707/170724_174947_1169.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500889787, 1500889787),
(40, 'bg1.png', 'uploads/image/201707/170724_174947_4297.png', 'uploads/thumb/201707/170724_174947_4297.png', 'png', 'image/png', 70284, '873e2c72ea9e0b3247fefef86ae12f91', '5a69f749cd554029df9bb6e536c6667deaf5d6e0', 0, 1500889787, 1500889787),
(41, '0ef71cf5a299412cbbd32f85898ceb52.PNG', 'uploads/image/201707/170724_174947_2821.png', 'uploads/thumb/201707/170724_174947_2821.png', 'png', 'image/png', 1931, '37a8e4da546a1f3fe24f6cdb9d11da8f', '1ec6f3406f7acfa79ed2b3a475fa487ea9b55e0d', 0, 1500889787, 1500889787),
(42, 'rwft.jpg', 'uploads/image/201707/170725_091520_7498.jpg', 'uploads/thumb/201707/170725_091520_7498.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1500945320, 1500945320),
(43, 'bg1.png', 'uploads/image/201707/170725_092827_2955.png', 'uploads/thumb/201707/170725_092827_2955.png', 'png', 'image/png', 70284, '873e2c72ea9e0b3247fefef86ae12f91', '5a69f749cd554029df9bb6e536c6667deaf5d6e0', 0, 1500946107, 1500946107),
(44, '0ef71cf5a299412cbbd32f85898ceb52.PNG', 'uploads/image/201707/170725_093204_4588.png', 'uploads/thumb/201707/170725_093204_4588.png', 'png', 'image/png', 1931, '37a8e4da546a1f3fe24f6cdb9d11da8f', '1ec6f3406f7acfa79ed2b3a475fa487ea9b55e0d', 0, 1500946324, 1500946324),
(45, 'bg1.png', 'uploads/image/201707/170725_095246_9625.png', 'uploads/thumb/201707/170725_095246_9625.png', 'png', 'image/png', 70284, '873e2c72ea9e0b3247fefef86ae12f91', '5a69f749cd554029df9bb6e536c6667deaf5d6e0', 0, 1500947566, 1500947566),
(46, '1194973045f91a108fo.jpg', 'uploads/image/201707/170725_111443_1991.jpg', 'uploads/thumb/201707/170725_111443_1991.jpg', 'jpg', 'image/jpeg', 1453876, '5e19a4668a3137f1cb1f0b4a13e4e4c4', 'a90527bf83fa142f835fecb440cbb7cff756ab46', 0, 1500952484, 1500952484),
(47, '5286.jpg', 'uploads/image/201707/170725_111455_9900.jpg', 'uploads/thumb/201707/170725_111455_9900.jpg', 'jpg', 'image/jpeg', 1745531, '46b67ac250dbc6c2c472065cce8b317d', '04e70a03ee8e49c2f8d0fa650bedb4c3de08bcff', 0, 1500952495, 1500952495),
(48, '12.png', 'uploads/image/201707/170726_100557_1115.png', 'uploads/thumb/201707/170726_100557_1115.png', 'png', 'image/jpeg', 1453876, '5e19a4668a3137f1cb1f0b4a13e4e4c4', 'a90527bf83fa142f835fecb440cbb7cff756ab46', 0, 1501034757, 1501034757),
(49, '5286.jpg', 'uploads/image/201707/170726_100731_7810.jpg', 'uploads/thumb/201707/170726_100731_7810.jpg', 'jpg', 'image/jpeg', 1745531, '46b67ac250dbc6c2c472065cce8b317d', '04e70a03ee8e49c2f8d0fa650bedb4c3de08bcff', 0, 1501034851, 1501034851),
(50, '12.png', 'uploads/image/201707/170726_100833_8203.png', 'uploads/thumb/201707/170726_100833_8203.png', 'png', 'image/jpeg', 1453876, '5e19a4668a3137f1cb1f0b4a13e4e4c4', 'a90527bf83fa142f835fecb440cbb7cff756ab46', 0, 1501034913, 1501034913),
(51, '5286.jpg', 'uploads/image/201707/170726_100913_1578.jpg', 'uploads/thumb/201707/170726_100913_1578.jpg', 'jpg', 'image/jpeg', 1745531, '46b67ac250dbc6c2c472065cce8b317d', '04e70a03ee8e49c2f8d0fa650bedb4c3de08bcff', 0, 1501034953, 1501034953),
(52, '5286.jpg', 'uploads/image/201707/170726_100950_3396.jpg', 'uploads/thumb/201707/170726_100950_3396.jpg', 'jpg', 'image/jpeg', 1745531, '46b67ac250dbc6c2c472065cce8b317d', '04e70a03ee8e49c2f8d0fa650bedb4c3de08bcff', 0, 1501034990, 1501034990),
(53, '12.png', 'uploads/image/201707/170726_102650_8032.png', 'uploads/thumb/201707/170726_102650_8032.png', 'png', 'image/jpeg', 1453876, '5e19a4668a3137f1cb1f0b4a13e4e4c4', 'a90527bf83fa142f835fecb440cbb7cff756ab46', 0, 1501036010, 1501036010),
(54, '12.png', 'uploads/image/201707/170726_103044_1348.png', 'uploads/thumb/201707/170726_103044_1348.png', 'png', 'image/jpeg', 1453876, '5e19a4668a3137f1cb1f0b4a13e4e4c4', 'a90527bf83fa142f835fecb440cbb7cff756ab46', 0, 1501036244, 1501036244),
(55, 'rwft.jpg', 'uploads/image/201707/170726_161013_9663.jpg', 'uploads/thumb/201707/170726_161013_9663.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1501056613, 1501056613),
(56, 'rwft.jpg', 'uploads/image/201707/170726_161537_8495.jpg', 'uploads/thumb/201707/170726_161537_8495.jpg', 'jpg', 'image/jpeg', 10530, '89d6bec35b661b5656a6fbc6473c37cf', '0755e112ad29947b452d2bf1619c963ced766468', 0, 1501056937, 1501056937),
(57, 'about-img.png', 'uploads/image/201707/170727_154052_7631.png', 'uploads/thumb/201707/170727_154052_7631.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501141252, 1501141252),
(58, 'about-img.png', 'uploads/image/201707/170727_154535_8145.png', 'uploads/thumb/201707/170727_154535_8145.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501141535, 1501141535),
(59, 'about-img.png', 'uploads/image/201707/170727_164838_2212.png', 'uploads/thumb/201707/170727_164838_2212.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501145318, 1501145318),
(60, '20161017luoddn.jpg', 'uploads/image/201707/170727_174311_8008.jpg', 'uploads/thumb/201707/170727_174311_8008.jpg', 'jpg', 'image/jpeg', 534526, '02de6ebabfe3ef7e5fce498c64f581bf', 'cfa171f10a88e85deb0588af8828fcd8187b4781', 0, 1501148591, 1501148591),
(61, '20161017pjhfbq.jpg', 'uploads/image/201707/170727_174344_4571.jpg', 'uploads/thumb/201707/170727_174344_4571.jpg', 'jpg', 'image/jpeg', 347973, 'a4863b6fa107f0c4c6006c2249a99941', '4155613c30e0342ec24ae7334d9409676c818368', 0, 1501148624, 1501148624),
(62, '14984415749447.jpg', 'uploads/image/201707/170728_095231_5530.jpg', '', 'jpg', NULL, 162406, '69d16fe42765bf60a705dd3f58ebfb59', '74cf9887be47b93c6f2f5d2ff4e5dbe6149563e3', 0, 1501206751, 1501206751),
(63, '14984415967918.jpg', 'uploads/image/201707/170728_095232_4651.jpg', '', 'jpg', NULL, 133881, '95c1e5b5c3d09531e0c5bd3c634087ef', '5c8aeb8def2ba3912db64bd89409d651d50d3931', 0, 1501206752, 1501206752),
(64, 'about-img.png', 'uploads/image/201707/170728_095236_6342.png', 'uploads/thumb/201707/170728_095236_6342.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501206756, 1501206756),
(65, '14984415749447.jpg', 'uploads/image/201707/170728_095340_7572.jpg', 'uploads/thumb/201707/170728_095340_7572.jpg', 'jpg', 'image/jpeg', 162406, '69d16fe42765bf60a705dd3f58ebfb59', '74cf9887be47b93c6f2f5d2ff4e5dbe6149563e3', 0, 1501206820, 1501206820),
(66, 'about-img.png', 'uploads/image/201707/170728_095347_7467.png', 'uploads/thumb/201707/170728_095347_7467.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501206827, 1501206827),
(67, '14984415967918.jpg', 'uploads/image/201707/170728_095353_6137.jpg', 'uploads/thumb/201707/170728_095353_6137.jpg', 'jpg', 'image/jpeg', 133881, '95c1e5b5c3d09531e0c5bd3c634087ef', '5c8aeb8def2ba3912db64bd89409d651d50d3931', 0, 1501206833, 1501206833),
(68, 'about-img.png', 'uploads/image/201707/170728_095420_2190.png', 'uploads/thumb/201707/170728_095420_2190.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501206860, 1501206860),
(69, '14984415749447.jpg', 'uploads/image/201707/170728_095613_2651.jpg', 'uploads/thumb/201707/170728_095613_2651.jpg', 'jpg', 'image/jpeg', 162406, '69d16fe42765bf60a705dd3f58ebfb59', '74cf9887be47b93c6f2f5d2ff4e5dbe6149563e3', 0, 1501206973, 1501206973),
(70, '14984419079364.jpg', 'uploads/image/201707/170728_095920_2243.jpg', 'uploads/thumb/201707/170728_095920_2243.jpg', 'jpg', 'image/jpeg', 124118, 'b556ab6ac7ad79e64f44aa209dd19d12', '00bb2150f8b9387444e539634e78a44f2268c53e', 0, 1501207160, 1501207160),
(71, '14984419079364.jpg', 'uploads/image/201707/170728_095930_2190.jpg', '', 'jpg', NULL, 124118, 'b556ab6ac7ad79e64f44aa209dd19d12', '00bb2150f8b9387444e539634e78a44f2268c53e', 0, 1501207170, 1501207170),
(72, '14984419231077.jpg', 'uploads/image/201707/170728_095931_5108.jpg', '', 'jpg', NULL, 99975, '9456d195b7b4393da89267a185dc03c1', '0e6903a421105ca3f3ab459c1c921badfa73abec', 0, 1501207171, 1501207171),
(73, '14984419079364.jpg', 'uploads/image/201707/170728_095947_3105.jpg', 'uploads/thumb/201707/170728_095947_3105.jpg', 'jpg', 'image/jpeg', 124118, 'b556ab6ac7ad79e64f44aa209dd19d12', '00bb2150f8b9387444e539634e78a44f2268c53e', 0, 1501207187, 1501207187),
(74, '14984419231077.jpg', 'uploads/image/201707/170728_100000_3802.jpg', 'uploads/thumb/201707/170728_100000_3802.jpg', 'jpg', 'image/jpeg', 99975, '9456d195b7b4393da89267a185dc03c1', '0e6903a421105ca3f3ab459c1c921badfa73abec', 0, 1501207200, 1501207200),
(75, '微信图片_20170728100855.png', 'uploads/image/201707/170728_101208_1159.png', 'uploads/thumb/201707/170728_101208_1159.png', 'png', 'image/png', 172804, '5e723c23124cfdfef441f0ef79d1469b', 'e27effacbef53c862de1c2d2bc646bd169567847', 0, 1501207928, 1501207928),
(76, '2600828784824117277.jpg', 'uploads/image/201707/170728_101605_2468.jpg', 'uploads/thumb/201707/170728_101605_2468.jpg', 'jpg', 'image/jpeg', 374952, '797284b65cd2cebdf5bb8626ce24c92e', 'e3549eda3721499c19b0c65a4491835cf8989814', 0, 1501208165, 1501208165),
(77, '1194973045f91a108fo.jpg', 'uploads/image/201707/170728_101902_6587.jpg', 'uploads/thumb/201707/170728_101902_6587.jpg', 'jpg', 'image/jpeg', 320758, '689df73ec9358315d0f97a8ccbe8ea44', '3a88682c93a47779aa2d35db893b8092f316c527', 0, 1501208342, 1501208342),
(78, 'forum-banner.png', 'uploads/image/201707/170728_104739_5441.png', 'uploads/thumb/201707/170728_104739_5441.png', 'png', 'image/png', 299126, '0659b600d708988cc76c5ef9e6de6a05', '80a24d5ea4cfa41680405b618415efd00aa8a1c7', 0, 1501210059, 1501210059),
(79, 'club-banner.png', 'uploads/image/201707/170728_104852_5315.png', 'uploads/thumb/201707/170728_104852_5315.png', 'png', 'image/png', 421272, 'b696473521b4078b661e52e6ab2f1891', '9c7927f3f422e14527e795610f7c4063fe25f2e9', 0, 1501210132, 1501210132),
(80, 'forum-banner.png', 'uploads/image/201707/170728_104905_6728.png', 'uploads/thumb/201707/170728_104905_6728.png', 'png', 'image/png', 299126, '0659b600d708988cc76c5ef9e6de6a05', '80a24d5ea4cfa41680405b618415efd00aa8a1c7', 0, 1501210145, 1501210145),
(81, 'about-img.png', 'backend/web/uploads/image/201707/170728_110854_4387.png', 'backend/web/uploads/thumb/201707/170728_110854_4387.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501211334, 1501211334),
(82, 'about-img.png', 'backend/web/uploads/image/201707/170728_111427_2322.png', 'backend/web/uploads/thumb/201707/170728_111427_2322.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501211667, 1501211667),
(83, 'club-banner.png', 'uploads/image/201707/170728_111852_1155.png', 'uploads/thumb/201707/170728_111852_1155.png', 'png', 'image/png', 421272, 'b696473521b4078b661e52e6ab2f1891', '9c7927f3f422e14527e795610f7c4063fe25f2e9', 0, 1501211932, 1501211932),
(84, 'club-banner.png', 'uploads/image/201707/170728_111941_7419.png', 'uploads/thumb/201707/170728_111941_7419.png', 'png', 'image/png', 421272, 'b696473521b4078b661e52e6ab2f1891', '9c7927f3f422e14527e795610f7c4063fe25f2e9', 0, 1501211981, 1501211981),
(85, 'bg1.png', 'backend/web/uploads/image/201707/170728_112123_4973.png', 'backend/web/uploads/thumb/201707/170728_112123_4973.png', 'png', 'image/png', 70284, '873e2c72ea9e0b3247fefef86ae12f91', '5a69f749cd554029df9bb6e536c6667deaf5d6e0', 0, 1501212083, 1501212083),
(86, 'about-img.png', 'backend/web/uploads/image/201707/170728_154659_6385.png', 'backend/web/uploads/thumb/201707/170728_154659_6385.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501228019, 1501228019),
(87, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_101439_6284.png', 'backend/web/uploads/thumb/201707/170731_101439_6284.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501467279, 1501467279),
(88, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_102413_2863.png', 'backend/web/uploads/thumb/201707/170731_102413_2863.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501467853, 1501467853),
(89, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_103102_2105.png', 'backend/web/uploads/thumb/201707/170731_103102_2105.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501468263, 1501468263),
(90, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_103533_4049.png', 'backend/web/uploads/thumb/201707/170731_103533_4049.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501468533, 1501468533),
(91, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_111736_5064.png', 'backend/web/uploads/thumb/201707/170731_111736_5064.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501471056, 1501471056),
(92, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_115405_8909.png', 'backend/web/uploads/thumb/201707/170731_115405_8909.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501473246, 1501473246),
(93, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_120102_9297.png', 'backend/web/uploads/thumb/201707/170731_120102_9297.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501473662, 1501473662),
(94, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_120116_5801.png', 'backend/web/uploads/thumb/201707/170731_120116_5801.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501473676, 1501473676),
(95, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_120500_2797.png', 'backend/web/uploads/thumb/201707/170731_120500_2797.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501473901, 1501473901),
(96, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_120651_1774.png', 'backend/web/uploads/thumb/201707/170731_120651_1774.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501474012, 1501474012),
(97, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_120751_2088.png', 'backend/web/uploads/thumb/201707/170731_120751_2088.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501474071, 1501474071),
(98, '170728_095420_2190.png', 'backend/web/uploads/image/201707/170731_120819_6361.png', 'backend/web/uploads/thumb/201707/170731_120819_6361.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501474099, 1501474099),
(99, 'about-img.png', 'uploads/image/201707/170731_133943_5207.png', 'uploads/thumb/201707/170731_133943_5207.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501479583, 1501479583),
(100, 'club-banner.png', 'uploads/image/201707/170731_133950_1823.png', 'uploads/thumb/201707/170731_133950_1823.png', 'png', 'image/png', 421272, 'b696473521b4078b661e52e6ab2f1891', '9c7927f3f422e14527e795610f7c4063fe25f2e9', 0, 1501479590, 1501479590),
(101, 'club-banner.png', 'uploads/image/201707/170731_134820_5568.png', 'uploads/thumb/201707/170731_134820_5568.png', 'png', 'image/png', 421272, 'b696473521b4078b661e52e6ab2f1891', '9c7927f3f422e14527e795610f7c4063fe25f2e9', 0, 1501480100, 1501480100),
(102, 'about-img.png', 'uploads/image/201707/170731_135013_7823.png', 'uploads/thumb/201707/170731_135013_7823.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501480213, 1501480213),
(103, 'about-img.png', 'uploads/image/201707/170731_135249_5785.png', 'uploads/thumb/201707/170731_135249_5785.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501480369, 1501480369),
(104, 'about-img.png', 'uploads/image/201707/170731_135552_3290.png', 'uploads/thumb/201707/170731_135552_3290.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501480552, 1501480552),
(105, 'club-banner.png', 'uploads/image/201707/170731_135652_2298.png', 'uploads/thumb/201707/170731_135652_2298.png', 'png', 'image/png', 421272, 'b696473521b4078b661e52e6ab2f1891', '9c7927f3f422e14527e795610f7c4063fe25f2e9', 0, 1501480612, 1501480612),
(106, 'forum-banner.png', 'uploads/image/201707/170731_135801_4665.png', 'uploads/thumb/201707/170731_135801_4665.png', 'png', 'image/png', 299126, '0659b600d708988cc76c5ef9e6de6a05', '80a24d5ea4cfa41680405b618415efd00aa8a1c7', 0, 1501480681, 1501480681),
(107, 'club-banner.png', 'uploads/image/201707/170731_161615_5252.png', 'uploads/thumb/201707/170731_161615_5252.png', 'png', 'image/png', 421272, 'b696473521b4078b661e52e6ab2f1891', '9c7927f3f422e14527e795610f7c4063fe25f2e9', 0, 1501488975, 1501488975),
(108, '170728_095420_2190.png', 'uploads/image/201707/170731_163214_7003.png', 'uploads/thumb/201707/170731_163214_7003.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501489934, 1501489934),
(109, 'about-img.png', 'backend/web/uploads/image/201707/170731_171431_9747.png', 'backend/web/uploads/thumb/201707/170731_171431_9747.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501492471, 1501492471),
(110, 'club-banner.png', 'uploads/image/201707/170731_171921_6578.png', 'uploads/thumb/201707/170731_171921_6578.png', 'png', 'image/png', 421272, 'b696473521b4078b661e52e6ab2f1891', '9c7927f3f422e14527e795610f7c4063fe25f2e9', 0, 1501492761, 1501492761),
(111, '20161017luoddn.jpg', 'backend/web/uploads/image/201707/170731_172228_9760.jpg', 'backend/web/uploads/thumb/201707/170731_172228_9760.jpg', 'jpg', 'image/jpeg', 184212, '540cf899c5f219213f98170d00714fb1', '100ab6bf86fa38cd402bdd2b64cb6f35d3edf17a', 0, 1501492948, 1501492948),
(112, 'about-img.png', 'backend/web/uploads/image/201707/170731_172338_4841.png', 'backend/web/uploads/thumb/201707/170731_172338_4841.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501493018, 1501493018),
(113, 'about-img.png', 'uploads/image/201707/170731_172809_3734.png', 'uploads/thumb/201707/170731_172809_3734.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501493289, 1501493289),
(114, '20161017pjhfbq.jpg', 'backend/web/uploads/image/201707/170731_173102_2496.jpg', 'backend/web/uploads/thumb/201707/170731_173102_2496.jpg', 'jpg', 'image/jpeg', 129817, '49146ee27a982c99a0a59987d2892c35', 'b4583ed29051e4fc2917d98180f92619718a796e', 0, 1501493462, 1501493462),
(115, 'about-img.png', 'uploads/image/201707/170731_173344_7197.png', 'uploads/thumb/201707/170731_173344_7197.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501493624, 1501493624),
(116, 'about-img.png', './uploads/image/201707/170731_173609_7896.png', './uploads/thumb/201707/170731_173609_7896.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501493769, 1501493769),
(117, 'about-img.png', './uploads/image/201707/170731_173648_7850.png', './uploads/thumb/201707/170731_173648_7850.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501493808, 1501493808),
(118, 'about-img.png', 'backend/web/uploads/image/201707/170731_173758_6335.png', 'backend/web/uploads/thumb/201707/170731_173758_6335.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501493878, 1501493878),
(119, 'bg1.png', './backend/web/uploads/image/201708/170801_092111_8919.png', './backend/web/uploads/thumb/201708/170801_092111_8919.png', 'png', 'image/png', 70284, '873e2c72ea9e0b3247fefef86ae12f91', '5a69f749cd554029df9bb6e536c6667deaf5d6e0', 0, 1501550472, 1501550472),
(120, 'club-banner.png', 'backend/web/uploads/image/201708/170801_094143_3992.png', 'backend/web/uploads/thumb/201708/170801_094143_3992.png', 'png', 'image/png', 421272, 'b696473521b4078b661e52e6ab2f1891', '9c7927f3f422e14527e795610f7c4063fe25f2e9', 0, 1501551703, 1501551703),
(121, '20161017pjhfbq.jpg', 'backend/web/uploads/image/201708/170801_094342_8074.jpg', 'backend/web/uploads/thumb/201708/170801_094342_8074.jpg', 'jpg', 'image/jpeg', 129817, '49146ee27a982c99a0a59987d2892c35', 'b4583ed29051e4fc2917d98180f92619718a796e', 0, 1501551822, 1501551822),
(122, '20161017luoddn.jpg', 'backend/web/uploads/image/201708/170801_094520_6601.jpg', 'backend/web/uploads/thumb/201708/170801_094520_6601.jpg', 'jpg', 'image/jpeg', 184212, '540cf899c5f219213f98170d00714fb1', '100ab6bf86fa38cd402bdd2b64cb6f35d3edf17a', 0, 1501551920, 1501551920),
(123, '14903213859921.jpg', 'backend/web/uploads/image/201708/170801_100707_1614.jpg', 'backend/web/uploads/thumb/201708/170801_100707_1614.jpg', 'jpg', 'image/jpeg', 15983, 'c309afe08174f5368acb017b336c5a5a', 'c8ae4e1649e1a52096982e1af02a5273b23f4803', 0, 1501553227, 1501553227),
(124, 'about-img.png', 'uploads/image/201708/170801_101446_3858.png', 'uploads/thumb/201708/170801_101446_3858.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501553686, 1501553686),
(125, 'team.jpg', 'uploads/image/201708/170801_144956_7490.jpg', 'uploads/thumb/201708/170801_144956_7490.jpg', 'jpg', 'image/jpeg', 93009, '0b51facc1cc25e7238f04f20ce56c519', '635b40408ff771d8ce2cb3dfc37121209e9da8d6', 0, 1501570196, 1501570196),
(126, 'about-img.png', 'uploads/image/201708/170801_150343_2846.png', 'uploads/thumb/201708/170801_150343_2846.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501571023, 1501571023),
(127, 'about-img.png', 'uploads/image/201708/170801_150549_6909.png', 'uploads/thumb/201708/170801_150549_6909.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501571149, 1501571149),
(128, 'about-img.png', 'uploads/image/201708/170801_150642_8997.png', 'uploads/thumb/201708/170801_150642_8997.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501571202, 1501571202),
(129, 'about-img.png', 'uploads/image/201708/170801_150820_2907.png', 'uploads/thumb/201708/170801_150820_2907.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501571300, 1501571300),
(130, 'about-img.png', 'uploads/image/201708/170801_151131_5604.png', 'uploads/thumb/201708/170801_151131_5604.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501571491, 1501571491),
(131, 'about-img.png', 'uploads/image/201708/170801_151337_3529.png', 'uploads/thumb/201708/170801_151337_3529.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501571617, 1501571617),
(132, 'about-img.png', 'uploads/image/201708/170801_151433_5731.png', 'uploads/thumb/201708/170801_151433_5731.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501571673, 1501571673),
(133, 'about-img.png', 'uploads/image/201708/170801_151727_7832.png', 'uploads/thumb/201708/170801_151727_7832.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501571847, 1501571847),
(134, 'about-img.png', 'uploads/image/201708/170801_151840_6994.png', 'uploads/thumb/201708/170801_151840_6994.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501571920, 1501571920),
(135, 'about-img.png', 'uploads/image/201708/170801_152502_2748.png', 'uploads/thumb/201708/170801_152502_2748.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501572302, 1501572302),
(136, '1494825178662.png', 'uploads/image/201708/170801_152711_9145.png', 'uploads/thumb/201708/170801_152711_9145.png', 'png', 'image/png', 625063, '2a1bf5a2543986ca1ce792cbdf714106', 'e55f3957c153a68a05d2dec4831876a5e6ceb65c', 0, 1501572431, 1501572431),
(137, '14948248211348.jpg', 'uploads/image/201708/170801_153113_5625.jpg', 'uploads/thumb/201708/170801_153113_5625.jpg', 'jpg', 'image/jpeg', 281176, 'f10ec79466ac79637837b6938abfe5fe', 'e759ba7bc7ba09cc43394a51bfe5c63f4cf2acc2', 0, 1501572673, 1501572673),
(138, 'about-img.png', 'uploads/image/201708/170801_153303_4866.png', 'uploads/thumb/201708/170801_153303_4866.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501572783, 1501572783),
(139, 'about-img.png', 'uploads/image/201708/170801_153928_7252.png', 'uploads/thumb/201708/170801_153928_7252.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501573168, 1501573168),
(140, '14902497429744.jpg', 'uploads/image/201708/170802_090937_9518.jpg', 'uploads/thumb/201708/170802_090937_9518.jpg', 'jpg', 'image/jpeg', 66060, 'd13de6f3ba94ac705dc6230181cf0c80', 'a3ae9b477090d99d042daf04927105366e3d1b8e', 0, 1501636177, 1501636177),
(141, '14902513937875.png', 'uploads/image/201708/170802_091321_9511.png', 'uploads/thumb/201708/170802_091321_9511.png', 'png', 'image/png', 625063, '2a1bf5a2543986ca1ce792cbdf714106', 'e55f3957c153a68a05d2dec4831876a5e6ceb65c', 0, 1501636401, 1501636401),
(142, '14939467516289.jpg', 'uploads/image/201708/170802_091535_4644.jpg', 'uploads/thumb/201708/170802_091535_4644.jpg', 'jpg', 'image/jpeg', 281176, 'f10ec79466ac79637837b6938abfe5fe', 'e759ba7bc7ba09cc43394a51bfe5c63f4cf2acc2', 0, 1501636535, 1501636535),
(143, '14902513937875.png', 'uploads/image/201708/170802_091739_1052.png', 'uploads/thumb/201708/170802_091739_1052.png', 'png', 'image/png', 625063, '2a1bf5a2543986ca1ce792cbdf714106', 'e55f3957c153a68a05d2dec4831876a5e6ceb65c', 0, 1501636660, 1501636660),
(144, '14902497429744.jpg', 'uploads/image/201708/170802_091850_7914.jpg', 'uploads/thumb/201708/170802_091850_7914.jpg', 'jpg', 'image/jpeg', 66060, 'd13de6f3ba94ac705dc6230181cf0c80', 'a3ae9b477090d99d042daf04927105366e3d1b8e', 0, 1501636730, 1501636730),
(145, '14938039429750.jpg', 'uploads/image/201708/170802_092735_2229.jpg', '', 'jpg', NULL, 16707, '3ebeb43a2380c8f538fec52a84d6903a', 'cfac0c8c68194539982c8de7ab83db6be02a45d8', 0, 1501637255, 1501637255),
(146, '170802_092735_2229.jpg', 'backend/web/uploads/image/201708/170802_092949_8230.jpg', 'backend/web/uploads/thumb/201708/170802_092949_8230.jpg', 'jpg', 'image/jpeg', 16707, '3ebeb43a2380c8f538fec52a84d6903a', 'cfac0c8c68194539982c8de7ab83db6be02a45d8', 0, 1501637389, 1501637389),
(147, '170728_095947_3105.jpg', 'backend/web/uploads/image/201708/170802_094304_6128.jpg', 'backend/web/uploads/thumb/201708/170802_094304_6128.jpg', 'jpg', 'image/jpeg', 124118, 'b556ab6ac7ad79e64f44aa209dd19d12', '00bb2150f8b9387444e539634e78a44f2268c53e', 0, 1501638185, 1501638185),
(148, '170728_100000_3802.jpg', 'backend/web/uploads/image/201708/170802_094314_4109.jpg', 'backend/web/uploads/thumb/201708/170802_094314_4109.jpg', 'jpg', 'image/jpeg', 99975, '9456d195b7b4393da89267a185dc03c1', '0e6903a421105ca3f3ab459c1c921badfa73abec', 0, 1501638194, 1501638194),
(149, '170728_095340_7572.jpg', 'backend/web/uploads/image/201708/170802_094559_5426.jpg', 'backend/web/uploads/thumb/201708/170802_094559_5426.jpg', 'jpg', 'image/jpeg', 162406, '69d16fe42765bf60a705dd3f58ebfb59', '74cf9887be47b93c6f2f5d2ff4e5dbe6149563e3', 0, 1501638359, 1501638359),
(150, '170728_095353_6137.jpg', 'backend/web/uploads/image/201708/170802_094611_4850.jpg', 'backend/web/uploads/thumb/201708/170802_094611_4850.jpg', 'jpg', 'image/jpeg', 133881, '95c1e5b5c3d09531e0c5bd3c634087ef', '5c8aeb8def2ba3912db64bd89409d651d50d3931', 0, 1501638371, 1501638371),
(151, '170728_095420_2190.png', 'uploads/image/201708/170802_104723_1818.png', 'uploads/thumb/201708/170802_104723_1818.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501642043, 1501642043),
(152, '170728_095420_2190.png', 'uploads/image/201708/170802_105658_7498.png', 'uploads/thumb/201708/170802_105658_7498.png', 'png', 'image/png', 540633, '86b083693e411410ed16fbc0d48a7b49', 'e7d4bf1882650e43bd1e184495776f5fc585ad76', 0, 1501642618, 1501642618),
(153, '14902497429744555 (1).jpg', 'uploads/image/201708/170802_105728_5037.jpg', 'uploads/thumb/201708/170802_105728_5037.jpg', 'jpg', 'image/jpeg', 66060, 'd13de6f3ba94ac705dc6230181cf0c80', 'a3ae9b477090d99d042daf04927105366e3d1b8e', 0, 1501642648, 1501642648),
(154, 'logo1.PNG', 'uploads/image/201709/170916_105953_2416.png', 'uploads/thumb/201709/170916_105953_2416.png', 'png', 'image/png', 229877, 'e8942eb3fa8317d6b8a3e6c854bebbb6', '01f584c9657c9f214a8f861552b72157f2e9df01', 0, 1505530793, 1505530793),
(155, 'logo1.PNG', 'uploads/image/201709/170916_110124_8914.png', 'uploads/thumb/201709/170916_110124_8914.png', 'png', 'image/png', 229877, 'e8942eb3fa8317d6b8a3e6c854bebbb6', '01f584c9657c9f214a8f861552b72157f2e9df01', 0, 1505530884, 1505530884),
(156, 'logo1.PNG', 'uploads/image/201709/170916_110234_4685.png', 'uploads/thumb/201709/170916_110234_4685.png', 'png', 'image/png', 229877, 'e8942eb3fa8317d6b8a3e6c854bebbb6', '01f584c9657c9f214a8f861552b72157f2e9df01', 0, 1505530954, 1505530954),
(157, 'logo1.PNG', 'uploads/image/201709/170916_110351_1564.png', 'uploads/thumb/201709/170916_110351_1564.png', 'png', 'image/png', 229877, 'e8942eb3fa8317d6b8a3e6c854bebbb6', '01f584c9657c9f214a8f861552b72157f2e9df01', 0, 1505531031, 1505531031),
(158, '2600828784824117277.jpg', 'uploads/image/201709/170916_110543_8373.jpg', 'uploads/thumb/201709/170916_110543_8373.jpg', 'jpg', 'image/jpeg', 374952, '797284b65cd2cebdf5bb8626ce24c92e', 'e3549eda3721499c19b0c65a4491835cf8989814', 0, 1505531144, 1505531144),
(159, '1194973045f91a108fo.jpg', 'uploads/image/201709/170916_111839_2339.jpg', 'uploads/thumb/201709/170916_111839_2339.jpg', 'jpg', 'image/jpeg', 1453876, '5e19a4668a3137f1cb1f0b4a13e4e4c4', 'a90527bf83fa142f835fecb440cbb7cff756ab46', 0, 1505531919, 1505531919),
(160, 'logo1.PNG', 'uploads/image/201709/170916_111915_1028.png', 'uploads/thumb/201709/170916_111915_1028.png', 'png', 'image/png', 229877, 'e8942eb3fa8317d6b8a3e6c854bebbb6', '01f584c9657c9f214a8f861552b72157f2e9df01', 0, 1505531955, 1505531955),
(161, 'logo1.PNG', 'uploads/image/201709/170916_140433_4638.png', 'uploads/thumb/201709/170916_140433_4638.png', 'png', 'image/png', 229877, 'e8942eb3fa8317d6b8a3e6c854bebbb6', '01f584c9657c9f214a8f861552b72157f2e9df01', 0, 1505541873, 1505541873),
(162, '2600828784824117277.jpg', 'uploads/image/201709/170916_140518_9469.jpg', 'uploads/thumb/201709/170916_140518_9469.jpg', 'jpg', 'image/jpeg', 374952, '797284b65cd2cebdf5bb8626ce24c92e', 'e3549eda3721499c19b0c65a4491835cf8989814', 0, 1505541918, 1505541918),
(163, '1194973045f91a108fo.jpg', 'uploads/image/201709/170916_140637_3833.jpg', 'uploads/thumb/201709/170916_140637_3833.jpg', 'jpg', 'image/jpeg', 1453876, '5e19a4668a3137f1cb1f0b4a13e4e4c4', 'a90527bf83fa142f835fecb440cbb7cff756ab46', 0, 1505541997, 1505541997),
(164, 'logo1.PNG', 'uploads/image/201709/170916_141002_9008.png', 'uploads/thumb/201709/170916_141002_9008.png', 'png', 'image/png', 229877, 'e8942eb3fa8317d6b8a3e6c854bebbb6', '01f584c9657c9f214a8f861552b72157f2e9df01', 0, 1505542202, 1505542202),
(165, '2600828784824117277.jpg', 'uploads/image/201709/170916_141843_9343.jpg', 'uploads/thumb/201709/170916_141843_9343.jpg', 'jpg', 'image/jpeg', 374952, '797284b65cd2cebdf5bb8626ce24c92e', 'e3549eda3721499c19b0c65a4491835cf8989814', 0, 1505542723, 1505542723),
(166, '5286.jpg', 'uploads/image/201709/170916_142139_3253.jpg', 'uploads/thumb/201709/170916_142139_3253.jpg', 'jpg', 'image/jpeg', 1745531, '46b67ac250dbc6c2c472065cce8b317d', '04e70a03ee8e49c2f8d0fa650bedb4c3de08bcff', 0, 1505542899, 1505542899),
(167, 'logo1.PNG', 'uploads/image/201709/170916_143244_3489.png', 'uploads/thumb/201709/170916_143244_3489.png', 'png', 'image/png', 229877, 'e8942eb3fa8317d6b8a3e6c854bebbb6', '01f584c9657c9f214a8f861552b72157f2e9df01', 0, 1505543564, 1505543564);

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `status`, `created_at`, `updated_at`) VALUES
(2, 'hzadmin', 'l84LDY2bvLnocYYeAtx1Z7rTq3vEu9fS', '$2y$13$ywwt2wTKZAZ6e31GhIKJTundTe6D4oHqzMifHPgrXGRUUil2QPqn6', NULL, '1234@qq.com', 10, 1501577682, 1501577682);

-- --------------------------------------------------------

--
-- 表的结构 `zc_webconfig`
--

CREATE TABLE `zc_webconfig` (
  `id` int(5) UNSIGNED NOT NULL,
  `type` varchar(20) NOT NULL COMMENT '配置类型:wechat表示微信公众号配置',
  `content` text NOT NULL COMMENT '序列化的数组字符串',
  `createtime` int(12) NOT NULL COMMENT '创建时间',
  `updatetime` int(12) NOT NULL COMMENT '更新时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='配置表(包含公众号配置和站点信息配置等)';

--
-- 转存表中的数据 `zc_webconfig`
--

INSERT INTO `zc_webconfig` (`id`, `type`, `content`, `createtime`, `updatetime`) VALUES
(6, 'web', 'a:13:{s:5:"_csrf";s:56:"djZ3MGprdGM0QRRlJV5ETh9bH2Q.BR4bIWA/SS9TIjIRTER0Cx0CAA==";s:7:"webname";s:33:"浙江省整形美容行业协会";s:7:"web_add";s:13:"www.zjapa.com";s:4:"host";s:33:"浙江省整形美容行业协会";s:11:"maintenance";s:33:"中国整形美容协会信息部";s:5:"phone";s:12:"0574-7331964";s:10:"wealth_add";s:42:"浙江省宁波市海曙区翠波路177号";s:4:"post";s:6:"100029";s:5:"email";s:18:"zjzxxh@capa.org.cn";s:3:"fax";s:12:"010-84280990";s:7:"recode1";s:19:"浙ICP备14047909-1";s:7:"recode2";s:42:"浙江省宁波市海曙区翠柏路117号";s:6:"submit";s:6:"提交";}', 1477409168, 1505544756);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `adminuser`
--
ALTER TABLE `adminuser`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `auth_assignment`
--
ALTER TABLE `auth_assignment`
  ADD PRIMARY KEY (`item_name`,`user_id`);

--
-- Indexes for table `auth_item`
--
ALTER TABLE `auth_item`
  ADD PRIMARY KEY (`name`),
  ADD KEY `rule_name` (`rule_name`),
  ADD KEY `idx-auth_item-type` (`type`);

--
-- Indexes for table `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD PRIMARY KEY (`parent`,`child`),
  ADD KEY `child` (`child`);

--
-- Indexes for table `auth_rule`
--
ALTER TABLE `auth_rule`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `display`
--
ALTER TABLE `display`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `message`
--
ALTER TABLE `message`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reply`
--
ALTER TABLE `reply`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `replyway`
--
ALTER TABLE `replyway`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slide`
--
ALTER TABLE `slide`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `source`
--
ALTER TABLE `source`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `upload`
--
ALTER TABLE `upload`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `password_reset_token` (`password_reset_token`);

--
-- Indexes for table `zc_webconfig`
--
ALTER TABLE `zc_webconfig`
  ADD PRIMARY KEY (`id`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `adminuser`
--
ALTER TABLE `adminuser`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- 使用表AUTO_INCREMENT `category`
--
ALTER TABLE `category`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;
--
-- 使用表AUTO_INCREMENT `display`
--
ALTER TABLE `display`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `images`
--
ALTER TABLE `images`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- 使用表AUTO_INCREMENT `message`
--
ALTER TABLE `message`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- 使用表AUTO_INCREMENT `news`
--
ALTER TABLE `news`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;
--
-- 使用表AUTO_INCREMENT `reply`
--
ALTER TABLE `reply`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `replyway`
--
ALTER TABLE `replyway`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `slide`
--
ALTER TABLE `slide`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- 使用表AUTO_INCREMENT `source`
--
ALTER TABLE `source`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `test`
--
ALTER TABLE `test`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `upload`
--
ALTER TABLE `upload`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID', AUTO_INCREMENT=168;
--
-- 使用表AUTO_INCREMENT `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `zc_webconfig`
--
ALTER TABLE `zc_webconfig`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- 限制导出的表
--

--
-- 限制表 `auth_item_child`
--
ALTER TABLE `auth_item_child`
  ADD CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
