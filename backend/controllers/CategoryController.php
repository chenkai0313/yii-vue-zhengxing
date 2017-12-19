<?php

namespace backend\controllers;

use Yii;
use common\models\Category;
use common\models\CategorySearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\Json;
use yii\helpers\Url;
/**
 * CategoryController implements the CRUD actions for Category model.
 */
class CategoryController extends BaseController {

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
     * Lists all Category models.
     * @return mixed
     */
    public function actionIndex() {
// if (!in_array(@$_SERVER['REMOTE_ADDR'], ['127.0.0.1', '::1'])) {
//     die('You are not allowed to access this file.');
// }










        $searchModel = new CategorySearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);
     if (Yii::$app->request->post('hasEditable')) {
     	     #权限设置
         if (!Yii::$app->user->can('admin')) {
               return $this->err('对不起，您没有此模块操作权限', Url::to(['category/index', 'id' => $model->id]), 3);
        }
        $id = Yii::$app->request->post('editableKey');
        $model = Category::findOne(['id' => $id]);
        $output = '';
        $posted = current($_POST['Category']);
        $post = ['Category' => $posted];
        if ($model->load($post)) {
            $model->save();
            isset($posted['title']) && $output = $model->weight;
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
     * Displays a single Category model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id) {
        return $this->render('view', [
                    'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Category model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate() {
          #权限设置
         if (!Yii::$app->user->can('admin')) {
               return $this->err('对不起，您没有此模块操作权限', Url::to(['category/index', 'id' => $model->id]), 3);
        }
        $model = new Category();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            if ($model->pid == 0) {
                $model->pid = $model->id;
                $model->save();
            }
            $imgurl = \common\models\Upload::find()
                    ->where(['id' => $model->bgimage])
                    ->asArray()
                    ->one();
            if (!empty($imgurl)) {
                $model->bgimage = $imgurl['file_name'];
                $model->save();
            }



            return $this->redirect(['index']);
        } else {
            return $this->render('create', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing Category model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id) {
           #权限设置
         if (!Yii::$app->user->can('admin')) {
               return $this->err('对不起，您没有此模块操作权限', Url::to(['category/index', 'id' => $model->id]), 3);
        }
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            if ($model->pid == 0) {
                $model->pid = $model->id;
                $model->save();
            }
            $imgurl = \common\models\Upload::find()
                    ->where(['id' => $model->bgimage])
                    ->asArray()
                    ->one();
            if (!empty($imgurl)) {
                $model->bgimage = $imgurl['file_name'];
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
     * Deletes an existing Category model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id) {
               #权限设置
         if (!Yii::$app->user->can('admin')) {
               return $this->err('对不起，您没有此模块操作权限', Url::to(['category/index', 'id' => $model->id]), 3);
        }
              $this->findModel($id)->delete(); 
        return $this->redirect(['index']);
    }

    /**
     * Finds the Category model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Category the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected
            function findModel($id) {
        if (($model = Category::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

}
