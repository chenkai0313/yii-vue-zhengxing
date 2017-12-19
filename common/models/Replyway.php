<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "replyway".
 *
 * @property integer $id
 * @property string $title
 */
class Replyway extends \yii\db\ActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'replyway';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['title'], 'required'],
            [['title'], 'string', 'max' => 20],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'id' => 'ID',
            'title' => Yii::t('app', 'Replyway Title'),
        ];
    }

}
