<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model common\models\Images */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="images-form">

    <?php $form = ActiveForm::begin(); ?>
 <?= $form->field($model, 'img')->widget('moxuandi\webuploader\MultiImage') ?>
        <?=
    $form->field($model, 'content')->widget('moxuandi\ueditor\UEditor', [
        'clientOptions' => [
            //编辑区域的大小
            'initialFrameWidth' => (['rows' => 6]),
//            'initialFrameHeight' => 800,
            //设置语言
            'lang' => 'zh-cn',
            //定制菜单
            // 'toolbars' => [
            //     [
            //         'fullscreen', 'source', 'undo', 'redo', '|',
            //         'fontsize',
            //         'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'removeformat',
            //         'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|',
            //         'forecolor', 'backcolor', '|',
            //         'lineheight', '|',
            //         'indent', '|'
            //     ],
            // ],
        ],
    ]);
    ?>

    <?= $form->field($model, 'url')->textInput(['maxlength' => true]) ?>
     <?= $form->field($model, 'weight')->hint(Yii::t('app', 'weight defalut'))->textInput() ?>
    <?php
    $rs = common\models\Display::find()
            ->select(['title'])
            ->orderBy('id')
            ->indexBy('id')
            ->column();
    ?>

    <?=
            $form->field($model, 'display')
            ->dropDownList($rs, ['prompt' => '请选择是否发布'])
    ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? '创建' : '修改', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>