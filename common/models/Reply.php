<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "reply".
 *
 * @property integer $id
 * @property integer $pid_theme
 * @property string $content
 * @property string $reply_people
 * @property integer $create_time
 */
class Reply extends \yii\db\ActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'reply';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['pid_theme', 'content', 'reply_people', 'create_time'], 'required'],
            [['pid_theme', 'create_time'], 'integer'],
            [['content'], 'string'],
            [['reply_people'], 'string', 'max' => 50],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'id' => 'ID',
            'pid_theme' => Yii::t('app', 'Pid Theme'),
            'content' => Yii::t('app', 'Content'),
            'reply_people' => Yii::t('app', 'Reply People'),
            'create_time' => Yii::t('app', 'Create Time'),
        ];
    }

}
