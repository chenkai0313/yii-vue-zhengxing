<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel common\models\ReplywaySearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Replyways');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="replyway-index">

    <p>
        <?= Html::a(Yii::t('app', 'Create Replyway'), ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <?=
    GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            [
                'attribute' => 'id',
                'contentOptions' => ['width' => '30px'],
            ],
            'title',
            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]);
    ?>
</div>
