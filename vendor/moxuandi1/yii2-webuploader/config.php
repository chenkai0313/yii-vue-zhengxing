<?php
/**
 * 前后端通信相关的配置
 */
return [
	/* 上传图片{image}配置项 */
	'imageMaxSize' => 2097152,  //2MB
	'imageAllowExts' => ['png', 'jpg', 'jpeg', 'gif', 'bmp'],  //允许上传的文件格式
	'imagePathFormat' => 'uploads/image/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}',  //文件名的格式, 需要生成缩略图时, 必须包含'image'
	'thumbStatus' => true,  //是否生成缩略图
	'thumbWidth' => 300,  //缩略图宽度
	'thumbHeight' => 200,  //缩略图高度
    'thumbCut' => 1,  //生成缩略图的方式, 0:留白, 1:裁剪

	/* 上传{flash}配置项 */
	'flashMaxSize' => 5242880,  //5MB
	'flashAllowExts' => ['flv', 'swf'],  //允许上传的文件格式
	'flashPathFormat' => 'uploads/flash/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}',  //文件名的格式

	/* 上传{media}配置项 */
	'mediaMaxSize' => 20971520,  //20MB
	'mediaAllowExts' => ['flv', 'swf', 'mkv', 'avi', 'rm', 'rmvb', 'mpeg', 'mpg', 'ogg', 'ogv', 'mov', 'wmv', 'mp4', 'webm', 'mp3', 'wav', 'mid'],  //文件名的格式
	'mediaPathFormat' => 'uploads/media/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}',  //文件名的格式

	/* 上传文件{file}配置项 */
	'fileMaxSize' => 20971520,  //20MB
	'fileAllowExts' => ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'flv', 'swf', 'mkv', 'avi', 'rm', 'rmvb', 'mpeg', 'mpg', 'ogg', 'ogv', 'mov', 'wmv', 'mp4', 'webm', 'mp3', 'wav', 'mid', 'rar', 'zip', 'tar', 'gz', '7z', 'bz2', 'cab', 'iso', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'pdf', 'txt', 'md', 'xml'],  //文件名的格式
	'filePathFormat' => 'uploads/file/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}',  //文件名的格式
];