(function($){
	// 当domReady的时候开始初始化
	$(function(){
		var $wrap = $('#uploader'),
			// 图片容器
			$queue = $('<ul class="filelist"></ul>').appendTo($wrap.find('.queueList')),
			// 状态栏，包括进度和控制按钮
			$statusBar = $wrap.find('.statusBar'),
			// 文件总体选择信息。
			$info = $statusBar.find('.info'),
			// 上传按钮
			$upload = $wrap.find('.uploadBtn'),
			// 没选择文件之前的内容。
			$placeHolder = $wrap.find('.placeholder'),
			// 进度条
			$progress = $statusBar.find('.progress').hide(),
			// 添加的文件数量
			fileCount = 0,
			// 添加的文件总大小
			fileSize = 0,
			// 可能有pedding, ready, uploading, confirm, done.
			state = 'pedding',
			// 上传成功的图片 id
			imgIds = '';
			// 所有文件的进度信息，key为file id
			percentages = {},
			// 判断浏览器是否支持图片的base64
			isSupportBase64 = (function(){
				var data = new Image();
				var support = true;
				data.onload = data.onerror = function(){
					if(this.width != 1 || this.height != 1){
						support = false;
					}
				}
                data.src = "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==";
                return support;
            })(),
            // 检测是否已经安装flash，检测flash的版本
            flashVersion = (function(){
                var version;
                try{
                    version = navigator.plugins['Shockwave Flash'];
                    version = version.description;
                }catch(ex){
                    try{
                        version = new ActiveXObject('ShockwaveFlash.ShockwaveFlash') .GetVariable('$version');
                    }catch(ex2){
                        version = '0.0';
                    }
                }
                version = version.match(/\d+/g);
                return parseFloat(version[0] + '.' + version[1], 10);
            })(),
			// 检测浏览器是否支持css-transition属性
            supportTransition = (function(){
                var s = document.createElement('p').style,
                    r = 'transition' in s || 'WebkitTransition' in s || 'MozTransition' in s || 'msTransition' in s || 'OTransition' in s;
                s = null;
                return r;
            })(),

            // WebUploader实例
            uploader;

        if(!WebUploader.Uploader.support('flash') && WebUploader.browser.ie){
            // flash 安装了但是版本过低。
            if(flashVersion){
                (function(container){
                    window['expressinstallcallback'] = function(state){
                        switch(state){
                            case 'Download.Cancelled': alert('您取消了更新！'); break;
                            case 'Download.Failed': alert('安装失败'); break;
                            default: alert('安装已成功，请刷新！'); break;
                        }
                        delete window['expressinstallcallback'];
                    };
                    var swf = './expressInstall.swf';
                    // insert flash object
                    var html = '<object type="application/' + 'x-shockwave-flash" data="' +  swf + '" ';
                    if(WebUploader.browser.ie){
                        html += 'classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" ';
                    }
                    html += 'width="100%" height="100%" style="outline:0">' + '<param name="movie" value="' + swf + '" />' + '<param name="wmode" value="transparent" />' + '<param name="allowscriptaccess" value="always" />' + '</object>';
                    container.html(html);
                })($wrap);
            // 压根就没有安转。
            }else{
                $wrap.html('<a href="http://www.adobe.com/go/getflashplayer" target="_blank" border="0"><img alt="get flash player" src="http://www.adobe.com/macromedia/style_guide/images/160x41_Get_Flash_Player.jpg" /></a>');
            }
            return;
        }else if(!WebUploader.Uploader.support()){
            alert('Web Uploader 不支持您的浏览器！');
            return;
        }

        // 实例化
		uploader = WebUploader.create({
			swf: '../dist/Uploader.swf',
			server: SENDURL,
			pick: {  //选择文件的按钮容器
				id:'#filePicker',
				label:'点击选择图片'
			},
			accept: {  //允许的文件类型
				title:'Images',
				extensions:'gif,jpg,jpeg,bmp,png',
				mimeTypes:'image/*'
			},
			thumb: {  //缩略图配置
				width: 120,
				height: 120
			},
			compress: false,  // 图片上传前不压缩
			prepareNextFile: true,  // 是否允许在文件传输时提前把下一个文件准备好。 对于一个文件的准备工作比较耗时，比如图片压缩，md5序列化。 如果能提前在当前文件传输期处理，可以节省总体耗时。
			threads: 10,  // 上传并发数。允许同时最大上传进程数
			//fileNumLimit: 300,  // 300个, 验证文件总数量, 超出则不允许加入队列
			//fileSizeLimit: 200 * 1024 * 1024,  // 200M, 验证文件总大小是否超出限制, 超出则不允许加入队列
			//fileSingleSizeLimit: 50 * 1024 * 1024,  // 50M, 验证单个文件大小是否超出限制, 超出则不允许加入队列
		});
        
        // 拖拽时不接受 js, txt 文件。
        uploader.on('dndAccept', function(items){
            var denied = false, len = items.length, i = 0,
                // 修改js类型
                unAllowed = 'text/plain;application/javascript';
            for (; i < len; i++){
                // 如果在列表里面
                if(~unAllowed.indexOf(items[i].type)){
                    denied = true;
                    break;
                }
            }
            return !denied;
        });

        // 添加“添加文件”的按钮，
        uploader.addButton({
            id: '#filePicker2',
            label: '继续添加'
        });

        uploader.on('ready', function(){
            window.uploader = uploader;
            //在这里设置回显
        });

        // 当有文件添加进来时执行，负责view的创建
        function addFile(file){
            var $li = $('<li id="' + file.id + '">' + '<p class="imgWrap"></p>' + '<p class="title">' + file.name + '</p>' + '<p class="progress"><span></span></p>' + '</li>'),
                $btns = $('<div class="file-panel"><span class="cancel">删除</span></div>').appendTo($li),
                $prgress = $li.find('p.progress span'),
                $wrap = $li.find('p.imgWrap'),
                $info = $('<p class="error"></p>'),
                showError = function(code){
                    switch(code){
                        case 'exceed_size': text = '文件大小超出'; break;
                        case 'interrupt': text = '上传暂停'; break;
                        default: text = '上传失败，请重试'; break;
                    }
                    $info.text(text).appendTo($li);
                };
            if(file.getStatus() === 'invalid'){
                showError(file.statusText);
            }else{
                // @todo lazyload
                $wrap.text('预览中');
                uploader.makeThumb(file, function(error, src){
                    var img;
                    if(error){
                        $wrap.text('不能预览');
                        return;
                    }
                    if(isSupportBase64){
                        img = $('<img src="'+src+'">');
                        $wrap.empty().append(img);
                    }else{
                        $.ajax('preview.php', {
                            method: 'POST',
                            data: src,
                            dataType:'json'
                        }).done(function(response){
                            if(response.result){
                                img = $('<img src="'+response.result+'">');
                                $wrap.empty().append(img);
                            }else{
                                $wrap.text("预览出错");
                            }
                        });
                    }
                });
                percentages[file.id] = [file.size, 0];
                file.rotation = 0;
            }
            // 文件状态变化
            file.on('statuschange', function(cur, prev){
                if(prev === 'progress')
                    $prgress.hide().width(0);
                switch(cur){
                	case 'inited':  //初始状态
                		break;
                	case 'queued':  //已经进入队列, 等待上传
                		$info.remove();
                    	$prgress.css('display', 'block');
                    	percentages[file.id][1] = 0;
                		break;
                	case 'progress':  //上传中
                		$info.remove();
                    	$prgress.css('display', 'block');
                		break;
                	case 'error':  //上传出错, 可重试
                		$li.find('span.success').remove();
                    	showError(file.statusText);
                    	percentages[file.id][1] = 1;
                		break;
                	case 'complete':  //上传完成
                		$prgress.hide().width(0);
                    	$li.append('<span class="success"></span>');
                		break;
                	case 'interrupt':  //上传中断, 可续传
                		showError('interrupt');
                		break;
                	case 'invalid':  //文件不合格, 不能重试上传
                    	showError(file.statusText);
                    	percentages[file.id][1] = 1;
                		break;
                	case 'cancelled':  //文件被移除
                		break;
                }
                $li.removeClass('state-' + prev).addClass('state-' + cur);
            });

			//当鼠标指针进入(穿过)元素时, 显示控制按钮
            $li.on('mouseenter', function(){$btns.stop().animate({height:30})});
            //当鼠标指针离开元素时, 隐藏控制按钮
            $li.on('mouseleave', function(){$btns.stop().animate({height:0})});

			//控制按钮被点击时
            $btns.on('click', 'span', function(){
                var index = $(this).index(), deg;
                switch(index){
                    case 0: uploader.removeFile(file); return;
                }
                if(supportTransition){
                    deg = 'rotate(' + file.rotation + 'deg)';
                    $wrap.css({'-webkit-transform':deg, '-mos-transform':deg, '-o-transform':deg, 'transform':deg});
                }else{
                    $wrap.css('filter', 'progid:DXImageTransform.Microsoft.BasicImage(rotation='+ (~~((file.rotation/90)%4 + 4)%4) +')');
                }
            });
            $li.appendTo($queue);
        }
        
        // 负责view的销毁
        function removeFile(file){
            var $li = $('#'+file.id);
            delete percentages[file.id];
            updateTotalProgress();
            $li.off().find('.file-panel').off().end().remove();
        }
        
        // 更新总体进度条
        function updateTotalProgress(){
            var loaded = 0, total = 0, spans = $progress.children(), percent;
            $.each(percentages, function(k, v){
                total += v[0];
                loaded += v[0] * v[1];
            });
            percent = total ? loaded / total : 0;
            spans.eq(0).text(Math.round(percent * 100 ) + '%');
            spans.eq(1).css('width', Math.round(percent * 100 ) + '%');
            updateStatus();
        }
        
		// 更新总体上传状态
        function updateStatus(){
            var text = '', stats;
            if(state === 'ready'){
                text = '选中' + fileCount + '张图片，共' + WebUploader.formatSize(fileSize ) + '。';
            }else if(state === 'confirm'){
                stats = uploader.getStats();
                if(stats.uploadFailNum){
                    text = '已成功上传' + stats.successNum+ '张照片至XX相册，'+ stats.uploadFailNum + '张照片上传失败，<a class="retry" href="#">重新上传</a>失败图片或<a class="ignore" href="#">忽略</a>'
                }
            }else{
                stats = uploader.getStats();
                text = '共' + fileCount + '张（' + WebUploader.formatSize(fileSize ) + '），已上传' + stats.successNum + '张';
                if(stats.uploadFailNum){
                    text += '，失败' + stats.uploadFailNum + '张';
                }
            }
            $info.html(text);
        }
        
        function setState(val){
            var file, stats;
            if(val === state){
                return;
            }
            $upload.removeClass('state-' + state);
            $upload.addClass('state-' + val);
            state = val;
            switch (state){
                case 'pedding':
                    $placeHolder.removeClass('element-invisible');
                    $queue.parent().removeClass('filled');
                    $queue.hide();
                    $statusBar.addClass('element-invisible');
                    uploader.refresh();
                    break;
                case 'ready':
                    $placeHolder.addClass('element-invisible');
                    $('#filePicker2').removeClass('element-invisible');
                    $queue.parent().addClass('filled');
                    $queue.show();
                    $statusBar.removeClass('element-invisible');
                    uploader.refresh();
                    break;
                case 'uploading':
                    $('#filePicker2').addClass('element-invisible');
                    $progress.show();
                    $upload.text('暂停上传');
                    break;
                case 'paused':
                    $progress.show();
                    $upload.text('继续上传');
                    break;
                case 'confirm':
                    $progress.hide();
                    $('#filePicker2').removeClass('element-invisible');
                    $upload.text('开始上传');
                    stats = uploader.getStats();
                    if(stats.successNum && !stats.uploadFailNum){
                        setState('finish');
                        return;
                    }
                    break;
                case 'finish':
                    stats = uploader.getStats();
                    if(stats.successNum){
                        alert('上传成功');
                    }else{
                        // 没有成功的图片，重设
                        state = 'done';
                        location.reload();
                    }
                    break;
            }
            updateStatus();
        }
        
        // 当 validate 不通过时，会以派送错误事件的形式通知调用者
		uploader.on('error', function(code){
			//alert('Eroor: ' + code);
			switch(code){
				case 'Q_EXCEED_NUM_LIMIT': alert('文件总数超出 fileNumLimit 限制, 超出部分将不添加到上传队列中'); break;
				case 'Q_EXCEED_SIZE_LIMIT': alert('文件总大小超出 fileSizeLimit 限制, 超出部分将不添加到上传队列中'); break;
				case 'Q_TYPE_DENIED': alert('文件类型不符合上传要求, 将不添加到上传队列中'); break;
				default: alert('Eroor: ' + code); break;
			}
        });
        
        // 当有文件被添加进队列的时候
		uploader.on('fileQueued', function(file){
            fileCount++;
            fileSize += file.size;
            if(fileCount === 1){
                $placeHolder.addClass('element-invisible');
                $statusBar.show();
            }
            addFile(file);
            setState('ready');
            updateTotalProgress();
        });
        
        // 当文件被移除队列后触发 fileDequeued 事件
		uploader.on('fileDequeued', function(file){
            fileCount--;
            fileSize -= file.size;

            if(!fileCount){
                setState('pedding');
            }

            removeFile(file);
            updateTotalProgress();
       });

		// 上传过程中触发 uploadProgress 事件，携带上传进度。
		uploader.on('uploadProgress', function(file, percentage){
            var $li = $('#'+file.id), $percent = $li.find('.progress span');
            $percent.css('width', percentage * 100 + '%');
            percentages[file.id][1] = percentage;
            updateTotalProgress();
       });
		
		// 当文件上传成功时触发 uploadSuccess 事件
		uploader.on('uploadSuccess', function(file, response){
			if(response.result === 'success'){
				imgIds === '' ? imgIds += response.id : imgIds += ',' + response.id;
			}else{
				file.setStatus('error', response.message);
			}
			$('#' + INPUTID).val(imgIds);
		});
		
		// 特殊事件all, 所有的事件触发都会响应到
        uploader.on('all', function(type){
            switch(type){
                case 'uploadFinished': setState('confirm'); break;
                case 'startUpload': setState('uploading'); break;
                case 'stopUpload': setState('paused'); break;
            }
        });

		//当上传按钮被点击时
        $upload.on('click', function(){
            if($(this).hasClass('disabled')){
                return false;
            }
            if(state === 'ready'){
                uploader.upload();
            }else if(state === 'paused'){
                uploader.upload();
            }else if(state === 'uploading'){
                uploader.stop();
            }
        });
        
        //当"重新上传"被点击时, 重试上传文件
        $info.on('click', '.retry', function(){
            uploader.retry();
        });
        
        //当"忽略"被点击时, 获取所有上传失败的文件, 然后删除
        $info.on('click', '.ignore', function(){
        	var errorFile = uploader.getFiles('error');
        	for(var i=0; i<errorFile.length; i++){
        		uploader.removeFile(errorFile[i]);
        	}
        });
        
        $upload.addClass('state-' + state);
        updateTotalProgress();
    });
})(jQuery);
