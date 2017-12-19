<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\Images */

$this->title = $model->id;
$this->params['breadcrumbs'][] = ['label' => '会员风采', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="images-view">



    <p>
        <?= Html::a('修改', ['update', 'id' => $model->id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('删除', ['delete', 'id' => $model->id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => '确定要删除吗？',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'id',
                 'weight',
            // 'img',
                [
                'attribute' => 'img',
                'format' => 'html',
                'value' => Html::img('@web/'.$model->img),
            ],
            'url:url',
            'content',
            //     ['attribute' => 'create_at',
            //     'format' => ['date', 'php:Y-m-d H:i'],
            // ],
                   [
                'attribute' => 'display',
                'value' => \common\models\Display::findOne($model->display)->title,
            ],
                ['attribute' => 'update_at',
                'format' => ['date', 'php:Y-m-d H:i'],
            ],

        ],
    ]) ?>

</div>