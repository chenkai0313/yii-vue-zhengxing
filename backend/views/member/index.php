<?php
use yii\helpers\Html;
// use yii\grid\GridView;
use yii\helpers\Url;
use kartik\grid\GridView;
/* @var $this yii\web\View */
/* @var $searchModel common\models\ImagesSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = '会员风采';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="images-index">


    <p>
        <?= Html::a('创建会员风采', ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <?= GridView::widget([
        'export' => false,
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            // 'weight',
              [
                'attribute' => 'weight',
                  'class'=>'kartik\grid\EditableColumn',
                'editableOptions'=>[
                'asPopover' => false,
                   'inputType'=>\kartik\editable\Editable::INPUT_TEXTAREA,
                                    ],
            ],
            // 'id',
            // 'img',
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
            'url:url',
            ['attribute' => 'create_at',
                'format' => ['date', 'php:Y-m-d H:i:s'],
            ],
            ['attribute' => 'update_at',
                'format' => ['date', 'php:Y-m-d H:i:s'],
            ],
                           [
                'attribute' => 'display',
                'footerOptions' => ['class' => 'hide'],
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
    ]); ?>
</div>