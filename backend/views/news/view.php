<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\News */

$this->title = $model->title;
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'News'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="news-view">



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
//            'pid',
            [
                'attribute' => 'pid',
                'value' => \common\models\Category::findOne($model->pid)->name,
            ],
//            'cid',
            [
                'attribute' => 'cid',
                'value' => \common\models\Category::findOne($model->cid)->name,
            ],
            'title:ntext',
            'remark:ntext',
//            'thumb',
            [
                'attribute' => 'thumb',
                'format' => 'html',
                'value' => Html::img('@web/'.$model->thumb),
            ],
            'content:ntext',
//            'source',
            [
                'attribute' => 'source',
                'value' => \common\models\Source::findOne($model->source)->name,
            ],
            'create_at',
//            'update_at',
            ['attribute' => 'update_at',
                'format' => ['date', 'php:Y-m-d H:i'],
            ],
            'weight',
            [
                'attribute' => 'source',
                'value' => \common\models\Source::findOne($model->source)->name,
            ],
//            'display',
            [
                'attribute' => 'display',
                'value' => \common\models\Display::findOne($model->display)->title,
            ],
        ],
    ])
    ?>

</div>
