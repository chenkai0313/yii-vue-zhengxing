<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\Message */

$this->title = $model->theme;
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Messages'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="message-view">

    <p>
        <?= Html::a(Yii::t('app', 'Update'), ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?=
        Html::a(Yii::t('app', 'Delete'), ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => Yii::t('app', 'Delete confirm'),
                'method' => 'post',
            ],
        ])
        ?>
    </p>

    <?=
    DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
            // 'theme',
            // [
            //     'attribute' => 'replyway',
            //     'value' => \common\models\Replyway::findOne($model->replyway)->title,
            // ],
            'linkman',
                 // 'linkman',
            'content:ntext',
            // 'display',
            ['attribute' => 'create_at',
                'format' => ['date', 'php:Y-m-d H:i'],
            ],
            'linkway',
            'address',
            'email',
        ],
    ])
    ?>

</div>
