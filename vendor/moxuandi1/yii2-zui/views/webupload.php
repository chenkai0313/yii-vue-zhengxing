<div id='<?= $id ?>-zuigrid' class="uploader">
    <div class="uploader-message text-center">
        <div class="content"></div>
        <button type="button" class="close">×</button>
    </div>
    <div class="placeholder" <?= $imgurls == '[]' ? '' : 'style="display:none;"'; ?>>
        <button type="button" class="uploader-btn-browse">点击选择文件</button>
        <p>或将照片拖到这里，单次最多可选300张</p>
    </div>
    <div class="uploader-files file-list file-list-grid"></div>
    <div class="statusBar" <?= $imgurls == '[]' ? 'style="display:none;"' : ''; ?>>
        <div class="uploader-status text-muted"></div>
        <div class="btns">
            <button type="button" class="btn btn-info uploader-btn-browse" style="margin-right:1em"><i class="icon icon-plus"></i> 继续添加</button>
            <button type="button" class="btn btn-success uploader-btn-start"><i class="icon icon-cloud-upload"></i> 开始上传</button>
            <button type="button" class="btn btn-success uploader-btn-start uploader-btn-paused" style="display:none;"><i class="icon icon-cloud-upload"></i> 继续上传</button>
            <button type="button" class="btn btn-success uploader-btn-stop" style="display:none;"><i class="icon icon-cloud-upload"></i> 暂停上传</button>
        </div>
    </div>
</div>

<?php
$asideJs = <<<JS
var options = {
    url: '{$sendUrl}',
    filters: {$filters},
    multipart_params: {action: '{$action}'},
    deleteConfirm: true,
    staticFiles: {$imgurls},
    deleteActionOnDone: function(file, doRemoveFile){
        var oldArray = $("#{$id}").val().split(',');
        var imgurls = '';
        for(var i in oldArray){
            if(oldArray[i] != file.remoteId){
                imgurls === '' ? imgurls += oldArray[i] : imgurls += ',' + oldArray[i];
            }
        }
        $("#{$id}").val(imgurls);
        doRemoveFile(file);
    },
    onUploadComplete: function(files){
        $('.uploader > .statusBar .uploader-btn-browse').show();
        $('.uploader > .statusBar .uploader-btn-start').show();
        $('.uploader > .statusBar .uploader-btn-start.uploader-btn-paused').hide();
        $('.uploader > .statusBar .uploader-btn-stop').hide();
        var imgurls = $("#{$id}").val();
        for(var i=0; i<files.length; i++){
            imgurls === '' ? imgurls += files[i].remoteId : imgurls += ',' + files[i].remoteId;
        }
        $("#{$id}").val(imgurls);
    },
    onFilesAdded: function(files){
      $('.uploader > .placeholder').hide();
      $('.uploader > .statusBar').show();
    },
    onUploadFile: function(file){
      $('.uploader > .statusBar .uploader-btn-browse').hide();
      $('.uploader > .statusBar .uploader-btn-start').hide();
      $('.uploader > .statusBar .uploader-btn-stop').show();
    },
    onStateChanged: function(state){
      if(state == 1){
        $('.uploader > .statusBar .uploader-btn-start.uploader-btn-paused').show();
        $('.uploader > .statusBar .uploader-btn-stop').hide();
      }
    }
};
$("#{$id}-zuigrid").uploader(options);
JS;
$this->registerJs($asideJs);
?>