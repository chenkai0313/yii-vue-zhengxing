<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model common\models\Message */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="message-form">

    <?php $form = ActiveForm::begin(); ?>

 <!--    <?= $form->field($model, 'theme')->textInput(['maxlength' => true]) ?>

 -->
<!--     <?php
    $rs = common\models\Replyway::find()
            ->select(['title'])
            ->orderBy('id')
            ->indexBy('id')
            ->column();
    ?>
    <?=
            $form->field($model, 'replyway')
            ->dropDownList($rs, ['prompt' => '请选择回复方式'])
    ?> -->
    <?= $form->field($model, 'linkway')->textInput(['maxlength' => true]) ?>
    <?= $form->field($model, 'linkman')->textInput(['maxlength' => true]) ?>
    <?= $form->field($model, 'email')->textInput(['maxlength' => true]) ?>
    <?= $form->field($model, 'address')->textInput(['maxlength' => true]) ?>

    <?=
    $form->field($model, 'content')->widget('moxuandi\ueditor\UEditor', [
        'clientOptions' => [
            //编辑区域的大小
            'initialFrameWidth' => (['rows' => 6]),
//            'initialFrameHeight' => 800,
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
    ]);
    ?>

    <!-- <?= $form->field($model, 'display')->textInput(['maxlength' => true]) ?> -->




    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? Yii::t('app', 'Create') : Yii::t('app', 'Update'), ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
