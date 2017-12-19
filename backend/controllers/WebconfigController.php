<?php

namespace backend\controllers;

use Yii;
use yii\web\Controller;
use backend\controllers\BaseController;
use common\models\Webconfig;
use yii\helpers\Url;
use yii\filters\VerbFilter;
use yii\web\ForbiddenHttpException;

class WebconfigController extends BaseController {

    public function behaviors() {
        return [
           // 'error' => ['class' => 'yii\web\ErrorAction'],
            'access' => [
                'class' => \yii\filters\AccessControl::className(),
                'rules' => [
                    [
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['POST'],
                ],
            ],
        ];
    }
    //站点信息配置
    public function actionWeb() {

        if (Yii::$app->request->isPost) {
        #权限设置
         if (!Yii::$app->user->can('admin')) {
               return $this->err('对不起，您没有此模块操作权限', Url::to(['web', 'id' => $model->id]), 3);
        }
            $_GPC = Yii::$app->request->post();

            $r = true;

            $model = Webconfig::find()->where(['type' => 'web'])->one();

            if (empty($model)) {
                $model = new Webconfig();
                $model->type = 'web';
                $model->createtime = time();
            }
            $data=$model->content;
            #logo 新浪微博 微信公众号
            #新浪微博
            $rd=$_FILES;
            if(empty($rd['qrcode1']['name'])){
            $mo = Webconfig::find()
                ->all();
            $da = unserialize($mo[0]['content']);
              $_GPC['qrcode1']=$da['qrcode1'];
            }else{
            $file1 = $_FILES['qrcode1'];
            $filName1 = $file1['name'];
            move_uploaded_file($file1['tmp_name'], '../.././backend/web/uploads/image/' . $filName1);
            $pic1 = '/backend/web/uploads/image/' . $file1['name'];
            $_GPC['qrcode1']= $pic1;
            }
            #微信公众号
            if(empty($rd['qrcode2']['name'])){
            $mo1 = Webconfig::find()
                ->all();
            $da1 = unserialize($mo1[0]['content']);
              $_GPC['qrcode2']=$da1['qrcode2'];
            }else{
            $file2 = $_FILES['qrcode2'];
            $filName2 = $file2['name'];
            move_uploaded_file($file2['tmp_name'], '../.././backend/web/uploads/image/' . $filName2);
            $pic2= '/backend/web/uploads/image/' . $file2['name'];
            $_GPC['qrcode2']= $pic2;
            }  
            #logo
            if(empty($rd['web_logo']['name'])){
            $mo2 = Webconfig::find()
                ->all();
            $da2 = unserialize($mo2[0]['content']);
              $_GPC['web_logo']=$da2['web_logo'];
            }else{
            $file3 = $_FILES['web_logo'];
            $filName3 = $file3['name'];
            move_uploaded_file($file3['tmp_name'], '../.././backend/web/uploads/image/' . $filName3);
            $pic3 = '/backend/web/uploads/image/' . $file3['name'];
            $_GPC['web_logo']= $pic3;
            } 
            #网站头部图片
            if(empty($rd['index_thumb']['name'])){
            $mo3 = Webconfig::find()
                ->all();
            $da3 = unserialize($mo3[0]['content']);
              $_GPC['index_thumb']=$da3['index_thumb'];
            }else{
            $file4 = $_FILES['index_thumb'];
            $filName4 = $file4['name'];
            move_uploaded_file($file4['tmp_name'], '../.././backend/web/uploads/image/' . $filName4);
            $pic4 = '/backend/web/uploads/image/' . $file4['name'];
            $_GPC['index_thumb']= $pic4;
            } 

            $model->content = serialize($_GPC);
            $model->updatetime = time();

            if ($ret = ($model->save())) {
                $r = $r && $ret;
            }
            if ($r) {
                return $this->success('配置成功', Url::to(['web', 'id' => $model->id]), 3);
            }
            exit;
        }
        $model = array();
        $model = Webconfig::find()->where(['type' => 'web'])->one();
      // var_dump($model);
      //       exit();
        $model = unserialize($model['content']);

        return $this->render('web', array('model' => $model));
    }



}
