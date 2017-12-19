<?php
namespace common\models;

use Yii;
use yii\behaviors\TimestampBehavior;

/**
 * This is the model class for table "{{%upload}}".
 *
 * @property string $id
 * @property string $real_name
 * @property string $file_name
 * @property string $thumb_name
 * @property string $file_ext
 * @property string $file_mime
 * @property string $file_size
 * @property string $md5
 * @property string $sha1
 * @property string $down_count
 * @property integer $created_at
 * @property integer $updated_at
 */
class Upload extends \yii\db\ActiveRecord
{
    public static function tableName()
    {
        return '{{%upload}}';
    }

    public function behaviors()
    {
        return [
            TimestampBehavior::className()
        ];
    }

    public function rules()
    {
        return [
            [['file_size', 'down_count', 'created_at', 'updated_at'], 'integer'],
            [['md5', 'sha1'], 'string'],
            [['real_name', 'file_name', 'thumb_name', 'file_ext', 'file_mime'], 'string', 'max' => 255],
            ['down_count', 'default', 'value'=>0],
        ];
    }

    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'real_name' => '原始文件名称',
            'file_name' => '文件路径',
            'thumb_name' => '缩略图',
            'file_ext' => '扩展名称',
            'file_mime' => 'MIME类型',
            'file_size' => '文件大小',
            'md5' => 'MD5',
            'sha1' => 'SHA1',
            'down_count' => '下载次数',
            'created_at' => '添加时间',
            'updated_at' => '更新时间',
        ];
    }
}
