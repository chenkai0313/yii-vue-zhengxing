<?php

namespace backend\controllers;

use Yii;
use common\models\News;
use common\models\NewsSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\Response;
use yii\web\ForbiddenHttpException;
use yii\helpers\Url;
use backend\controllers\BaseController;
use yii\helpers\Json;
/**
 * NewsController implements the CRUD actions for News model.
 */
class NewsController extends BaseController {

    public function actions() {
        $captchaConfig = [
            'class' => 'yii\captcha\CaptchaAction',
            'maxLength' => 4,
            'minLength' => 4,
        ];
        return [
            'upload' => [
                'class' => 'moxuandi\ueditor\UEditorAction',
            ],
            'ZuiUploader' => [
                'class' => 'moxuandi\zui\ZuiAction',
                'config' => [
                    'thumbWidth' => 110, //缩略图宽度
                    'thumbHeight' => 110, //缩略图高度
                ],
            ],
            'Kupload' => [
                'class' => 'moxuandi\kindeditor\KindEditorAction',
                //可选参数, 参考 config.php
                'config' => [
                    'thumbWidth' => 150, //缩略图宽度
                    'thumbHeight' => 100, //缩略图高度
                ],
            ],
            'WebUploader' => [
                'class' => 'moxuandi\webuploader\Uploader',
                'config' => [
                    'thumbWidth' => 110, //缩略图宽度
                    'thumbHeight' => 110, //缩略图高度
                ],
            ],
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => $captchaConfig, // 注册-验证码
        ];
    }

    /**
     * @inheritdoc
     */
    public function behaviors() {
        return [
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

    /**
     * Lists all News models.
     * @return mixed
     */
    public function actionIndex() {
        $searchModel = new NewsSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);
    if (Yii::$app->request->post('hasEditable')) {
        $id = Yii::$app->request->post('editableKey');
        $model = News::findOne(['id' => $id]);
        $output = '';
        $posted = current($_POST['News']);
        $post = ['News' => $posted];
        if ($model->load($post)) {
            $model->save();
            isset($posted['weight']) && $output = $model->weight;
        }
        $out = Json::encode(['output'=>$output, 'message'=>'']);
        return $out;
    }
    return $this->render('index', [
        'searchModel' => $searchModel,
        'dataProvider' => $dataProvider,
    ]);

    }

    /**
     *  Obtain information about secondary classification BY CK.
     */
//获取二级分类的信息
    public function actionGetnewssubcate() {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $pid = $_POST['id'];
        $data = \common\models\Category::find()->asArray()->where(['pid' => $pid]) ->andWhere(['display'=>1])->all();
//        response(1, 'success', $data);
        return($data);
    }

    /**
     * DELETE ALL DATA BY CK.
     */
    public function actionDeleteall() {
        Yii::$app->response->format = Response::FORMAT_JSON;
        $id = $_POST['id'];
        foreach ($id as $r) {
            $this->findModel($r)->delete();
        }
        return(1);
    }

    /**
     * Displays a single News model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id) {
        return $this->render('view', [
                    'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new News model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate() {
        if (!Yii::$app->user->can('createPost')) {
            throw new ForbiddenHttpException('对不起，您没有操作·权限');
        }
        $model = new News();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            $imgurl = \common\models\Upload::find()
                    ->where(['id' => $model->thumb])
                    ->asArray()
                    ->one();
            if (!empty($imgurl)) {
                $model->thumb = $imgurl['file_name'];
                $model->save();
            }
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('create', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing News model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id) {
        $model = $this->findModel($id);
        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            $imgurl = \common\models\Upload::find()
                    ->where(['id' => $model->thumb])
                    ->asArray()
                    ->one();
            if (!empty($imgurl['file_name'])) {
                $imgurl = \common\models\Upload::find()
                        ->where(['id' => $model->thumb])
                        ->asArray()
                        ->one();
                $model->thumb = $imgurl['file_name'];
                $model->save();
            }

            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('update', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing News model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id) {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the News model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return News the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id) {
        if (($model = News::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

}
