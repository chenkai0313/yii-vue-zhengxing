<?php

use yii\helpers\Html;
// use yii\grid\GridView;
use yii\helpers\Url;
use kartik\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel common\models\SlideSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Slides');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="slide-index">


    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a(Yii::t('app', 'Create Slide'), ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <?=
    GridView::widget([
        'dataProvider' => $dataProvider,
        'export' => false,
        'filterModel' => $searchModel,
        'columns' => [
            [
                'attribute' => 'id',
                'contentOptions' => ['width' => '30px'],
            ],
            [
                'attribute' => 'weight',
                'contentOptions' => ['width' => '30px'],
                  'class'=>'kartik\grid\EditableColumn',
                'editableOptions'=>[
                'asPopover' => false,
                   'inputType'=>\kartik\editable\Editable::INPUT_TEXTAREA,
                                    ],
            ],
            [
                'attribute' => 'title',
                'value' => 'shorttitle'
            ],
            [
                'attribute' => 'img',
                'format' => [
                    'image',
                    [
                        'width' => '300',
                        'height' => '150'
                    ]
                ],
                'value' => function ($model) {
                    return '@web/'.$model->img;
                }
            ],
            [
                'attribute' => 'display',
                'filter' => \common\models\Display::find()
                        ->select(['title', 'id'])
                        ->indexBy('id')
                        ->orderby('id desc')
                        ->column(),
                'value' => function($model) {
                    return \common\models\Display::findOne($model->display)->title;
                },
            ],
            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]);
    ?>
</div>
