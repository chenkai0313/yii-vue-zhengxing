<?php
namespace moxuandi\helper;

class Helper
{
    /**
     * 判断当前服务器操作系统
     * @return string
     */
    public static function getOs()
    {
        return PATH_SEPARATOR == ':' ? 'Linux' : 'Windows';
    }

    /**
     * 遍历文件夹
     * @param string $dir eg:'D:/wamp64/www/yii2advanced'
     * @param bool $all true表示递归遍历
     * @param array $ret
     * @return array
     */
    public static function scanfDir($dir='', $all=false, &$ret=[])
    {
        if($handle = opendir($dir)){
            while(($file = readdir($handle)) !== false){
                if(!in_array($file, ['.', '..', '.git', '.gitignore', '.svn', '.buildpath', '.project'])){
                    $cur_path = $dir . '/' . $file;
                    if(is_dir($cur_path)){
                        $ret['dirs'][] = $cur_path;
                        $all && self::scanfDir($cur_path, $all, $ret);
                    }else{
                        $ret['files'][] = $cur_path;
                    }
                }
            }
            closedir($handle);
        }
        return $ret;
    }

    /**
     * 格式化文件大小的单位
     * @param $size  //文件大小
     * @param int $dec  //小数位数
     * @return string
     */
    public static function byteFormat($size, $dec=2)
    {
        $byte = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB', 'BB', 'NB', 'DB', 'CB'];
        $pos = 0;
        while($size >= 1024){
            $size /= 1024;
            $pos ++;
        }
        return round($size, $dec) . ' ' . $byte[$pos];
    }


    /**
     * 排序
     * @param $a
     * @param $b
     * @param string $order //排序形式
     * @return int
     */
    public static function cmp_func($a, $b, $order='name')
    {
        if($a['is_dir'] && !$b['is_dir']){
            return -1;
        }elseif(!$a['is_dir'] && $b['is_dir']){
            return 1;
        }else{
            if($order == 'size'){
                if($a['filesize'] > $b['filesize']){
                    return 1;
                }elseif($a['filesize'] < $b['filesize']){
                    return -1;
                }else{
                    return 0;
                }
            }elseif($order == 'type'){
                return strcmp($a['filetype'], $b['filetype']);
            }else{
                return strcmp($a['filename'], $b['filename']);
            }
        }
    }

    /**
     * 创建目录并检查目录是否可写
     * @param $dir
     * @return bool|string
     */
    public static function createDir($dir)
    {
        if(!file_exists($dir) && !mkdir($dir, 0777, true)){
            return '目录创建失败';
        }elseif(is_writable($dir)){
            return '目录没有写入权限';
        }
        return true;
    }

    /**
     * 获取文件的扩展名
     * @param $file
     * @return string
     */
    public static function getExt($file)
    {
        $pathinfo = pathinfo($file);
        return strtolower($pathinfo['extension']);
        //return strtolower(substr(strrchr($file, '.'), 1));
    }

    /**
     * 获取图片的宽高
     * @param $img
     * @return array|bool
     */
    public static function getImageInfo($img)
    {
        if($imgInfo = getimagesize($img)){
            $info = [
                'width' => $imgInfo[0],
                'height' => $imgInfo[1],
            ];
            return $info;
        }else{
            return false;
        }
    }
}
