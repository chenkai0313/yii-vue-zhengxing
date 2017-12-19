<?php
namespace moxuandi\kindeditor;

use Yii;
use yii\helpers\ArrayHelper;
use yii\helpers\Html;
use yii\helpers\Json;
use yii\helpers\Url;
use yii\web\View;
use yii\widgets\InputWidget;

/**
 * Class KindEditor
 *
 * @author zhangmoxuan <1104984259@qq.com>
 * @original author Qinn Pan <Pan JingKui, pjkui@qq.com, http://www.pjkui.com>
 * @link http://www.zhangmoxuan.com
 * @QQ 1104984259
 * @date 2017-4-1
 */
class KindEditor extends InputWidget
{
	public $clientOptions = [];     // 配置选项，参阅KindEditor官网文档(定制菜单等)

	public $item = false;		//定制编辑器的工具栏，flase为完整模式，true为简单模式

	public $inputOptions = [];    //input输入域的html属性

    public $buttonOptions = [];    //button按钮的html属性

	/** 定义编辑器的类型
	 * textEditor: HTML编辑器(默认)
	 * colorpicker: 取色器
	 * uploadButton: 自定义上传按钮
	 * file-dialog: 上传文件
	 * image-dialog: 上传图片(网络图片 + 本地上传)
	 * image-dialog-remote: 上传图片(网络图片)
	 * image-dialog-local: 上传图片(本地上传)
	 * image-manager: 浏览服务器(图片)
	 * flash-manager: 浏览服务器(Flash)
	 * media-manager: 浏览服务器(视音频)
	 * file-manager: 浏览服务器(文件)
	 * multiImageDialog: 批量上传图片(未实现)
	 */
	public $editorType;

	protected $_options;    // 默认配置

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
			'allowFileManager'=>'true',     // 显示浏览远程服务器按钮
			'fileManagerJson' => Url::to(['Kupload', 'action'=>'fileManagerJson']),
			'uploadJson' => Url::to(['Kupload', 'action'=>'uploadJson']),
			'width' => '100%',
			'height' => '500',
			'filterMode' => false
		];
		if($this->item){
			$this->_options['items'] = [
				'source', '|', 'bold', 'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|',
				'insertorderedlist', 'insertunorderedlist', 'forecolor', 'hilitecolor', 'fontname', 'fontsize', '|',
				'code', 'link', 'unlink', 'emoticons', 'image', 'multiimage', 'flash', 'media', 'insertfile', '|',
				'fullscreen'
			];
		}
		$this->clientOptions = ArrayHelper::merge($this->_options, $this->clientOptions);
        if($this->hasModel())
            parent::init();
	}

	public function run()
	{
		$this->registerClientScript();
		if($this->hasModel()){
			switch($this->editorType){
				case 'colorpicker':
					return Html::activeTextInput($this->model, $this->attribute, ArrayHelper::merge(['id'=>$this->id, 'class'=>'form-control'], $this->inputOptions)) . Html::button('打开取色器', ArrayHelper::merge(['id'=>'k_colorpicker', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'uploadButton':
                    return Html::activeTextInput($this->model, $this->attribute, ArrayHelper::merge(['id'=>$this->id, 'class'=>'form-control'], $this->inputOptions)) . Html::button('选择文件', ArrayHelper::merge(['id'=>'k_uploadBtn', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'file-dialog':
                    return Html::activeTextInput($this->model, $this->attribute, ArrayHelper::merge(['id'=>$this->id, 'class'=>'form-control'], $this->inputOptions)) . Html::button('选择文件', ArrayHelper::merge(['id'=>'k_fileBtn', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'image-dialog':
                    return Html::activeTextInput($this->model, $this->attribute, ArrayHelper::merge(['id'=>$this->id, 'class'=>'form-control'], $this->inputOptions)) . Html::button('选择图片', ArrayHelper::merge(['id'=>'k_imageBtn', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'image-dialog-remote':
                    return Html::activeTextInput($this->model, $this->attribute, ArrayHelper::merge(['id'=>$this->id, 'class'=>'form-control'], $this->inputOptions)) . Html::button('选择图片', ArrayHelper::merge(['id'=>'k_imageRemote', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'image-dialog-local':
                    return Html::activeTextInput($this->model, $this->attribute, ArrayHelper::merge(['id'=>$this->id, 'class'=>'form-control'], $this->inputOptions)) . Html::button('选择图片', ArrayHelper::merge(['id'=>'k_imageLocal', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'image-manager':
                    return Html::activeTextInput($this->model, $this->attribute, ArrayHelper::merge(['id'=>$this->id, 'class'=>'form-control'], $this->inputOptions)) . Html::button('浏览服务器', ArrayHelper::merge(['id'=>'k_imagemanager', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'flash-manager':
                    return Html::activeTextInput($this->model, $this->attribute, ArrayHelper::merge(['id'=>$this->id, 'class'=>'form-control'], $this->inputOptions)) . Html::button('浏览服务器', ArrayHelper::merge(['id'=>'k_flashmanager', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'media-manager':
					return Html::activeTextInput($this->model, $this->attribute, ArrayHelper::merge(['id'=>$this->id, 'class'=>'form-control'], $this->inputOptions)) . Html::button('浏览服务器', ArrayHelper::merge(['id'=>'k_mediamanager', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'file-manager':
					return Html::activeTextInput($this->model, $this->attribute, ArrayHelper::merge(['id'=>$this->id, 'class'=>'form-control'], $this->inputOptions)) . Html::button('浏览服务器', ArrayHelper::merge(['id'=>'k_filemanager', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				default:
					return Html::activeTextarea($this->model, $this->attribute, ['id'=>$this->id]);
					break;
			}
		}else{
			switch($this->editorType){
				case 'colorpicker':
					return Html::textInput($this->id, $this->value, ArrayHelper::merge(['class'=>'form-control', 'id'=>$this->id], $this->inputOptions)) . Html::button('打开取色器', ArrayHelper::merge(['id'=>'k_colorpicker', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'uploadButton':
                    return Html::textInput($this->id, $this->value, ArrayHelper::merge(['class'=>'form-control', 'id'=>$this->id], $this->inputOptions)) . Html::button('选择文件', ArrayHelper::merge(['id'=>'k_uploadBtn', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'file-dialog':
                    return Html::textInput($this->id, $this->value, ArrayHelper::merge(['class'=>'form-control', 'id'=>$this->id], $this->inputOptions)) . Html::button('选择文件', ArrayHelper::merge(['id'=>'k_fileBtn', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'image-dialog':
                    return Html::textInput($this->id, $this->value, ArrayHelper::merge(['class'=>'form-control', 'id'=>$this->id], $this->inputOptions)) . Html::button('选择图片', ArrayHelper::merge(['id'=>'k_imageBtn', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'image-dialog-remote':
                    return Html::textInput($this->id, $this->value, ArrayHelper::merge(['class'=>'form-control', 'id'=>$this->id], $this->inputOptions)) . Html::button('选择图片', ArrayHelper::merge(['id'=>'k_imageRemote', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'image-dialog-local':
                    return Html::textInput($this->id, $this->value, ArrayHelper::merge(['class'=>'form-control', 'id'=>$this->id], $this->inputOptions)) . Html::button('选择图片', ArrayHelper::merge(['id'=>'k_imageLocal', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'image-manager':
					return Html::textInput($this->id, $this->value, ArrayHelper::merge(['class'=>'form-control', 'id'=>$this->id], $this->inputOptions)) . Html::button('浏览服务器', ArrayHelper::merge(['id'=>'k_imagemanager', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'flash-manager':
                    return Html::textInput($this->id, $this->value, ArrayHelper::merge(['class'=>'form-control', 'id'=>$this->id], $this->inputOptions)) . Html::button('浏览服务器', ArrayHelper::merge(['id'=>'k_flashmanager', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'media-manager':
                    return Html::textInput($this->id, $this->value, ArrayHelper::merge(['class'=>'form-control', 'id'=>$this->id], $this->inputOptions)) . Html::button('浏览服务器', ArrayHelper::merge(['id'=>'k_mediamanager', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				case 'file-manager':
                    return Html::textInput($this->id, $this->value, ArrayHelper::merge(['class'=>'form-control', 'id'=>$this->id], $this->inputOptions)) . Html::button('浏览服务器', ArrayHelper::merge(['id'=>'k_filemanager', 'class'=>'btn btn-default'], $this->buttonOptions));
					break;
				default:
                    return Html::textarea($this->id, $this->value, ['id'=>$this->id]);
					break;
			}
		}
	}

	/**
	 * 注册客户端脚本
	 */
	protected function registerClientScript()
	{
		KindEditorAsset::register($this->view);
		switch($this->editorType){
			case 'colorpicker':
				$script = <<<EOT
KindEditor.ready(function(K){
	var colorpicker;
	K('#k_colorpicker').bind('click', function(e){
		e.stopPropagation();
		if(colorpicker){
			colorpicker.remove();
			colorpicker = null;
			return;
		}
		var colorpickerPos = K('#k_colorpicker').pos();
		colorpicker = K.colorpicker({
			x: colorpickerPos.x,
			y: colorpickerPos.y + K('#k_colorpicker').height(),
			z: 19811214,
			selectedColor: 'default',
			noColor: '无颜色',
			click: function(color) {
				K('#{$this->id}').val(color);
				colorpicker.remove();
				colorpicker = null;
			}
		});
	});
	K(document).click(function(){
		if(colorpicker){
			colorpicker.remove();
			colorpicker = null;
		}
	});
});
EOT;
				break;
			case 'uploadButton':
				$url = Url::to(['Kfupload', 'action'=>'uploadJson', 'dir'=>'file']);
				$script = <<<EOT
KindEditor.ready(function(K) {
	var uploadbutton = K.uploadbutton({
		button : K('#k_uploadBtn')[0],
		fieldName : 'imgFile',
		url : '{$url}',
		afterUpload : function(data) {
			if (data.error === 0) {
				var url = K.formatUrl(data.url, 'absolute');
				K('#{$this->id}').val(url);
			} else {
				alert(data.message);
			}
		},
		afterError : function(str) {
			alert('自定义错误信息: ' + str);
		}
	});
	uploadbutton.fileBox.change(function(e) {
		uploadbutton.submit();
	});
});
EOT;
			break;
			case 'file-dialog':
				$script = <<<EOT
KindEditor.ready(function(K){
	var editor = K.editor({
		allowFileManager: true,
		uploadJson: "{$this->_options['uploadJson']}",
		fileManagerJson: "{$this->_options['fileManagerJson']}",
	});
	K('#k_fileBtn').click(function(){
		editor.loadPlugin('insertfile', function(){
			editor.plugin.fileDialog({
				fileUrl: K('#{$this->id}').val(),
				clickFn: function(url, title){
					K('#{$this->id}').val(url);
					editor.hideDialog();
				}
			});
		});
	});
});
EOT;
				break;
			case 'image-dialog':
				$script = <<<EOT
KindEditor.ready(function(K){
	var editor = K.editor({
		allowFileManager: true,
		uploadJson: "{$this->_options['uploadJson']}",
		fileManagerJson: "{$this->_options['fileManagerJson']}",
	});
	K('#k_imageBtn').click(function(){
		editor.loadPlugin('image', function(){
			editor.plugin.imageDialog({
				imageUrl: K('#{$this->id}').val(),
				clickFn: function(url, title, width, height, border, align){
					K('#{$this->id}').val(url);
					editor.hideDialog();
				}
			});
		});
	});
});
EOT;
				break;
			case 'image-dialog-remote':
				$script = <<<EOT
KindEditor.ready(function(K){
	var editor = K.editor({
		allowFileManager: true,
		uploadJson: "{$this->_options['uploadJson']}",
		fileManagerJson: "{$this->_options['fileManagerJson']}",
	});
	K('#k_imageRemote').click(function(){
		editor.loadPlugin('image', function(){
			editor.plugin.imageDialog({
				showLocal: false,
				imageUrl: K('#{$this->id}').val(),
				clickFn: function(url, title, width, height, border, align){
					K('#{$this->id}').val(url);
					editor.hideDialog();
				}
			});
		});
	});
});
EOT;
				break;
			case 'image-dialog-local':
				$script = <<<EOT
KindEditor.ready(function(K){
	var editor = K.editor({
		allowFileManager: true,
		uploadJson: "{$this->_options['uploadJson']}",
		fileManagerJson: "{$this->_options['fileManagerJson']}",
	});
	K('#k_imageLocal').click(function(){
		editor.loadPlugin('image', function(){
			editor.plugin.imageDialog({
				showRemote: false,
				imageUrl: K('#{$this->id}').val(),
				clickFn: function(url, title, width, height, border, align){
					K('#{$this->id}').val(url);
					editor.hideDialog();
				}
			});
		});
	});
});
EOT;
				break;
			case 'image-manager':
				$script = <<<EOT
KindEditor.ready(function(K){
	var editor = K.editor({
		fileManagerJson: "{$this->_options['fileManagerJson']}",
	});
	K('#k_imagemanager').click(function(){
		editor.loadPlugin('filemanager', function(){
			editor.plugin.filemanagerDialog({
				viewType: 'VIEW',
				dirName: 'image',
				clickFn: function(url, title){
					K('#{$this->id}').val(url);
					editor.hideDialog();
				}
			});
		});
	});
});
EOT;
				break;
			case 'flash-manager':
				$script = <<<EOT
KindEditor.ready(function(K){
	var editor = K.editor({
		fileManagerJson: "{$this->_options['fileManagerJson']}",
	});
	K('#k_flashmanager').click(function(){
		editor.loadPlugin('filemanager', function(){
			editor.plugin.filemanagerDialog({
				viewType: 'LIST',
				dirName: 'flash',
				clickFn: function(url, title){
					K('#{$this->id}').val(url);
					editor.hideDialog();
				}
			});
		});
	});
});
EOT;
				break;
			case 'media-manager':
				$script = <<<EOT
KindEditor.ready(function(K){
	var editor = K.editor({
		fileManagerJson: "{$this->_options['fileManagerJson']}",
	});
	K('#k_mediamanager').click(function(){
		editor.loadPlugin('filemanager', function(){
			editor.plugin.filemanagerDialog({
				viewType: 'LIST',
				dirName: 'media',
				clickFn: function(url, title){
					K('#{$this->id}').val(url);
					editor.hideDialog();
				}
			});
		});
	});
});
EOT;
				break;
			case 'file-manager':
				$script = <<<EOT
KindEditor.ready(function(K){
	var editor = K.editor({
		fileManagerJson: "{$this->_options['fileManagerJson']}",
	});
	K('#k_filemanager').click(function(){
		editor.loadPlugin('filemanager', function(){
			editor.plugin.filemanagerDialog({
				viewType: 'LIST',
				dirName: 'file',
				clickFn: function(url, title){
					K('#{$this->id}').val(url);
					editor.hideDialog();
				}
			});
		});
	});
});
EOT;
				break;
			default:
				$script = "KindEditor.ready(function(K){
	K.create('#" . $this->id . "', " . Json::encode($this->clientOptions) . ");
});";
				break;
		}
		$this->view->registerJs($script, View::POS_READY);
	}
}