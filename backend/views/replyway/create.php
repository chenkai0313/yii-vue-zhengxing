<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Replyway */

$this->title = Yii::t('app', 'Create Replyway');
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Replyways'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="replyway-create">
    <?=
    $this->render('_form', [
        'model' => $model,
    ])
    ?>

</div>
