<?php

namespace backend\controllers;

use Yii;
use common\models\Reply;
use common\models\ReplySearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\Url;

/**
 * ReplyController implements the CRUD actions for Reply model.
 */
class ReplyController extends BaseController {

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
     * Lists all Reply models.
     * @return mixed
     */
    public function actionIndex() {
        $searchModel = new ReplySearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
                    'searchModel' => $searchModel,
                    'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Reply model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id) {
        return $this->render('view', [
                    'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Reply model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate() {
        $model = new Reply();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->id]);
        } else {
            return $this->render('create', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing Reply model.
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
     * Deletes an existing Reply model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id) {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Message page by ck.
     */
    public function actionMessage($id) {
        $model = \common\models\Message::find()
                ->where('id = :id', [':id' => $id])
                ->asArray()
                ->one();
        $rs = Reply::find()
                ->where('pid_theme=:id', [':id' => $id])
                ->asArray()
                ->all();
        return $this->render('message', get_defined_vars());
    }

    /**
     * update Message  by ck.
     */
    public function actionDisplay($id, $display) {
        $model = \common\models\Message::find()
                ->where('id = :id', [':id' => $id])
                ->one();
        $model->display = $display;

        if ($model->update()) {
            return $this->success(Yii::t('app', 'Update Success'), Url::to(['reply/message', 'id' => $id]), 3);
        } else {
            return $this->error(Yii::t('app', 'Update Error'), Url::to(['reply/message', 'id' => $id]), 3);
        }
    }

    /**
     * add Message  by ck.
     */
    public function actionAdd($id) {
        $model = new Reply();
        $model->pid_theme = intval($id);
        $model->content = $_POST['content'];
        $model->reply_people = Yii::t('app', 'admin');
        $model->create_time = time();
        if ($model->save()) {
            return $this->success(Yii::t('app', 'Add Success'), Url::to(['reply/message', 'id' => $id]), 3);
        } else {
            return $this->error(Yii::t('app', 'Add Error'), Url::to(['reply/message', 'id' => $id]), 3);
        }
    }

    /**
     * Finds the Reply model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Reply the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id) {
        if (($model = Reply::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

}
