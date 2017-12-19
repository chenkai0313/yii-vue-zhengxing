<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "news".
 *
 * @property integer $id
 * @property string $title
 * @property string $remark
 * @property integer $thumb
 * @property string $content
 * @property integer $source
 * @property integer $create_at
 * @property integer $update_at
 * @property integer $weight
 * @property integer $pid
 * @property integer $cid
 */
class News extends \yii\db\ActiveRecord {

    /**
     * @inheritdoc
     */
    public static function tableName() {
        return 'news';
    }

    /**
     * @inheritdoc
     */
    public function rules() {
        return [
            [['title', 'remark', 'content', 'source', 'create_at', 'pid', 'cid', 'display',], 'required'],
            [['title', 'remark', 'content'], 'string'],
            [['source', 'update_at', 'weight', 'pid', 'cid', 'display',], 'integer'],
            [['thumb'], 'string', 'max' => 255],
            [['create_at'], 'string', 'max' => 200],
            ['weight', 'default', 'value' => 0],
        ];
    }
    public  static function test(){
        $data= \common\models\Category::find()
                       ->select(['name', 'id','pid'])
                        ->indexBy('id')
                        ->orderby('id desc')
                        ->column();
    return $data;
    }
    // #形成层级结构
    // private static function GetLevel($arr, $pid, $step)
    // {
    //     global $level;
    //     foreach ($arr as $key => $val) {
    //         if ($val['pid'] == $pid) {
    //             $flg = str_repeat('1123', $step + 1);
    //             $val['name'] = $flg . $val['name'];
    //             $level[] = $val;
    //             static::GetLevel($arr, $val['id'], $step + 1);
    //         }
    //     }
    //     return $level;
    // }


    public function getTitle1() {
        return $this->hasOne(Source::className(), array('id' => 'source'));
    }

    public function getshorttitle() {
        return mb_strlen($this->title) > 50 ? mb_substr($this->title, 0, 50, 'utf-8') . '...' : $this->title;
    }

    public function beforeSave($insert) {
        if (parent::beforeSave($insert)) {
            if ($insert) {

                $this->update_at = time();
            } else {
                $this->update_at = time();
            }
            return true;
        } else {
            return false;
        }
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels() {
        return [
            'id' => 'ID',
            'title' => Yii::t('app', 'Title'),
            'remark' => Yii::t('app', 'Remark'),
            'thumb' => Yii::t('app', 'Thumb'),
            'content' => Yii::t('app', 'Content'),
            'source' => Yii::t('app', 'Source'),
            'create_at' => Yii::t('app', 'Create At'),
            'update_at' => Yii::t('app', 'Update At'),
            'weight' => Yii::t('app', 'Weight'),
            'pid' => Yii::t('app', 'first category pid'),
            'cid' => Yii::t('app', 'Cid'),
            'display' => Yii::t('app', 'Display'),
        ];
    }

}
