<?php
namespace moxuandi\zui;

use yii\web\AssetBundle;

class ZuiAsset extends AssetBundle
{
    public $sourcePath = '@vendor/moxuandi/yii2-zui/assets';
	
    public $css = [
        'css/zui.min.css',
    ];
    public $js = [
        'js/zui.min.js',
    ];
    public $depends = [
        'yii\web\JqueryAsset',
    ];
}
