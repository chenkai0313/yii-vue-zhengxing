<?php

use yii\helpers\Html;
use yii\grid\GridView;
use yii\helpers\Url;

/* @var $this yii\web\View */
/* @var $searchModel common\models\MessageSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Messages');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="message-index">
<!-- <p>
        <?= Html::a(Yii::t('app', 'Create Message'), ['create'], ['class' => 'btn btn-success']) ?>
    </p>  -->
    <?=
    GridView::widget([
        'showFooter' => true,
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'id' => 'grid',
        'columns' => [
            [
                'class' => 'yii\grid\CheckboxColumn',
                'name' => 'id',
                'headerOptions' => ['width' => '30'],
                'footer' => '<button href="#" id="ck" class="btn btn-default btn-xs btn-delete" url="' . Url::toRoute('message/deleteall') . '">删除</button>',
                'footerOptions' => ['colspan' => 8],
            ],
            [
                'attribute' => 'id',
                'contentOptions' => ['width' => '30px'],
                'footerOptions' => ['class' => 'hide'],
            ],
            // [
            //     'attribute' => 'theme',
            //     'value' => 'shorttitle',
            //     'footerOptions' => ['class' => 'hide'],
            // ],
            // [
            //     'attribute' => 'replyway',
            //     'filter' => \common\models\Replyway::find()
            //             ->select(['title', 'id'])
            //             ->indexBy('id')
            //             ->orderby('id desc')
            //             ->column(),
            //     'value' => function($model) {
            //         return \common\models\Replyway::findOne($model->replyway)->title;
            //     },
            //     'footerOptions' => ['class' => 'hide'],
            // ],
            ['attribute' => 'linkway', 'footerOptions' => ['class' => 'hide']],
            // ['attribute' => 'content', 'footerOptions' => ['class' => 'hide']],
                [
                'attribute' => 'content',
                'value' => 'shortcontent',
                'footerOptions' => ['class' => 'hide'],
            ],
            ['attribute' => 'linkman', 'footerOptions' => ['class' => 'hide']],
            ['attribute' => 'email', 'footerOptions' => ['class' => 'hide']],
            ['attribute' => 'address', 'footerOptions' => ['class' => 'hide']],
            // [
            //     'attribute' => 'display',
            //     'value' => function($v) {

            //         return $v->display ? Yii::t('app', 'Show') : Yii::t('app', 'hidden');
            //     },
            //     'footerOptions' => ['class' => 'hide'],
            // ],
            [
                'attribute' => 'create_at',
                'format' => ['date', 'php:Y-m-d H:i:s'],
                'footerOptions' => ['class' => 'hide'],
            ],
                   ['class' => 'yii\grid\ActionColumn',
                   'template'=>'{view} {delete}',
                   ],
            // [
            //     'class' => 'yii\grid\ActionColumn',
            //     'footerOptions' => ['class' => 'hide'],
            //     'template' => '{update}{delete}',
            //     'buttons' => [
            //         'update' => function($url, $model, $k) {
            //             $url = "index.php?r=reply%2Fmessage&id=$model->id";
            //             $options = [
            //                 'title' => Yii::t('app', 'view reply'),
            //                 'aria-label' => Yii::t('app', 'view reply'),
            //                 'style' => 'margin-right:1rem;'
            //             ];
            //             return Html::a('<span class="glyphicon glyphicon-eye-open"></span>', $url, $options);
            //         }
            //     ]
            // ],
        ],
    ]);
    ?>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        $("#ck").click(function () {
            var ids = $("#grid").yiiGridView("getSelectedRows");
            if (ids != "") {
                if (confirm("<?php echo Yii::t('app', 'Delete confirm'); ?>") == true) {
                    $.ajax({
                        type: "POST",
                        data: {
                            'id': ids
                        },
                        url: "<?php echo Url::toRoute('message/deleteall') ?>",
                        dataType: "json",
                        success: function (data) {
                            // console.log(data);
                            // return false;
                            if (data == 1) {
                                window.location.reload();
                            }
                        }
                    });
                }
                ;
            } else {
                alert("<?php echo Yii::t('app', 'Delete confirm data'); ?>");
            }
        });
    });
</script>