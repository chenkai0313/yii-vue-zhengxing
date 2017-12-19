<?php

namespace backend\controllers;

use Yii;
use common\models\Slide;
use common\models\SlideSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\Json;
/**
 * SlideController implements the CRUD actions for Slide model.
 */
class SlideController extends Controller {

    /**
     * @inheritdoc
     */
    public function behaviors() {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['POST'],
                ],
            ],
        ];
    }

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
     * Lists all Slide models.
     * @return mixed
     */
    public function actionIndex() {
        $searchModel = new SlideSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);
    if (Yii::$app->request->post('hasEditable')) {
        $id = Yii::$app->request->post('editableKey');
        $model = Slide::findOne(['id' => $id]);
        $output = '';
        $posted = current($_POST['Slide']);
        $post = ['Slide' => $posted];
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
     * Displays a single Slide model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id) {
        return $this->render('view', [
                    'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Slide model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate() {
        $model = new Slide();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            $imgurl = \common\models\Upload::find()
                    ->where(['id' => $model->img])
                    ->asArray()
                    ->one();
            $model->img = $imgurl['file_name'];
            $model->save();
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('create', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing Slide model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id) {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            $imgurl = \common\models\Upload::find()
                    ->where(['id' => $model->img])
                    ->asArray()
                    ->one();
            $model->img = $imgurl['file_name'];
            $model->save();
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('update', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing Slide model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id) {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the Slide model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Slide the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id) {
        if (($model = Slide::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

}
