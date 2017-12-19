<?php

namespace backend\controllers;

use Yii;
use common\models\Images;
use common\models\ImagesSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\Json;
/**
 * ImagesController implements the CRUD actions for Images model.
 */
class LinkController extends Controller
{



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
    public function behaviors()
    {
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
     * Lists all Images models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new ImagesSearch();
        $dataProvider = $searchModel->searchlinker(Yii::$app->request->queryParams);
           if (Yii::$app->request->post('hasEditable')) {
        $id = Yii::$app->request->post('editableKey');
        $model = Images::findOne(['id' => $id]);
        $output = '';
        $posted = current($_POST['Images']);
        $post = ['Images' => $posted];
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
     * Displays a single Images model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Images model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate()
    {
        $model = new Images();
        $data=Yii::$app->request->post();
        $data['Images']['type']=1;#友情链接
        if ($model->load($data) && $model->save()) {
                    $imgurl = \common\models\Upload::find()
                    ->where(['id' => $model->img])
                    ->asArray()
                    ->one();
            if (!empty($imgurl)) {
                $model->img = $imgurl['file_name'];
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
     * Updates an existing Images model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
                    $imgurl = \common\models\Upload::find()
                    ->where(['id' => $model->img])
                    ->asArray()
                    ->one();
            if (!empty($imgurl['file_name'])) {
                $imgurl = \common\models\Upload::find()
                        ->where(['id' => $model->img])
                        ->asArray()
                        ->one();
                $model->img = $imgurl['file_name'];
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
     * Deletes an existing Images model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the Images model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Images the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Images::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
