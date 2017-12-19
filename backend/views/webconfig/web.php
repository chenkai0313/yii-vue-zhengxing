<?php
/* @var $this yii\web\View */

use yii\helpers\Url;
use yii\helpers\Html;
use yii\widgets\ActiveForm;
$this->title = '参数配置';
?>


<div class="col-xs-12 col-sm-9 col-lg-10">

    <style type="text/css">
        .red {float:left;color:red}
        .white{float:left;color:#fff}
        .tooltipbox {
            background:#fef8dd;border:1px solid #c40808; position:absolute; left:0;top:0; text-align:center;height:20px;
            color:#c40808;padding:2px 5px 1px 5px; border-radius:3px;z-index:1000;
        }
        .red { float:left;color:red}
        #web_logo {
            width: 200px;
            height: 200px;
        }
        #qeT {
            width: 200px;
            height: 200px;
        }
        #qeO {
            width: 200px;
            height: 200px;
        }
        .web_logBox {
            display: flex;
            justify-content: center;
        }
    </style>
    <script type="text/javascript">
        function showImageDialog(elm, opts, options) {
            require(["util"], function (util) {
                var btn = $(elm);
                var ipt = btn.parent().prev();
                var val = ipt.val();
                var img = ipt.parent().next().children();
                options = {'global': false, 'class_extra': '', 'direct': true, 'multiple': false};
                util.image(val, function (url) {
                    if (url.url) {
                        if (img.length > 0) {
                            img.get(0).src = url.url;
                        }
                        ipt.val(url.attachment);
                        ipt.attr("filename", url.filename);
                        ipt.attr("url", url.url);
                    }
                    if (url.media_id) {
                        if (img.length > 0) {
                            img.get(0).src = "";
                        }
                        ipt.val(url.media_id);
                    }
                }, null, options);
            });
        }
        function deleteImage(elm) {
            require(["jquery"], function ($) {
                $(elm).prev().attr("src", "./resource/images/nopic.jpg");
                $(elm).parent().prev().find("input").val("");
            });
        }
    </script>
    <ul class="nav nav-tabs">

        <li class="<?php if ($this->context->action->id == 'web') echo 'active'; ?>"><a href="<?= Url::to(['webconfig/web']); ?>">站点设置</a></li>

    </ul>
    <div class="main">
        <form action="" method="post" class="form-horizontal form" enctype="multipart/form-data" id="form1">
            <input type="hidden" name="<?= Yii::$app->request->csrfParam ?>" value="<?= Yii::$app->request->getCsrfToken() ?>" />

            <div class="panel panel-default">
                <div class="panel-heading">站点信息</div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">后台站点名称</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="webname" class="form-control" value="<?php echo empty($model) ? '' : $model['webname'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">网站域名</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="web_add" class="form-control" value="<?php echo empty($model) ? '' : $model['web_add'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">网站SEO</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="web_seo" class="form-control" value="<?php echo empty($model) ? '' : $model['web_seo'] ?>">
                        </div>
                    </div>

                  <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">主办</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="host" class="form-control" value="<?php echo empty($model) ? '' : $model['host'] ?>">
                        </div>
                    </div>

                       <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">维护</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="maintenance" class="form-control" value="<?php echo empty($model) ? '' : $model['maintenance'] ?>">
                        </div>
                    </div>



                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">热线</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="phone" class="form-control" value="<?php echo empty($model) ? '' : $model['phone'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">地址</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="wealth_add" class="form-control" value="<?php echo empty($model) ? '' : $model['wealth_add'] ?>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">邮编</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="post" class="form-control" value="<?php echo empty($model) ? '' : $model['post'] ?>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">邮箱</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="email" class="form-control" value="<?php echo empty($model) ? '' : $model['email'] ?>">
                        </div>
                    </div>

                     <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">传真</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="fax" class="form-control" value="<?php echo empty($model) ? '' : $model['fax'] ?>">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">备案号1</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="recode1" class="form-control" value="<?php echo empty($model) ? '' : $model['recode1'] ?>">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">备案号2</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="text" name="recode2" class="form-control " value="<?php echo empty($model) ? '' : $model['recode2'] ?>">
                        </div>
                    </div>
                    <div class="web_logBox" id="web_logBoxI">
                        <img id="web_logo" src="">
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">网站LOGO</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="file" name="web_logo" class="form-control"  value="<?php echo empty($model) ? '' : $model['web_logo'] ?>">
                            <input id="logoHi" type="hidden" value="<?php echo empty($model) ? '' : $model['web_logo'] ?>">
                        </div>
                    </div>
                    <div class="web_logBox" id="qecode1">
                        <img id="qeO" src="">
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">新浪微博</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="file" name="qrcode1" class="form-control" value="<?php echo empty($model) ? '' : $model['qrcode1'] ?>">
                            <input id="reco" type="hidden" value="<?php echo empty($model) ? '' : $model['qrcode1'] ?>">
                        </div>
                    </div>
                    <div class="web_logBox" id="qecode2">
                        <img id="qeT" src="">
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">微信公众号</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="file" name="qrcode2" class="form-control" value="<?php echo empty($model) ? '' : $model['qrcode2'] ?>">
                            <input id="qrc" type="hidden" value="<?php echo empty($model) ? '' : $model['qrcode2'] ?>">
                        </div>
                    </div>
                    <div class="web_logBox" id="index_thumb">
                        <img id="qeT1" src="">
                    </div>
                    <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">网站头部图片</label>
                        <div class="col-sm-9 col-xs-12">
                            <input type="file" name="index_thumb" class="form-control" value="<?php echo empty($model) ? '' : $model['index_thumb'] ?>">
                            <input id="index" type="hidden" value="<?php echo empty($model) ? '' : $model['index_thumb'] ?>">
                        </div>
                    </div>

          



            <!--         <div class="form-group">
                        <label class="col-xs-12 col-sm-3 col-md-2 control-label">阅读须知</label>
                        <div class="col-sm-9 col-xs-12" row="10" cols="30">
                  <textarea type="text" name="must_know" rows="10" class="form-control" value="<?php echo empty($model) ? '' : $model['must_know'] ?>"><?php echo empty($model) ? '' : $model['must_know'] ?>
                      
                  </textarea> 
                        <!--     <input type="text" name="must_know" rows="10" class="form-control" value="<?php echo empty($model) ? '' : $model['must_know'] ?>"> -->
        <!--                 </div>
                    </div> --> 
               
                </div>
            </div>

            <div class="form-group col-sm-12">
                <input type="submit" name="submit" value="提交" class="btn btn-primary col-lg-1">
            </div>
        </form>
    </div>
    <script language="javascript">
            if ($("#logoHi").val() !== "") {
                $("#web_logBoxI").css("display","flex")
                var srcWebLogo = $("#logoHi").val()
                $("#web_logo").attr("src",srcWebLogo)
                   
            } else {
                console.log("1")
                $("#web_logBoxI").css("display","none")
            }

            if ($("#reco").val() !== "") {
                $("#qecode1").css("display","flex")
                var srcWebLogoO = $("#reco").val()
                $("#qeO").attr("src",srcWebLogoO)
                   
            } else {
                $("#qecode1").css("display","none")
            }

            if ($("#qrc").val() !== "") {
                $("#qecode2").css("display","flex")
                var srcWebLogoT = $("#qrc").val()
                $("#qeT").attr("src",srcWebLogoT)
                   
            } else {
                $("#qecode2").css("display","none")
            }

            if ($("#index").val() !== "") {
                $("#index_thumb").css("display","flex")
                var srcWebLogoT = $("#index").val()
                $("#qeT1").attr("src",srcWebLogoT)
                   
            } else {
                $("#index_thumb").css("display","none")
            }
    </script>
</div>