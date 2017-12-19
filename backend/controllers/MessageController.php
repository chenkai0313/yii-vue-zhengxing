<?php

namespace backend\controllers;

use Yii;
use common\models\Message;
use common\models\MessageSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\Response;

/**
 * MessageController implements the CRUD actions for Message model.
 */
class MessageController extends Controller {

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
     * Lists all Message models.
     * @return mixed
     */
    public function actionIndex() {
        $searchModel = new MessageSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
                    'searchModel' => $searchModel,
                    'dataProvider' => $dataProvider,
        ]);
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
     * Displays a single Message model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id) {
        return $this->render('view', [
                    'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Message model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate() {
        $model = new Message();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('create', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing Message model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id) {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('update', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing Message model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id) {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the Message model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Message the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id) {
        if (($model = Message::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

}
