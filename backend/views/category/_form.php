<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* create by ck */
/* @var $this yii\web\View */
/* @var $model common\models\Category */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="category-form">
    <?php $form = ActiveForm::begin(); ?>
    <?= $form->field($model, 'name')->textInput(['maxlength' => true]) ?>
    <?php
    $items = \common\models\Category::find()
    ->where('id=pid')
            ->all();
    $allitems = yii\helpers\ArrayHelper::map($items, 'id', 'name');
    $allitems[0] = Yii::t('app', 'first category');
    ?>
    <?= $form->field($model, 'pid')->dropDownList($allitems) ?>

    <?= $form->field($model, 'bgimage')->hint(Yii::t('app', 'bgimage defalut'))->widget('moxuandi\webuploader\MultiImage') ?>
     <?= $form->field($model, 'remark')->textInput() ?>

    <?php
    $array[0] = '不展示';
    $array[1] = '展示';
    ?>
    <?=
            $form->field($model, 'display')
            ->dropDownList($array, ['prompt' => '请选择是否展示'])
    ?>
 
     <?php
    $array[0] = '单页面';
    $array[1] = '列表页';
    $array[2] = '一级标题页面';
    $array[3] = '文章列表';
    $array[4] = '图片模型';
    ?>
    <?=
            $form->field($model, 'list_type')
            ->dropDownList($array, ['prompt' => '请选择模板'])
    ?>
    <?= $form->field($model, 'weight')->hint(Yii::t('app', 'weight defalut'))->textInput() ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? '创建' : '修改', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
