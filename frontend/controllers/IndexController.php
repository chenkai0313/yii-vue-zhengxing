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

class IndexController extends Controller
{
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
                    'newsdetail' => ['GET'],
                    'newslist' => ['GET'],
                    #新闻发布
                    'indexnews' => ['GET'],
                    #整形咨询
                    'indexplastic' => ['GET'],
                    #法律法规
                    'indexlaw' => ['GET'],
                    #继续教育
                    'indexedation' => ['GET'],
                    #专家栏目
                    'indexspecialist' => ['GET'],
                    #重要通知
                    'indexnotice' => ['GET'],
                    'addmessage' => ['GET'],
                    'indexservice' => ['GET'],
                    'indexsearch' => ['GET'],
                ],
            ],
        ];
    }

    /**
     * 内容检索
     * @params['title']
     *
     * @return mixed
     */
    public function actionIndexsearch()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $request = Yii::$app->request;
        $params['keyword'] = $request->get('keyword');
        $params['limit'] = $request->get('limit');
        $params['page'] = $request->get('page');
        $params['limit'] = isset($params['limit']) ? $params['limit'] : 10;
        $params['page'] = isset($params['page']) ? $params['page'] : 1;
        $params['keyword'] = isset($params['keyword']) ? $params['keyword'] : null;
        if (!empty($params['keyword'])) {
                $offset = ($params['page'] - 1) * $params['limit'];
            $list = \common\models\News::find()
                ->where('display=:display', [':display' => 1])
                ->andWhere(['like', 'title', $params['keyword']])
                ->orderBy('weight desc ,id  desc')
                ->offset($offset)
                ->limit($params['limit'])
                ->asArray()
                ->all();
             $data= \common\models\News::find()
                ->where('display=:display', [':display' => 1])
                 ->andWhere(['like', 'title', $params['keyword']])
                ->asArray()
                ->all();  
            $count=count($data);    
            return ['code' => 1,'data'=> $list,'keyword'=>$params['keyword'],'count'=>$count ,'page' => $params['page'],'limit' => $params['limit'] ];  
        }else{
            return ['code' => 90002,'msg'=>'没有传入关键字' ];  
        }

    }

    /**
     * 导航栏
     * @return mixed
     */
    #0 单页面 1 列表页 2 一级标题页面 3 文章列表 4 图片模型
    public function actionCatagory()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $catagory = \common\models\Category::find()
            ->orderBy('weight desc ,id  asc')
            ->where('display=:display', [':display' => 1])
            ->andwhere('pid=id')
            ->asArray()
            ->all();
        foreach ($catagory as $k => &$v) {
            $v['bgimage'] = 'backend/web/' . $v['bgimage'];
            $v['create_at'] = date('Y-m-d H:i:s', $v['create_at']);
            $v['update_at'] = date('Y-m-d H:i:s', $v['update_at']);
        }
        $count = count($catagory);
        return ['code' => 1, 'count' => $count, 'data' => $catagory];
    }

    /**
     * 底部信息
     * @return mixed
     */
    public function actionFooter()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $model = \common\models\Webconfig::find()
            ->asArray()
            ->all();
        $footer = unserialize($model[0]['content']);
        return ['code' => 1, 'data' => $footer];
    }

    /**
     *友情链接
     * @return mixed
     */
    public function actionLink()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $model = \common\models\Images::find()
            ->orderBy('weight desc ,id  desc')
            ->where('display=:display', [':display' => 1])
            ->andWhere('type=:type', [':type' => 1])
            ->limit()
            ->asArray()
            ->all();
        foreach ($model as $k => &$v) {
            $v['img'] = 'backend/web/' . $v['img'];
            $v['create_at'] = date('Y-m-d H:i:s', $v['create_at']);
            $v['update_at'] = date('Y-m-d H:i:s', $v['update_at']);
        }
        $count = count($model);
        return ['code' => 1, 'count' => $count, 'data' => $model];
    }

    /**
     *服务大厅
     * @return mixed
     */
    public function actionIndexservice()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $model = \common\models\Images::find()
            ->orderBy('weight desc ,id  desc')
            ->where('display=:display', [':display' => 1])
            ->andWhere('type=:type', [':type' => 3])
            ->asArray()
            ->all();
        foreach ($model as $k => &$v) {
            $v['img'] = 'backend/web/' . $v['img'];
            $v['create_at'] = date('Y-m-d H:i:s', $v['create_at']);
            $v['update_at'] = date('Y-m-d H:i:s', $v['update_at']);
        }
        $count = count($model);
        $catagory = \common\models\Category::find()
            ->where('id=:id', [':id' => 107])
            ->asArray()
            ->one();
        return ['code' => 1, 'count' => $count, 'data' => $model, 'info' => $catagory];
    }

    /**
     *会员风采
     * @return mixed
     */
    public function actionMember()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $data = \common\models\News::find()
            ->where('display=:display', [':display' => 1])
            ->andwhere('cid=:cid', [':cid' => 93])
            ->orderBy('weight desc ,id  desc')
            ->limit(6)
            ->asArray()
            ->all();
        foreach ($data as $k => &$v) {
            $v['thumb'] = 'backend/web/' . $v['thumb'];
        }
        $catagory = \common\models\Category::find()
            ->where('id=:id', [':id' => 93])
            ->asArray()
            ->one();
        return ['code' => 1, 'data' => $data, 'info' => $catagory];
    }

    /**
     *轮播图
     * @return mixed
     */
    public function actionCarousel()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $model = \common\models\Slide::find()
            ->where(['display' => 1])
            ->asArray()
            ->orderBy('weight desc,id desc')
            ->all();
        foreach ($model as $k => &$v) {
            $v['img'] = 'backend/web/' . $v['img'];
            $v['create_at'] = date('Y-m-d H:i:s', $v['create_at']);
            $v['update_at'] = date('Y-m-d H:i:s', $v['update_at']);
        }
        $count = count($model);
        return ['code' => 1, 'count' => $count, 'data' => $model];
    }

    /**
     *二级标题
     * @return mixed
     */
    public function actionCatagorychild()
    {
        $request = Yii::$app->request;
        $id = $request->get('id');
        if (!$id)
            return '没有传入该栏目的ID';
        Yii::$app->response->format = Response::FORMAT_JSON;
        $model = \common\models\Category::find()
            ->orderBy('weight desc ,id  asc')
            ->where('display=:display', [':display' => 1])
            ->andWhere('pid=:id', [':id' => $id])
            ->asArray()
            ->all();
        foreach ($model as $k => &$v) {
            $v['bgimage'] = 'backend/web/' . $v['bgimage'];
            $v['create_at'] = date('Y-m-d H:i:s', $v['create_at']);
            $v['update_at'] = date('Y-m-d H:i:s', $v['update_at']);
        }
        $count = count($model);
        return ['code' => 1, 'count' => $count, 'data' => $model, 'ck' => $id];
    }

    /**
     *新闻详情
     * @return mixed
     */
    public function actionNewsdetail()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $request = Yii::$app->request;
        $id = $request->get('id');
        if (!$id)
            return '没有传入新闻的ID';
        $news = \common\models\News::find()
            ->where('id=:id', [':id' => $id])
            ->andWhere('display=:display', [':display' => 1])
            ->orderBy('weight desc ,id  desc')
            ->asArray()
            ->one();
        $source = \common\models\Source::find()
            ->where('id=:id', [':id' => $news['source']])
            ->one();

        $content = $news['content'];
        $news['content'] = str_replace("backend/web/", "/backend/web/backend/web/", $content);
        $news['thumb'] = 'backend/web/' . $news['thumb'];
        $news['source'] = $source['name'];
        return ['code' => 1, 'data' => $news];
    }

    /**
     *新闻列表页
     * @return mixed
     */
    public function actionNewslist()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $request = Yii::$app->request;
        $id = $request->get('id');
        $params['limit'] = $request->get('limit');
        $params['page'] = $request->get('page');
        $params['keyword'] = $request->get('keyword');
        $params['limit'] = isset($params['limit']) ? $params['limit'] : 10;
        $params['page'] = isset($params['page']) ? $params['page'] : 1;
        $params['keyword'] = isset($params['keyword']) ? $params['keyword'] : null;
        if (!$id)
            return '没有传入该栏目的ID';
        $catagory = \common\models\Category::find()
            ->where('id=:id', [':id' => $id])
            ->asArray()
            ->one();
        $catagory['bgimage'] = 'backend/web/' . $catagory['bgimage'];
        $catagory['create_at'] = date('Y-m-d H:i:s', $catagory['create_at']);
        $catagory['update_at'] = date('Y-m-d H:i:s', $catagory['update_at']);
        $offset = ($params['page'] - 1) * $params['limit'];
        if (!empty($params['keyword'])) {
            $list = \common\models\News::find()
                ->where('display=:display', [':display' => 1])
                ->andwhere('cid=:cid', [':cid' => $id])
                ->andWhere(['like', 'title', $params['keyword']])
                ->orderBy('weight desc ,id  desc')
                ->offset($offset)
                ->limit($params['limit'])
                ->asArray()
                ->all();
            $datas = \common\models\News::find()
                  ->where('display=:display', [':display' => 1])
                  ->andwhere('cid=:cid', [':cid' => $id])
                  ->orderBy('weight desc ,id  desc')
                  ->asArray()
                  ->all();
        $count = count($datas);
            foreach ($list as $k => &$v) {
                $v['thumb'] = 'backend/web/' . $v['thumb'];
            }
            return ['code' => 1, 'count' => $count, 'page' => $params['page'], 'data' => $list, 'catagory' => $catagory];
        }
        $data = \common\models\News::find()
            ->where('display=:display', [':display' => 1])
            ->andwhere('cid=:cid', [':cid' => $id])
            ->orderBy('weight desc ,id  desc')
            ->offset($offset)
            ->limit($params['limit'])
            ->asArray()
            ->all();
        $datas = \common\models\News::find()
            ->where('display=:display', [':display' => 1])
            ->andwhere('cid=:cid', [':cid' => $id])
            ->orderBy('weight desc ,id  desc')
            ->asArray()
            ->all();
        $count = count($datas);

        foreach ($data as $k => &$v) {
            $v['thumb'] = 'backend/web/' . $v['thumb'];
        }
        return ['code' => 1, 'count' => $count, 'page' => $params['page'], 'data' => $data, 'catagory' => $catagory];
    }

    /**
     *首页新闻发布板块
     * @return mixed
     */
    public function actionIndexnews()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $data = \common\models\News::find()
            ->where('display=:display', [':display' => 1])
            ->andwhere('cid=:cid', [':cid' => 103])
            ->orderBy('weight desc ,id  desc')
            ->limit(9)
            ->asArray()
            ->all();
        foreach ($data as $k => &$v) {
            $v['thumb'] = 'backend/web/' . $v['thumb'];
        }
        $catagory = \common\models\Category::find()
            ->where('id=:id', [':id' => 103])
            ->asArray()
            ->one();
        return ['code' => 1, 'data' => $data, 'info' => $catagory];
    }

    /**
     *首页整形资讯板块
     * @return mixed
     */
    public function actionIndexplastic()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $data = \common\models\News::find()
            ->where('display=:display', [':display' => 1])
            ->andwhere('cid=:cid', [':cid' => 102])
            ->orderBy('weight desc ,id  desc')
            ->limit(5)
            ->asArray()
            ->all();
        foreach ($data as $k => &$v) {
            $v['thumb'] = 'backend/web/' . $v['thumb'];
        }
        $catagory = \common\models\Category::find()
            ->where('id=:id', [':id' => 102])
            ->asArray()
            ->one();
        return ['code' => 1, 'data' => $data, 'info' => $catagory];
    }

    /**
     *首页继续教育板块
     * @return mixed
     */
    public function actionIndexedation()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $data = \common\models\News::find()
            ->where('display=:display', [':display' => 1])
            ->andwhere('cid=:cid', [':cid' => 100])
            ->orderBy('weight desc ,id  desc')
            ->limit(9)
            ->asArray()
            ->all();
        foreach ($data as $k => &$v) {
            $v['thumb'] = 'backend/web/' . $v['thumb'];
        }
        $catagory = \common\models\Category::find()
            ->where('id=:id', [':id' => 100])
            ->asArray()
            ->one();
        return ['code' => 1, 'data' => $data, 'info' => $catagory];
    }

    /**
     *首页法律法规板块
     * @return mixed
     */
    public function actionIndexlaw()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $data = \common\models\News::find()
            ->where('display=:display', [':display' => 1])
            ->andwhere('cid=:cid', [':cid' => 99])
            ->orderBy('weight desc ,id  desc')
            ->limit(8)
            ->asArray()
            ->all();
        foreach ($data as $k => &$v) {
            $v['thumb'] = 'backend/web/' . $v['thumb'];
        }
        $catagory = \common\models\Category::find()
            ->where('id=:id', [':id' => 99])
            ->asArray()
            ->one();
        return ['code' => 1, 'data' => $data, 'info' => $catagory];
    }

    /**
     *首页法律法规板块
     * @return mixed
     */
    public function actionIndexnotice()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $data = \common\models\News::find()
            ->where('display=:display', [':display' => 1])
            ->andwhere('cid=:cid', [':cid' => 104])
            ->orderBy('weight desc ,id  desc')
            ->limit(2)
            ->asArray()
            ->all();
        foreach ($data as $k => &$v) {
            $v['thumb'] = 'backend/web/' . $v['thumb'];
        }
        $catagory = \common\models\Category::find()
            ->where('id=:id', [':id' => 104])
            ->asArray()
            ->one();
        return ['code' => 1, 'data' => $data, 'info' => $catagory];
    }

    /**
     *专家栏目板块
     * @return mixed
     */
    public function actionIndexspecialist()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $data = \common\models\News::find()
            ->where('display=:display', [':display' => 1])
            ->andwhere('cid=:cid', [':cid' => 101])
            ->orderBy('weight desc ,id  desc')
            ->asArray()
            ->all();
        foreach ($data as $k => &$v) {
            $v['thumb'] = 'backend/web/' . $v['thumb'];
        }
        $catagory = \common\models\Category::find()
            ->where('id=:id', [':id' => 101])
            ->asArray()
            ->one();
        return ['code' => 1, 'data' => $data, 'info' => $catagory];
    }

    /**
     *添加留言板块
     * @return mixed
     */
    public function actionAddmessage()
    {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $request = Yii::$app->request;
        $address = $request->get('address');
        $linkway = $request->get('linkway');
        $linkman = $request->get('linkman');
        $email = $request->get('email');
        $content = $request->get('content');
        $model = new  \common\models\Message();
        $model->address = $address;
        $model->linkway = $linkway;
        $model->linkman = $linkman;
        $model->email = $email;
        $model->content = $content;
        $model->create_at = time();

        if ($model->save()) {
            return ['code' => 1, 'data' => '添加成功', 'ck' => $request];
        } else {
            return ['code' => 90002, 'data' => '添加失败', 'ck' => $request];
        }
    }


}



