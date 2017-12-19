<?php
namespace moxuandi\kindeditor;

use yii\web\AssetBundle;

/**
 * Asset of KindEditor
 *
 * @author zhangmoxuan <1104984259@qq.com>
 * @original author Qinn Pan <Pan JingKui, pjkui@qq.com, http://www.pjkui.com>
 * @link http://www.zhangmoxuan.com
 * @QQ 1104984259
 * @date 2017-4-1
 */
class KindEditorAsset extends AssetBundle
{
	public $sourcePath = '@vendor/moxuandi/yii2-kindeditor/assets';
	
	public $js = [
		'kindeditor-all-min.js',
	];

	public $css = [
		'themes/default/default.css'
	];

    public $depends = [
        'yii\web\JqueryAsset',
    ];
}