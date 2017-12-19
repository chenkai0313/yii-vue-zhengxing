<?php
namespace moxuandi\ueditor;

use yii\web\AssetBundle;

/**
 * Asset of UEditor
 *
 * @author zhangmoxuan <1104984259@qq.com>
 * @link http://www.zhangmoxuan.cn
 * @QQ 1104984259
 * @date 2017-4-10
 */
class UEditorAsset extends AssetBundle
{
    public $sourcePath = '@vendor/moxuandi/yii2-ueditor/assets';

	public $js = [
		'ueditor.config.js',
		'ueditor.all.js',
	];

    public $depends = [
        'yii\web\JqueryAsset',
    ];
}