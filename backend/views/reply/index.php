<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel common\models\ReplySearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Replies');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="reply-index">
<!--    <p>
    <?= Html::a('Create Reply', ['create'], ['class' => 'btn btn-success']) ?>
    </p>-->
    <?=
    GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            [
                'attribute' => 'id',
                'contentOptions' => ['width' => '30px'],
            ],
            [
                'attribute' => 'pid_theme',
                'value' => function($model) {
                    $r = \common\models\Message::findOne($model->pid_theme)->theme;
                    if ($r) {
                        return $r;
                    } else {
                        return Yii::t('app', 'theme delete');
                    }
                },
            ],
            'content:ntext',
            'reply_people',
            ['attribute' => 'create_time',
                'format' => ['date', 'php:Y-m-d H:i:s'],
            ],
            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]);
    ?>
</div>
