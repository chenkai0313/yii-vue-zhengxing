<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Images */

$this->title = '修改友情链接: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => '服务大厅', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->id, 'url' => ['view', 'id' => $model->id]];

?>
<div class="images-update"
    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>