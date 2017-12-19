-- MySQL dump 10.13  Distrib 5.7.19, for Linux (x86_64)
--
-- Host: localhost    Database: zhengxing
-- ------------------------------------------------------
-- Server version	5.7.19-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `adminuser`
--

DROP TABLE IF EXISTS `adminuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `adminuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `nickname` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `profile` text COLLATE utf8_unicode_ci,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `adminuser`
--

LOCK TABLES `adminuser` WRITE;
/*!40000 ALTER TABLE `adminuser` DISABLE KEYS */;
INSERT INTO `adminuser` VALUES (7,'admin','管理员','*','admin@qq.com','最大权限所有者','9fWACxHyjr7Wj6E-UXj9yg13ynoKM0-Y','$2y$13$DuxhcfRPrsWBBiAGx7MBOu0IFSyhGxrUZdRFWsZPWb/mMM6k1BeDq',NULL),(8,'article','文章发布员','*','123@qq.com','文章发布员','lfw5v4ZREepvuRGgoZw_IYFvWAfPmT0b','$2y$13$TzINnFGiuFyEMW671VwveOukyahNXXzLb/YAJ.OrWJ.UlON2hymK2',NULL);
/*!40000 ALTER TABLE `adminuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_assignment`
--

DROP TABLE IF EXISTS `auth_assignment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_assignment`
--

LOCK TABLES `auth_assignment` WRITE;
/*!40000 ALTER TABLE `auth_assignment` DISABLE KEYS */;
INSERT INTO `auth_assignment` VALUES ('admin','7',1505532566),('commentAuditor','1',1505483257),('commentAuditor','4',1465177361),('commentAuditor','6',1505484530),('commentAuditor','7',1505532566),('postAdmin','1',1505483257),('postAdmin','2',1477816632),('postAdmin','7',1505532566),('postAdmin','8',1505539758),('postOperator','1',1505483257),('postOperator','3',1465177361),('postOperator','7',1505532565);
/*!40000 ALTER TABLE `auth_assignment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_item`
--

DROP TABLE IF EXISTS `auth_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_item` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`),
  KEY `rule_name` (`rule_name`),
  KEY `idx-auth_item-type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_item`
--

LOCK TABLES `auth_item` WRITE;
/*!40000 ALTER TABLE `auth_item` DISABLE KEYS */;
INSERT INTO `auth_item` VALUES ('admin',1,'系统管理员',NULL,NULL,1465177361,1465177361),('approveComment',2,'审核评论',NULL,NULL,1465177361,1465177361),('createPost',2,'新增文章',NULL,NULL,1465177361,1465177361),('deletePost',2,'删除文章',NULL,NULL,1465177361,1465177361),('postAdmin',1,'文章管理员',NULL,NULL,1465177361,1465177361),('updatePost',2,'修改文章',NULL,NULL,1465177361,1465177361);
/*!40000 ALTER TABLE `auth_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_item_child`
--

DROP TABLE IF EXISTS `auth_item_child`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`),
  CONSTRAINT `auth_item_child_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `auth_item_child_ibfk_2` FOREIGN KEY (`child`) REFERENCES `auth_item` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_item_child`
--

LOCK TABLES `auth_item_child` WRITE;
/*!40000 ALTER TABLE `auth_item_child` DISABLE KEYS */;
INSERT INTO `auth_item_child` VALUES ('postAdmin','createPost'),('postAdmin','deletePost'),('admin','postAdmin'),('postAdmin','updatePost');
/*!40000 ALTER TABLE `auth_item_child` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_rule`
--

DROP TABLE IF EXISTS `auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_rule`
--

LOCK TABLES `auth_rule` WRITE;
/*!40000 ALTER TABLE `auth_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pid` int(10) DEFAULT NULL COMMENT '父级ID',
  `name` varchar(50) NOT NULL COMMENT '栏目名称',
  `bgimage` varchar(255) NOT NULL COMMENT '栏目背景图片',
  `display` int(10) NOT NULL COMMENT '是否展示（1发布2不发布3草稿）',
  `weight` int(10) NOT NULL DEFAULT '0' COMMENT '权重',
  `create_at` int(20) NOT NULL,
  `update_at` int(20) NOT NULL,
  `list_type` int(50) DEFAULT NULL COMMENT '展示类型（0 单页面 1 列表页 2 一级标题页面 3 文章列表 4 图片模型）',
  `remark` varchar(255) DEFAULT NULL COMMENT '栏目描述',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (84,84,'首页','uploads/image/201709/170920_140554_1038.jpg',1,0,1505543599,1505887557,0,NULL),(88,88,'机构审评','uploads/image/201709/170925_171712_6983.jpg',1,0,1505549266,1506331034,2,''),(100,89,'继续教育','uploads/image/201709/170925_171923_5991.jpg',1,0,1505886553,1506331166,3,'CONTINUING EDUCATION'),(87,87,'工作动态','uploads/image/201709/170925_171525_5436.jpg',1,0,1505549227,1506330928,2,''),(86,86,'协会信息','uploads/image/201709/170925_171649_7486.jpg',1,0,1505549204,1506331012,2,''),(89,89,'学术活动','uploads/image/201709/170925_171730_9049.jpg',1,0,1505549283,1506331053,2,''),(90,90,'行业论坛','uploads/image/201709/170925_171750_3878.jpg',1,0,1505549321,1506331073,2,''),(91,91,'二级机构','uploads/image/201709/170925_171840_5630.jpg',1,0,1505549408,1506331122,2,''),(92,92,'会员服务','uploads/image/201709/170925_171825_4742.jpg',1,0,1505549468,1506331107,2,''),(93,93,'会员风采','uploads/image/201709/170925_145833_5608.jpg',1,0,1505549515,1506322716,2,'MEMBER STYLE'),(94,86,'协会介绍','uploads/image/201709/170925_170005_1363.jpg',1,0,1505660033,1506330009,1,''),(95,86,'协会章程','uploads/image/201709/170925_170022_7358.jpg',1,0,1505660076,1506330024,1,''),(96,86,'组织机构','uploads/image/201709/170925_170036_5097.jpg',1,0,1505660097,1506330038,1,''),(97,86,'协会领导','uploads/image/201709/170925_170107_3399.jpg',1,0,1505660116,1506330071,1,''),(98,86,'规则制定','uploads/image/201709/170925_170122_7468.jpg',1,0,1505660139,1506330085,1,''),(99,86,'政策法规','uploads/image/201709/170925_170138_6913.jpg',1,0,1505660160,1506330101,1,'LAWS AND REGULATIONS'),(101,89,'专家栏','uploads/image/201709/170925_172028_2460.jpg',1,0,1505886878,1506331230,3,'EXPERT COLUMN'),(102,87,'整形资讯','uploads/image/201709/170925_171953_2381.jpg',1,0,1505887102,1506331196,3,'PLASTIC INFORMATION'),(103,87,'新闻发布','uploads/image/201709/170925_171432_3947.jpg',1,0,1505887563,1506330874,3,'NEWS RELEASE'),(104,87,'重要通知','uploads/image/201709/170925_171451_2138.jpg',1,0,1505887720,1506330893,3,'IMPORTANT NOTICE'),(105,105,'联系我们','uploads/image/201709/170925_145738_6542.jpg',1,0,1505894444,1506322661,4,''),(106,105,'电话地图','uploads/image/201709/170925_154333_9936.jpg',1,-1,1505894472,1506325416,4,''),(107,84,'服务大厅','',0,0,1506154179,1506154179,0,'Service Hall');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `display`
--

DROP TABLE IF EXISTS `display`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `display` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `display`
--

LOCK TABLES `display` WRITE;
/*!40000 ALTER TABLE `display` DISABLE KEYS */;
INSERT INTO `display` VALUES (1,'发布'),(2,'不发布'),(3,'草稿');
/*!40000 ALTER TABLE `display` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `images` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `img` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '图片路径',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '外链',
  `create_at` int(50) NOT NULL,
  `update_at` int(50) NOT NULL,
  `type` int(10) NOT NULL COMMENT '类型（1会员风采2友情链接）',
  `weight` int(10) DEFAULT NULL COMMENT '权重',
  `display` int(10) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `images`
--

LOCK TABLES `images` WRITE;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` VALUES (15,'uploads/image/201709/170927_110703_1860.jpg','http://baidu.com',1505550769,1506481626,1,1,1,NULL,''),(16,'uploads/image/201709/170927_110730_6019.jpg','www.baidu.com',1505550792,1506481652,1,0,1,NULL,''),(20,'uploads/image/201709/170923_091111_3786.png','www.baidu.com',1505553454,1506129073,2,3,1,NULL,NULL),(21,'uploads/image/201709/170916_171807_5356.jpg','www.baidu.com',1505553494,1506311954,2,5,1,NULL,'<p><img src=\"backend/web/uploads/image/201709/170925_115905_2149.jpg\" title=\"170925_115905_2149.jpg\" alt=\"微信图片_20170913092153.jpg\"/></p><p>123123</p>'),(22,'uploads/image/201709/170916_171839_2235.jpg','www.baidu.com',1505553524,1505553524,2,0,1,NULL,NULL),(23,'uploads/image/201709/170916_171858_5725.jpg','www.baidu.com',1505553543,1505553543,2,0,1,NULL,NULL),(27,'uploads/image/201709/170923_160309_3699.png','#',1506153805,1506169938,3,0,1,'完善中',NULL),(28,'uploads/image/201709/170923_160356_6439.png','#',1506153838,1506153838,3,0,1,'在线投诉',NULL),(29,'uploads/image/201709/170923_160429_3550.png','#',1506153871,1506153871,3,0,1,'下载专区',NULL),(30,'uploads/image/201709/170923_160447_9258.png','#',1506153902,1506153902,3,0,1,'机构查询',NULL),(31,'uploads/image/201709/170923_160538_4971.png','#',1506153940,1506153940,3,0,1,'新闻专区',NULL),(32,'uploads/image/201709/170923_160557_3491.png','#',1506153967,1506153967,3,0,1,'学术交流',NULL),(33,'uploads/image/201709/170923_160618_5779.png','#',1506153987,1506153987,3,0,1,'产品查询',NULL),(34,'uploads/image/201709/170923_160655_3143.png','#',1506154018,1506154018,3,0,1,'服务指南',NULL),(35,'uploads/image/201709/170927_110829_1169.jpg','http://baidu,com',1506481727,1506481727,1,0,1,NULL,'<p>友情链接<br/></p>'),(36,'uploads/image/201709/170927_113106_8626.jpg','#',1506483068,1506483068,1,0,1,NULL,'<p>友情链接<br/></p>');
/*!40000 ALTER TABLE `images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `theme` varchar(255) DEFAULT NULL,
  `replyway` int(10) DEFAULT NULL,
  `linkman` varchar(255) DEFAULT NULL,
  `content` text,
  `display` int(10) DEFAULT NULL,
  `create_at` int(50) DEFAULT NULL,
  `linkway` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migration`
--

DROP TABLE IF EXISTS `migration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migration` (
  `version` varchar(180) NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migration`
--

LOCK TABLES `migration` WRITE;
/*!40000 ALTER TABLE `migration` DISABLE KEYS */;
INSERT INTO `migration` VALUES ('m000000_000000_base',1500537632),('m130524_201442_init',1500537635);
/*!40000 ALTER TABLE `migration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `news` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
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
  `display` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=102 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (52,'关于加强浙江省医疗美容机构医疗广告的自律工作开展报告','关于加强浙江省医疗美容机构医疗广告的自律工作开展报告','uploads/image/201709/170927_100703_1194.jpg','<p>关于加强浙江省医疗美容机构医疗广告的自律工作开展报告</p>',4,'2017-09-15 14:50',1506478026,0,89,100,1),(53,'浙江省启动20117年度医疗美容机构评价工作','浙江省启动20117年度医疗美容机构评价工作','uploads/image/201709/170927_102515_4072.jpg','<p>浙江省启动20117年度医疗美容机构评价工作</p>',4,'2017-09-20 14:50',1506479389,2,89,100,1),(54,'关于印发干细胞制剂剂量控制及临床研究','关于印发干细胞制剂剂量控制及临床研究','','<p>关于印发干细胞制剂剂量控制及临床研究</p>',4,'2017-09-20 13:50',1506480384,1,86,99,1),(55,'关于印发干细胞制剂剂量控制及临床研究','关于印发干细胞制剂剂量控制及临床研究','','<p>关于印发干细胞制剂剂量控制及临床研究</p>',4,'2017-09-20 10:50',1506480614,0,86,99,1),(56,'国务院办公厅关于加快推进协会业务文件下发','国务院办公厅关于加快推进协会业务文件下发','','<p>国务院办公厅关于加快推进协会业务文件下发</p>',4,'2017-09-13 10:50',1506480673,0,86,99,1),(57,'专家一','整形医师主任','uploads/image/201709/170921_161854_5689.jpg','<p>整形医师主任整形医师主任整形医师主任整形医师主任整形医师主任整形医师主任</p>',4,'2017-09-20 13:50',1506481234,0,89,101,1),(58,'xinqian','整形医师主任','uploads/image/201709/170927_105933_2195.jpg','<p>整形医师主任整形医师主任整形医师主任整形医师主任</p>',4,'2017-09-20 13:50',1506481176,0,89,101,1),(59,'随着社会的经济发展','随着社会的经济发展','uploads/image/201709/170927_095740_2196.jpg','<p>随着社会的经济发展</p>',4,'2017-09-20 14:50',1506477477,12,87,102,1),(60,'医疗美容骗贷狂欢熟人推荐被骗者拉入群伙','这里是整形资讯','uploads/image/201709/170923_161819_8880.jpg','<p>&nbsp;&nbsp;&nbsp; 医疗美容骗贷狂欢熟人推荐被骗者拉入群伙<br/></p>',4,'2017-09-20 14:30',1506524437,22,87,102,1),(61,'2016年度《医疗美容机构评价标准》评价试行工作正式启动','2016年度《医疗美容机构评价标准》评价试行工作正式启动','uploads/image/201709/170927_095934_2460.jpg','<p>&nbsp;&nbsp;&nbsp; 2016年度《医疗美容机构评价标准》评价试行工作正式启动</p>',4,'2017-09-20 14:00',1506477672,0,87,102,1),(62,'整形资讯','整形资讯','uploads/image/201709/170927_100201_8382.jpg','<p>整形资讯</p>',4,'2017-09-20 14:50',1506477723,0,87,102,1),(63,'放心美 医无忧医美保险','放心美 医无忧医美保险','uploads/image/201709/170927_100012_5517.jpg','<p>&nbsp;&nbsp;&nbsp; 放心美 医无忧医美保险</p>',4,'2017-09-20 14:00',1506477619,0,87,102,1),(64,'加强交流，共创A等级建设','加强交流，共创A等级建设','uploads/image/201709/170927_100535_7710.jpg','<p>加强交流，共创A等级建设</p>',4,'2017-09-20 14:05',1506477938,0,87,103,1),(65,'关于加强浙江省医疗美容机构医疗广告的自律工作开展报告','关于加强浙江省医疗美容机构医疗广告的自律工作开展报告','uploads/image/201709/170927_100736_1424.jpg','<p>关于加强浙江省医疗美容机构医疗广告的自律工作开展报告</p>',4,'2017-09-20 14:05',1506478061,0,87,103,1),(66,'2017年微创医学美容征文大会通知','2017年微创医学美容征文大会通知','uploads/image/201709/170927_101654_4478.jpg','<p>由中国整形美容协会微创与皮肤整形美容分会，脂肪医学分会，新技术与新材料分会，乳房整形分会，激光美容分会，皮肤美容分会，眼整形美容分会，面部年轻化分会，中医美容分会，鼻整形美容分会主办。<br/></p>',4,'2017-09-20 14:05',1506478785,1,87,104,1),(67,'2017年度开展严厉打击非法整形美容专项行动','2017年度开展严厉打击非法整形美容专项行动','uploads/image/201709/170927_102220_1162.jpg','<p>为进一步维护消费者合法权益，保护人民健康，国家卫生委，药品总局决定于2017年9月开展严厉打击非法医疗美容专项行动<br/></p>',4,'2017-09-20 14:05',1506478943,0,87,104,1),(68,'123','132','uploads/image/201709/170920_174137_3530.jpg','<p>12312312312312312313131351431531c53sa1d53sa1d35as1d35as1d35a153da13</p>',4,'2017-09-20 17:45',1505962789,1,86,86,1),(69,'浙江省启动20117年度医疗美容机构评价工作','浙江省启动20117年度医疗美容机构评价工作','uploads/image/201709/170927_100431_4887.jpg','<p>浙江省启动20117年度医疗美容机构评价工作</p>',4,'2017-09-21 14:50',1506477874,1,87,103,1),(71,'浙江省首届整形美容狐狸学术交流会在南京顺利召开','浙江省首届整形美容狐狸学术交流会在南京顺利召开','uploads/image/201709/170923_203101_8960.jpg','<p>浙江省首届整形美容狐狸学术交流会在南京顺利召开</p>',6,'2017-08-31 06:30',1506479480,0,89,100,1),(93,'第二届浙江医学抗衰老暨脂肪干细胞研究与学术应用大会会议','第二届浙江医学抗衰老暨脂肪干细胞研究与学术应用大会会议','','<p>第二届浙江医学抗衰老暨脂肪干细胞研究与学术应用大会会议</p>',4,'2017-09-27 10:25',1506479244,0,89,100,1),(73,'123','123','uploads/image/201709/170922_102442_1733.jpg','<p>123</p>',6,'2017-09-22 15:50',1506047765,1,86,94,1),(89,'浙江省整形美容协会临时党小组正式成立','浙江省整形美容协会临时党小组正式成立','','<p>浙江省整形美容协会临时党小组正式成立</p>',4,'2017-09-27 10:10',1506478367,0,87,103,1),(74,'专家','专家','uploads/image/201709/170927_110011_1552.jpg','<p>专家</p>',4,'2017-09-23 09:40',1506481214,0,89,101,1),(75,'专家','专家','uploads/image/201709/170927_110054_6133.jpg','<p>专家</p>',4,'2017-09-23 09:40',1506481257,0,89,101,1),(76,'专家','专家','uploads/image/201709/170923_094515_8292.jpg','<p>专家</p>',4,'2017-09-23 09:40',1506131118,0,89,101,1),(77,'专家','专家','uploads/image/201709/170927_110316_5340.jpg','<p>专家</p>',4,'2017-09-20 09:45',1506481453,0,89,101,1),(78,'专家','专家','uploads/image/201709/170927_110432_6324.jpg','<p>专家</p>',4,'2017-09-23 09:45',1506481475,0,89,101,1),(95,'关于举办2017浙江医学抗衰老学术会议暨注射美容规范化培训通知','关于举办2017浙江医学抗衰老学术会议暨注射美容规范化培训通知','','<p>关于举办2017浙江医学抗衰老学术会议暨注射美容规范化培训通知</p>',4,'2017-09-27 10:30',1506479540,0,89,100,1),(96,'关于举办抗衰老与中医美容新进展学习班通知','关于举办抗衰老与中医美容新进展学习班通知','','<p>关于举办抗衰老与中医美容新进展学习班通知</p>',4,'2017-09-27 10:30',1506479601,0,89,100,1),(97,'浙江省首届正整形美容护理学术交流会议征文活动报名及通知','浙江省首届正整形美容护理学术交流会议征文活动报名及通知','uploads/image/201709/170927_104020_7915.jpg','<p>浙江省首届正整形美容护理学术交流会议征文活动报名及通知</p>',4,'2017-09-27 10:35',1506480030,0,89,100,1),(86,'浙江医美行业将迎综合监管新格局','浙江医美行业将迎综合监管新格局','','<p>浙江医美行业将迎综合监管新格局</p>',4,'2017-09-27 10:05',1506478169,0,87,103,1),(87,'第二期《医疗美容机构评价标准》解决培训班','第二期《医疗美容机构评价标准》解决培训班','','<p>第二期《医疗美容机构评价标准》解决培训班</p>',4,'2017-09-27 10:05',1506478248,0,87,103,1),(88,'关于进一步加强规范“微整形”的通知','关于进一步加强规范“微整形”的通知','','<p>关于进一步加强规范“微整形”的通知</p>',4,'2017-09-27 10:10',1506478315,0,87,103,1),(83,'会员风采一','这里是会员风采','uploads/image/201709/170927_102302_7084.jpg','<p>这里是会员风采</p>',4,'2017-09-25 15:05',1506478985,0,93,93,1),(84,'会员风采二','这里是会员风采二','uploads/image/201709/170927_102321_8905.jpg','<p>这里是会员风采</p>',4,'2017-09-25 15:10',1506479003,0,93,93,1),(85,'这里是会员风采三','这里是会员风采三','uploads/image/201709/170927_102355_9610.jpg','<p>这里是会员风采</p>',4,'2017-09-25 15:10',1506479038,0,93,93,1),(90,'关于蔡刚同志任浙江省整形美容协会第一届理事报告','关于蔡刚同志任浙江省整形美容协会第一届理事','','<p>关于蔡刚同志任浙江省整形美容协会第一届理事报告</p>',4,'2017-09-27 10:10',1506478442,0,87,103,1),(91,'关于开展首期整形美容专业护士远程教育培训的通知','关于开展首期整形美容专业护士远程教育培训的通知','','<p>关于开展首期整形美容专业护士远程教育培训的通知</p>',4,'2017-09-27 10:10',1506478494,0,87,103,1),(92,'会员风采三','会员风采三','uploads/image/201709/170927_102443_8604.jpg','<p>会员风采三</p>',4,'2017-09-27 10:20',1506479086,1,93,93,1),(94,'关于申报3.28年国家级和省级继续医学教育项目通知','关于申报3.28年国家级和省级继续医学教育项目通知','uploads/image/201709/170927_103022_2620.jpg','<p>关于申报3.28年国家级和省级继续医学教育项目通知</p>',4,'2017-09-27 10:25',1506479429,0,89,100,1),(98,'香港，澳门特别行政区医师在内地进行短期培训学习','香港，澳门特别行政区医师在内地进行短期培训学习','','<p>香港，澳门特别行政区医师在内地进行短期培训学习</p>',4,'2017-09-27 10:10',1506480779,0,86,99,1),(99,'台湾医师在大陆短期行医规定管理制度发布','台湾医师在大陆短期行医规定管理制度发布','','<p>台湾医师在大陆短期行医规定管理制度发布</p>',4,'2017-09-27 10:50',1506480895,0,86,99,1),(100,'卫生部办公厅关于进一步加强医疗美容行业管理','卫生部办公厅关于进一步加强医疗美容行业管理','','<p>卫生部办公厅关于进一步加强医疗美容行业管理</p>',4,'2017-09-27 10:55',1506480963,0,86,99,1),(101,'江苏省实施《医疗机构管理条例》办法等发布','江苏省实施《医疗机构管理条例》办法等发布','','<p>江苏省实施《医疗机构管理条例》办法等发布</p>',4,'2017-09-27 10:55',1506481083,0,86,99,1);
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reply`
--

DROP TABLE IF EXISTS `reply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reply` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pid_theme` int(10) NOT NULL,
  `content` text NOT NULL,
  `reply_people` varchar(50) NOT NULL,
  `create_time` int(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reply`
--

LOCK TABLES `reply` WRITE;
/*!40000 ALTER TABLE `reply` DISABLE KEYS */;
INSERT INTO `reply` VALUES (5,5,'4556','管理员',1501030645);
/*!40000 ALTER TABLE `reply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `replyway`
--

DROP TABLE IF EXISTS `replyway`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `replyway` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `replyway`
--

LOCK TABLES `replyway` WRITE;
/*!40000 ALTER TABLE `replyway` DISABLE KEYS */;
INSERT INTO `replyway` VALUES (1,'E-MAIL'),(2,'腾讯QQ'),(3,'电话或者手机');
/*!40000 ALTER TABLE `replyway` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rongyi`
--

DROP TABLE IF EXISTS `rongyi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rongyi`
--

LOCK TABLES `rongyi` WRITE;
/*!40000 ALTER TABLE `rongyi` DISABLE KEYS */;
/*!40000 ALTER TABLE `rongyi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `slide`
--

DROP TABLE IF EXISTS `slide`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `slide` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `weight` int(10) NOT NULL,
  `create_at` int(50) NOT NULL,
  `update_at` int(50) NOT NULL,
  `display` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `slide`
--

LOCK TABLES `slide` WRITE;
/*!40000 ALTER TABLE `slide` DISABLE KEYS */;
INSERT INTO `slide` VALUES (9,'第二张','uploads/image/201709/170917_220822_9298.jpg','',3,1505657304,1506128703,1),(8,'第一张幻灯片','uploads/image/201709/170917_220802_7935.jpg','',1,1505657287,1505658181,1),(10,'第三张','uploads/image/201709/170923_090450_9991.png','',2,1505657317,1506128692,1),(11,'第四章','uploads/image/201709/170917_220922_6129.jpg','',0,1505657365,1506170010,1);
/*!40000 ALTER TABLE `slide` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `source`
--

DROP TABLE IF EXISTS `source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `source` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `crate_at` int(20) NOT NULL,
  `update_at` int(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `source`
--

LOCK TABLES `source` WRITE;
/*!40000 ALTER TABLE `source` DISABLE KEYS */;
INSERT INTO `source` VALUES (4,'admin',1500883462,1500883462),(6,'百度',1505917213,1505917213);
/*!40000 ALTER TABLE `source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `test` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'123');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upload`
--

DROP TABLE IF EXISTS `upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `upload` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `real_name` varchar(255) DEFAULT NULL COMMENT '原始文件名称',
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `thumb_name` varchar(255) DEFAULT NULL COMMENT '缩略图',
  `file_ext` varchar(255) DEFAULT NULL COMMENT '扩展名称',
  `file_mime` varchar(255) DEFAULT NULL COMMENT 'MIME类型',
  `file_size` int(11) unsigned DEFAULT '0' COMMENT '文件大小',
  `md5` text COMMENT 'MD5',
  `sha1` text COMMENT 'SHA1',
  `down_count` int(11) unsigned DEFAULT '0' COMMENT '下载次数',
  `created_at` int(11) DEFAULT NULL COMMENT '添加时间',
  `updated_at` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=346 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upload`
--

LOCK TABLES `upload` WRITE;
/*!40000 ALTER TABLE `upload` DISABLE KEYS */;
INSERT INTO `upload` VALUES (1,'img_3.jpg','uploads/image/201704/170410_093213_7943.jpg','uploads/thumb/201704/170410_093213_7943.jpg','jpg','image/jpeg',200913,'338a8d7c37f895e7aff3be9ad409b817','bc784edb77fb52c7144acc45aa52f2885049e21f',0,1491787933,1491787933),(2,'123.jpg','uploads/image/201707/170722_220928_2294.jpg','uploads/thumb/201707/170722_220928_2294.jpg','jpg','image/jpeg',30226,'9f8344c89c4e7d50b70e8c636d4ebe6a','f955c737b33db9cf3d3fc4844a4c97248d177918',0,1500732568,1500732568),(3,'123.jpg','uploads/image/201707/170722_221016_7552.jpg','uploads/thumb/201707/170722_221016_7552.jpg','jpg','image/jpeg',30226,'9f8344c89c4e7d50b70e8c636d4ebe6a','f955c737b33db9cf3d3fc4844a4c97248d177918',0,1500732616,1500732616),(4,'123.jpg','uploads/image/201707/170722_221248_7235.jpg','uploads/thumb/201707/170722_221248_7235.jpg','jpg','image/jpeg',30226,'9f8344c89c4e7d50b70e8c636d4ebe6a','f955c737b33db9cf3d3fc4844a4c97248d177918',0,1500732768,1500732768),(5,'123.jpg','uploads/image/201707/170722_221747_7106.jpg','uploads/thumb/201707/170722_221747_7106.jpg','jpg','image/jpeg',30226,'9f8344c89c4e7d50b70e8c636d4ebe6a','f955c737b33db9cf3d3fc4844a4c97248d177918',0,1500733067,1500733067),(6,'123.jpg','uploads/image/201707/170722_222213_5416.jpg','uploads/thumb/201707/170722_222213_5416.jpg','jpg','image/jpeg',30226,'9f8344c89c4e7d50b70e8c636d4ebe6a','f955c737b33db9cf3d3fc4844a4c97248d177918',0,1500733333,1500733333),(7,'123.jpg','uploads/image/201707/170722_222239_2557.jpg','uploads/thumb/201707/170722_222239_2557.jpg','jpg','image/jpeg',30226,'9f8344c89c4e7d50b70e8c636d4ebe6a','f955c737b33db9cf3d3fc4844a4c97248d177918',0,1500733359,1500733359),(8,'123.jpg','uploads/image/201707/170722_222612_5676.jpg','uploads/thumb/201707/170722_222612_5676.jpg','jpg','image/jpeg',30226,'9f8344c89c4e7d50b70e8c636d4ebe6a','f955c737b33db9cf3d3fc4844a4c97248d177918',0,1500733572,1500733572),(9,'123.jpg','uploads/image/201707/170722_222651_1989.jpg','uploads/thumb/201707/170722_222651_1989.jpg','jpg','image/jpeg',30226,'9f8344c89c4e7d50b70e8c636d4ebe6a','f955c737b33db9cf3d3fc4844a4c97248d177918',0,1500733611,1500733611),(10,'123.jpg','uploads/image/201707/170722_222828_7665.jpg','uploads/thumb/201707/170722_222828_7665.jpg','jpg','image/jpeg',30226,'9f8344c89c4e7d50b70e8c636d4ebe6a','f955c737b33db9cf3d3fc4844a4c97248d177918',0,1500733708,1500733708),(11,'123.jpg','uploads/image/201707/170722_222843_2394.jpg','uploads/thumb/201707/170722_222843_2394.jpg','jpg','image/jpeg',30226,'9f8344c89c4e7d50b70e8c636d4ebe6a','f955c737b33db9cf3d3fc4844a4c97248d177918',0,1500733723,1500733723),(12,'1题.png','uploads/image/201707/170724_130005_4943.png','uploads/thumb/201707/170724_130005_4943.png','png','image/png',1324352,'9ba9231e67d817b8174f2ccaa922cb08','c80c4c55c471f9dc9d2dd6af533c5c8d96dab369',0,1500872405,1500872405),(13,'藏云logo.jpg','uploads/image/201707/170724_130110_7226.jpg','uploads/thumb/201707/170724_130110_7226.jpg','jpg','image/jpeg',323170,'830e37a876863d5e5419e6cc2dbc7cc4','896e34d454c2b5b71376aa9374a7d4cde26fe4cc',0,1500872470,1500872470),(14,'藏云logo.jpg','uploads/image/201707/170724_130214_3594.jpg','uploads/thumb/201707/170724_130214_3594.jpg','jpg','image/jpeg',323170,'830e37a876863d5e5419e6cc2dbc7cc4','896e34d454c2b5b71376aa9374a7d4cde26fe4cc',0,1500872534,1500872534),(15,'藏云logo.jpg','uploads/image/201707/170724_130239_8620.jpg','uploads/thumb/201707/170724_130239_8620.jpg','jpg','image/jpeg',323170,'830e37a876863d5e5419e6cc2dbc7cc4','896e34d454c2b5b71376aa9374a7d4cde26fe4cc',0,1500872559,1500872559),(16,'藏云logo.jpg','uploads/image/201707/170724_130310_9043.jpg','uploads/thumb/201707/170724_130310_9043.jpg','jpg','image/jpeg',323170,'830e37a876863d5e5419e6cc2dbc7cc4','896e34d454c2b5b71376aa9374a7d4cde26fe4cc',0,1500872590,1500872590),(17,'rwft.jpg','uploads/image/201707/170724_143638_5456.jpg','uploads/thumb/201707/170724_143638_5456.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500878198,1500878198),(18,'bg1.png','uploads/image/201707/170724_144058_1635.png','uploads/thumb/201707/170724_144058_1635.png','png','image/png',70284,'873e2c72ea9e0b3247fefef86ae12f91','5a69f749cd554029df9bb6e536c6667deaf5d6e0',0,1500878458,1500878458),(19,'rwft.jpg','uploads/image/201707/170724_144214_3996.jpg','uploads/thumb/201707/170724_144214_3996.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500878534,1500878534),(20,'rwft.jpg','uploads/image/201707/170724_144318_4154.jpg','uploads/thumb/201707/170724_144318_4154.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500878598,1500878598),(21,'rwft.jpg','uploads/image/201707/170724_144427_2278.jpg','uploads/thumb/201707/170724_144427_2278.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500878667,1500878667),(22,'rwft.jpg','uploads/image/201707/170724_144442_2852.jpg','uploads/thumb/201707/170724_144442_2852.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500878682,1500878682),(23,'rwft.jpg','uploads/image/201707/170724_144523_6984.jpg','uploads/thumb/201707/170724_144523_6984.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500878723,1500878723),(24,'rwft.jpg','uploads/image/201707/170724_144603_2291.jpg','uploads/thumb/201707/170724_144603_2291.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500878763,1500878763),(25,'rwft.jpg','uploads/image/201707/170724_144621_3741.jpg','uploads/thumb/201707/170724_144621_3741.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500878781,1500878781),(26,'rwft.jpg','uploads/image/201707/170724_144652_6576.jpg','uploads/thumb/201707/170724_144652_6576.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500878812,1500878812),(27,'rwft.jpg','uploads/image/201707/170724_144715_1193.jpg','uploads/thumb/201707/170724_144715_1193.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500878835,1500878835),(28,'bg1.png','uploads/image/201707/170724_145439_8034.png','uploads/thumb/201707/170724_145439_8034.png','png','image/png',70284,'873e2c72ea9e0b3247fefef86ae12f91','5a69f749cd554029df9bb6e536c6667deaf5d6e0',0,1500879280,1500879280),(29,'0ef71cf5a299412cbbd32f85898ceb52.PNG','uploads/image/201707/170724_145602_9368.png','uploads/thumb/201707/170724_145602_9368.png','png','image/png',1931,'37a8e4da546a1f3fe24f6cdb9d11da8f','1ec6f3406f7acfa79ed2b3a475fa487ea9b55e0d',0,1500879362,1500879362),(30,'rwft.jpg','uploads/image/201707/170724_145612_4960.jpg','uploads/thumb/201707/170724_145612_4960.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500879372,1500879372),(31,'rwft.jpg','uploads/image/201707/170724_145624_1987.jpg','uploads/thumb/201707/170724_145624_1987.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500879384,1500879384),(32,'bg1.png','uploads/image/201707/170724_153139_4131.png','uploads/thumb/201707/170724_153139_4131.png','png','image/png',70284,'873e2c72ea9e0b3247fefef86ae12f91','5a69f749cd554029df9bb6e536c6667deaf5d6e0',0,1500881499,1500881499),(33,'bg1.png','uploads/image/201707/170724_154548_7867.png','uploads/thumb/201707/170724_154548_7867.png','png','image/png',70284,'873e2c72ea9e0b3247fefef86ae12f91','5a69f749cd554029df9bb6e536c6667deaf5d6e0',0,1500882348,1500882348),(34,'rwft.jpg','uploads/image/201707/170724_155544_2499.jpg','uploads/thumb/201707/170724_155544_2499.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500882945,1500882945),(35,'rwft.jpg','uploads/image/201707/170724_161730_4814.jpg','uploads/thumb/201707/170724_161730_4814.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500884250,1500884250),(36,'0ef71cf5a299412cbbd32f85898ceb52.PNG','uploads/image/201707/170724_174819_2353.png','uploads/thumb/201707/170724_174819_2353.png','png','image/png',1931,'37a8e4da546a1f3fe24f6cdb9d11da8f','1ec6f3406f7acfa79ed2b3a475fa487ea9b55e0d',0,1500889699,1500889699),(37,'bg1.png','uploads/image/201707/170724_174819_9993.png','uploads/thumb/201707/170724_174819_9993.png','png','image/png',70284,'873e2c72ea9e0b3247fefef86ae12f91','5a69f749cd554029df9bb6e536c6667deaf5d6e0',0,1500889699,1500889699),(38,'rwft.jpg','uploads/image/201707/170724_174819_4895.jpg','uploads/thumb/201707/170724_174819_4895.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500889699,1500889699),(39,'rwft.jpg','uploads/image/201707/170724_174947_1169.jpg','uploads/thumb/201707/170724_174947_1169.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500889787,1500889787),(40,'bg1.png','uploads/image/201707/170724_174947_4297.png','uploads/thumb/201707/170724_174947_4297.png','png','image/png',70284,'873e2c72ea9e0b3247fefef86ae12f91','5a69f749cd554029df9bb6e536c6667deaf5d6e0',0,1500889787,1500889787),(41,'0ef71cf5a299412cbbd32f85898ceb52.PNG','uploads/image/201707/170724_174947_2821.png','uploads/thumb/201707/170724_174947_2821.png','png','image/png',1931,'37a8e4da546a1f3fe24f6cdb9d11da8f','1ec6f3406f7acfa79ed2b3a475fa487ea9b55e0d',0,1500889787,1500889787),(42,'rwft.jpg','uploads/image/201707/170725_091520_7498.jpg','uploads/thumb/201707/170725_091520_7498.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1500945320,1500945320),(43,'bg1.png','uploads/image/201707/170725_092827_2955.png','uploads/thumb/201707/170725_092827_2955.png','png','image/png',70284,'873e2c72ea9e0b3247fefef86ae12f91','5a69f749cd554029df9bb6e536c6667deaf5d6e0',0,1500946107,1500946107),(44,'0ef71cf5a299412cbbd32f85898ceb52.PNG','uploads/image/201707/170725_093204_4588.png','uploads/thumb/201707/170725_093204_4588.png','png','image/png',1931,'37a8e4da546a1f3fe24f6cdb9d11da8f','1ec6f3406f7acfa79ed2b3a475fa487ea9b55e0d',0,1500946324,1500946324),(45,'bg1.png','uploads/image/201707/170725_095246_9625.png','uploads/thumb/201707/170725_095246_9625.png','png','image/png',70284,'873e2c72ea9e0b3247fefef86ae12f91','5a69f749cd554029df9bb6e536c6667deaf5d6e0',0,1500947566,1500947566),(46,'1194973045f91a108fo.jpg','uploads/image/201707/170725_111443_1991.jpg','uploads/thumb/201707/170725_111443_1991.jpg','jpg','image/jpeg',1453876,'5e19a4668a3137f1cb1f0b4a13e4e4c4','a90527bf83fa142f835fecb440cbb7cff756ab46',0,1500952484,1500952484),(47,'5286.jpg','uploads/image/201707/170725_111455_9900.jpg','uploads/thumb/201707/170725_111455_9900.jpg','jpg','image/jpeg',1745531,'46b67ac250dbc6c2c472065cce8b317d','04e70a03ee8e49c2f8d0fa650bedb4c3de08bcff',0,1500952495,1500952495),(48,'12.png','uploads/image/201707/170726_100557_1115.png','uploads/thumb/201707/170726_100557_1115.png','png','image/jpeg',1453876,'5e19a4668a3137f1cb1f0b4a13e4e4c4','a90527bf83fa142f835fecb440cbb7cff756ab46',0,1501034757,1501034757),(49,'5286.jpg','uploads/image/201707/170726_100731_7810.jpg','uploads/thumb/201707/170726_100731_7810.jpg','jpg','image/jpeg',1745531,'46b67ac250dbc6c2c472065cce8b317d','04e70a03ee8e49c2f8d0fa650bedb4c3de08bcff',0,1501034851,1501034851),(50,'12.png','uploads/image/201707/170726_100833_8203.png','uploads/thumb/201707/170726_100833_8203.png','png','image/jpeg',1453876,'5e19a4668a3137f1cb1f0b4a13e4e4c4','a90527bf83fa142f835fecb440cbb7cff756ab46',0,1501034913,1501034913),(51,'5286.jpg','uploads/image/201707/170726_100913_1578.jpg','uploads/thumb/201707/170726_100913_1578.jpg','jpg','image/jpeg',1745531,'46b67ac250dbc6c2c472065cce8b317d','04e70a03ee8e49c2f8d0fa650bedb4c3de08bcff',0,1501034953,1501034953),(52,'5286.jpg','uploads/image/201707/170726_100950_3396.jpg','uploads/thumb/201707/170726_100950_3396.jpg','jpg','image/jpeg',1745531,'46b67ac250dbc6c2c472065cce8b317d','04e70a03ee8e49c2f8d0fa650bedb4c3de08bcff',0,1501034990,1501034990),(53,'12.png','uploads/image/201707/170726_102650_8032.png','uploads/thumb/201707/170726_102650_8032.png','png','image/jpeg',1453876,'5e19a4668a3137f1cb1f0b4a13e4e4c4','a90527bf83fa142f835fecb440cbb7cff756ab46',0,1501036010,1501036010),(54,'12.png','uploads/image/201707/170726_103044_1348.png','uploads/thumb/201707/170726_103044_1348.png','png','image/jpeg',1453876,'5e19a4668a3137f1cb1f0b4a13e4e4c4','a90527bf83fa142f835fecb440cbb7cff756ab46',0,1501036244,1501036244),(55,'rwft.jpg','uploads/image/201707/170726_161013_9663.jpg','uploads/thumb/201707/170726_161013_9663.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1501056613,1501056613),(56,'rwft.jpg','uploads/image/201707/170726_161537_8495.jpg','uploads/thumb/201707/170726_161537_8495.jpg','jpg','image/jpeg',10530,'89d6bec35b661b5656a6fbc6473c37cf','0755e112ad29947b452d2bf1619c963ced766468',0,1501056937,1501056937),(57,'about-img.png','uploads/image/201707/170727_154052_7631.png','uploads/thumb/201707/170727_154052_7631.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501141252,1501141252),(58,'about-img.png','uploads/image/201707/170727_154535_8145.png','uploads/thumb/201707/170727_154535_8145.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501141535,1501141535),(59,'about-img.png','uploads/image/201707/170727_164838_2212.png','uploads/thumb/201707/170727_164838_2212.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501145318,1501145318),(60,'20161017luoddn.jpg','uploads/image/201707/170727_174311_8008.jpg','uploads/thumb/201707/170727_174311_8008.jpg','jpg','image/jpeg',534526,'02de6ebabfe3ef7e5fce498c64f581bf','cfa171f10a88e85deb0588af8828fcd8187b4781',0,1501148591,1501148591),(61,'20161017pjhfbq.jpg','uploads/image/201707/170727_174344_4571.jpg','uploads/thumb/201707/170727_174344_4571.jpg','jpg','image/jpeg',347973,'a4863b6fa107f0c4c6006c2249a99941','4155613c30e0342ec24ae7334d9409676c818368',0,1501148624,1501148624),(62,'14984415749447.jpg','uploads/image/201707/170728_095231_5530.jpg','','jpg',NULL,162406,'69d16fe42765bf60a705dd3f58ebfb59','74cf9887be47b93c6f2f5d2ff4e5dbe6149563e3',0,1501206751,1501206751),(63,'14984415967918.jpg','uploads/image/201707/170728_095232_4651.jpg','','jpg',NULL,133881,'95c1e5b5c3d09531e0c5bd3c634087ef','5c8aeb8def2ba3912db64bd89409d651d50d3931',0,1501206752,1501206752),(64,'about-img.png','uploads/image/201707/170728_095236_6342.png','uploads/thumb/201707/170728_095236_6342.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501206756,1501206756),(65,'14984415749447.jpg','uploads/image/201707/170728_095340_7572.jpg','uploads/thumb/201707/170728_095340_7572.jpg','jpg','image/jpeg',162406,'69d16fe42765bf60a705dd3f58ebfb59','74cf9887be47b93c6f2f5d2ff4e5dbe6149563e3',0,1501206820,1501206820),(66,'about-img.png','uploads/image/201707/170728_095347_7467.png','uploads/thumb/201707/170728_095347_7467.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501206827,1501206827),(67,'14984415967918.jpg','uploads/image/201707/170728_095353_6137.jpg','uploads/thumb/201707/170728_095353_6137.jpg','jpg','image/jpeg',133881,'95c1e5b5c3d09531e0c5bd3c634087ef','5c8aeb8def2ba3912db64bd89409d651d50d3931',0,1501206833,1501206833),(68,'about-img.png','uploads/image/201707/170728_095420_2190.png','uploads/thumb/201707/170728_095420_2190.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501206860,1501206860),(69,'14984415749447.jpg','uploads/image/201707/170728_095613_2651.jpg','uploads/thumb/201707/170728_095613_2651.jpg','jpg','image/jpeg',162406,'69d16fe42765bf60a705dd3f58ebfb59','74cf9887be47b93c6f2f5d2ff4e5dbe6149563e3',0,1501206973,1501206973),(70,'14984419079364.jpg','uploads/image/201707/170728_095920_2243.jpg','uploads/thumb/201707/170728_095920_2243.jpg','jpg','image/jpeg',124118,'b556ab6ac7ad79e64f44aa209dd19d12','00bb2150f8b9387444e539634e78a44f2268c53e',0,1501207160,1501207160),(71,'14984419079364.jpg','uploads/image/201707/170728_095930_2190.jpg','','jpg',NULL,124118,'b556ab6ac7ad79e64f44aa209dd19d12','00bb2150f8b9387444e539634e78a44f2268c53e',0,1501207170,1501207170),(72,'14984419231077.jpg','uploads/image/201707/170728_095931_5108.jpg','','jpg',NULL,99975,'9456d195b7b4393da89267a185dc03c1','0e6903a421105ca3f3ab459c1c921badfa73abec',0,1501207171,1501207171),(73,'14984419079364.jpg','uploads/image/201707/170728_095947_3105.jpg','uploads/thumb/201707/170728_095947_3105.jpg','jpg','image/jpeg',124118,'b556ab6ac7ad79e64f44aa209dd19d12','00bb2150f8b9387444e539634e78a44f2268c53e',0,1501207187,1501207187),(74,'14984419231077.jpg','uploads/image/201707/170728_100000_3802.jpg','uploads/thumb/201707/170728_100000_3802.jpg','jpg','image/jpeg',99975,'9456d195b7b4393da89267a185dc03c1','0e6903a421105ca3f3ab459c1c921badfa73abec',0,1501207200,1501207200),(75,'微信图片_20170728100855.png','uploads/image/201707/170728_101208_1159.png','uploads/thumb/201707/170728_101208_1159.png','png','image/png',172804,'5e723c23124cfdfef441f0ef79d1469b','e27effacbef53c862de1c2d2bc646bd169567847',0,1501207928,1501207928),(76,'2600828784824117277.jpg','uploads/image/201707/170728_101605_2468.jpg','uploads/thumb/201707/170728_101605_2468.jpg','jpg','image/jpeg',374952,'797284b65cd2cebdf5bb8626ce24c92e','e3549eda3721499c19b0c65a4491835cf8989814',0,1501208165,1501208165),(77,'1194973045f91a108fo.jpg','uploads/image/201707/170728_101902_6587.jpg','uploads/thumb/201707/170728_101902_6587.jpg','jpg','image/jpeg',320758,'689df73ec9358315d0f97a8ccbe8ea44','3a88682c93a47779aa2d35db893b8092f316c527',0,1501208342,1501208342),(78,'forum-banner.png','uploads/image/201707/170728_104739_5441.png','uploads/thumb/201707/170728_104739_5441.png','png','image/png',299126,'0659b600d708988cc76c5ef9e6de6a05','80a24d5ea4cfa41680405b618415efd00aa8a1c7',0,1501210059,1501210059),(79,'club-banner.png','uploads/image/201707/170728_104852_5315.png','uploads/thumb/201707/170728_104852_5315.png','png','image/png',421272,'b696473521b4078b661e52e6ab2f1891','9c7927f3f422e14527e795610f7c4063fe25f2e9',0,1501210132,1501210132),(80,'forum-banner.png','uploads/image/201707/170728_104905_6728.png','uploads/thumb/201707/170728_104905_6728.png','png','image/png',299126,'0659b600d708988cc76c5ef9e6de6a05','80a24d5ea4cfa41680405b618415efd00aa8a1c7',0,1501210145,1501210145),(81,'about-img.png','backend/web/uploads/image/201707/170728_110854_4387.png','backend/web/uploads/thumb/201707/170728_110854_4387.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501211334,1501211334),(82,'about-img.png','backend/web/uploads/image/201707/170728_111427_2322.png','backend/web/uploads/thumb/201707/170728_111427_2322.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501211667,1501211667),(83,'club-banner.png','uploads/image/201707/170728_111852_1155.png','uploads/thumb/201707/170728_111852_1155.png','png','image/png',421272,'b696473521b4078b661e52e6ab2f1891','9c7927f3f422e14527e795610f7c4063fe25f2e9',0,1501211932,1501211932),(84,'club-banner.png','uploads/image/201707/170728_111941_7419.png','uploads/thumb/201707/170728_111941_7419.png','png','image/png',421272,'b696473521b4078b661e52e6ab2f1891','9c7927f3f422e14527e795610f7c4063fe25f2e9',0,1501211981,1501211981),(85,'bg1.png','backend/web/uploads/image/201707/170728_112123_4973.png','backend/web/uploads/thumb/201707/170728_112123_4973.png','png','image/png',70284,'873e2c72ea9e0b3247fefef86ae12f91','5a69f749cd554029df9bb6e536c6667deaf5d6e0',0,1501212083,1501212083),(86,'about-img.png','backend/web/uploads/image/201707/170728_154659_6385.png','backend/web/uploads/thumb/201707/170728_154659_6385.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501228019,1501228019),(87,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_101439_6284.png','backend/web/uploads/thumb/201707/170731_101439_6284.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501467279,1501467279),(88,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_102413_2863.png','backend/web/uploads/thumb/201707/170731_102413_2863.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501467853,1501467853),(89,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_103102_2105.png','backend/web/uploads/thumb/201707/170731_103102_2105.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501468263,1501468263),(90,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_103533_4049.png','backend/web/uploads/thumb/201707/170731_103533_4049.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501468533,1501468533),(91,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_111736_5064.png','backend/web/uploads/thumb/201707/170731_111736_5064.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501471056,1501471056),(92,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_115405_8909.png','backend/web/uploads/thumb/201707/170731_115405_8909.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501473246,1501473246),(93,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_120102_9297.png','backend/web/uploads/thumb/201707/170731_120102_9297.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501473662,1501473662),(94,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_120116_5801.png','backend/web/uploads/thumb/201707/170731_120116_5801.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501473676,1501473676),(95,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_120500_2797.png','backend/web/uploads/thumb/201707/170731_120500_2797.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501473901,1501473901),(96,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_120651_1774.png','backend/web/uploads/thumb/201707/170731_120651_1774.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501474012,1501474012),(97,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_120751_2088.png','backend/web/uploads/thumb/201707/170731_120751_2088.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501474071,1501474071),(98,'170728_095420_2190.png','backend/web/uploads/image/201707/170731_120819_6361.png','backend/web/uploads/thumb/201707/170731_120819_6361.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501474099,1501474099),(99,'about-img.png','uploads/image/201707/170731_133943_5207.png','uploads/thumb/201707/170731_133943_5207.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501479583,1501479583),(100,'club-banner.png','uploads/image/201707/170731_133950_1823.png','uploads/thumb/201707/170731_133950_1823.png','png','image/png',421272,'b696473521b4078b661e52e6ab2f1891','9c7927f3f422e14527e795610f7c4063fe25f2e9',0,1501479590,1501479590),(101,'club-banner.png','uploads/image/201707/170731_134820_5568.png','uploads/thumb/201707/170731_134820_5568.png','png','image/png',421272,'b696473521b4078b661e52e6ab2f1891','9c7927f3f422e14527e795610f7c4063fe25f2e9',0,1501480100,1501480100),(102,'about-img.png','uploads/image/201707/170731_135013_7823.png','uploads/thumb/201707/170731_135013_7823.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501480213,1501480213),(103,'about-img.png','uploads/image/201707/170731_135249_5785.png','uploads/thumb/201707/170731_135249_5785.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501480369,1501480369),(104,'about-img.png','uploads/image/201707/170731_135552_3290.png','uploads/thumb/201707/170731_135552_3290.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501480552,1501480552),(105,'club-banner.png','uploads/image/201707/170731_135652_2298.png','uploads/thumb/201707/170731_135652_2298.png','png','image/png',421272,'b696473521b4078b661e52e6ab2f1891','9c7927f3f422e14527e795610f7c4063fe25f2e9',0,1501480612,1501480612),(106,'forum-banner.png','uploads/image/201707/170731_135801_4665.png','uploads/thumb/201707/170731_135801_4665.png','png','image/png',299126,'0659b600d708988cc76c5ef9e6de6a05','80a24d5ea4cfa41680405b618415efd00aa8a1c7',0,1501480681,1501480681),(107,'club-banner.png','uploads/image/201707/170731_161615_5252.png','uploads/thumb/201707/170731_161615_5252.png','png','image/png',421272,'b696473521b4078b661e52e6ab2f1891','9c7927f3f422e14527e795610f7c4063fe25f2e9',0,1501488975,1501488975),(108,'170728_095420_2190.png','uploads/image/201707/170731_163214_7003.png','uploads/thumb/201707/170731_163214_7003.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501489934,1501489934),(109,'about-img.png','backend/web/uploads/image/201707/170731_171431_9747.png','backend/web/uploads/thumb/201707/170731_171431_9747.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501492471,1501492471),(110,'club-banner.png','uploads/image/201707/170731_171921_6578.png','uploads/thumb/201707/170731_171921_6578.png','png','image/png',421272,'b696473521b4078b661e52e6ab2f1891','9c7927f3f422e14527e795610f7c4063fe25f2e9',0,1501492761,1501492761),(111,'20161017luoddn.jpg','backend/web/uploads/image/201707/170731_172228_9760.jpg','backend/web/uploads/thumb/201707/170731_172228_9760.jpg','jpg','image/jpeg',184212,'540cf899c5f219213f98170d00714fb1','100ab6bf86fa38cd402bdd2b64cb6f35d3edf17a',0,1501492948,1501492948),(112,'about-img.png','backend/web/uploads/image/201707/170731_172338_4841.png','backend/web/uploads/thumb/201707/170731_172338_4841.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501493018,1501493018),(113,'about-img.png','uploads/image/201707/170731_172809_3734.png','uploads/thumb/201707/170731_172809_3734.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501493289,1501493289),(114,'20161017pjhfbq.jpg','backend/web/uploads/image/201707/170731_173102_2496.jpg','backend/web/uploads/thumb/201707/170731_173102_2496.jpg','jpg','image/jpeg',129817,'49146ee27a982c99a0a59987d2892c35','b4583ed29051e4fc2917d98180f92619718a796e',0,1501493462,1501493462),(115,'about-img.png','uploads/image/201707/170731_173344_7197.png','uploads/thumb/201707/170731_173344_7197.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501493624,1501493624),(116,'about-img.png','./uploads/image/201707/170731_173609_7896.png','./uploads/thumb/201707/170731_173609_7896.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501493769,1501493769),(117,'about-img.png','./uploads/image/201707/170731_173648_7850.png','./uploads/thumb/201707/170731_173648_7850.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501493808,1501493808),(118,'about-img.png','backend/web/uploads/image/201707/170731_173758_6335.png','backend/web/uploads/thumb/201707/170731_173758_6335.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501493878,1501493878),(119,'bg1.png','./backend/web/uploads/image/201708/170801_092111_8919.png','./backend/web/uploads/thumb/201708/170801_092111_8919.png','png','image/png',70284,'873e2c72ea9e0b3247fefef86ae12f91','5a69f749cd554029df9bb6e536c6667deaf5d6e0',0,1501550472,1501550472),(120,'club-banner.png','backend/web/uploads/image/201708/170801_094143_3992.png','backend/web/uploads/thumb/201708/170801_094143_3992.png','png','image/png',421272,'b696473521b4078b661e52e6ab2f1891','9c7927f3f422e14527e795610f7c4063fe25f2e9',0,1501551703,1501551703),(121,'20161017pjhfbq.jpg','backend/web/uploads/image/201708/170801_094342_8074.jpg','backend/web/uploads/thumb/201708/170801_094342_8074.jpg','jpg','image/jpeg',129817,'49146ee27a982c99a0a59987d2892c35','b4583ed29051e4fc2917d98180f92619718a796e',0,1501551822,1501551822),(122,'20161017luoddn.jpg','backend/web/uploads/image/201708/170801_094520_6601.jpg','backend/web/uploads/thumb/201708/170801_094520_6601.jpg','jpg','image/jpeg',184212,'540cf899c5f219213f98170d00714fb1','100ab6bf86fa38cd402bdd2b64cb6f35d3edf17a',0,1501551920,1501551920),(123,'14903213859921.jpg','backend/web/uploads/image/201708/170801_100707_1614.jpg','backend/web/uploads/thumb/201708/170801_100707_1614.jpg','jpg','image/jpeg',15983,'c309afe08174f5368acb017b336c5a5a','c8ae4e1649e1a52096982e1af02a5273b23f4803',0,1501553227,1501553227),(124,'about-img.png','uploads/image/201708/170801_101446_3858.png','uploads/thumb/201708/170801_101446_3858.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501553686,1501553686),(125,'team.jpg','uploads/image/201708/170801_144956_7490.jpg','uploads/thumb/201708/170801_144956_7490.jpg','jpg','image/jpeg',93009,'0b51facc1cc25e7238f04f20ce56c519','635b40408ff771d8ce2cb3dfc37121209e9da8d6',0,1501570196,1501570196),(126,'about-img.png','uploads/image/201708/170801_150343_2846.png','uploads/thumb/201708/170801_150343_2846.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501571023,1501571023),(127,'about-img.png','uploads/image/201708/170801_150549_6909.png','uploads/thumb/201708/170801_150549_6909.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501571149,1501571149),(128,'about-img.png','uploads/image/201708/170801_150642_8997.png','uploads/thumb/201708/170801_150642_8997.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501571202,1501571202),(129,'about-img.png','uploads/image/201708/170801_150820_2907.png','uploads/thumb/201708/170801_150820_2907.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501571300,1501571300),(130,'about-img.png','uploads/image/201708/170801_151131_5604.png','uploads/thumb/201708/170801_151131_5604.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501571491,1501571491),(131,'about-img.png','uploads/image/201708/170801_151337_3529.png','uploads/thumb/201708/170801_151337_3529.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501571617,1501571617),(132,'about-img.png','uploads/image/201708/170801_151433_5731.png','uploads/thumb/201708/170801_151433_5731.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501571673,1501571673),(133,'about-img.png','uploads/image/201708/170801_151727_7832.png','uploads/thumb/201708/170801_151727_7832.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501571847,1501571847),(134,'about-img.png','uploads/image/201708/170801_151840_6994.png','uploads/thumb/201708/170801_151840_6994.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501571920,1501571920),(135,'about-img.png','uploads/image/201708/170801_152502_2748.png','uploads/thumb/201708/170801_152502_2748.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501572302,1501572302),(136,'1494825178662.png','uploads/image/201708/170801_152711_9145.png','uploads/thumb/201708/170801_152711_9145.png','png','image/png',625063,'2a1bf5a2543986ca1ce792cbdf714106','e55f3957c153a68a05d2dec4831876a5e6ceb65c',0,1501572431,1501572431),(137,'14948248211348.jpg','uploads/image/201708/170801_153113_5625.jpg','uploads/thumb/201708/170801_153113_5625.jpg','jpg','image/jpeg',281176,'f10ec79466ac79637837b6938abfe5fe','e759ba7bc7ba09cc43394a51bfe5c63f4cf2acc2',0,1501572673,1501572673),(138,'about-img.png','uploads/image/201708/170801_153303_4866.png','uploads/thumb/201708/170801_153303_4866.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501572783,1501572783),(139,'about-img.png','uploads/image/201708/170801_153928_7252.png','uploads/thumb/201708/170801_153928_7252.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501573168,1501573168),(140,'14902497429744.jpg','uploads/image/201708/170802_090937_9518.jpg','uploads/thumb/201708/170802_090937_9518.jpg','jpg','image/jpeg',66060,'d13de6f3ba94ac705dc6230181cf0c80','a3ae9b477090d99d042daf04927105366e3d1b8e',0,1501636177,1501636177),(141,'14902513937875.png','uploads/image/201708/170802_091321_9511.png','uploads/thumb/201708/170802_091321_9511.png','png','image/png',625063,'2a1bf5a2543986ca1ce792cbdf714106','e55f3957c153a68a05d2dec4831876a5e6ceb65c',0,1501636401,1501636401),(142,'14939467516289.jpg','uploads/image/201708/170802_091535_4644.jpg','uploads/thumb/201708/170802_091535_4644.jpg','jpg','image/jpeg',281176,'f10ec79466ac79637837b6938abfe5fe','e759ba7bc7ba09cc43394a51bfe5c63f4cf2acc2',0,1501636535,1501636535),(143,'14902513937875.png','uploads/image/201708/170802_091739_1052.png','uploads/thumb/201708/170802_091739_1052.png','png','image/png',625063,'2a1bf5a2543986ca1ce792cbdf714106','e55f3957c153a68a05d2dec4831876a5e6ceb65c',0,1501636660,1501636660),(144,'14902497429744.jpg','uploads/image/201708/170802_091850_7914.jpg','uploads/thumb/201708/170802_091850_7914.jpg','jpg','image/jpeg',66060,'d13de6f3ba94ac705dc6230181cf0c80','a3ae9b477090d99d042daf04927105366e3d1b8e',0,1501636730,1501636730),(145,'14938039429750.jpg','uploads/image/201708/170802_092735_2229.jpg','','jpg',NULL,16707,'3ebeb43a2380c8f538fec52a84d6903a','cfac0c8c68194539982c8de7ab83db6be02a45d8',0,1501637255,1501637255),(146,'170802_092735_2229.jpg','backend/web/uploads/image/201708/170802_092949_8230.jpg','backend/web/uploads/thumb/201708/170802_092949_8230.jpg','jpg','image/jpeg',16707,'3ebeb43a2380c8f538fec52a84d6903a','cfac0c8c68194539982c8de7ab83db6be02a45d8',0,1501637389,1501637389),(147,'170728_095947_3105.jpg','backend/web/uploads/image/201708/170802_094304_6128.jpg','backend/web/uploads/thumb/201708/170802_094304_6128.jpg','jpg','image/jpeg',124118,'b556ab6ac7ad79e64f44aa209dd19d12','00bb2150f8b9387444e539634e78a44f2268c53e',0,1501638185,1501638185),(148,'170728_100000_3802.jpg','backend/web/uploads/image/201708/170802_094314_4109.jpg','backend/web/uploads/thumb/201708/170802_094314_4109.jpg','jpg','image/jpeg',99975,'9456d195b7b4393da89267a185dc03c1','0e6903a421105ca3f3ab459c1c921badfa73abec',0,1501638194,1501638194),(149,'170728_095340_7572.jpg','backend/web/uploads/image/201708/170802_094559_5426.jpg','backend/web/uploads/thumb/201708/170802_094559_5426.jpg','jpg','image/jpeg',162406,'69d16fe42765bf60a705dd3f58ebfb59','74cf9887be47b93c6f2f5d2ff4e5dbe6149563e3',0,1501638359,1501638359),(150,'170728_095353_6137.jpg','backend/web/uploads/image/201708/170802_094611_4850.jpg','backend/web/uploads/thumb/201708/170802_094611_4850.jpg','jpg','image/jpeg',133881,'95c1e5b5c3d09531e0c5bd3c634087ef','5c8aeb8def2ba3912db64bd89409d651d50d3931',0,1501638371,1501638371),(151,'170728_095420_2190.png','uploads/image/201708/170802_104723_1818.png','uploads/thumb/201708/170802_104723_1818.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501642043,1501642043),(152,'170728_095420_2190.png','uploads/image/201708/170802_105658_7498.png','uploads/thumb/201708/170802_105658_7498.png','png','image/png',540633,'86b083693e411410ed16fbc0d48a7b49','e7d4bf1882650e43bd1e184495776f5fc585ad76',0,1501642618,1501642618),(153,'14902497429744555 (1).jpg','uploads/image/201708/170802_105728_5037.jpg','uploads/thumb/201708/170802_105728_5037.jpg','jpg','image/jpeg',66060,'d13de6f3ba94ac705dc6230181cf0c80','a3ae9b477090d99d042daf04927105366e3d1b8e',0,1501642648,1501642648),(154,'logo1.PNG','uploads/image/201709/170916_105953_2416.png','uploads/thumb/201709/170916_105953_2416.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1505530793,1505530793),(155,'logo1.PNG','uploads/image/201709/170916_110124_8914.png','uploads/thumb/201709/170916_110124_8914.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1505530884,1505530884),(156,'logo1.PNG','uploads/image/201709/170916_110234_4685.png','uploads/thumb/201709/170916_110234_4685.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1505530954,1505530954),(157,'logo1.PNG','uploads/image/201709/170916_110351_1564.png','uploads/thumb/201709/170916_110351_1564.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1505531031,1505531031),(158,'2600828784824117277.jpg','uploads/image/201709/170916_110543_8373.jpg','uploads/thumb/201709/170916_110543_8373.jpg','jpg','image/jpeg',374952,'797284b65cd2cebdf5bb8626ce24c92e','e3549eda3721499c19b0c65a4491835cf8989814',0,1505531144,1505531144),(159,'1194973045f91a108fo.jpg','uploads/image/201709/170916_111839_2339.jpg','uploads/thumb/201709/170916_111839_2339.jpg','jpg','image/jpeg',1453876,'5e19a4668a3137f1cb1f0b4a13e4e4c4','a90527bf83fa142f835fecb440cbb7cff756ab46',0,1505531919,1505531919),(160,'logo1.PNG','uploads/image/201709/170916_111915_1028.png','uploads/thumb/201709/170916_111915_1028.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1505531955,1505531955),(161,'logo1.PNG','uploads/image/201709/170916_140433_4638.png','uploads/thumb/201709/170916_140433_4638.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1505541873,1505541873),(162,'2600828784824117277.jpg','uploads/image/201709/170916_140518_9469.jpg','uploads/thumb/201709/170916_140518_9469.jpg','jpg','image/jpeg',374952,'797284b65cd2cebdf5bb8626ce24c92e','e3549eda3721499c19b0c65a4491835cf8989814',0,1505541918,1505541918),(163,'1194973045f91a108fo.jpg','uploads/image/201709/170916_140637_3833.jpg','uploads/thumb/201709/170916_140637_3833.jpg','jpg','image/jpeg',1453876,'5e19a4668a3137f1cb1f0b4a13e4e4c4','a90527bf83fa142f835fecb440cbb7cff756ab46',0,1505541997,1505541997),(164,'logo1.PNG','uploads/image/201709/170916_141002_9008.png','uploads/thumb/201709/170916_141002_9008.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1505542202,1505542202),(165,'2600828784824117277.jpg','uploads/image/201709/170916_141843_9343.jpg','uploads/thumb/201709/170916_141843_9343.jpg','jpg','image/jpeg',374952,'797284b65cd2cebdf5bb8626ce24c92e','e3549eda3721499c19b0c65a4491835cf8989814',0,1505542723,1505542723),(166,'5286.jpg','uploads/image/201709/170916_142139_3253.jpg','uploads/thumb/201709/170916_142139_3253.jpg','jpg','image/jpeg',1745531,'46b67ac250dbc6c2c472065cce8b317d','04e70a03ee8e49c2f8d0fa650bedb4c3de08bcff',0,1505542899,1505542899),(167,'logo1.PNG','uploads/image/201709/170916_143244_3489.png','uploads/thumb/201709/170916_143244_3489.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1505543564,1505543564),(168,'001_30.jpg','uploads/image/201709/170916_163144_3227.jpg','uploads/thumb/201709/170916_163144_3227.jpg','jpg','image/jpeg',10148,'98eca7c1169e9713979ff276cd7168b5','db3a2328d57fc5f3ddcf5a42ac9a106eb4f072fb',0,1505550704,1505550704),(169,'001_30.jpg','uploads/image/201709/170916_163242_3124.jpg','uploads/thumb/201709/170916_163242_3124.jpg','jpg','image/jpeg',10148,'98eca7c1169e9713979ff276cd7168b5','db3a2328d57fc5f3ddcf5a42ac9a106eb4f072fb',0,1505550762,1505550762),(170,'001_30.jpg','uploads/image/201709/170916_163305_8427.jpg','uploads/thumb/201709/170916_163305_8427.jpg','jpg','image/jpeg',10148,'98eca7c1169e9713979ff276cd7168b5','db3a2328d57fc5f3ddcf5a42ac9a106eb4f072fb',0,1505550785,1505550785),(171,'001_30.jpg','uploads/image/201709/170916_163328_2471.jpg','uploads/thumb/201709/170916_163328_2471.jpg','jpg','image/jpeg',10148,'98eca7c1169e9713979ff276cd7168b5','db3a2328d57fc5f3ddcf5a42ac9a106eb4f072fb',0,1505550808,1505550808),(172,'001_30.jpg','uploads/image/201709/170916_163402_8810.jpg','uploads/thumb/201709/170916_163402_8810.jpg','jpg','image/jpeg',10148,'98eca7c1169e9713979ff276cd7168b5','db3a2328d57fc5f3ddcf5a42ac9a106eb4f072fb',0,1505550842,1505550842),(173,'001_30.jpg','uploads/image/201709/170916_163434_6739.jpg','uploads/thumb/201709/170916_163434_6739.jpg','jpg','image/jpeg',10148,'98eca7c1169e9713979ff276cd7168b5','db3a2328d57fc5f3ddcf5a42ac9a106eb4f072fb',0,1505550874,1505550874),(174,'001_30.jpg','uploads/image/201709/170916_163817_1774.jpg','uploads/thumb/201709/170916_163817_1774.jpg','jpg','image/jpeg',10148,'98eca7c1169e9713979ff276cd7168b5','db3a2328d57fc5f3ddcf5a42ac9a106eb4f072fb',0,1505551097,1505551097),(175,'001_19.jpg','uploads/image/201709/170916_171722_7310.jpg','uploads/thumb/201709/170916_171722_7310.jpg','jpg','image/jpeg',33543,'a11ae3a9979800029989bc32c4e95766','ec1bb181897734c5693c98bef6b137eb1b6fbbd6',0,1505553442,1505553442),(176,'001_19.jpg','uploads/image/201709/170916_171807_5356.jpg','uploads/thumb/201709/170916_171807_5356.jpg','jpg','image/jpeg',33543,'a11ae3a9979800029989bc32c4e95766','ec1bb181897734c5693c98bef6b137eb1b6fbbd6',0,1505553487,1505553487),(177,'001_19.jpg','uploads/image/201709/170916_171839_2235.jpg','uploads/thumb/201709/170916_171839_2235.jpg','jpg','image/jpeg',33543,'a11ae3a9979800029989bc32c4e95766','ec1bb181897734c5693c98bef6b137eb1b6fbbd6',0,1505553519,1505553519),(178,'001_19.jpg','uploads/image/201709/170916_171858_5725.jpg','uploads/thumb/201709/170916_171858_5725.jpg','jpg','image/jpeg',33543,'a11ae3a9979800029989bc32c4e95766','ec1bb181897734c5693c98bef6b137eb1b6fbbd6',0,1505553538,1505553538),(179,'001_02.jpg','uploads/image/201709/170917_220802_7935.jpg','uploads/thumb/201709/170917_220802_7935.jpg','jpg','image/jpeg',361505,'6e9cf384f5c31f2d60dd41898cdabf64','af0c7eb3ae0c08bb46f6ce521fb2809109b36558',0,1505657282,1505657282),(180,'001_02.jpg','uploads/image/201709/170917_220822_9298.jpg','uploads/thumb/201709/170917_220822_9298.jpg','jpg','image/jpeg',361505,'6e9cf384f5c31f2d60dd41898cdabf64','af0c7eb3ae0c08bb46f6ce521fb2809109b36558',0,1505657302,1505657302),(181,'001_02.jpg','uploads/image/201709/170917_220835_2257.jpg','uploads/thumb/201709/170917_220835_2257.jpg','jpg','image/jpeg',361505,'6e9cf384f5c31f2d60dd41898cdabf64','af0c7eb3ae0c08bb46f6ce521fb2809109b36558',0,1505657315,1505657315),(182,'001_02.jpg','uploads/image/201709/170917_220922_6129.jpg','uploads/thumb/201709/170917_220922_6129.jpg','jpg','image/jpeg',361505,'6e9cf384f5c31f2d60dd41898cdabf64','af0c7eb3ae0c08bb46f6ce521fb2809109b36558',0,1505657362,1505657362),(183,'article_05.jpg','uploads/image/201709/170917_225343_4880.jpg','uploads/thumb/201709/170917_225343_4880.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1505660023,1505660023),(184,'article_05.jpg','uploads/image/201709/170917_225430_4619.jpg','uploads/thumb/201709/170917_225430_4619.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1505660070,1505660070),(185,'article_05.jpg','uploads/image/201709/170917_225452_9507.jpg','uploads/thumb/201709/170917_225452_9507.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1505660092,1505660092),(186,'article_05.jpg','uploads/image/201709/170917_225512_7481.jpg','uploads/thumb/201709/170917_225512_7481.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1505660112,1505660112),(187,'article_05.jpg','uploads/image/201709/170917_225537_4793.jpg','uploads/thumb/201709/170917_225537_4793.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1505660137,1505660137),(188,'article_05.jpg','uploads/image/201709/170917_225556_7293.jpg','uploads/thumb/201709/170917_225556_7293.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1505660156,1505660156),(189,'v2-9f1a14801765003e4e44aaa08b34b056_r.jpg','uploads/image/201709/170920_133729_7529.jpg','uploads/thumb/201709/170920_133729_7529.jpg','jpg','image/jpeg',853212,'9f1a14801765003e4e44aaa08b34b056','25ebffee66647500a3283975d492cf065f505bad',0,1505885849,1505885849),(190,'微信图片_20170913092153.jpg','backend/web/uploads/image/201709/170920_134935_8347.jpg','backend/web/uploads/thumb/201709/170920_134935_8347.jpg','jpg','image/jpeg',244744,'5cebb8d6973d135301e52ea7593ff4ee','ce4a40067ea13822bafcbf3656df48e5ed66086d',0,1505886575,1505886575),(191,'article_02.jpg','uploads/image/201709/170920_140111_3560.jpg','uploads/thumb/201709/170920_140111_3560.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887271,1505887271),(192,'article_02.jpg','uploads/image/201709/170920_140131_1800.jpg','uploads/thumb/201709/170920_140131_1800.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887291,1505887291),(193,'article_02.jpg','uploads/image/201709/170920_140143_1632.jpg','uploads/thumb/201709/170920_140143_1632.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887303,1505887303),(194,'article_02.jpg','uploads/image/201709/170920_140222_1846.jpg','uploads/thumb/201709/170920_140222_1846.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887342,1505887342),(195,'article_02.jpg','uploads/image/201709/170920_140233_2784.jpg','uploads/thumb/201709/170920_140233_2784.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887353,1505887353),(196,'article_02.jpg','uploads/image/201709/170920_140244_5833.jpg','uploads/thumb/201709/170920_140244_5833.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887364,1505887364),(197,'001_10.jpg','uploads/image/201709/170920_140245_8310.jpg','uploads/thumb/201709/170920_140245_8310.jpg','jpg','image/jpeg',43737,'611c6e85f71fe54a2b2608d3d1275ffd','8421310c9379d588d996f0246b6bdd62b474dd8e',0,1505887365,1505887365),(198,'001_05.jpg','uploads/image/201709/170920_140317_8572.jpg','uploads/thumb/201709/170920_140317_8572.jpg','jpg','image/jpeg',47332,'ecaa121e5bf675c29c2901bbbaf56f7e','ac7b78a7a7405a994af06324be369f7859da6042',0,1505887397,1505887397),(199,'article_02.jpg','uploads/image/201709/170920_140330_5955.jpg','uploads/thumb/201709/170920_140330_5955.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887410,1505887410),(200,'article_02.jpg','uploads/image/201709/170920_140355_2669.jpg','uploads/thumb/201709/170920_140355_2669.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887435,1505887435),(201,'001_11.jpg','uploads/image/201709/170920_140359_6032.jpg','uploads/thumb/201709/170920_140359_6032.jpg','jpg','image/jpeg',34826,'dd9d7b37366146d6d52ad6b510be49f8','5aeaef637287aa13143f06cd6fbd67dda9cc93aa',0,1505887439,1505887439),(202,'article_02.jpg','uploads/image/201709/170920_140415_1328.jpg','uploads/thumb/201709/170920_140415_1328.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887455,1505887455),(203,'article_02.jpg','uploads/image/201709/170920_140426_4202.jpg','uploads/thumb/201709/170920_140426_4202.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887466,1505887466),(204,'001_15.jpg','uploads/image/201709/170920_140430_2064.jpg','uploads/thumb/201709/170920_140430_2064.jpg','jpg','image/jpeg',42644,'9b947681715e8f7b781ad8eeb8ef4c87','ba154b3d4dcc0475a10bd7a180784597c812a711',0,1505887470,1505887470),(205,'article_02.jpg','uploads/image/201709/170920_140441_1440.jpg','uploads/thumb/201709/170920_140441_1440.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887481,1505887481),(206,'article_02.jpg','uploads/image/201709/170920_140503_5507.jpg','uploads/thumb/201709/170920_140503_5507.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887503,1505887503),(207,'article_02.jpg','uploads/image/201709/170920_140520_4224.jpg','uploads/thumb/201709/170920_140520_4224.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887520,1505887520),(208,'article_02.jpg','uploads/image/201709/170920_140533_5375.jpg','uploads/thumb/201709/170920_140533_5375.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887533,1505887533),(209,'article_02.jpg','uploads/image/201709/170920_140554_1038.jpg','uploads/thumb/201709/170920_140554_1038.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887555,1505887555),(210,'article_02.jpg','uploads/image/201709/170920_140555_3970.jpg','uploads/thumb/201709/170920_140555_3970.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887555,1505887555),(211,'001_22.jpg','uploads/image/201709/170920_140637_8429.jpg','uploads/thumb/201709/170920_140637_8429.jpg','jpg','image/jpeg',63123,'aea04f6e8b503fce1caf94bdb36335cc','8c72ec4a95fbb1c572a6f59e02e083fc9bbff3ae',0,1505887597,1505887597),(212,'001_22.jpg','uploads/image/201709/170920_140743_7909.jpg','uploads/thumb/201709/170920_140743_7909.jpg','jpg','image/jpeg',63123,'aea04f6e8b503fce1caf94bdb36335cc','8c72ec4a95fbb1c572a6f59e02e083fc9bbff3ae',0,1505887663,1505887663),(213,'article_02.jpg','uploads/image/201709/170920_140834_7394.jpg','uploads/thumb/201709/170920_140834_7394.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1505887714,1505887714),(214,'001_22.jpg','uploads/image/201709/170920_140914_9688.jpg','uploads/thumb/201709/170920_140914_9688.jpg','jpg','image/jpeg',63123,'aea04f6e8b503fce1caf94bdb36335cc','8c72ec4a95fbb1c572a6f59e02e083fc9bbff3ae',0,1505887754,1505887754),(215,'article_05.jpg','uploads/image/201709/170920_174137_3530.jpg','uploads/thumb/201709/170920_174137_3530.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1505900497,1505900497),(216,'article_05.jpg','uploads/image/201709/170920_174943_3034.jpg','uploads/thumb/201709/170920_174943_3034.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1505900983,1505900983),(217,'article_05.jpg','backend/web/uploads/image/201709/170920_175005_5883.jpg','backend/web/uploads/thumb/201709/170920_175005_5883.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1505901005,1505901005),(218,'001_15.jpg','uploads/image/201709/170921_111333_8483.jpg','uploads/thumb/201709/170921_111333_8483.jpg','jpg','image/jpeg',42644,'9b947681715e8f7b781ad8eeb8ef4c87','ba154b3d4dcc0475a10bd7a180784597c812a711',0,1505963613,1505963613),(219,'001_10.jpg','uploads/image/201709/170921_114521_7409.jpg','uploads/thumb/201709/170921_114521_7409.jpg','jpg','image/jpeg',43737,'611c6e85f71fe54a2b2608d3d1275ffd','8421310c9379d588d996f0246b6bdd62b474dd8e',0,1505965521,1505965521),(220,'001_08.jpg','uploads/image/201709/170921_120102_9369.jpg','uploads/thumb/201709/170921_120102_9369.jpg','jpg','image/jpeg',36431,'b534d29a044d861ec6b7504253f0a9f4','5f05aa0cf3eb17b823844359a1417d3172744c57',0,1505966462,1505966462),(221,'001_08.jpg','uploads/image/201709/170921_120332_8221.jpg','uploads/thumb/201709/170921_120332_8221.jpg','jpg','image/jpeg',36431,'b534d29a044d861ec6b7504253f0a9f4','5f05aa0cf3eb17b823844359a1417d3172744c57',0,1505966612,1505966612),(222,'001_10.jpg','uploads/image/201709/170921_120405_2281.jpg','uploads/thumb/201709/170921_120405_2281.jpg','jpg','image/jpeg',43737,'611c6e85f71fe54a2b2608d3d1275ffd','8421310c9379d588d996f0246b6bdd62b474dd8e',0,1505966645,1505966645),(223,'001_11.jpg','uploads/image/201709/170921_120424_9630.jpg','uploads/thumb/201709/170921_120424_9630.jpg','jpg','image/jpeg',34826,'dd9d7b37366146d6d52ad6b510be49f8','5aeaef637287aa13143f06cd6fbd67dda9cc93aa',0,1505966664,1505966664),(224,'001_15.jpg','uploads/image/201709/170921_120500_6838.jpg','uploads/thumb/201709/170921_120500_6838.jpg','jpg','image/jpeg',42644,'9b947681715e8f7b781ad8eeb8ef4c87','ba154b3d4dcc0475a10bd7a180784597c812a711',0,1505966700,1505966700),(225,'001_15.jpg','uploads/image/201709/170921_120606_8146.jpg','uploads/thumb/201709/170921_120606_8146.jpg','jpg','image/jpeg',42644,'9b947681715e8f7b781ad8eeb8ef4c87','ba154b3d4dcc0475a10bd7a180784597c812a711',0,1505966766,1505966766),(226,'001_22.jpg','uploads/image/201709/170921_132707_1798.jpg','uploads/thumb/201709/170921_132707_1798.jpg','jpg','image/jpeg',63123,'aea04f6e8b503fce1caf94bdb36335cc','8c72ec4a95fbb1c572a6f59e02e083fc9bbff3ae',0,1505971627,1505971627),(227,'001_22.jpg','uploads/image/201709/170921_155748_1368.jpg','uploads/thumb/201709/170921_155748_1368.jpg','jpg','image/jpeg',63123,'aea04f6e8b503fce1caf94bdb36335cc','8c72ec4a95fbb1c572a6f59e02e083fc9bbff3ae',0,1505980668,1505980668),(228,'001_27.jpg','uploads/image/201709/170921_161836_8038.jpg','uploads/thumb/201709/170921_161836_8038.jpg','jpg','image/jpeg',35577,'a2f0e41d694663652fd3510327be052c','603819b52ffa127e63e8afb55c27ca066d29379d',0,1505981916,1505981916),(229,'001_27.jpg','uploads/image/201709/170921_161854_5689.jpg','uploads/thumb/201709/170921_161854_5689.jpg','jpg','image/jpeg',35577,'a2f0e41d694663652fd3510327be052c','603819b52ffa127e63e8afb55c27ca066d29379d',0,1505981934,1505981934),(230,'TIM图片20170904095445.jpg','uploads/image/201709/170922_102442_1733.jpg','uploads/thumb/201709/170922_102442_1733.jpg','jpg','image/jpeg',46325,'de34f4acb5f14832416fd9a841e68b7a','5f7bf1e4db3809fcfb63a73b30f6245de4279015',0,1506047082,1506047082),(231,'TIM图片20170904095445.jpg','uploads/image/201709/170922_102530_2615.jpg','uploads/thumb/201709/170922_102530_2615.jpg','jpg','image/jpeg',46325,'de34f4acb5f14832416fd9a841e68b7a','5f7bf1e4db3809fcfb63a73b30f6245de4279015',0,1506047130,1506047130),(232,'TIM图片20170904095445.jpg','uploads/image/201709/170922_104532_9390.jpg','uploads/thumb/201709/170922_104532_9390.jpg','jpg','image/jpeg',46325,'de34f4acb5f14832416fd9a841e68b7a','5f7bf1e4db3809fcfb63a73b30f6245de4279015',0,1506048332,1506048332),(233,'267914167440353941.png','uploads/image/201709/170922_105556_4147.png','uploads/thumb/201709/170922_105556_4147.png','png','image/png',16339,'0ef4f476874481045fc5aa8b25b416f6','365fb4aca282c5d4b321c671c08abbef5cd0f72f',0,1506048956,1506048956),(234,'v2-9f1a14801765003e4e44aaa08b34b056_r.jpg','uploads/image/201709/170922_105617_9429.jpg','uploads/thumb/201709/170922_105617_9429.jpg','jpg','image/jpeg',853212,'9f1a14801765003e4e44aaa08b34b056','25ebffee66647500a3283975d492cf065f505bad',0,1506048978,1506048978),(235,'267914167440353941.png','uploads/image/201709/170922_110534_6403.png','uploads/thumb/201709/170922_110534_6403.png','png','image/png',16339,'0ef4f476874481045fc5aa8b25b416f6','365fb4aca282c5d4b321c671c08abbef5cd0f72f',0,1506049534,1506049534),(236,'v2-9f1a14801765003e4e44aaa08b34b056_r.jpg','uploads/image/201709/170922_110534_7909.jpg','uploads/thumb/201709/170922_110534_7909.jpg','jpg','image/jpeg',853212,'9f1a14801765003e4e44aaa08b34b056','25ebffee66647500a3283975d492cf065f505bad',0,1506049535,1506049535),(237,'267914167440353941.png','uploads/image/201709/170922_145238_7076.png','uploads/thumb/201709/170922_145238_7076.png','png','image/png',16339,'0ef4f476874481045fc5aa8b25b416f6','365fb4aca282c5d4b321c671c08abbef5cd0f72f',0,1506063158,1506063158),(238,'v2-9f1a14801765003e4e44aaa08b34b056_r.jpg','uploads/image/201709/170922_145239_4498.jpg','uploads/thumb/201709/170922_145239_4498.jpg','jpg','image/jpeg',853212,'9f1a14801765003e4e44aaa08b34b056','25ebffee66647500a3283975d492cf065f505bad',0,1506063159,1506063159),(239,'logo1.PNG','uploads/image/201709/170923_090450_9991.png','uploads/thumb/201709/170923_090450_9991.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1506128690,1506128690),(240,'logo1.PNG','uploads/image/201709/170923_090549_9647.png','uploads/thumb/201709/170923_090549_9647.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1506128749,1506128749),(241,'logo1.PNG','uploads/image/201709/170923_091111_3786.png','uploads/thumb/201709/170923_091111_3786.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1506129071,1506129071),(242,'logo1.PNG','uploads/image/201709/170923_091640_4379.png','uploads/thumb/201709/170923_091640_4379.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1506129400,1506129400),(243,'2600828784824117277.jpg','uploads/image/201709/170923_091715_4573.jpg','uploads/thumb/201709/170923_091715_4573.jpg','jpg','image/jpeg',374952,'797284b65cd2cebdf5bb8626ce24c92e','e3549eda3721499c19b0c65a4491835cf8989814',0,1506129435,1506129435),(244,'logo1.png','uploads/image/201709/170923_093212_2450.png','uploads/thumb/201709/170923_093212_2450.png','png','image/png',229877,'e8942eb3fa8317d6b8a3e6c854bebbb6','01f584c9657c9f214a8f861552b72157f2e9df01',0,1506130332,1506130332),(245,'微信图片_20170425175721.jpg','uploads/image/201709/170923_093315_6690.jpg','uploads/thumb/201709/170923_093315_6690.jpg','jpg','image/jpeg',98389,'bafc2ebb70ed7d52985be2b4ff6a8774','dff89b716ab5ae8848cfaaaa04999c3e9dc4b748',0,1506130395,1506130395),(246,'001_27.jpg','uploads/image/201709/170923_094326_6999.jpg','uploads/thumb/201709/170923_094326_6999.jpg','jpg','image/jpeg',35577,'a2f0e41d694663652fd3510327be052c','603819b52ffa127e63e8afb55c27ca066d29379d',0,1506131006,1506131006),(247,'001_27.jpg','uploads/image/201709/170923_094515_8292.jpg','uploads/thumb/201709/170923_094515_8292.jpg','jpg','image/jpeg',35577,'a2f0e41d694663652fd3510327be052c','603819b52ffa127e63e8afb55c27ca066d29379d',0,1506131115,1506131115),(248,'001_27.jpg','uploads/image/201709/170923_094534_8758.jpg','uploads/thumb/201709/170923_094534_8758.jpg','jpg','image/jpeg',35577,'a2f0e41d694663652fd3510327be052c','603819b52ffa127e63e8afb55c27ca066d29379d',0,1506131134,1506131134),(249,'001_27.jpg','uploads/image/201709/170923_094615_9409.jpg','uploads/thumb/201709/170923_094615_9409.jpg','jpg','image/jpeg',35577,'a2f0e41d694663652fd3510327be052c','603819b52ffa127e63e8afb55c27ca066d29379d',0,1506131175,1506131175),(250,'001_27.jpg','uploads/image/201709/170923_094645_1698.jpg','uploads/thumb/201709/170923_094645_1698.jpg','jpg','image/jpeg',35577,'a2f0e41d694663652fd3510327be052c','603819b52ffa127e63e8afb55c27ca066d29379d',0,1506131205,1506131205),(251,'微信图片_20170425175721.jpg','uploads/image/201709/170923_151017_2722.jpg','uploads/thumb/201709/170923_151017_2722.jpg','jpg','image/jpeg',98389,'bafc2ebb70ed7d52985be2b4ff6a8774','dff89b716ab5ae8848cfaaaa04999c3e9dc4b748',0,1506150617,1506150617),(252,'001_30.jpg','uploads/image/201709/170923_153128_7715.jpg','uploads/thumb/201709/170923_153128_7715.jpg','jpg','image/jpeg',10148,'98eca7c1169e9713979ff276cd7168b5','db3a2328d57fc5f3ddcf5a42ac9a106eb4f072fb',0,1506151888,1506151888),(253,'001_30.jpg','uploads/image/201709/170923_153346_7372.jpg','uploads/thumb/201709/170923_153346_7372.jpg','jpg','image/jpeg',10148,'98eca7c1169e9713979ff276cd7168b5','db3a2328d57fc5f3ddcf5a42ac9a106eb4f072fb',0,1506152026,1506152026),(254,'small.png','uploads/image/201709/170923_153851_7187.png','uploads/thumb/201709/170923_153851_7187.png','png','image/png',294514,'04fbf0e8aa3ecbf85df5603a9b3cbf88','a5579c034cdbe26065ad01b8d20d1839c1737362',0,1506152331,1506152331),(255,'icon2.png','uploads/image/201709/170923_160309_3699.png','uploads/thumb/201709/170923_160309_3699.png','png','image/png',1508,'8852ea73da10f9211e0f907d34560bfb','bd247678168a26a37a95f07e83eed990c443fd11',0,1506153789,1506153789),(256,'icon6.png','uploads/image/201709/170923_160356_6439.png','uploads/thumb/201709/170923_160356_6439.png','png','image/png',1219,'cad0457797833d457a23edcd1f4ac784','5472abf65367628d98ca7de1eb6e9e6d13fd92ae',0,1506153836,1506153836),(257,'icon7.png','uploads/image/201709/170923_160429_3550.png','uploads/thumb/201709/170923_160429_3550.png','png','image/png',756,'a2c77feeb1e7aba01a0eb9af5d5b74d5','d0ee719b46a71b17f3141678f9e73767620484d2',0,1506153869,1506153869),(258,'icon4.png','uploads/image/201709/170923_160447_9258.png','uploads/thumb/201709/170923_160447_9258.png','png','image/png',2104,'1dd7df7a1fbad2a22d9838eacecc9a1c','257492cf5984bc90e4014a60fdd4966c4cc68d99',0,1506153887,1506153887),(259,'icon8.png','uploads/image/201709/170923_160538_4971.png','uploads/thumb/201709/170923_160538_4971.png','png','image/png',734,'a7cfc38bf356ba9aa354e784ea820609','fd7b9ea6e4f78bf6b61adde0dc07a7f990cc8795',0,1506153938,1506153938),(260,'icon5.png','uploads/image/201709/170923_160557_3491.png','uploads/thumb/201709/170923_160557_3491.png','png','image/png',1068,'f0e27e6729dad746a38e2b4b35fd7df7','cb3aa4a95a06b099a0ccbfb7cb26370c76ba49a3',0,1506153957,1506153957),(261,'icon1.png','uploads/image/201709/170923_160618_5779.png','uploads/thumb/201709/170923_160618_5779.png','png','image/png',1378,'b404ef72f715483ff6e2d2806bbc7db0','247eef5bd87f2b519a851b5ee81155ff8a5631de',0,1506153978,1506153978),(262,'icon3.png','uploads/image/201709/170923_160655_3143.png','uploads/thumb/201709/170923_160655_3143.png','png','image/png',1481,'947e47cb2abf90bac155462ee1094f7f','ce32143267aeeec5e0a00ceee014ea959c08d99d',0,1506154015,1506154015),(263,'001_27.jpg','uploads/image/201709/170923_161712_1325.jpg','uploads/thumb/201709/170923_161712_1325.jpg','jpg','image/jpeg',35577,'a2f0e41d694663652fd3510327be052c','603819b52ffa127e63e8afb55c27ca066d29379d',0,1506154632,1506154632),(264,'001_08.jpg','uploads/image/201709/170923_161819_8880.jpg','uploads/thumb/201709/170923_161819_8880.jpg','jpg','image/jpeg',36431,'b534d29a044d861ec6b7504253f0a9f4','5f05aa0cf3eb17b823844359a1417d3172744c57',0,1506154699,1506154699),(265,'qrcode (1).png','uploads/image/201709/170923_202954_8234.png','uploads/thumb/201709/170923_202954_8234.png','png','image/png',478,'835c6874a02238f650cac8c63ead126a','fd7e084e686c418e42d26cc21122e3142f2c1738',0,1506169794,1506169794),(266,'article_05.jpg','uploads/image/201709/170923_203101_8960.jpg','uploads/thumb/201709/170923_203101_8960.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1506169861,1506169861),(267,'article_05.jpg','uploads/image/201709/170923_203427_2343.jpg','uploads/thumb/201709/170923_203427_2343.jpg','jpg','image/jpeg',169654,'47a73d879b589902eb378374261ef56f','eae5cc67986b58ca43ed7e1bf299f6653e9b1008',0,1506170067,1506170067),(268,'article_02.jpg','uploads/image/201709/170925_114505_2236.jpg','uploads/thumb/201709/170925_114505_2236.jpg','jpg','image/jpeg',150445,'96aaef833fe19a745e32cca1fec46ce1','d9b7c90fba0cfa5fdd4691eff7e50d647ab439cb',0,1506311105,1506311105),(269,'v2-9f1a14801765003e4e44aaa08b34b056_r.jpg','uploads/image/201709/170925_115236_5491.jpg','uploads/thumb/201709/170925_115236_5491.jpg','jpg','image/jpeg',853212,'9f1a14801765003e4e44aaa08b34b056','25ebffee66647500a3283975d492cf065f505bad',0,1506311557,1506311557),(270,'微信图片_20170913092153.jpg','backend/web/uploads/image/201709/170925_115251_1667.jpg','backend/web/uploads/thumb/201709/170925_115251_1667.jpg','jpg','image/jpeg',244744,'5cebb8d6973d135301e52ea7593ff4ee','ce4a40067ea13822bafcbf3656df48e5ed66086d',0,1506311571,1506311571),(271,'微信图片_20170913092153.jpg','backend/web/uploads/image/201709/170925_115319_4200.jpg','backend/web/uploads/thumb/201709/170925_115319_4200.jpg','jpg','image/jpeg',244744,'5cebb8d6973d135301e52ea7593ff4ee','ce4a40067ea13822bafcbf3656df48e5ed66086d',0,1506311599,1506311599),(272,'微信图片_20170913092153.jpg','backend/web/uploads/image/201709/170925_115347_8612.jpg','backend/web/uploads/thumb/201709/170925_115347_8612.jpg','jpg','image/jpeg',244744,'5cebb8d6973d135301e52ea7593ff4ee','ce4a40067ea13822bafcbf3656df48e5ed66086d',0,1506311627,1506311627),(273,'微信图片_20170913092153.jpg','backend/web/uploads/image/201709/170925_115759_3214.jpg','backend/web/uploads/thumb/201709/170925_115759_3214.jpg','jpg','image/jpeg',244744,'5cebb8d6973d135301e52ea7593ff4ee','ce4a40067ea13822bafcbf3656df48e5ed66086d',0,1506311879,1506311879),(274,'微信图片_20170913092153.jpg','backend/web/uploads/image/201709/170925_115905_2149.jpg','backend/web/uploads/thumb/201709/170925_115905_2149.jpg','jpg','image/jpeg',244744,'5cebb8d6973d135301e52ea7593ff4ee','ce4a40067ea13822bafcbf3656df48e5ed66086d',0,1506311945,1506311945),(275,'3.jpg','uploads/image/201709/170925_143135_6040.jpg','uploads/thumb/201709/170925_143135_6040.jpg','jpg','image/jpeg',155159,'a582194aa0c025315277192cfbc811bb','949f0dd555f765aa834908c5ef1de9d7df496657',0,1506321095,1506321095),(276,'001_19.jpg','uploads/image/201709/170925_143548_7654.jpg','uploads/thumb/201709/170925_143548_7654.jpg','jpg','image/jpeg',33543,'a11ae3a9979800029989bc32c4e95766','ec1bb181897734c5693c98bef6b137eb1b6fbbd6',0,1506321348,1506321348),(277,'3.jpg','uploads/image/201709/170925_145738_6542.jpg','uploads/thumb/201709/170925_145738_6542.jpg','jpg','image/jpeg',155159,'a582194aa0c025315277192cfbc811bb','949f0dd555f765aa834908c5ef1de9d7df496657',0,1506322658,1506322658),(278,'2.jpg','uploads/image/201709/170925_145833_5608.jpg','uploads/thumb/201709/170925_145833_5608.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506322713,1506322713),(279,'001_19.jpg','uploads/image/201709/170925_150934_8649.jpg','uploads/thumb/201709/170925_150934_8649.jpg','jpg','image/jpeg',33543,'a11ae3a9979800029989bc32c4e95766','ec1bb181897734c5693c98bef6b137eb1b6fbbd6',0,1506323374,1506323374),(280,'001_19.jpg','uploads/image/201709/170925_151308_4737.jpg','uploads/thumb/201709/170925_151308_4737.jpg','jpg','image/jpeg',33543,'a11ae3a9979800029989bc32c4e95766','ec1bb181897734c5693c98bef6b137eb1b6fbbd6',0,1506323588,1506323588),(281,'001_19.jpg','uploads/image/201709/170925_151453_5699.jpg','uploads/thumb/201709/170925_151453_5699.jpg','jpg','image/jpeg',33543,'a11ae3a9979800029989bc32c4e95766','ec1bb181897734c5693c98bef6b137eb1b6fbbd6',0,1506323693,1506323693),(282,'1.jpg','uploads/image/201709/170925_153223_2931.jpg','uploads/thumb/201709/170925_153223_2931.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506324743,1506324743),(283,'1.jpg','uploads/image/201709/170925_153252_2648.jpg','uploads/thumb/201709/170925_153252_2648.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506324772,1506324772),(284,'1.jpg','uploads/image/201709/170925_153602_1582.jpg','uploads/thumb/201709/170925_153602_1582.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506324962,1506324962),(285,'1.jpg','uploads/image/201709/170925_153837_1899.jpg','uploads/thumb/201709/170925_153837_1899.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325117,1506325117),(286,'1.jpg','uploads/image/201709/170925_153923_2318.jpg','uploads/thumb/201709/170925_153923_2318.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325163,1506325163),(287,'1.jpg','uploads/image/201709/170925_153947_8120.jpg','uploads/thumb/201709/170925_153947_8120.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325187,1506325187),(288,'1.jpg','uploads/image/201709/170925_154004_8184.jpg','uploads/thumb/201709/170925_154004_8184.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325204,1506325204),(289,'1.jpg','uploads/image/201709/170925_154036_2074.jpg','uploads/thumb/201709/170925_154036_2074.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325236,1506325236),(290,'1.jpg','uploads/image/201709/170925_154126_7926.jpg','uploads/thumb/201709/170925_154126_7926.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325286,1506325286),(291,'1.jpg','uploads/image/201709/170925_154141_5180.jpg','uploads/thumb/201709/170925_154141_5180.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325302,1506325302),(292,'1.jpg','uploads/image/201709/170925_154157_7961.jpg','uploads/thumb/201709/170925_154157_7961.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325317,1506325317),(293,'1.jpg','uploads/image/201709/170925_154221_9081.jpg','uploads/thumb/201709/170925_154221_9081.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325341,1506325341),(294,'1.jpg','uploads/image/201709/170925_154234_9828.jpg','uploads/thumb/201709/170925_154234_9828.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325354,1506325354),(295,'1.jpg','uploads/image/201709/170925_154255_7166.jpg','uploads/thumb/201709/170925_154255_7166.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506325375,1506325375),(296,'3.jpg','uploads/image/201709/170925_154333_9936.jpg','uploads/thumb/201709/170925_154333_9936.jpg','jpg','image/jpeg',155159,'a582194aa0c025315277192cfbc811bb','949f0dd555f765aa834908c5ef1de9d7df496657',0,1506325413,1506325413),(297,'1.jpg','uploads/image/201709/170925_170005_1363.jpg','uploads/thumb/201709/170925_170005_1363.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506330006,1506330006),(298,'1.jpg','uploads/image/201709/170925_170022_7358.jpg','uploads/thumb/201709/170925_170022_7358.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506330022,1506330022),(299,'1.jpg','uploads/image/201709/170925_170036_5097.jpg','uploads/thumb/201709/170925_170036_5097.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506330036,1506330036),(300,'1.jpg','uploads/image/201709/170925_170052_5889.jpg','uploads/thumb/201709/170925_170052_5889.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506330052,1506330052),(301,'1.jpg','uploads/image/201709/170925_170107_3399.jpg','uploads/thumb/201709/170925_170107_3399.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506330067,1506330067),(302,'1.jpg','uploads/image/201709/170925_170122_7468.jpg','uploads/thumb/201709/170925_170122_7468.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506330082,1506330082),(303,'1.jpg','uploads/image/201709/170925_170138_6913.jpg','uploads/thumb/201709/170925_170138_6913.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506330098,1506330098),(304,'2.jpg','uploads/image/201709/170925_171413_1733.jpg','uploads/thumb/201709/170925_171413_1733.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506330853,1506330853),(305,'2.jpg','uploads/image/201709/170925_171432_3947.jpg','uploads/thumb/201709/170925_171432_3947.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506330872,1506330872),(306,'2.jpg','uploads/image/201709/170925_171451_2138.jpg','uploads/thumb/201709/170925_171451_2138.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506330891,1506330891),(307,'2.jpg','uploads/image/201709/170925_171525_5436.jpg','uploads/thumb/201709/170925_171525_5436.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506330925,1506330925),(308,'1.jpg','uploads/image/201709/170925_171649_7486.jpg','uploads/thumb/201709/170925_171649_7486.jpg','jpg','image/jpeg',271908,'5453106aa79ccdb5556bc6568da5fe79','3fc49d577dd4376b369227f05c3d84f836ec8553',0,1506331009,1506331009),(309,'2.jpg','uploads/image/201709/170925_171712_6983.jpg','uploads/thumb/201709/170925_171712_6983.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506331032,1506331032),(310,'2.jpg','uploads/image/201709/170925_171730_9049.jpg','uploads/thumb/201709/170925_171730_9049.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506331050,1506331050),(311,'2.jpg','uploads/image/201709/170925_171750_3878.jpg','uploads/thumb/201709/170925_171750_3878.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506331070,1506331070),(312,'2.jpg','uploads/image/201709/170925_171825_4742.jpg','uploads/thumb/201709/170925_171825_4742.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506331105,1506331105),(313,'2.jpg','uploads/image/201709/170925_171840_5630.jpg','uploads/thumb/201709/170925_171840_5630.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506331120,1506331120),(314,'2.jpg','uploads/image/201709/170925_171923_5991.jpg','uploads/thumb/201709/170925_171923_5991.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506331163,1506331163),(315,'2.jpg','uploads/image/201709/170925_171953_2381.jpg','uploads/thumb/201709/170925_171953_2381.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506331193,1506331193),(316,'2.jpg','uploads/image/201709/170925_172028_2460.jpg','uploads/thumb/201709/170925_172028_2460.jpg','jpg','image/jpeg',350501,'ebcfe95de8c5067d59e85a11136172a3','dc33dc7d98efda0320023e4e18faf190ad397e36',0,1506331228,1506331228),(317,'zhengxing-2_04.jpg','uploads/image/201709/170927_095740_2196.jpg','uploads/thumb/201709/170927_095740_2196.jpg','jpg','image/jpeg',44151,'44e86b1ef8b06b9855ee5f4f5fd89e16','4a42bd564a24d5bd881f79b0b0d2559e96694101',0,1506477460,1506477460),(318,'zhengxing-2_05.jpg','uploads/image/201709/170927_095837_5393.jpg','uploads/thumb/201709/170927_095837_5393.jpg','jpg','image/jpeg',45963,'6ac73364b723dc5073f5e0685df050c5','4f24923e2cbacbe5bbe21cc8a533884c409db80d',0,1506477517,1506477517),(319,'zhengxing-2_12.jpg','uploads/image/201709/170927_095934_2460.jpg','uploads/thumb/201709/170927_095934_2460.jpg','jpg','image/jpeg',61598,'0f03ff29ade02ba4756be1f8915214bc','6c390352a9eca6232442fe9fd373210f505607c1',0,1506477574,1506477574),(320,'zhengxing-2_05.jpg','uploads/image/201709/170927_100012_5517.jpg','uploads/thumb/201709/170927_100012_5517.jpg','jpg','image/jpeg',45963,'6ac73364b723dc5073f5e0685df050c5','4f24923e2cbacbe5bbe21cc8a533884c409db80d',0,1506477612,1506477612),(321,'zhengxing-2_11.jpg','uploads/image/201709/170927_100201_8382.jpg','uploads/thumb/201709/170927_100201_8382.jpg','jpg','image/jpeg',33705,'c0bc1cf1fa9c550b6e1e38ac17ef569c','7bc01005c5c598e74598c0b32eaabd93cda81f9a',0,1506477721,1506477721),(322,'zhengxing-2_07.jpg','uploads/image/201709/170927_100431_4887.jpg','uploads/thumb/201709/170927_100431_4887.jpg','jpg','image/jpeg',93733,'d34d0872a271002efd0066f16c414469','177d1c71fd8fa03ce80aa3702c553a19d56a286f',0,1506477871,1506477871),(323,'zhengxing-2_07.jpg','uploads/image/201709/170927_100535_7710.jpg','uploads/thumb/201709/170927_100535_7710.jpg','jpg','image/jpeg',93733,'d34d0872a271002efd0066f16c414469','177d1c71fd8fa03ce80aa3702c553a19d56a286f',0,1506477935,1506477935),(324,'zhengxing-2_07.jpg','uploads/image/201709/170927_100703_1194.jpg','uploads/thumb/201709/170927_100703_1194.jpg','jpg','image/jpeg',93733,'d34d0872a271002efd0066f16c414469','177d1c71fd8fa03ce80aa3702c553a19d56a286f',0,1506478023,1506478023),(325,'zhengxing-2_07.jpg','uploads/image/201709/170927_100736_1424.jpg','uploads/thumb/201709/170927_100736_1424.jpg','jpg','image/jpeg',93733,'d34d0872a271002efd0066f16c414469','177d1c71fd8fa03ce80aa3702c553a19d56a286f',0,1506478056,1506478056),(326,'zhengxing-2_19.jpg','uploads/image/201709/170927_101654_4478.jpg','uploads/thumb/201709/170927_101654_4478.jpg','jpg','image/jpeg',69255,'bafd5448d4774d370aefafb8921ad731','aa51a54a5f98eb0135445c72c3372df1af77a16f',0,1506478614,1506478614),(327,'zhengxing-2_17.jpg','uploads/image/201709/170927_102220_1162.jpg','uploads/thumb/201709/170927_102220_1162.jpg','jpg','image/jpeg',43428,'3208295c4c8bdaf5dfe58133ed0d2cb4','37cb26e01f6e15fb0598a0016c14df18819ced4b',0,1506478940,1506478940),(328,'zhengxing-2_28.jpg','uploads/image/201709/170927_102302_7084.jpg','uploads/thumb/201709/170927_102302_7084.jpg','jpg','image/jpeg',12520,'91252c72bfd31646b6efa1e68a2d0a82','4a7c45a00435a00fb84ef9b44e28d31e79be7e2f',0,1506478982,1506478982),(329,'zhengxing-2_34.jpg','uploads/image/201709/170927_102321_8905.jpg','uploads/thumb/201709/170927_102321_8905.jpg','jpg','image/jpeg',17066,'b339fd80b3f1191f7241a67d3793f4b7','bbe1b70f242008ff18d7f54d4158f1a3e77219aa',0,1506479001,1506479001),(330,'zhengxing-2_31.jpg','uploads/image/201709/170927_102355_9610.jpg','uploads/thumb/201709/170927_102355_9610.jpg','jpg','image/jpeg',14370,'136c20e3b7a4fce98c37095c4927b774','1d73e6a77306c0f00e4e3c36513e8628f1640131',0,1506479035,1506479035),(331,'zhengxing-2_22.jpg','uploads/image/201709/170927_102443_8604.jpg','uploads/thumb/201709/170927_102443_8604.jpg','jpg','image/jpeg',33302,'c05b0817eb5e8caf494b94d68b024d5f','6978caf3c2e2d5849312ea1d1d853b79f82bbec0',0,1506479083,1506479083),(332,'zhengxing-2_24.jpg','uploads/image/201709/170927_102515_4072.jpg','uploads/thumb/201709/170927_102515_4072.jpg','jpg','image/jpeg',62813,'d4f9edeed9f097493daf19b4a1d26d1f','528c2e3fec0f1c0de5376b8b3379e64b59d2df4c',0,1506479115,1506479115),(333,'zhengxing-2_24.jpg','uploads/image/201709/170927_103022_2620.jpg','uploads/thumb/201709/170927_103022_2620.jpg','jpg','image/jpeg',62813,'d4f9edeed9f097493daf19b4a1d26d1f','528c2e3fec0f1c0de5376b8b3379e64b59d2df4c',0,1506479422,1506479422),(334,'zhengxing-2_24.jpg','uploads/image/201709/170927_104020_7915.jpg','uploads/thumb/201709/170927_104020_7915.jpg','jpg','image/jpeg',62813,'d4f9edeed9f097493daf19b4a1d26d1f','528c2e3fec0f1c0de5376b8b3379e64b59d2df4c',0,1506480020,1506480020),(335,'zhengxing-2_46.jpg','uploads/image/201709/170927_105933_2195.jpg','uploads/thumb/201709/170927_105933_2195.jpg','jpg','image/jpeg',28728,'e6b880465acfa3a8a0ef1854d148758d','6585f629aa3708f626049b8deaca98a804020e21',0,1506481173,1506481173),(336,'zhengxing-2_48.jpg','uploads/image/201709/170927_110011_1552.jpg','uploads/thumb/201709/170927_110011_1552.jpg','jpg','image/jpeg',38774,'73680f4f1494a2bd51270183c774cb96','993ba6e3a338e2824730fe6d25529f747477f350',0,1506481211,1506481211),(337,'zhengxing-2_50.jpg','uploads/image/201709/170927_110054_6133.jpg','uploads/thumb/201709/170927_110054_6133.jpg','jpg','image/jpeg',35978,'ec885f427594c5ac36a5b1dfaf1a2ae1','30340e9a0dd4998c630f973e0203acfc8ac26cf3',0,1506481254,1506481254),(338,'zhengxing-2_52.jpg','uploads/image/201709/170927_110316_5340.jpg','uploads/thumb/201709/170927_110316_5340.jpg','jpg','image/jpeg',35344,'7502e209b16ddd044930600c7505478b','afe1ddb39179a62bcb303b59536e1d577c3898f8',0,1506481396,1506481396),(339,'zhengxing-2_46.jpg','uploads/image/201709/170927_110432_6324.jpg','uploads/thumb/201709/170927_110432_6324.jpg','jpg','image/jpeg',28728,'e6b880465acfa3a8a0ef1854d148758d','6585f629aa3708f626049b8deaca98a804020e21',0,1506481472,1506481472),(340,'zhengxing-2_59.jpg','uploads/image/201709/170927_110621_9394.jpg','uploads/thumb/201709/170927_110621_9394.jpg','jpg','image/jpeg',10220,'9a588f7eb91c1cded7f737c4c3deba94','c74adc2533d9095548e3210fc672aef3cc0d4433',0,1506481581,1506481581),(341,'zhengxing-2_61.jpg','uploads/image/201709/170927_110642_4859.jpg','uploads/thumb/201709/170927_110642_4859.jpg','jpg','image/jpeg',11270,'6b8f08368a6c5fa4592c5d49008106f8','59965880a56c77be0d330957bf7cf536a9aaa931',0,1506481602,1506481602),(342,'zhengxing-2_63.jpg','uploads/image/201709/170927_110703_1860.jpg','uploads/thumb/201709/170927_110703_1860.jpg','jpg','image/jpeg',10380,'c65a7c95a79caef322808377dde1cd1d','d45efcfbbec694e785fb5e74903312a4bf275590',0,1506481623,1506481623),(343,'zhengxing-2_65.jpg','uploads/image/201709/170927_110730_6019.jpg','uploads/thumb/201709/170927_110730_6019.jpg','jpg','image/jpeg',7169,'82b8447d7083cc1a4b4d1af1591e85d2','5039af1f2d27686ecb31d218ba05a0ae45cc4313',0,1506481650,1506481650),(344,'zhengxing-2_71.jpg','uploads/image/201709/170927_110829_1169.jpg','uploads/thumb/201709/170927_110829_1169.jpg','jpg','image/jpeg',5975,'221e93d3951079ac77b9c4c13ea3e606','ffc583b665e1a2fd197ec4d59366a371fd6c9330',0,1506481709,1506481709),(345,'zhengxing-2_65.jpg','uploads/image/201709/170927_113106_8626.jpg','uploads/thumb/201709/170927_113106_8626.jpg','jpg','image/jpeg',7169,'82b8447d7083cc1a4b4d1af1591e85d2','5039af1f2d27686ecb31d218ba05a0ae45cc4313',0,1506483066,1506483066);
/*!40000 ALTER TABLE `upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT '10',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `password_reset_token` (`password_reset_token`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (2,'hzadmin','l84LDY2bvLnocYYeAtx1Z7rTq3vEu9fS','$2y$13$ywwt2wTKZAZ6e31GhIKJTundTe6D4oHqzMifHPgrXGRUUil2QPqn6',NULL,'1234@qq.com',10,1501577682,1501577682);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zc_webconfig`
--

DROP TABLE IF EXISTS `zc_webconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zc_webconfig` (
  `id` int(5) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) NOT NULL COMMENT '配置类型:wechat表示微信公众号配置',
  `content` text NOT NULL COMMENT '序列化的数组字符串',
  `createtime` int(12) NOT NULL COMMENT '创建时间',
  `updatetime` int(12) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='配置表(包含公众号配置和站点信息配置等)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zc_webconfig`
--

LOCK TABLES `zc_webconfig` WRITE;
/*!40000 ALTER TABLE `zc_webconfig` DISABLE KEYS */;
INSERT INTO `zc_webconfig` VALUES (6,'web','a:18:{s:5:\"_csrf\";s:56:\"WS4wOVpIclJgTEpgKAEbP2BWc10jIwE9M0RJdmh7NB5uHXxMaQITOQ==\";s:7:\"webname\";s:33:\"浙江省整形美容行业协会\";s:7:\"web_add\";s:13:\"www.zjapa.com\";s:7:\"web_seo\";s:68:\"浙江省整形美容行业协会   整形美容  美容行业协会\";s:4:\"host\";s:33:\"浙江省整形美容行业协会\";s:11:\"maintenance\";s:33:\"中国整形美容协会信息部\";s:5:\"phone\";s:12:\"0574-7331964\";s:10:\"wealth_add\";s:42:\"浙江省宁波市海曙区翠波路177号\";s:4:\"post\";s:6:\"100029\";s:5:\"email\";s:18:\"zjzxxh@capa.org.cn\";s:3:\"fax\";s:12:\"010-84280990\";s:7:\"recode1\";s:19:\"浙ICP备14047909-1\";s:7:\"recode2\";s:27:\"京公网安备110102000889\";s:6:\"submit\";s:6:\"提交\";s:7:\"qrcode1\";s:37:\"/backend/web/uploads/image/qrcode.png\";s:7:\"qrcode2\";s:37:\"/backend/web/uploads/image/qrcode.png\";s:8:\"web_logo\";s:35:\"/backend/web/uploads/image/logo.png\";s:11:\"index_thumb\";s:58:\"/backend/web/uploads/image/微信图片_20171120141225.png\";}',1477409168,1511158319);
/*!40000 ALTER TABLE `zc_webconfig` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-11-27 17:29:41
