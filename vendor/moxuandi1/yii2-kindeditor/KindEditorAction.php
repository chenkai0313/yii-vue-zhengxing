<?php
namespace moxuandi\kindeditor;

use yii;
use yii\base\Action;
use yii\helpers\ArrayHelper;

/**
 * Description of KindEditorAction
 *
 * @author zhangmoxuan <1104984259@qq.com>
 * @original author Qinn Pan <Pan JingKui, pjkui@qq.com, http://www.pjkui.com>
 * @link http://www.zhangmoxuan.com
 * @QQ 1104984259
 * @date 2017-4-1
 */
class KindEditorAction extends Action
{
	public $config = [];
	public function init()
	{
		yii::$app->request->enableCsrfValidation = false;	//关闭csrf
		$_config = require(__DIR__ . '/config.php');
		$this->config = ArrayHelper::merge($_config, $this->config);
		parent::init();
	}

	public function run()
	{
		$this->handleAction();
	}

	/**
	 * 处理action
	 */
	protected function handleAction()
	{
		switch(yii::$app->request->get('action')){
			case 'fileManagerJson': $this->actionList(); break;
			case 'uploadJson': $this->actionUpload(); break;
			default: break;
		}
	}

	/**
	 * 上传
	 */
	protected function actionUpload()
	{
		$dir = yii::$app->request->get('dir');
		switch($dir){
			case 'image':
				$config = [
					'maxSize' => $this->config['imageMaxSize'],
					'allowExts' => $this->config['imageAllowExts'],
					'pathFormat' => $this->config['imagePathFormat'],
					'thumbStatus' => $this->config['thumbStatus'],
					'thumbWidth' => $this->config['thumbWidth'],
					'thumbHeight' => $this->config['thumbHeight'],
                    'thumbCut' => $this->config['thumbCut'],
				];
				break;
			case 'flash':
				$config = [
					'maxSize' => $this->config['flashMaxSize'],
					'allowExts' => $this->config['flashAllowExts'],
					'pathFormat' => $this->config['flashPathFormat'],
				];
				break;
			case 'media':
				$config = [
					'maxSize' => $this->config['mediaMaxSize'],
					'allowExts' => $this->config['mediaAllowExts'],
					'pathFormat' => $this->config['mediaPathFormat'],
				];
				break;
			case 'file':
				$config = [
					'maxSize' => $this->config['fileMaxSize'],
					'allowExts' => $this->config['fileAllowExts'],
					'pathFormat' => $this->config['filePathFormat'],
				];
				break;
			default:
			    $config = [];
				break;
		}

		// 生成上传实例对象并完成上传
        $upload = new Uploader($config);

		if($upload->stateInfo == 'SUCCESS'){
			header('Content-type: text/html; charset=UTF-8');
			//header('Content-type: application/json; charset=UTF-8');	//IE下可能出错，怀疑火狐下批量上传失败，也是这个原因
			echo json_encode(array('error'=>0, 'url'=>'/' . $upload->fullName));
			exit;
		}else{
			echo $upload->stateInfo;
			exit;
		}
	}

	/**
	 * 获取已上传的文件列表
	 */
	protected function actionList()
	{
		$ext_arr = array('gif', 'jpg', 'jpeg', 'png', 'bmp');
		$dir_name = yii::$app->request->get('dir');
		if(!in_array($dir_name, array('', 'image', 'flash', 'media', 'file'))){
			echo '无效的目录名。';
			exit;
		}

		if($dir_name !== ''){
			$root_path = $_SERVER['DOCUMENT_ROOT'] . '/uploads/' . $dir_name . '/';
			$root_url = yii::$app->request->hostInfo . '/uploads/' . $dir_name . '/';
			if(!file_exists($root_path)){
				mkdir($root_path);
			}
		}

		// 根据path参数，设置各路径和URL
		if(empty($_GET['path'])){
			$current_path = realpath($root_path) . '/';
			$current_url = $root_url;
			$current_dir_path = '';
			$moveup_dir_path = '';
		}else{
			$current_path = realpath($root_path) . '/' . $_GET['path'];
			$current_url = $root_url . $_GET['path'];
			$current_dir_path = $_GET['path'];
			$moveup_dir_path = preg_replace('/(.*?)[^\/]+\/$/', '$1', $current_dir_path);
		}

		// 不允许使用'..'移动到上一级目录
		if(preg_match('/\.\./', $current_path)){
			echo '访问不被允许。';
			exit;
		}

		// 最后一个字符不是'/'
		if(!preg_match('/\/$/', $current_path)){
			echo '参数无效。';
			exit;
		}

		// 目录不存在或不是目录
		if(!file_exists($current_path) || !is_dir($current_path)){
			echo '目录不存在。';
			exit;
		}

		// 遍历目录取得文件信息
		$file_list = array();
		if($handle = opendir($current_path)){
			$i = 0;
			while(false !== ($filename = readdir($handle))){
				if($filename{0} == '.'){
					continue;
				}
				$file = $current_path . $filename;
				if(is_dir($file)){
					$file_list[$i]['is_dir'] = true; //是否文件夹
					$file_list[$i]['has_file'] = (count(scandir($file)) > 2); //文件夹是否包含文件
					$file_list[$i]['filesize'] = 0; //文件大小
					$file_list[$i]['is_photo'] = false; //是否图片
					$file_list[$i]['filetype'] = ''; //文件类别，用扩展名判断
				}else{
					$file_list[$i]['is_dir'] = false;
					$file_list[$i]['has_file'] = false;
					$file_list[$i]['filesize'] = filesize($file);   //文件大小
					$file_list[$i]['dir_path'] = '';
					$file_ext = strtolower(pathinfo($file, PATHINFO_EXTENSION));    //小写的扩展名
					$file_list[$i]['is_photo'] = in_array($file_ext, $ext_arr);     //是否是图片（扩展名为$ext_arr中的一个）
					$file_list[$i]['filetype'] = $file_ext; //扩展名
				}
				$file_list[$i]['filename'] = $filename; //文件名，包含扩展名
				$file_list[$i]['datetime'] = date('Y-m-d H:i:s', filemtime($file)); //文件最后修改时间
				$i++;
			}
			closedir($handle);
		}

		usort($file_list, [$this, 'cmp_func']); //用cmp_func()函数对数组进行排序

		$result = array();
		$result['moveup_dir_path'] = $moveup_dir_path;      //相对于根目录的上一级目录
		$result['current_dir_path'] = $current_dir_path;    //相对于根目录的当前目录
		$result['current_url'] = $current_url;              //当前目录的URL
		$result['total_count'] = count($file_list);         //文件数
		$result['file_list'] = $file_list;                  //文件列表数组

		header('Content-type: application/json; charset=UTF-8');
		echo json_encode($result);
	}

	//排序
	public function cmp_func($a, $b)
	{
		// 排序形式，name or size or type
		$order = empty($_GET['order']) ? 'name' : strtolower($_GET['order']);

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
}