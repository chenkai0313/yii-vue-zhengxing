<?php

use yii\helpers\Html;
// use yii\grid\GridView;
use yii\helpers\Url;
use kartik\grid\GridView;
/* @var $this yii\web\View */
/* @var $searchModel common\models\NewsSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'News');
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="news-index">

    <p>
        <?= Html::a(Yii::t('app', 'Create News'), ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <?=
    GridView::widget([
        'showFooter' => true,
        'export' => false,
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'id' => 'grid',
        'columns' => [
            [
                'class' => 'yii\grid\CheckboxColumn',
                'name' => 'id',
                'headerOptions' => ['width' => '30'],
                'footer' => '<button href="#" id="ck" class="btn btn-default btn-xs btn-delete" url="' . Url::toRoute('news/deleteall') . '">删除</button>',
                'footerOptions' => ['colspan' => 8],
            ],
            [
                'attribute' => 'id',
                'contentOptions' => ['width' => '30px'],
                'footerOptions' => ['class' => 'hide'],
            ],
            [
                'attribute' => 'weight',
                'contentOptions' => ['width' => '30px'],
                'footerOptions' => ['class' => 'hide'],
                'class'=>'kartik\grid\EditableColumn',
                'editableOptions'=>[
                'asPopover' => false,
                   'inputType'=>\kartik\editable\Editable::INPUT_TEXTAREA,
                                    ],
            ],
            [
                'attribute' => 'source',
                'footerOptions' => ['class' => 'hide'],
                'filter' => \common\models\Source::find()
                        ->select(['name', 'id'])
                        ->indexBy('id')
                        ->orderby('id desc')
                        ->column(),
                'value' => function($model) {
                    return \common\models\Source::findOne($model->source)->name;
                },
            ],
            [
                'attribute' => 'cid',
                'footerOptions' => ['class' => 'hide'],
                     'filter' =>   \common\models\news::test(),
                'value' => function($model) {
                    return \common\models\Category::findOne($model->cid)->name;
                },
            ],
            [
                'attribute' => 'title',
                'value' => 'shorttitle',
                'footerOptions' => ['class' => 'hide'],
            ],
            ['attribute' => 'create_at', 'footerOptions' => ['class' => 'hide']],
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
                        url: "<?php echo Url::toRoute('news/deleteall') ?>",
                        dataType: "json",
                        success: function (data) {
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