<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Replyway */

$this->title = 'Update Replyway: ' . $model->title;
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Replyways'), 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->title, 'url' => ['view', 'id' => $model->id]];
?>
<div class="replyway-update">
    <?=
    $this->render('_form', [
        'model' => $model,
    ])
    ?>

</div>
