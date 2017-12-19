<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel common\models\SourceSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Sources');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="source-index">

    <p>
        <?= Html::a(Yii::t('app', 'Create Source'), ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <?=
    GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            'id',
            'name',
            ['attribute' => 'crate_at',
                'format' => ['date', 'php:Y-m-d H:i:s'],
            ],
            ['attribute' => 'update_at',
                'format' => ['date', 'php:Y-m-d H:i:s'],
            ],
            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]);
    ?>
</div>
