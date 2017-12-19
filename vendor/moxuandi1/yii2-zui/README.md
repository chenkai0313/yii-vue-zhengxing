ZUI
=========
一个基于 Bootstrap 深度定制开源前端实践方案，帮助你快速构建现代跨屏应用。

安装
------------

1.使用 [composer](https://pkg.phpcomposer.com/) 下载:
```
composer require --prefer-dist moxuandi/yii2-zui "dev-master"
```


用法
-----

如果你仅仅使用zui框架:
```php
AppAsset:
public $depends = [
    'moxuandi\zui\ZuiAsset',
];
```

如果你要使用多图上传:
```php
controller:
public function actions()
{
    return [
        'ZuiUploader' => [
            'class' => 'moxuandi\zui\ZuiAction',
            'config' => [
                'thumbWidth' => 110,   //缩略图宽度
                'thumbHeight' => 110,  //缩略图高度
            ],
        ],
    ];
}

view:
<?= $form->field($model, 'imgurl')->widget('moxuandi\zui\MultiImage') ?>
//多文件上传
<?= $form->field($model, 'imgurl')->widget('moxuandi\zui\MultiImage', [
    'action'=>'medias',
    'filter'=>[
        'mime_types'=> [['title'=>'视音频', 'extensions'=>'flv,swf,mkv,avi,rm,rmvb,mpeg,mpg,ogg,ogv,mov,wmv,mp4,webm,mp3,wav,mid']],
        'max_file_size'=>'220mb',
        'prevent_duplicates'=>true
    ]
]) ?>
//action有三个值：
//images: 多图上传，默认值
//files: 多文件上传
//medias: 多视音频上传
//filter 必须与控制器中的config配置项配合使用

//百度WebUploader上传界面(用法同MultiImage)：
<?= $form->field($model, 'imgurl')->widget('moxuandi\zui\WebUpload') ?>
```