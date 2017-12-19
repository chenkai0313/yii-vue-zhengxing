<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model common\models\Images */

$this->title = '创建友情链接';
$this->params['breadcrumbs'][] = ['label' => '友情链接', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="images-create">
    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>