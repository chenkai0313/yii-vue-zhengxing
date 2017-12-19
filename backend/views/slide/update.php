<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Slide */

$this->title = 'Update Slide: ' . $model->title;
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Slides'), 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->title, 'url' => ['view', 'id' => $model->id]];
?>
<div class="slide-update">



    <?=
    $this->render('_form', [
        'model' => $model,
    ])
    ?>

</div>
