<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Message */

$this->title = 'Update Message: ' . $model->id;
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Messages'), 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->theme, 'url' => ['view', 'id' => $model->id]];
?>
<div class="message-update">
    <?=
    $this->render('_form', [
        'model' => $model,
    ])
    ?>

</div>
