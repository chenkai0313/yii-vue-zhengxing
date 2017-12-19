<?php
/**
 * 前后端通信相关的配置
 * 详情请查看assets/php/config.json
 */
return [
	/* 上传图片配置项 */
	"imageActionName" => "uploadimage",
	"imageFieldName" => "upfile",
	"imageMaxSize" => 2097152, //2MB
	"imageAllowFiles" => [".png", ".jpg", ".jpeg", ".gif", ".bmp"],
	"imageCompressEnable" => true,
	"imageCompressBorder" => 1600,
	"imageInsertAlign" => "none",
	"imageUrlPrefix" => "",
	"imagePathFormat" => "uploads/image/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}",
	'thumbStatus' => true,	//是否生成缩略图
	'thumbWidth' => 240,	//缩略图宽度
	'thumbHeight' => 320,	//缩略图高度
    'thumbCut' => 1,  //生成缩略图的方式, 0:留白, 1:裁剪

	/* 涂鸦图片上传配置项 */
	"scrawlActionName" => "uploadscrawl",
	"scrawlFieldName" => "upfile",
	"scrawlPathFormat" => "uploads/scrawl/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}",
	"scrawlMaxSize" => 2097152, //2MB
	"scrawlUrlPrefix" => "",
	"scrawlInsertAlign" => "none",

	/* 截图工具上传 */
	"snapscreenActionName" => "uploadimage",
	"snapscreenPathFormat" => "uploads/snapscreen/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}",
	"snapscreenUrlPrefix" => "",
	"snapscreenInsertAlign" => "none",

	/* 抓取远程图片配置 */
	"catcherLocalDomain" => ["127.0.0.1", "localhost", "img.baidu.com"],
	"catcherActionName" => "catchimage",
	"catcherFieldName" => "source",
	"catcherPathFormat" => "uploads/image/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}",
	"catcherUrlPrefix" => "",
	"catcherMaxSize" => 2097152, //2MB
	"catcherAllowFiles" => [".png", ".jpg", ".jpeg", ".gif", ".bmp"],

	/* 上传视频配置 */
	"videoActionName" => "uploadvideo",
	"videoFieldName" => "upfile",
	"videoPathFormat" => "uploads/media/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}",
	"videoUrlPrefix" => "",
	"videoMaxSize" => 20971520, //20MB
	"videoAllowFiles" => [".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg", ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid"],

	/* 上传文件配置 */
	"fileActionName" => "uploadfile",
	"fileFieldName" => "upfile",
	"filePathFormat" => "uploads/file/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}",
	"fileUrlPrefix" => "",
	"fileMaxSize" => 20971520, //20MB
	"fileAllowFiles" => [".png", ".jpg", ".jpeg", ".gif", ".bmp", ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg", ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid", ".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml"],

	/* 列出指定目录下的图片 */
	"imageManagerActionName" => "listimage",
	"imageManagerListPath" => "/uploads/image/",
	"imageManagerListSize" => 20,
	"imageManagerUrlPrefix" => "",
	"imageManagerInsertAlign" => "none",
	"imageManagerAllowFiles" => [".png", ".jpg", ".jpeg", ".gif", ".bmp"],

	/* 列出指定目录下的文件 */
	"fileManagerActionName" => "listfile",
	"fileManagerListPath" => "/uploads/file/",
	"fileManagerUrlPrefix" => "",
	"fileManagerListSize" => 20,
	"fileManagerAllowFiles" => [".png", ".jpg", ".jpeg", ".gif", ".bmp", ".flv", ".swf", ".mkv", ".avi", ".rm", ".rmvb", ".mpeg", ".mpg", ".ogg", ".ogv", ".mov", ".wmv", ".mp4", ".webm", ".mp3", ".wav", ".mid", ".rar", ".zip", ".tar", ".gz", ".7z", ".bz2", ".cab", ".iso", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".pdf", ".txt", ".md", ".xml"]
];