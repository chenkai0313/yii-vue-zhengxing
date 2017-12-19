<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\Url;
use kartik\datetime\DateTimePicker;

/* @var $this yii\web\View */
/* @var $model common\models\News */
/* @var $form yii\widgets\ActiveForm */
?>

<style type="text/css">
    .upbox{position: fixed;top: 0;left: 0;width: 100%;height: 100%;background-color: rgba(0,0,0,0.7);z-index: -1;opacity: 0}
    .selectbox{position: fixed;top: 20%;left:50%;width: 80%;margin-left:-40%;background-color: #fff;}
    #uploader .placeholder{}
</style>
<div class="news-form">

    <?php $form = ActiveForm::begin(); ?>
    <div class="form-group">
        <label class=" control-label">
            <span style='color:red'>*</span>
            分类
        </label>
        </br>
        <div class=" ">
            <select class="form-control" style="margin-right:15px;" id="s_lb" name="News[pid]"    autocomplete="off">
                <option value="">请选择一级分类</option>
                <?php $data = \common\models\Category::find()->asArray()->where('id = pid')->all(); ?>
                <?php foreach ($data as $v) { ?>
                    <option value="<?= $v['id'] ?>" <?php if ($v['id'] == $model['pid']) echo 'selected' ?>><?= $v['name'] ?></option>
                <?php } ?>
            </select>
        </div>
        </br>
        <div class=" ">
            <select class="form-control" style="margin-right:15px;" id="s_xm" name="News[cid]"  autocomplete="off">
                <option value="">请选择二级分类</option>
                <?php
                if ($model['cid']) {
                    $cate = \common\models\Category::find()->asArray()->where(['id' => $model['cid']])
                    ->andWhere(['display'=>1])->one();
                    ?>
                    <option value="<?= $model['cid'] ?>" selected="true"><?= $cate['name'] ?></option>
                    <?php
                }
                ?>
            </select>
        </div>
    </div>
    <?= $form->field($model, 'title')->textInput() ?>

    <?= $form->field($model, 'remark')->textarea(['rows' => 6]) ?>

<!--     <div class="upbox">
    <div class="selectbox"> -->

    <?= $form->field($model, 'thumb')->widget('moxuandi\webuploader\MultiImage') ?>
<!--     </div> -->
<!--     </div>
       <label class=" control-label">
           新闻封面图片
       </label>
       <div>
                <?= Html::img($model->thumb)?>
       </div>
   
    <div class="picbtn">
    <button type="button" class="btn btn-info"><?php 
  if($model->thumb){
     echo "重新上传";
   }else{
     echo "上传";
   }

     ?></button>
    </div> -->
     
     
    <?=
    $form->field($model, 'content')->widget('moxuandi\ueditor\UEditor', [
        'clientOptions' => [
            //编辑区域的大小
            'initialFrameWidth' => (['rows' => 6]),
//            'initialFrameHeight' => 800,
            //设置语言
            'lang' => 'zh-cn',
            //定制菜单
            // 'toolbars' => [
            //     [
            //         'fullscreen', 'source', 'undo', 'redo', '|',
            //         'fontsize',
            //         'bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'removeformat',
            //         'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|',
            //         'forecolor', 'backcolor', '|',
            //         'lineheight', '|',
            //         'indent', '|'
            //     ],
            // ],
        ],
    ]);
    ?>
    <?php
    $rs = common\models\Source::find()
            ->select(['name'])
            ->orderBy('id')
            ->indexBy('id')
            ->column();
    ?>
    <?=
            $form->field($model, 'source')
            ->dropDownList($rs, ['prompt' => '请选择来源'])
    ?>

    <?=
    $form->field($model, 'create_at')->widget(DateTimePicker::classname(), [
        'options' => ['placeholder' => ''],
        'pluginOptions' => [
            'autoclose' => true
        ]
    ]);
    ?>
    <?= $form->field($model, 'weight')->hint(Yii::t('app', 'weight defalut'))->textInput() ?>

    <?php
    $rs = common\models\Display::find()
            ->select(['title'])
            ->orderBy('id')
            ->indexBy('id')
            ->column();
    ?>
    <?=
            $form->field($model, 'display')
            ->dropDownList($rs, ['prompt' => '请选择是否发布'])
    ?>




    <script type="text/javascript">
        $(document).ready(function () {
            // alert("1");
            $("#s_lb").change(function () {
                var selectText = $("#s_lb").find("option:selected").val();
                $.ajax({
                    type: "POST",
                    data: {
                        'id': selectText
                    },
                    url: "<?php echo yii\helpers\Url::toRoute(['news/getnewssubcate']) ?> ",
                    dataType: "json",
                    success: function (data) {
                        console.log(data);
                        $("#s_xm").html('');
                        $("#s_xm").append("<option value=''>请选择二级分类</option>");
                        for (var i in data) {
                            $("#s_xm").append("<option value=" + data[i].id + ">" + data[i].name + "</option>");
                        }
                    }
                });

            });

            $('.picbtn').bind('click',function(){
                $('.upbox').css({'z-index':'1111111','opacity':'1'})
            })

            $('.upbox').click(function(e){
                var node = e.target;
                console.log(node.nodeName)
                if(node.className !='upbox'){
                    if(node.nodeName.toLowerCase() =='input'){
                        e.stopPropagation();
                    }
                    else{
                        e.stopPropagation();
                        return false;
                        
                    }
                    e.stopPropagation();
                    // return false;
                }
                else{
                $('.upbox').css({'z-index':'-1','opacity':'0'})
                    
                }
            })            

        });
    </script>
    <script type="text/javascript">
        $(function(){
            var id = '<?php echo $model['cid']?>';
            var selectTexts = $("#s_lb").find("option:selected").val();
                $.ajax({
                    type: "POST",
                    data: {
                        'id': selectTexts
                    },
                    url: "<?php echo yii\helpers\Url::toRoute(['news/getnewssubcate']) ?> ",
                    dataType: "json",
                    success: function (data) {
                        $("#s_xm").html('');
                        $("#s_xm").append("<option value=''>请选择二级分类</option>");
                        for (var i in data) {
                            if(data[i].id == parseInt(id)){
                            $("#s_xm").append("<option value=" + data[i].id + " selected = 'selected'>" + data[i].name + "</option>");

                            }
                            $("#s_xm").append("<option value=" + data[i].id + ">" + data[i].name + "</option>");
                            }
                },
                error: function(res){

                }
            })
        })
    </script>





    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? Yii::t('app', 'Create') : Yii::t('app', 'Update'), ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
