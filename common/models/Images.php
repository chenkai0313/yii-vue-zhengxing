<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "images".
 *
 * @property integer $id
 * @property string $img
 * @property string $url
 * @property integer $create_at
 * @property integer $update_at
 */
class Images extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'images';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['img', 'url','display'], 'required'],
            [['create_at', 'update_at','type','weight','display'], 'integer'],
            [['img', 'url','name'], 'string', 'max' => 255],
            ['weight', 'default', 'value' => 0],
            [['content'], 'string'],
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

   public function getDisplay() {
        // var_dump($this->display);
        // exit;
        if($this->display==0){
            return '不展示';
        }elseif($this->display==1){
            return '展示';
          }
    }
    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'img' => '图片',
            'url' => '链接',
            'weight' => '权重',
            'display' => '是否发布',
            'type' => 'type',
            'create_at' => '创建时间',
            'update_at' => '更新时间',
            'name' => '名称',
            'content'=>'内容',
        ];
    }
}
