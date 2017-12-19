<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "source".
 *
 * @property integer $id
 * @property string $name
 * @property integer $crate_at
 * @property integer $update_at
 */
class Source extends \yii\db\ActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'source';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['name',], 'required'],
            [['crate_at', 'update_at'], 'integer'],
            [['name'], 'string', 'max' => 255],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'id' => 'ID',
            'name' => Yii::t('app', 'Source Name'),
            'crate_at' => Yii::t('app', 'Create At'),
            'update_at' => Yii::t('app', 'Update At'),
        ];
    }

    public function beforeSave($insert) {
        if (parent::beforeSave($insert)) {
            if ($insert) {
                $this->crate_at = time();
                $this->update_at = time();
            } else {
                $this->update_at = time();
            }
            return true;
        } else {
            return false;
        }
    }

}
