<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "category".
 * create by ck 
 * @property integer $id
 * @property integer $pid
 * @property string $name
 * @property string $bgimage
 * @property integer $display
 * @property integer $weight
 * @property integer $create_at
 * @property integer $update_at
 */
class Category extends \yii\db\ActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'category';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
                [['pid', 'name', 'display','list_type'], 'required'],
                [['pid', 'display', 'weight', 'create_at', 'update_at','list_type'], 'integer'],
                [['name'], 'string', 'max' => 50],
                [['bgimage','remark'], 'string', 'max' => 255],
                ['weight', 'default', 'value' => 0],
        ];
    }

    public function getTitle1() {
        return $this->hasOne(Category::className(), array('id' => 'name'));
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
    public function getListtype() {

        if($this->list_type==0){
            return '单页面';
        }
        if($this->list_type==1){
            return '列表页';
          }
        if($this->list_type==2){
            return '这是一级标题页面';
          }
        if($this->list_type==3) {
             return '新闻列表';
          }
              if($this->list_type==4) {
             return '图片模型';
          }
        
    }
    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'id' => 'ID',
            'pid' => Yii::t('app', 'Pid'),
            'name' => Yii::t('app', 'Name'),
            'bgimage' => Yii::t('app', 'Bgimage'),
            'display' => Yii::t('app', 'Display'),
            'weight' => Yii::t('app', 'Weight'),
            'create_at' => Yii::t('app', 'Create At'),
            'update_at' => Yii::t('app', 'Update At'),
             'list_type' => Yii::t('app', 'list  type'),
             'remark'=>'标题描述',
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

}
