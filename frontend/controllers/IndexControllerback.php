<?php
namespace frontend\controllers;
use Yii;
use yii\filters\Cors;
use yii\helpers\ArrayHelper;
use yii\web\Response;
use yii\web\Session;
use yii\base\Component;
use yii\web\Controller;
use yii\web\ForbiddenHttpException;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
header('Access-Control-Allow-Origin: *');
header("Access-Control-Allow-Headers: Origin, X-Requested-With, Content-Type, Accept");
header('Access-Control-Allow-Methods: GET, POST, PUT,DELETE');
header('Access-Control-Allow-Credentials: true');
class IndexController extends Controller {
      public $enableCsrfValidation = false;
      public $enableCrossValidation = true;
      public $enableRawBodyValidation = true;


    public function behaviors()
    {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'catagorychild' => ['GET'],
                    'catagory' => ['GET'],
                    'footer' => ['GET'],
                    'link' => ['GET'],
                    'member' => ['GET'],
                    'carousel' => ['GET'],
                ],
            ],
        ];
    }

    /**
     * 导航栏
     * @return mixed
     */
    #0 单页面 1 列表页 2 一级标题页面 3 文章列表 4 图片模型
  public function actionCatagory(){
       Yii::$app->response->format = Response::FORMAT_JSON;
       $catagory = \common\models\Category::find()
                ->orderBy('weight desc ,id  desc')
                ->where('display=:display', [':display' => 1])
                ->asArray()
                ->all();     
        foreach ($catagory as $k=> &$v) {
                  $v['bgimage']='backend/web/'.$v['bgimage'];   
                  $v['create_at']=date('Y-m-d H:i:s',$v['create_at']);
                  $v['update_at']=date('Y-m-d H:i:s',$v['update_at']);
                }
      $count=count($catagory); 
      return ['code'=>1,'count'=>$count,'data'=>$catagory];   		
  }
    /**
     * 底部信息
     * @return mixed
     */
    public function actionFooter(){
       Yii::$app->response->format = Response::FORMAT_JSON;
       $model = \common\models\Webconfig::find()
                ->asArray()
                ->all();
       $footer = unserialize($model[0]['content']);
      return ['code'=>1,'data'=>$footer];
  }
    /**
     *友情链接 
     * @return mixed
     */
    public function actionLink(){
        Yii::$app->response->format = Response::FORMAT_JSON;
    	$model = \common\models\Images::find()
                ->orderBy('weight desc ,id  desc')
                ->where('display=:display', [':display' => 1])
                ->andWhere('type=:type',[':type'=>1])
                ->limit()
                ->asArray()
                ->all();
                foreach ($model as $k=> &$v) {
                  $v['img']='backend/web/'.$v['img'];
                  $v['create_at']=date('Y-m-d H:i:s',$v['create_at']);
                  $v['update_at']=date('Y-m-d H:i:s',$v['update_at']);
                }
      $count=count($model);             
       return ['code'=>1,'count'=>$count,'data'=>$model];
  }

    /**
     *会员风采 
     * @return mixed
     */
    public function actionMember(){
    	Yii::$app->response->format = Response::FORMAT_JSON;
        $model = \common\models\Images::find()
                ->orderBy('weight desc ,id  desc')
                ->where('display=:display', [':display' => 1])
                ->andWhere('type=:type',[':type'=>2])
                ->asArray()
                ->all();
                foreach ($model as $k=> &$v) {
                  $v['img']='backend/web/'.$v['img'];
                  $v['create_at']=date('Y-m-d H:i:s',$v['create_at']);
                  $v['update_at']=date('Y-m-d H:i:s',$v['update_at']);
                }
        $count=count($model);  
      return ['code'=>1,'count'=>$count,'data'=>$model];
  }

    /**
     *轮播图
     * @return mixed
     */
   public function actionCarousel(){
  		Yii::$app->response->format = Response::FORMAT_JSON;
  		$model= \common\models\Slide::find()
                ->where(['display' => 1])
                ->asArray()
                ->orderBy('weight desc,id desc')
                ->all();
                foreach ($model as $k=> &$v) {
                  $v['img']='backend/web/'.$v['img'];
                  $v['create_at']=date('Y-m-d H:i:s',$v['create_at']);
                  $v['update_at']=date('Y-m-d H:i:s',$v['update_at']);
                }
        $count=count($model);    
        return ['code'=>1,'count'=>$count,'data'=>$model];
   }

    /**
     *二级标题
     * @return mixed
     */

    public function actionCatagorychild(){
    $request = Yii::$app->request;
    $id = $request->get('id');  
    if(!$id)
        return '没有传入该栏目的ID';
    Yii::$app->response->format = Response::FORMAT_JSON;
       $model = \common\models\Category::find()
                ->orderBy('weight desc ,id  desc')
                ->where('display=:display', [':display' => 1])
                ->andWhere('pid=:id',[':id'=>$id])
                ->asArray()
                ->all();     
        foreach ($model as $k=> &$v) {
                  $v['bgimage']='backend/web/'.$v['bgimage'];   
                  $v['create_at']=date('Y-m-d H:i:s',$v['create_at']);
                  $v['update_at']=date('Y-m-d H:i:s',$v['update_at']);
                }
      $count=count($model); 
      return ['code'=>1,'count'=>$count,'data'=>$model];   		
  }














    public function actionIndex() {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $ra = \common\models\Category::findBySql('SELECT * FROM category where id=pid')
                ->orderBy('weight desc')
                ->where('display=:display', [':display' => 1])
                ->asArray()
                ->all();
        $rb = \common\models\Category::find()
                ->where('display=:display', [':display' => 1])
                ->orderBy('weight desc')
                ->asArray()
                ->all();
        $arr = array();
        $list = array();
        foreach ($ra as $key => $value) {
           if ($value['display'] == 1) {
                 $list[$key]['parents'][] = $value;
                     foreach ($rb as $k => $v) {
                            if ($v['pid'] == $value['id'] && $v['id'] != $v['pid']) {
                                $list[$key]['child'][] = $v;
                                                 }
                            else{
                                  $list[$key]['child'][] = '';
                                 }
                            }
                     }
        }
        return ['catagory'=>123];
    }

// 关于我们
    public function actionAbout(){
       Yii::$app->response->format = Response::FORMAT_JSON;
       $data = \common\models\Category::find()
                ->where(['display' => 1])
                 ->andWhere(['id'=>64])
                ->orderBy('weight asc')
                ->asArray()
                ->one();
        $news = \common\models\News::find()
               ->where(['display' => 1])
                ->andWhere(['cid'=>64])
                ->orderBy('weight desc,id desc')
                ->asArray()
                ->one();
                $news['bgimage']=$data['bgimage'];
        // $array=array();
        // $array[0]=$data['bgimage'];
        // $array[1]=$news;
    return ['array'=>$news];
    }
    // 详情页
    public function actionDetail(){
    Yii::$app->response->format = Response::FORMAT_JSON;
        // $id = file_get_contents('php://input');
        // $id = json_decode($id);
        $id  = $_POST['id'];
        $news = \common\models\News::find()
                  ->where(['cid'=>$id])
                  ->andWhere(['display' => 1])
                  ->orderBy('weight desc,id desc')
                  ->asArray()
                  ->one();
        $source=\common\models\Source::find()
                  ->where(['id'=>$news['source']])
                  ->one();
        $news['source'] = $source['name'];
          $content=$news['content'];
          $news['content']=str_replace("backend/web/","backend/web/backend/web/", $content);

     return ['data'=>$news];
   }
   // 轮播图
   public function actionSlide(){
    Yii::$app->response->format = Response::FORMAT_JSON;
    $slide= \common\models\Slide::find()
              ->where(['display' => 1])
                ->asArray()
                ->orderBy('weight desc,id desc')
                ->all();
     return ['slide'=>$slide];
   }
   // 每周股评
   public function actionStock(){
       Yii::$app->response->format = Response::FORMAT_JSON;
          $news = \common\models\News::find()
                ->where(['display' => 1])
                ->andWhere(['cid' => 74])
                ->orderBy('weight desc,id desc')
                  ->limit(4)
                ->asArray()
                ->all();
          $catagory = \common\models\Category::find()
                ->where(['display' => 1])
                 ->andWhere(['id'=>74])
                ->orderBy('weight asc')
                ->asArray()
                ->one();
        $array=array();
        $array[0]=$catagory['bgimage'];
        $array[1]=$news;
       return ['array'=>$array];
   }
  // 关于融熠 金融学院 投资管理
    public function actionManger(){
        Yii::$app->response->format = Response::FORMAT_JSON;
         $catagory1= \common\models\Category::find()
                ->where(['display' => 1])
                 ->andWhere(['id'=>71])
                ->orderBy('weight asc')
                ->asArray()
                ->one();
        $catagory2= \common\models\Category::find()
                ->where(['display' => 1])
                 ->andWhere(['id'=>68])
                ->orderBy('weight asc')
                ->asArray()
                ->one();
        $catagory3= \common\models\Category::find()
                ->where(['display' => 1])
                 ->andWhere(['id'=>48])
                ->orderBy('weight asc')
                ->asArray()
                ->one();
         $array=array();
          $array[0]['bgimage']=$catagory1['bgimage'];
          $array[0]['id']=73;
          $array[0]['list_type']="0";
          $array[0]['name']=$catagory1['name'];
          $array[1]['bgimage']=$catagory2['bgimage'];
          $array[1]['id']=69;
          $array[1]['list_type']="1";
          $array[1]['name']=$catagory2['name'];
          $array[2]['bgimage']=$catagory3['bgimage'];
          $array[2]['list_type']="0";
          $array[2]['id']=64;
          $array[2]['name']=$catagory3['name'];
         return ['array'=>$array];
    }


 // 基础信息
    public function actionMessage(){
        Yii::$app->response->format = Response::FORMAT_JSON;
        $model = \common\models\Webconfig::find()
                ->asArray()
                ->all();
        $rs = unserialize($model[1]['content']);
   
       return ['array'=>$rs];
   
    }
  // 列表页
    public function actionList(){
        Yii::$app->response->format = Response::FORMAT_JSON;
        $id=$_POST['id'];
        $catagory = \common\models\Category::find()
                ->where(['display' => 1])
                 ->andWhere(['id'=>$id])
                ->asArray()
                ->one();
        $news = \common\models\News::find()
                  ->where(['cid'=>$id])
                  ->andWhere(['display' => 1])
                  ->orderBy('weight desc,id desc')
                  ->limit(8)
                  ->asArray()
                  ->all();
         $news1 = \common\models\News::find()
                  ->where(['cid'=>$id])
                  ->andWhere(['display' => 1])
                  ->orderBy('weight desc,id desc')
                  ->asArray()
                  ->all(); 


        foreach ($news as &$v1) {
             
                $remark = $v1['remark'];
                $thumb = $v1['thumb'];
                $content=$v1['content'];
                $v1['remark'] = mb_strlen($remark, 'utf-8') > 100 ? mb_substr($remark, 0, 100, 'utf-8') . '...' : $remark;
                $v1['content']=str_replace("backend/web/","backend/web/backend/web/", $content);
                $v1['thumb']=str_replace("uploads/image","backend/web/uploads/image", $thumb);
       
        }
        $count=count($news1);
        return ['news'=>$news,'count'=>$count,'name'=>$catagory['name']];
    }
    // 新闻详情页
    public function actionNewsdetail(){
        Yii::$app->response->format = Response::FORMAT_JSON;
        $id=$_POST['id'];
         $news = \common\models\News::find()
                  ->where(['id'=>$id])
                  ->andWhere(['display' => 1])

                  ->asArray()
                  ->one();
        $source=\common\models\Source::find()
                  ->where(['id'=>$news['source']])
                  ->one();
        $content=$news['content'];
        $news['content']=str_replace("backend/web/","backend/web/backend/web/", $content);
        $news['source'] = $source['name'];
       return ['news'=>$news];
    }


    // // 分页
    public function actionPage(){
      Yii::$app->response->format = Response::FORMAT_JSON;
      $cid=$_POST['id'];
      $page=$_POST['page'];
      $size=$_POST['size'];
      $defaultPageSize=$page*$size;
      $query=$defaultPageSize+$size;
  
      $news = \common\models\News::find()
            ->where(['cid'=>$cid])
            ->andWhere(['display' => 1])
           ->orderBy('weight desc,id desc')
            ->limit(8)
            ->offset($defaultPageSize,$query)
            ->all();
      foreach ($news as &$v1) {
            if ($v1['remark']) {     
                $remark = $v1['remark'];
                $v1['remark'] = mb_strlen($remark, 'utf-8') > 100 ? mb_substr($remark, 0, 100, 'utf-8') . '...' : $remark;
            }
        }
      return ['news'=>$news];


    }
  // 添加留言
  public function actionAddmessage(){
     Yii::$app->response->format = Response::FORMAT_JSON;
     $model=new  \common\models\Message();
     $model->theme=$_POST['theme'];
     $model->content=$_POST['content'];
     $model->linkway=$_POST['linkway'];
     $model->linkman=$_POST['linkman'];
     $model->replyway=0;
     $model->display=0;
     $model->create_at=time();
     if($model->save()){
      return['ok'=>200];
     }else{
       return['error'=>400];
     }
  }

}



