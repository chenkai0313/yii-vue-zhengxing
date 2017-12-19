<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "slide".
 *
 * @property integer $id
 * @property string $title
 * @property string $img
 * @property string $url
 * @property integer $weight
 * @property integer $create_at
 * @property integer $update_at
 */
class Slide extends \yii\db\ActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'slide';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['title', 'img', 'display',], 'required'],
            [['weight', 'create_at', 'update_at', 'display',], 'integer'],
            [['title', 'img', 'url'], 'string', 'max' => 255],
            ['weight', 'default', 'value' => 0],
        ];
    }

    public function beforeSave($insert) {
        if (parent::beforeSave($insert)) {
            if ($insert) {
                $this->create_at = time();
                $this->update_at = time();
            } else {
                $this->update_at = time();
            }
            return true;
        } else {
            return false;
        }
    }

    public function getshorttitle() {
        return mb_strlen($this->title) > 15 ? mb_substr($this->title, 0, 15, 'utf-8') . '...' : $this->title;
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'id' => 'ID',
            'title' => Yii::t('app', 'Title'),
            'img' => Yii::t('app', 'Img'),
            'url' => Yii::t('app', 'Url'),
            'display' => Yii::t('app', 'Display'),
            'weight' => Yii::t('app', 'Weight'),
            'create_at' => Yii::t('app', 'Create At'),
            'update_at' => Yii::t('app', 'Update At'),
        ];
    }

}
