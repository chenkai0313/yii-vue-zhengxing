<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model common\models\Source */

$this->title = Yii::t('app', 'Create Source');
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Source'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="source-create">



    <?=
    $this->render('_form', [
        'model' => $model,
    ])
    ?>

</div>
