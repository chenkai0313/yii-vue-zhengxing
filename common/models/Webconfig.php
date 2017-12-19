<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "zcw_webconfig".
 *
 * @property string $id
 * @property string $type
 * @property string $content
 * @property integer $createtime
 * @property integer $updatetime
 */
class Webconfig extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'zc_webconfig';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['type', 'content', 'createtime', 'updatetime'], 'required'],
            [['content'], 'string'],
            [['createtime', 'updatetime'], 'integer'],
            [['type'], 'string', 'max' => 20],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'type' => '配置类型置',
            'content' => '序列化的数组字符串',
            'createtime' => '创建时间',
            'updatetime' => '更新时间',
        ];
    }
}
