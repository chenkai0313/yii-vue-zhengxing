<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel common\models\MessageSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = Yii::t('app', 'Reply Messages');
$this->params['breadcrumbs'][] = $this->title;
?>
<style>
    #nav_header{border-bottom: 1px solid #d4cece;height: 8rem;line-height: 8rem;}
    #nav_header_left{font-size: 3.5rem;display: inline-block;}
    #nav_header_right{float: right;}
    #nav_content{margin-top: 2rem;border: 1px solid #d4cece;min-height: 8rem;height: auto;background-color: #f5f5f5;}
    #nav_content_theme{height: 3rem;line-height: 3rem;}
    #nav_content_theme>div{}
    #nav_content_theme>div>a:hover{text-decoration: none;}
    #controller{float:right;background-color: #ccc;}
    #theme{display: inline-block;font-size: 1.5rem;margin-left: 1rem;}
    #a1{<?php
        if ($model['display'] == 1) {
            echo 'background-color: #337ab7;color: white;';
        } else {
            echo 'color: black;';
        }
        ?> display: inline-block;width: 4rem;text-align: center;}
    #a2{<?php
        if ($model['display'] == 0) {
            echo 'background-color: #337ab7;color: white;';
        } else {
            echo 'color: black;';
        }
        ?>
        width: 4rem;text-align: center;display: inline-block;}
    #nav_content_footer{border: 1px solid #d4cece;height: 3.5rem;background-color: #60BBFF;line-height: 3.5rem;}
    #nav_content_footer>ul{padding: 0px;margin-left: 1rem;}
    #nav_content_footer>ul>li{list-style: none;float: left;margin-left: 1rem;color: white;}
    #nav_reply{margin-top: 1rem;}
    #nav_reply_content{margin-top: 1rem;}
    #nav_content_content{text-indent: 2rem;}
</style>
<div id="nav_header">
    <div id="nav_header_left"><?php echo Yii::t('app', 'message view') ?></div>
    <div id="nav_header_right">
        <?= Html::a(Yii::t('app', 'message list'), ['message/index'], ['class' => 'btn btn-success']) ?>
    </div>
</div>
<div id="nav_content">
    <div id="nav_content_theme">
        <div  id="theme"><b><?= $model['theme'] ?></b></div>
        <div  id="controller" >
            <?= Html::a(Yii::t('app', 'Show'), ['display', 'id' => $model['id'], 'display' => 1], ['style' => '', 'id' => 'a1']) ?>
            <?= Html::a(Yii::t('app', 'hidden'), ['display', 'id' => $model['id'], 'display' => 0], ['class' => '', 'id' => 'a2']) ?>
        </div>
    </div>
    <div id="nav_content_content">
        &nbsp;&nbsp;&nbsp;&nbsp;<?= $model['content'] ?>
    </div>
    <div id="nav_content_footer">
        <ul>
            <li>联系人:<?= $model['linkman'] ?></li>
            <li>回复方式：<?= $model['linkway'] ?></li>
            <li>添加日期：<?= date('Y-m-d H:i:m', $model['create_at']) ?></li>
        </ul>
    </div>
</div>
<?php foreach ($rs as $r): ?>
    <div id="nav_reply">
        <b><?= $r['reply_people'] ?>回复[<?= date('Y-m-d H:i:m', $r['create_time']) ?>]</b>： <?= $r['content'] ?>
    </div>
<?php endforeach; ?>
<div id="nav_reply_content">
    <form action="<?= yii\helpers\Url::toRoute(['reply/add', 'id' => $model['id']]) ?>" method="post">
        <input name="_csrf" type="hidden" id="_csrf" value="<?= Yii::$app->request->csrfToken ?>">
        <textarea name="content" cols="90" rows="5" class="textArea" id="content"></textarea>
        <br>
        <input name="submit" class="btn  btn-primary" type="submit" value="留言回复">
    </form>
</div>
