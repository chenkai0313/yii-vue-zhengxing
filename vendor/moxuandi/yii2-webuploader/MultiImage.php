<?php
namespace moxuandi\webuploader;

use common\models\Upload;
use yii\helpers\Html;
use yii\helpers\Json;
use yii\helpers\Url;
use yii\widgets\InputWidget;

class MultiImage extends InputWidget
{
    public function init()
    {
        parent::init();
        if($this->hasModel()){
            $this->id = Html::getInputId($this->model, $this->attribute);
            echo Html::activeHiddenInput($this->model, $this->attribute);
        }else{
            echo Html::hiddenInput($this->name, $this->value);
        }
    }

    public function run()
    {
        MultiImageAsset::register($this->view);
        return $this->render('multi', [
            'sendUrl' => Url::to(['WebUploader', 'action'=>'uploadJson']),
            'inputId' => $this->id,
        ]);
    }
}
