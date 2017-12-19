<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model common\models\Category */

$this->title = $model->name;
$this->params['breadcrumbs'][] = ['label' => Yii::t('app', 'Category'), 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="category-view">



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
            'name',
            [
                'attribute' => 'bgimage',
                'format' => 'html',
                'value' => Html::img('@web/'.$model->bgimage),
            ],
            // 'display',
            [
                'attribute' => 'display',
                'value' =>$model->getDisplay(),
            ],
            'weight',
            'remark',
//            'create_at',
            [
                'attribute' => 'create_at',
                'value' => date("Y-m-d H:i:s", $model->create_at)
            ],
            [
                'attribute' => 'update_at',
                'value' => date("Y-m-d H:i:s", $model->update_at)
            ],
                 [
                'attribute' => 'list_type',
                'value' =>$model->getListtype(),
            ],
      
        ],
    ])
    ?>

</div>
