<?php
namespace moxuandi\kindeditor;
use common\models\Upload;
use moxuandi\helper\Helper;
use yii\web\UploadedFile;

/**
 * uploader for KindEditorAction
 *
 * @author zhangmoxuan <1104984259@qq.com>
 * @link http://www.zhangmoxuan.com
 * @QQ 1104984259
 * @date 2017-4-1
 */
class Uploader
{
    public $file;    //上传对象
    public $config;    //配置信息
    public $realName;    //原始文件名
    public $fileExt;    //文件扩展名
    public $fileSize;   //文件大小
    public $fileMime;   //MIME类型
    public $fileName;    //新文件名
    public $fullName;    //完整的新文件名,即从当前站点目录开始的URL
    public $thumbName = '';    //缩略图文件名,即从当前站点目录开始的URL
    public $stateInfo;    //上传状态信息,
    private $stateMap = [    //上传状态映射表，国际化用户需考虑此处数据的国际化
        0 => 'SUCCESS',	//上传成功标记，不可改变，否则flash判断会出错
        1 => '文件大小超出 upload_max_filesize 限制',
        2 => '文件大小超出 HTML MAX_FILE_SIZE 限制',
        3 => '文件未被完整上传',
        4 => '没有文件被上传',
        6 => '找不到临时文件',
        7 => '无法将临时文件写入磁盘',
        8 => '因php扩展停止文件上传',
        'ERROR_SIZE_EXCEED' => '文件大小超出限制',
        'ERROR_TYPE_NOT_ALLOWED' => '文件类型不被允许',
        'ERROR_CREATE_DIR' => '目录创建失败',
        'ERROR_DIR_NOT_WRITEABLE' => '目录没有写入的权限',
        'ERROR_FILE_MOVE' => '文件保存时出错',
        'ERROR_THUMB' => '缩略图创建失败',
        'ERROR_UPLOAD' => '非法上传',
        'ERROR_DATABASE' => '文件上传成功，但在保存到数据库时失败！'
    ];

	/**
	 * 构造函数
     * 初始化参数
	 */
    public function __construct($config)
    {
       $this->config = $config;
        if($this->file = UploadedFile::getInstanceByName('imgFile')){
            if(self::checkUpload($this->file)){
                self::uploadFile();
            }else{
                return false;
            }
        }else{
            $this->stateInfo = $this->stateMap[3];
            return false;
        }
    }

    public function uploadFile()
    {
        $this->fullName = self::getFullName();
        $this->fileName = self::getFileName();

        //创建缩略图
        $thumbStatus = isset($this->config['thumbStatus']) ? $this->config['thumbStatus'] : false;
        if($thumbStatus && in_array($this->fileExt, ['jpg', 'jpeg', 'png', 'gif'])){
            if(!self::makeThumb($this->file->tempName)){
                $this->stateInfo = $this->stateMap['ERROR_THUMB'];
                return false;
            }
        }

        //创建目录
        if(!self::createDir(dirname($this->fullName)))
            return false;

        //调用 yii\web\UploadedFile:saveAs() 方法保存上传文件, 并删除临时文件
        if(!$this->file->saveAs($this->fullName)){
            $this->stateInfo = $this->stateMap['ERROR_FILE_MOVE'];
            return false;
        }else{
            $model = new Upload();
            $model->real_name = $this->realName;
            $model->file_name = $this->fullName;
            $model->thumb_name = $this->thumbName;
            $model->file_ext = $this->fileExt;
            $model->file_mime = $this->fileMime;
            $model->file_size = $this->fileSize;
            $model->md5 = md5_file($this->fullName);
            $model->sha1 = sha1_file($this->fullName);
            if($model->save()){
                $this->stateInfo = $this->stateMap['0'];
                return true;
            }else{
                $this->stateInfo = $this->stateMap['ERROR_DATABASE'];
                return false;
            }
        }
    }

    private function makeThumb($tmpName)
    {
        $imageInfo = Helper::getImageInfo($tmpName);
        $width = $this->config['thumbWidth'];
        $height = $this->config['thumbHeight'];
        $bgimg = imagecreatetruecolor($width, $height);		//新建一个背景图片
        $white = imagecolorallocate($bgimg, 255, 255, 255);	//为一幅图像分配颜色
        imagefill($bgimg, 0, 0, $white);	//填充背景色为白色
        switch($this->fileMime){
            case 'image/gif':
                $im = @imagecreatefromgif($tmpName);
                $outfun = 'imagegif';
                break;
            case 'image/png':
                $im = @imagecreatefrompng($tmpName);
                $outfun = 'imagepng';
                break;
            case 'image/jpeg':
                $im = @imagecreatefromjpeg($tmpName);
                $outfun = 'imagejpeg';
                break;
            default: return false;
        }

        $copy = false;	//是否直接复制图片到背景图上
        if($imageInfo['width'] / $width >= $imageInfo['height'] / $height){ //宽度较大时
            if($imageInfo['width'] > $width){	//图片宽度大于缩略图宽度
                if($this->config['thumbCut']){
                    //左右两端裁掉:
                    $new_height = $height;
                    $new_width = ($height * $imageInfo['width']) / $imageInfo['height'];
                    $bg_x = ($width - $new_width)/2;
                    imagecopyresampled($bgimg, $im, $bg_x, 0, 0, 0, $new_width, $new_height, $imageInfo['width'], $imageInfo['height']);
                }else{
                    //上下两端留白:
                    $new_width = $width;
                    $new_height = ($width * $imageInfo['height']) / $imageInfo['width'];
                    $bg_y = ceil(abs(($height - $new_height) / 2));		//取绝对值并进一法取整
                    imagecopyresampled($bgimg, $im, 0, $bg_y, 0, 0, $new_width, $new_height, $imageInfo['width'], $imageInfo['height']);
                }
            }else{
                $copy = true;
            }
        }else{ //高度较大时
            if($imageInfo['height'] > $height){		//图片高度大于缩略图高度
                if($this->config['thumbCut']){
                    //上下两端裁掉:
                    $new_width = $width;
                    $new_height = ($width * $imageInfo['height']) / $imageInfo['width'];
                    $bg_y = ($height - $new_height)/2;
                    imagecopyresampled($bgimg, $im, 0, $bg_y, 0, 0, $new_width, $new_height, $imageInfo['width'], $imageInfo['height']);
                }else{
                    //左右两端留白:
                    $new_height = $height;
                    $new_width = ($height * $imageInfo['width']) / $imageInfo['height'];
                    $bg_x = ceil(abs(($width - $new_width) / 2));		//取绝对值并进一法取整
                    imagecopyresampled($bgimg, $im, $bg_x, 0, 0, 0, $new_width, $new_height, $imageInfo['width'], $imageInfo['height']);
                }
            }else{
                $copy = true;
            }
        }
        if($copy){	//直接复制图片到背景图上
            $bg_x = ceil(($width - $imageInfo['width']) / 2);
            $bg_y = ceil(($height - $imageInfo['height']) / 2);
            imagecopy($bgimg, $im, $bg_x, $bg_y, 0, 0, $imageInfo['width'], $imageInfo['height']);
        }

        //获取缩略图路径
        $this->thumbName = self::getThumb($this->fullName);

        //创建目录
        if(!self::createDir(dirname($this->thumbName)))
            return false;

        $outfun($bgimg, $this->thumbName);    //输出保存缩略图
        imagedestroy($bgimg);    //销毁背景图
        return true;
    }

    /**
     * 检查文件是否符合要求
     * @param $file
     * @return bool
     */
    private function checkUpload($file)
    {
        if(empty($file)){
            $this->stateInfo = $this->stateMap[4];
            return false;
        }
        if($file->error){
            $this->stateInfo = $this->stateMap[$file->error];
            return false;
        }
        if(!file_exists($file->tempName)){
            $this->stateInfo = $this->stateMap[6];
            return false;
        }
        if(!is_uploaded_file($file->tempName)){
            $this->stateInfo = $this->stateMap['ERROR_UPLOAD'];
            return false;
        }
        if($file->size > $this->config['maxSize']){
            $this->stateInfo = $this->stateMap['ERROR_SIZE_EXCEED'];
            return false;
        }

        $this->realName = $file->name;
        $this->fileSize = $file->size;
        $this->fileMime = $file->type;
        $this->fileExt = Helper::getExt($file->name);

        if(!in_array($this->fileExt, $this->config['allowExts'])){
            $this->stateInfo = $this->stateMap['ERROR_TYPE_NOT_ALLOWED'];
            return false;
        }
        
        return true;
    }

    /**
     * 创建目录并检查目录是否可写
     * @param $dirname: 目录路径
     * @return bool
     */
    private function createDir($dirname)
    {
        if(!file_exists($dirname) && !mkdir($dirname, 0777, true)){
            $this->stateInfo = $this->stateMap['ERROR_CREATE_DIR'];
            return false;
        }elseif(!is_writable($dirname)){
            $this->stateInfo = $this->stateMap['ERROR_DIR_NOT_WRITEABLE'];
            return false;
        }
        return true;
    }

    /**
     * 获取完整文件名
     * @return string
     */
    private function getFullName()
    {
        //替换日期事件
        $t = time();
        $d = explode('-', date('Y-y-m-d-H-i-s'));
        $format = $this->config['pathFormat'];
        $format = str_replace('{yyyy}', $d[0], $format);
        $format = str_replace('{yy}', $d[1], $format);
        $format = str_replace('{mm}', $d[2], $format);
        $format = str_replace('{dd}', $d[3], $format);
        $format = str_replace('{hh}', $d[4], $format);
        $format = str_replace('{ii}', $d[5], $format);
        $format = str_replace('{ss}', $d[6], $format);
        $format = str_replace('{time}', $t, $format);

        //过滤文件名的非法字符,并替换文件名
        $realName = substr($this->realName, 0, strrpos($this->realName, '.'));
        $realName = preg_replace("/[\|\?\"\<\>\/\*\\\\]+/", '', $realName);
        $format = str_replace('{filename}', $realName, $format);

        //替换随机字符串
        $randNum = rand(1, 10000000000) . rand(1, 10000000000);
        if (preg_match("/\{rand\:([\d]*)\}/i", $format, $matches)) {
            $format = preg_replace("/\{rand\:[\d]*\}/i", substr($randNum, 0, $matches[1]), $format);
        }
        ;
        return $format . '.' . $this->fileExt;
    }

    /**
     * 截取文件名
     * @return string
     */
    private function getFileName()
    {
        return substr($this->fullName, strrpos($this->fullName, '/') + 1);
    }

    /**
     * 获取缩略图文件名
     */
    public static function getThumb($url){
        return str_replace('image', 'thumb', $url);	//完整的缩略图路径
    }
}