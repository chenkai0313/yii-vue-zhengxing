<?php
use yii\helpers\Html;
// use yii\grid\GridView;
use yii\helpers\Url;
use kartik\grid\GridView;
use kartik\editable\Editable;
/* @var $this yii\web\View */
/* @var $searchModel common\models\CategorySearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Category');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="category-index">

        <!-- <?= Html::a(Yii::t('app', 'Create Category'), ['create'], ['class' => 'btn btn-success']) ?> -->

    <?=
    GridView::widget([
             'export' => false,
        'dataProvider' => $dataProvider,
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
                'attribute' => 'pid',
                'filter' => \common\models\Category::find()
                        ->select(['name', 'id'])
                        ->where('id=pid')
                        ->indexBy('id')
                        ->orderby('id desc')
                        ->column(),
                'value' => function($model) {
                    return \common\models\Category::findOne($model->pid)->name;
                },
            ],
            'name',
            'remark',

            [
                'attribute' => 'display',
                   'filter' => array(
                    '1' => '展示',
                    '0' => '不展示'
                ),
                'value' => function($v) {
                    return $v->display ? '展示' : '不展示';
                },
            ],

            [
                'attribute' => 'list_type',
                  'filter' => array(
                    '3'=>'文章列表',
                     '2' => '这是一级标题页面',
                    '1' => '列表页',
                    '0' => '单页面'
                ),
                'value' => function($v) {
                    if($v->list_type==0){
                        return '单页面';
                    }
                   if($v->list_type==1){
                        return '列表页';
                   }
                    if($v->list_type==2){
                        return '这是一级标题页面';
                   }
                      if($v->list_type==3){
                        return '文章列表';
                   }
                         if($v->list_type==4){
                        return '图片模型';
                   }

                    
                },
            ],

            // ['class' => 'yii\grid\ActionColumn'],
                [
                'class' => 'yii\grid\ActionColumn',
                'footerOptions' => ['class' => 'hide'],
            
                'template' => '{view}{update}',
                // 'buttons' => [
                //     'update' => function($url, $model, $k) {
                //         $url = "index.php?r=reply%2Fmessage&id=$model->id";
                //         $options = [
                //             'title' => Yii::t('app', 'view reply'),
                //             'aria-label' => Yii::t('app', 'view reply'),
                //             'style' => 'margin-right:1rem;'
                //         ];
                //         return Html::a('<span class="glyphicon glyphicon-eye-open"></span>', $url, $options);
                //     }
                // ]
            ],
        ],
    ]);
    ?>
</div>
