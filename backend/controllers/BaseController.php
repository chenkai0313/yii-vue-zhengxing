<?php

namespace backend\controllers;
use Yii;
use yii\web\Controller;

class BaseController extends \yii\web\Controller
{
        protected $refer;
        //成功提示页面
	public function success($message,$href='',$time=3){
                $this->refer=Yii::$app->request->getReferrer();
		return $this->redirect(['success','message'=>$message,'time'=>$time,'href'=>!$href?urlencode($this->refer):urlencode($href)]);
	}
	//错误提示页面
	public function err($message,$href='',$time=3){
		 $this->refer=Yii::$app->request->getReferrer();
		return $this->redirect(['err','message'=>$message,'time'=>$time,'href'=>!$href?urlencode($this->refer):urlencode($href)]);
	
	}

	public function actionErr(){
		$this->layout=false;
		$_GPC=Yii::$app->request->get();
		return $this->render('../common/error',array('time'=>$_GPC['time'],'message'=>$_GPC['message'],'href'=>urldecode($_GPC['href'])));
	}
	public function actionSuccess(){
		$this->layout=false;
		$_GPC=Yii::$app->request->get();
		return $this->render('../common/success',array('time'=>$_GPC['time'],'message'=>$_GPC['message'],'href'=>urldecode($_GPC['href'])));
	}
	protected function dump($k,$exit=false){
		if(!DUMP) return;  
        echo '<pre>';
        print_r($k);
        echo'</pre>';
        if($exit)
        exit;
	}
        public function referer(){
            header("location:".Yii::$app->request->getReferrer());
        }
}
