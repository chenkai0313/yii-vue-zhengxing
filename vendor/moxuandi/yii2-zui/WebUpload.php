<?php
namespace moxuandi\zui;

use common\models\Upload;
use yii;
use yii\helpers\Html;
use yii\helpers\Json;
use yii\helpers\Url;
use yii\widgets\InputWidget;

class WebUpload extends InputWidget
{
    /** 上传类型,
     * images: 多图上传
     * files: 多文件上传
     * medias: 多视音频上传
     */
    public $action = 'images';

    /** 上传文件限制, 将替换 $filters 中的内容
     * 数组的形式, eg:
     * [
     *   'mime_types'=> [['title'=>'图片', 'extensions'=>'jpg,jpeg,png,gif']],
     *   'max_file_size'=>'2mb',
     *   'prevent_duplicates'=>true
     * ],
     */
    public $filter = [];

    /** zui filters 说明: 用来过滤文件的类型、大小等。该选项为一个对象，可以包含如下属性的一项或全部：
     * mime_types：用来设定允许上传的文件类型，该值为一个对象数组，每个对象包含 title 和 extensions 属性；
     * max_file_size：最大允许上传的文件大小，例如 1024，单位为字节（b），也可用为一个字符串，包含数值或单位，例如 128kb；
     * prevent_duplicates：是否允许选取重复的文件，默认为 false 不允许，如果两个文件名和大小都相同则被认为是重复的文件；
     * 一个完整示例如下：
     * {
     *   // 只允许上传图片或图标（.ico）
     *   mime_types: [
     *     {title: '图片', extensions: 'jpg,gif,png'},
     *     {title: '图标', extensions: 'ico'}
     *   ],
     *   // 最大上传文件为 1MB
     *   max_file_size: '1mb',
     *   // 不允许上传重复文件
     *   prevent_duplicates: true
     * }
     */
    public $filters = [
        'images' => [
            'mime_types'=> [['title'=>'图片', 'extensions'=>'jpg,jpeg,png,gif']],
            'max_file_size'=>'2mb',
            'prevent_duplicates'=>true
        ],
        'files' => [
            'mime_types'=> [['title'=>'文件', 'extensions'=>'png,jpg,jpeg,gif,bmp,flv,swf,mkv,avi,rm,rmvb,mpeg,mpg,ogg,ogv,mov,wmv,mp4,webm,mp3,wav,mid,rar,zip,tar,gz,7z,bz2,cab,iso,doc,docx,xls,xlsx,ppt,pptx,pdf,txt,md,xml']],
            'max_file_size'=>'20mb',
            'prevent_duplicates'=>true
        ],
        'medias' => [
            'mime_types'=> [['title'=>'视音频', 'extensions'=>'flv,swf,mkv,avi,rm,rmvb,mpeg,mpg,ogg,ogv,mov,wmv,mp4,webm,mp3,wav,mid']],
            'max_file_size'=>'20mb',
            'prevent_duplicates'=>true
        ],
    ];

    public function init()
    {
        parent::init();
        if($this->hasModel()){
            $this->id = Html::getInputId($this->model, $this->attribute);
            echo Html::activeHiddenInput($this->model, $this->attribute);
        }else{
            echo Html::hiddenInput($this->name, $this->value);
        }

        if(!empty($this->filter)){
            $this->filters[$this->action] = $this->filter;
        }
    }

    public function run()
    {
        $attribute = $this->attribute;
        $imgIdArray = $this->model->$attribute ? explode(',', $this->model->$attribute) : '';
        $imgurls = [];
        if(!empty($imgIdArray)){
            foreach($imgIdArray as $i=>$img){
                $imgModel = Upload::findOne($img);
                $imgurls[$img] = [
                    'id' => $img,
                    'remoteId' => $img,
                    'previewImage' => '/' . $imgModel->file_name,
                    'url' => '/' . $imgModel->file_name,
                    'name' => $imgModel->real_name,
                    'type' => $imgModel->file_mime,
                    'size' => $imgModel->file_size,
                    'origSize' => $imgModel->file_size,
                    //'lastModifiedDate ' => $imginfo['mtime'],
                ];
            }
        }

        WebUploadAsset::register($this->view);
        return $this->render('webupload', [
            'sendUrl' => Url::to(['ZuiUploader']),
            'id' => $this->id,
            'action' => $this->action,
            'filters' => Json::encode($this->filters[$this->action]),
            'imgurls' => Json::encode($imgurls)
        ]);
    }
}
