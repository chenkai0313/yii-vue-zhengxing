百度Ueditor编辑器
=====================
安装:
------------
使用 [composer](http://getcomposer.org/download/) 下载:
```
composer require --prefer-dist moxuandi/yii2-ueditor:"dev-master"
```


使用:
-----

在 `Controller` 中添加:
```php
public function actions()
{
    return [
        'upload' => [
            'class' => 'moxuandi\ueditor\UEditorAction',
        ]
    ];
}
```

在 `View` 中添加:
```php
1. 简单调用:
<?= $form->field($model, 'content')->widget('moxuandi\ueditor\UEditor'); ?>

2. 带参数调用:
<?= $form->field($model, 'content')->widget('moxuandi\ueditor\UEditor', [
    'clientOptions'=>[
        //编辑区域的大小
        'initialFrameWidth'=>'920',
        'initialFrameHeight'=>800,
        //设置语言
        'lang' => 'zh-cn',
        //定制菜单
        'toolbars' => [
            [
                'fullscreen', 'source', 'undo', 'redo', '|',
                'fontsize',
                'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'removeformat',
                'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|',
                'forecolor', 'backcolor', '|',
                'lineheight', '|',
                'indent', '|'
            ],
        ],
    ],
]); ?>

3. 不带 $model 调用:
<?= \moxuandi\ueditor\UEditor::widget([
    'clientOptions'=>['initialFrameWidth'=>'920'],
    'attribute'=>'image'
]) ?>
```
编辑器相关配置，请在`view`中配置，参数为`clientOptions`，比如定制菜单，编辑器大小等等，具体参数请查看[Ueditor官网文档](http://fex-team.github.io/ueditor/)

文件上传相关配置，请在`controller`中配置，参数为`config`,例如文件上传路径等；更多参数请参照 config.php (跟[UEditor提供的config.json](http://fex-team.github.io/ueditor/#server-config)一样)

简单实例: 
```php
public function actions()
{
    return [
        'upload' => [
            'class' => 'moxuandi\ueditor\UEditorAction',
            'config' => [
                'imageMaxSize' => 1024,
            ],
        ],
    ];
}
```

