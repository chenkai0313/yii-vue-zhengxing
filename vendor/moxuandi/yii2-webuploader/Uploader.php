<?php
namespace moxuandi\webuploader;

use yii;
use yii\base\Action;
use yii\helpers\ArrayHelper;

/**
 * Description of KindEditorAction
 *
 * @author zhangmoxuan <1104984259@qq.com>
 * @original author Qinn Pan <Pan JingKui, pjkui@qq.com, http://www.pjkui.com>
 * @link http://www.zhangmoxuan.cn
 * @QQ 1104984259
 * @date 2017-4-1
 */
class Uploader extends Action
{
	public $config = [];
	public function init()
	{
		yii::$app->request->enableCsrfValidation = false;	//关闭csrf
		$_config = require(__DIR__ . '/config.php');
		$this->config = ArrayHelper::merge($_config, $this->config);
		parent::init();
	}

    /**
     * 处理action
     */
	public function run()
	{
        $this->actionUpload();
        /*switch(yii::$app->request->get('action')){
            case 'fileManagerJson': $this->actionList(); break;
            case 'multi': $this->actionUpload(); break;
            default: break;
        }*/
	}

	/**
	 * 上传
	 */
	protected function actionUpload()
	{
        $config = [
            'maxSize' => $this->config['imageMaxSize'],
            'allowExts' => $this->config['imageAllowExts'],
            'pathFormat' => $this->config['imagePathFormat'],
            'thumbStatus' => $this->config['thumbStatus'],
            'thumbWidth' => $this->config['thumbWidth'],
            'thumbHeight' => $this->config['thumbHeight'],
            'thumbCut' => $this->config['thumbCut'],
        ];

		// 生成上传实例对象并完成上传
		$upload = new Uploader2($config);

		// 返回上传结果
        if($upload->stateInfo === 'SUCCESS'){
            echo json_encode(['result'=>'success', 'id'=>$upload->id, 'url'=>'/' . $upload->fullName]);
            exit();
        }else{
            echo json_encode(['result'=>'failed', 'message'=>$upload->stateInfo]);
            exit();
        }

	}
}