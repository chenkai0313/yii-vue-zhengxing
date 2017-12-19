<?php
/**
 * @link http://www.yiichina.com/extension/342
 * @link https://github.com/BigKuCha/yii2-ueditor-widget
 * @link http://ueditor.baidu.com/website/index.html
 */
namespace moxuandi\ueditor;

use Yii;
use yii\helpers\ArrayHelper;
use yii\helpers\Html;
use yii\helpers\Json;
use yii\helpers\Url;
use yii\web\View;
use yii\widgets\InputWidget;

/**
 * Class UEditor
 *
 * @author zhangmoxuan <1104984259@qq.com>
 * @link http://www.zhangmoxuan.cn
 * @QQ 1104984259
 * @date 2017-4-10
 */
class UEditor extends InputWidget
{
	//配置选项,参阅Ueditor官网文档(定制菜单等)
	public $clientOptions = [];

	//默认配置
	protected $_options;

	/**
	 * @throws \yii\base\InvalidConfigException
	 */
	public function init()
	{
		//$this->id = $this->hasModel() ? Html::getInputId($this->model, $this->attribute) : $this->id;
        if($this->hasModel()){
            $this->id = Html::getInputId($this->model, $this->attribute);
        }elseif($this->attribute){
            $this->id = $this->id . '_' . $this->attribute;
        }
		$this->_options = [
			'serverUrl' => Url::to(['upload']),
			'initialFrameWidth' => '100%',	// 最小920
			'initialFrameHeight' => '400',
			'lang' => 'zh-cn',
			//'lang' => (strtolower(Yii::$app->language) == 'en-us') ? 'en' : 'zh-cn',
			'toolbars' => [[
				'fullscreen', 'source', '|', 'undo', 'redo', '|',
				'preview', 'searchreplace', 'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc', '|',
				'indent', 'rowspacingtop', 'rowspacingbottom', 'lineheight', '|',
				'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|',
				'customstyle', 'paragraph', 'fontfamily', 'fontsize', 'insertcode', '|',
				'simpleupload', 'insertimage', 'emotion', 'scrawl', 'insertvideo', 'music', 'attachment', 'map', 'background','link', 'unlink', 'anchor', 'horizontal', 'date', 'time', 'spechars', 'inserttable', '|',
				'drafts', 'help',
			]],
		];
		$this->clientOptions = ArrayHelper::merge($this->_options, $this->clientOptions);
        if($this->hasModel())
            parent::init();
	}

	public function run()
	{
		$this->registerClientScript();
		if($this->hasModel()){
			return Html::activeTextarea($this->model, $this->attribute, ['id' => $this->id]);
		}else{
			return Html::textarea($this->id, $this->value, ['id' => $this->id]);
		}
	}

	/**
	 * 注册客户端脚本
	 */
	protected function registerClientScript()
	{
		UEditorAsset::register($this->view);
		$clientOptions = Json::encode($this->clientOptions);
		$script = "UE.getEditor('" . $this->id . "', " . $clientOptions . ")";
		$this->view->registerJs($script, View::POS_READY);
	}
}