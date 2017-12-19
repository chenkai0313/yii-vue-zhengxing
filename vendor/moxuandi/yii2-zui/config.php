<?php
/**
 * 前后端通信相关的配置
 */
return [
    /* 上传图片{images}配置项 */
    "imageMaxSize" => 2*1024*1024, //2MB
    "imageAllowExts" => ["png", "jpg", "jpeg", "gif", "bmp"],
    "imagePathFormat" => "uploads/image/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}",
    'thumbStatus' => true,	//是否生成缩略图
    'thumbWidth' => 300,	//缩略图宽度
    'thumbHeight' => 200,	//缩略图高度
    'thumbCut' => 1,  //生成缩略图的方式, 0:留白, 1:裁剪

    /* 上传视音频{medias}配置项 */
    'mediaMaxSize' => 20*1024*1024,  //20MB
    'mediaAllowExts' => ['flv', 'swf', 'mkv', 'avi', 'rm', 'rmvb', 'mpeg', 'mpg', 'ogg', 'ogv', 'mov', 'wmv', 'mp4', 'webm', 'mp3', 'wav', 'mid'],  //文件名的格式
    'mediaPathFormat' => 'uploads/media/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}',  //文件名的格式

    /* 上传文件{files}配置项 */
    'fileMaxSize' => 20*1024*1024,  //20MB
    'fileAllowExts' => ['png', 'jpg', 'jpeg', 'gif', 'bmp', 'flv', 'swf', 'mkv', 'avi', 'rm', 'rmvb', 'mpeg', 'mpg', 'ogg', 'ogv', 'mov', 'wmv', 'mp4', 'webm', 'mp3', 'wav', 'mid', 'rar', 'zip', 'tar', 'gz', '7z', 'bz2', 'cab', 'iso', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'pdf', 'txt', 'md', 'xml'],  //文件名的格式
    'filePathFormat' => 'uploads/file/{yyyy}{mm}/{yy}{mm}{dd}_{hh}{ii}{ss}_{rand:4}',  //文件名的格式
];