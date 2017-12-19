KindEditor编辑器
=====================
KindEditor 是一套开源的在线HTML编辑器，主要用于让用户在网站上获得所见即所得编辑效果，开发人员可以用 KindEditor 把传统的多行文本输入框(textarea)替换为可视化的富文本输入框。 KindEditor 使用 JavaScript 编写，可以无缝地与 Java、.NET、PHP、ASP 等程序集成，比较适合在 CMS、商城、论坛、博客、Wiki、电子邮件等互联网应用上使用。 


安装:
------------
使用 [composer](https://pkg.phpcomposer.com/) 下载:
```
composer require --prefer-dist moxuandi/yii2-kindeditor:"dev-master"
```


使用:
-----

在 `Controller` 中添加:
```php
public function actions()
{
    return [
        'Kupload' => [
            'class'=>'moxuandi\kindeditor\KindEditorAction',
            //可选参数, 参考 config.php
            'config' => [
                'thumbWidth' => 150,	//缩略图宽度
                'thumbHeight' => 100,	//缩略图高度
            ],
        ],
    ];
}
```

在 `View` 中添加:
```php
1. 简单调用:
<?= $form->field($model, 'content')->widget('moxuandi\kindeditor\KindEditor'); ?>


2. 带参数调用:
<?= $form->field($model, 'content')->widget('moxuandi\kindeditor\KindEditor',[
	'clientOptions'=>['width'=>'1000', 'height'=>500],
]); ?>

3. 不带 $model 调用:
<?= \moxuandi\kindeditor\KindEditor::widget([
    'editorType'=>'image-dialog',
    'attribute'=>'image'
]) ?>
```
编辑器相关配置，请在`view`中配置，参数为`clientOptions`，比如定制菜单，编辑器大小等等，具体参数请查看[KindEditor官网文档](http://kindeditor.net/docs/option.html)


单独调用插件:
```php
<?= $form->field($model, 'imgurl')->widget('moxuandi\kindeditor\KindEditor', [
    'editorType'=>'image-dialog',
    'inputOptions'=>[  //input输入域的html属性
        'style'=>'display:inline-block;width:calc(100% - 84px);margin-right:6px;'
    ],
    'buttonOptions'=>['class'=>'btn btn-default'],  //按钮的html属性
]) ?>

editorType: 定义编辑器的类型, 值有：
    textEditor: HTML编辑器(默认)
    colorpicker: 取色器
    uploadButton: 自定义上传按钮
    file-dialog: 上传文件
    image-dialog: 上传图片(网络图片 + 本地上传)
    image-dialog-remote: 上传图片(网络图片)
    image-dialog-local: 上传图片(本地上传)
    image-manager: 浏览服务器(图片)
    flash-manager: 浏览服务器(Flash)
    media-manager: 浏览服务器(视音频)
    file-manager: 浏览服务器(文件)
    multiImageDialog: 批量上传图片(未实现)
```
