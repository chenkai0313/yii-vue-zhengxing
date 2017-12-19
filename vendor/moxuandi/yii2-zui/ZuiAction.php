<?php
namespace moxuandi\zui;

use yii;
use yii\base\Action;
use yii\helpers\ArrayHelper;
use yii\helpers\Json;

class ZuiAction extends Action
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
        self::actionUpload();
	}

	/**
	 * 上传
	 */
	protected function actionUpload()
	{
        switch(yii::$app->request->post('action')){
            case 'files':
                $config = [
                    'maxSize' => $this->config['fileMaxSize'],
                    'allowExts' => $this->config['fileAllowExts'],
                    'pathFormat' => $this->config['filePathFormat'],
                ];
                break;
            case 'medias':
                $config = [
                    'maxSize' => $this->config['mediaMaxSize'],
                    'allowExts' => $this->config['mediaAllowExts'],
                    'pathFormat' => $this->config['mediaPathFormat'],
                ];
                break;
            case 'images':
            default:
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
        }

        $upload = new Uploader($config);
        if($upload->stateInfo === 'SUCCESS'){
            //header('Content-type: text/html; charset=UTF-8');
            echo Json::encode(['result'=>'success', 'id'=>$upload->id, 'url'=>'/' . $upload->fullName]);
            exit;
        }else{
            echo Json::encode(['result'=>'failed', 'message'=>$upload->stateInfo]);
            exit;
        }
	}
}