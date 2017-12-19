<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model common\models\Images */

$this->title = '创建会员风采';
$this->params['breadcrumbs'][] = ['label' => '会员风采', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="images-create">
    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>