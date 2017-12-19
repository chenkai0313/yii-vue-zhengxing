<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Images */

$this->title = '修改会员风采: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => '会员风采', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];

?>
<div class="images-update"
    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>