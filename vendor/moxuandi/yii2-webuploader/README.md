yii2-webuploader-title
======================
WebUploader是由Baidu WebFE(FEX)团队开发的一个简单的以HTML5为主，FLASH为辅的现代文件上传组件。在现代的浏览器里面能充分发挥HTML5的优势，同时又不摒弃主流IE浏览器，沿用原来的FLASH运行时，兼容IE6+，iOS 6+, android 4+。两套运行时，同样的调用方式，可供用户任意选用。  采用大文件分片并发上传，极大的提高了文件上传效率。

Installation
------------

The preferred way to install this extension is through [composer](http://getcomposer.org/download/).

Either run

```
composer require --prefer-dist moxuandi/yii2-webuploader "dev-master"
```

需要更新：
-----
1. 编辑回显功能
2. 样式外观
3.重写上传类


Usage
-----

Once the extension is installed, simply use it in your code by  :

```php
controller:
public function actions()
{
    return [
        'WebUploader' => [
            'class' => 'moxuandi\webuploader\Uploader',
            'config' => [
                'thumbWidth' => 110,   //缩略图宽度
                'thumbHeight' => 110,  //缩略图高度
            ],
        ],
    ];
}

view:
<?= $form->field($model, 'imgurl')->widget('moxuandi\webuploader\MultiImage') ?>