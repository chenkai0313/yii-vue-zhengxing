<div id='<?= $id ?>-zuigrid' class="uploader" style="margin-bottom:0">
    <div class="uploader-message text-center">
        <div class="content"></div>
        <button type="button" class="close">×</button>
    </div>
    <div class="uploader-files file-list file-list-grid"></div>
    <hr class="divider">
    <div style="padding-top:5px">
        <div class="uploader-status pull-right text-muted"></div>
        <button type="button" class="btn btn-info uploader-btn-browse" style="margin-right:1em"><i class="icon icon-plus"></i> 选择文件</button>
        <button type="button" class="btn btn-success uploader-btn-start"><i class="icon icon-cloud-upload"></i> 开始上传</button>
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
        var imgurls = $("#{$id}").val();
        for(var i=0; i<files.length; i++){
            imgurls === '' ? imgurls += files[i].remoteId : imgurls += ',' + files[i].remoteId;
        }
        $("#{$id}").val(imgurls);
    },
    fileFormater: function(fileid, file, status){
        fileid.find('.file-name').text(file.name);
        fileid.find('.btn-download-file').attr('href', file.url);
        fileid.find('.btn-download-file').attr('download', file.name);
    }
};
$("#{$id}-zuigrid").uploader(options);
JS;
$this->registerJs($asideJs);
?>