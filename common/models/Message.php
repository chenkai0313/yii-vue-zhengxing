<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "message".
* create by ck 
 * @property integer $id
 * @property string $theme
 * @property integer $replyway
 * @property string $linkman
 * @property string $content
 * @property integer $display
 * @property integer $create_at
 * @property string $linkway
 */
class Message extends \yii\db\ActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'message';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['linkman', 'content',  'linkway'], 'required'],
            [[ 'display', 'create_at'], 'integer'],
            [['content'], 'string'],
            [[ 'linkman', 'linkway','address','email'], 'string', 'max' => 255],
        ];
    }

    public function getshorttitle() {
        return mb_strlen($this->theme) > 15 ? mb_substr($this->theme, 0, 15, 'utf-8') . '...' : $this->theme;
    }

    public function beforeSave($insert) {
        if (parent::beforeSave($insert)) {
            if ($insert) {
                $this->create_at = time();
            } else {
                $this->create_at = time();
            }
            return true;
        } else {
            return false;
        }
    }
    public function getshortcontent() {
        return mb_strlen($this->content) > 15 ? mb_substr($this->content, 0, 15, 'utf-8') . '...' : $this->content;
    }
    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'id' => 'ID',
            'theme' => Yii::t('app', 'Theme'),
            'replyway' => Yii::t('app', 'Replyway'),
            'linkman' => Yii::t('app', 'Linkman'),
            'content' => Yii::t('app', 'Content'),
            'display' => Yii::t('app', 'Display'),
            'create_at' => Yii::t('app', 'Create At'),
            'linkway' => Yii::t('app', 'Linkway'),
            'address'=>'地区',
            'email'=>'邮箱'
        ];
    }

}
