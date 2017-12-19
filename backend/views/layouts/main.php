<?php
/* @var $this \yii\web\View */
/* @var $content string */

use backend\assets\AppAsset;
use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\widgets\Breadcrumbs;
use common\widgets\Alert;
use yii\helpers\Url;

AppAsset::register($this);
?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
    <head>
        <meta charset="<?= Yii::$app->charset ?>">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <?= Html::csrfMetaTags() ?>
        <title><?= Html::encode($this->title) ?></title>
        <?php $this->head() ?>
        <?= Html::jsFile('@web/js/jquery.js') ?>
    </head>
    <body>
        <?php $this->beginBody() ?>
        <?php
        $model = \common\models\Webconfig::find()
                ->asArray()
                ->all();
        $rs = unserialize($model[0]['content']);
        // var_dump($rs);
        // exit();
        ?>
        <div class="wrap">
            <?php
            NavBar::begin([
                'brandLabel' => $rs['webname'],
                'brandUrl' => Yii::$app->homeUrl,
                'options' => [
                    'class' => 'navbar-inverse navbar-fixed-top',
                ],
            ]);

            if (Yii::$app->user->isGuest) {
                $menuItems[] = ['label' => '登录', 'url' => ['/site/login']];
            } else {
                $menuItems[] = '<li>'
                        . Html::beginForm(['/site/logout'], 'post')
                        . Html::submitButton(
                                '退出 (' . Yii::$app->user->identity->nickname . ')', ['class' => 'btn btn-link']
                        )
                        . Html::endForm()
                        . '</li>';
            }
            echo Nav::widget([
                'options' => ['class' => 'navbar-nav navbar-right'],
                'items' => $menuItems,
            ]);
            NavBar::end();
            ?>
            <style>
                .navbar-brand{
                    font-size: 24px;
                }
                #left{
                    height: auto;
                    width: 13%;
                    min-height: 23rem;
                    float: left;
                    margin-right: 1rem;
                    padding: 0px;

                }
                .panel-heading:hover{
                    background-color:#f5f5f5;
                    cursor: pointer;

                }
                .panel-heading>a:hover{
                    text-decoration: none;
                }

            </style>


            <div class="container" style="width: <?php if (!Yii::$app->user->isGuest) echo "100%"; ?>">


                <?php if (!Yii::$app->user->isGuest) { ?>

                    <div id="left" class="col-md-12">

                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title ">业务菜单</h4>
                                <a class="panel-collapse collapsed" data-toggle="collapse" href="#frame-menu">
                                    <i class="fa fa-chevron-circle-down"></i>
                                </a>
                            </div>
                            <ul class="list-group collapse in" id="frame-menu">
                                <a class="  list-group-item <?php if ($this->context->id == 'webconfig') echo 'active'; ?>" href="<?= Url::toRoute('webconfig/web') ?>"><i class="glyphicon glyphicon-home "></i> &nbsp;&nbsp;系统配置</a>
                                <a class="  list-group-item <?php if ($this->context->id == 'adminuser') echo 'active'; ?>" href="<?= Url::toRoute('adminuser/index') ?>"><i class="glyphicon glyphicon-wrench"></i> &nbsp;&nbsp;管理员设置</a>
                                <a class="list-group-item <?php if ($this->context->id == 'category') echo 'active'; ?>" href="<?= Url::toRoute('category/index') ?>"><i class="glyphicon glyphicon-th-list "></i> &nbsp;&nbsp;导航栏管理</a>
                                <a class="list-group-item <?php if ($this->context->id == 'slide') echo 'active'; ?>" href="<?= Url::toRoute('slide/index') ?>"><i class="glyphicon glyphicon-film"></i> &nbsp;&nbsp;轮播图管理</a>
                                <a class="list-group-item <?php if ($this->context->id == 'service') echo 'active'; ?>" href="<?= Url::toRoute('service/index') ?>"><i class="glyphicon glyphicon-modal-window "></i> &nbsp;&nbsp;服务大厅</a>

                         <!--         <a class="list-group-item <?php if ($this->context->id == 'member') echo 'active'; ?>" href="<?= Url::toRoute('member/index') ?>"><i class="glyphicon glyphicon-user "></i> &nbsp;&nbsp;会员风采</a>-->
                                 <a class="list-group-item <?php if ($this->context->id == 'link') echo 'active'; ?>" href="<?= Url::toRoute('link/index') ?>"><i class="glyphicon glyphicon-tags "></i> &nbsp;&nbsp;友情链接</a> 
                                 
                                <div class="panel-group" id="panel-339383">
                                    <div class="panel ">
                                        <div class="panel-heading">
                                            <a class="  panel-title collapsed" data-toggle="collapse" data-parent="#panel-339383" href="#panel-element-345832"><i class=" <?php
                                                if ($this->context->id == 'news' || $this->context->id == 'source') {
                                                    echo 'glyphicon glyphicon-chevron-down';
                                                } else {
                                                    echo 'glyphicon glyphicon-chevron-right ';
                                                }
                                                ?>  "></i> 新闻管理</a>
                                        </div>


                                        <div id="panel-element-345832" class="panel-collapse collapse <?php if ($this->context->id == 'news' || $this->context->id == 'source' || $this->context->action->id == 'create') echo 'in'; ?>">
                                            <div class=" panel-body" style="padding: 0px;">

                                                <a class="list-group-item <?php if ($this->context->id == 'news') echo 'active'; ?>" href="<?= Url::toRoute('news/index') ?>"><i class="fa fa-puzzle-piece"></i> &nbsp;&nbsp;所有新闻</a>

                                            </div>

                                            <!--                                            <div class="panel-body" style="padding: 0px;">
                                                                                            <a class="list-group-item <?php if ($this->context->action->id == 'create') echo 'active'; ?>" href="<?= Url::toRoute('news/create') ?>"><i class="fa fa-puzzle-piece"></i> &nbsp;&nbsp;发布新闻</a>
                                                                                        </div>-->
                                            <div class="panel-body" style="padding: 0px;">
                                                <a class="list-group-item <?php if ($this->context->id == 'source') echo 'active'; ?>" href="<?= Url::toRoute('source/index') ?>"><i class="fa fa-puzzle-piece"></i> &nbsp;&nbsp;所有来源</a>
                                            </div>
                                        </div>



                                    </div>
                                    <div class="panel ">
                                        <div class="panel-heading">
                                            <a class="panel-title collapsed " data-toggle="collapse" data-parent="#panel-339383" href="#panel-element-107168">
                                                <i class="  glyphicon glyphicon-comment"></i> 留言管理</a>
                                        </div>
                                        <div id="panel-element-107168" class="panel-collapse collapse <?php if ($this->context->id == 'message' || $this->context->id == 'replyway' || $this->context->id == 'reply') echo 'in'; ?>">
                                            <div class="panel-body"style="padding: 0px;">
                                                <a class="list-group-item <?php if ($this->context->id == 'message') echo 'active'; ?>" href="<?= Url::toRoute('message/index') ?>"><i class="fa fa-puzzle-piece"></i> &nbsp;&nbsp;查看留言</a>
                                            </div>
                                  <!--           <div class="panel-body"style="padding: 0px;">
                                                <a class="list-group-item <?php if ($this->context->id == 'replyway') echo 'active'; ?>" href="<?= Url::toRoute('replyway/index') ?>"><i class="fa fa-puzzle-piece"></i> &nbsp;&nbsp;回复方式</a>
                                            </div> -->
                                      <!--       <div class="panel-body"style="padding: 0px;">
                                                <a class="list-group-item <?php if ($this->context->id == 'reply') echo 'active'; ?>" href="<?= Url::toRoute('reply/index') ?>"><i class="fa fa-puzzle-piece"></i> &nbsp;&nbsp;留言回复</a>
                                            </div> -->
                                        </div>
                                    </div>

                                </div>


                            </ul>
                        </div>

                    </div>

                <?php } ?>



                <div style="width: 85%;float: left;">
                    <?=
                    Breadcrumbs::widget([
                        'links' => isset($this->params['breadcrumbs']) ? $this->params['breadcrumbs'] : [],
                    ])
                    ?>
                    <?= Alert::widget() ?>
                    <?= $content ?>
                </div>
            </div>
        </div>

        <footer class="footer">
            <div class="container">
                <p class="pull-left">&copy; 浙江省整形美容行业协会 <?= date('Y') ?></p>
            </div>
        </footer>


        <?php $this->endBody() ?>
    </body>
</html>
<?php $this->endPage() ?>
