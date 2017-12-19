<?php
namespace moxuandi\zui;

use yii\web\AssetBundle;

class WebUploadAsset extends AssetBundle
{
    public $sourcePath = '@vendor/moxuandi/yii2-zui/assets';

    public $css = [
        'lib/uploader/zui.uploader.css',
        'webupload/webupload.css',
    ];

    public $js = [
        'lib/uploader/zui.uploader.min.js',
    ];

    public $depends = [
        'moxuandi\zui\ZuiAsset',
    ];
}
