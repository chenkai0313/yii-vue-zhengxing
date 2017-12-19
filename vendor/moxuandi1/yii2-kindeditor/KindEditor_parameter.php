<?php
/**
 * KindEditor 编辑器初始化参数
 * width   string  编辑器的宽度, 可以设置px或%, 比textarea输入框样式表宽度优先度高
 * height  string  编辑器的高度, 只能设置px, 比textarea输入框样式表宽度优先度高
 * minWidth  int   指定编辑器最小宽度，单位为px, 默认值: 650
 * minHeight int   指定编辑器最小高度，单位为px, 默认值: 100
 * items   array   配置编辑器的工具栏，其中”/”表示换行，”|”表示分隔符，默认配置参看本文末尾
 * noDisableItems  array  designMode 为false时，要保留的工具栏图标，默认值: [‘source’, ‘fullscreen’]
 * filterMode  Boolean   true时根据 htmlTags 过滤HTML代码，false时允许输入任何代码, 默认值: true
 * htmlTags    Object    指定要保留的HTML标记和属性。Object的key为HTML标签名，value为HTML属性数组，”.”开始的属性表示style属性，默认配置参看本文末尾
 * wellFormatMode   Boolean   true时美化HTML数据，默认值: true
 * resizeType   Int  2或1或0，2时可以拖动改变宽度和高度，1时只能改变高度，0时不能拖动。默认值: 2
 * themeType   String   指定主题风格，可设置”default”、”simple”，指定simple时需要引入simple.css。默认值: “default”
 * langType  String  指定语言，可设置”en”、”zh-CN”，需要引入lang/[langType].js。默认值: “zh-CN”
 * designMode  Boolean   可视化模式或代码模式，默认值: true
 * fullscreenMode  Boolean   true时加载编辑器后变成全屏模式。默认值: false
 * basePath  String   指定编辑器的根目录路径。默认值: 根据kindeditor.js文件名自动获取
 * themesPath  String 指定编辑器的themes目录路径。默认值: basePath + ‘themes/’
 * pluginsPath   String   指定编辑器的plugins目录路径。默认值: basePath + ‘plugins/’
 * langPath   String   指定编辑器的lang目录路径。默认值: basePath + ‘lang/’
 * minChangeSize   String   undo/redo文字输入最小变化长度，当输入的文字变化小于这个长度时不会添加到undo记录里。默认值: 5
 * urlType   String   改变站内本地URL，可设置”“、”relative”、”absolute”、”domain”。空为不修改URL，relative为相对路径，absolute为绝对路径，domain为带域名的绝对路径。默认值: “”
 * newlineTag   String  设置回车换行标签，可设置”p”、”br”。默认值: “p”
 * pasteType  Int  设置粘贴类型，0:禁止粘贴, 1:纯文本粘贴, 2:HTML粘贴，默认值: 2
 * dialogAlignType  String   设置弹出框(dialog)的对齐类型，可设置”“、”page”，指定page时按当前页面居中，指定空时按编辑器居中。默认值: “page”
 * shadowMode   Boolean   true时弹出层(dialog)显示阴影。默认值: true
 * zIndex   Int  指定弹出层的基准z-index。默认值: 811213
 * useContextmenu    Boolean    true时使用右键菜单，false时屏蔽右键菜单。默认值: true
 * syncType   String   同步数据的方式，可设置”“、”form”，值为form时提交form时自动同步，空时不会自动同步。默认值: “form”
 * indentChar  String  wellFormatMode 为true时，HTML代码缩进字符。默认值: “\t”
 * cssPath  String|Array  指定编辑器iframe document的CSS文件，用于设置可视化区域的样式。默认值: 空
 * cssData   String   指定编辑器iframe document的CSS数据，用于设置可视化区域的样式。默认值: 空
 * bodyClass  String   指定编辑器iframe document body的className。默认值: “ke-content”
 * colorTable  Array   指定取色器里的颜色。默认配置参看本文末尾
 * afterCreate   Function  设置编辑器创建后执行的回调函数
 * afterChange   Function  编辑器内容发生变化后执行的回调函数
 * afterTab  Function  按下TAB键后执行的的回调函数。默认值: 插入4个空格的函数
 * afterFocus   Function  编辑器聚焦(focus)时执行的回调函数
 * afterBlur  Function  编辑器失去焦点(blur)时执行的回调函数
 * afterUpload  Function 上传文件后执行的回调函数
 * uploadJson   String  指定上传文件的服务器端程序。默认值: basePath + ‘php/upload_json.php’
 * fileManagerJson  String   指定浏览远程图片的服务器端程序。默认值: basePath + ‘php/file_manager_json.php’
 * allowPreviewEmoticons   Boolean  true时鼠标放在表情上可以预览表情。默认值: true
 * allowImageUpload   Boolean   true时显示图片上传按钮。默认值: true
 * allowFlashUpload   Boolean   true时显示Flash上传按钮。默认值: true
 * allowMediaUpload  Boolean  true时显示视音频上传按钮。默认值: true
 * allowFileUpload   Boolean  true时显示文件上传按钮。默认值: true
 * allowFileManager   Boolean  true时显示浏览远程服务器按钮。默认值: false
 * fontSizeTable   Array  指定文字大小。默认值: ['9px', '10px', '12px', '14px', '16px', '18px', '24px', '32px']
 * imageTabIndex   Int  图片弹出层的默认显示标签索引。默认值: 0
 * formatUploadUrl   Boolean   false时不会自动格式化上传后的URL。默认值: true
 * fullscreenShortcut  Boolean  false时禁用ESC全屏快捷键。默认值: false
 * extraFileUploadParams  Array 上传图片、Flash、视音频、文件时，支持添加别的参数一并传到服务器。默认值: {}
 * filePostName   String  指定上传文件form名称。默认值: imgFile
 * fillDescAfterUploadImage   Boolean  true时图片上传成功后切换到图片编辑标签，false时插入图片后关闭弹出框。默认值: false
 * afterSelectFile   Function   从图片空间选择文件后执行的回调函数。
 * pagebreakHtml  String  可指定分页符HTML。默认值: <hr style=”page-break-after: always;” class=”ke-pagebreak” />
 * allowImageRemote   Boolean   true时显示网络图片标签，false时不显示。默认值: true
 * autoHeightMode   Boolean  值为true，并引入autoheight.js插件时自动调整高度。默认值: false
 * fixToolBar   Boolean   值为true，并引入fixtoolbar.js插件时固定工具栏位置。默认值: false
 * */

/**
 * items 默认参数, 其中”/”表示换行，”|”表示分隔符
 * 	[
 *  	'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste',
 *      'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright',
 *      'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript',
 *      'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/',
 *      'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold',
 *      'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image', 'multiimage',
 *      'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak',
 *      'anchor', 'link', 'unlink', '|', 'about'
 *	]
 * 	参数说明:
 * source 	HTML代码
 * preview 	预览
 * undo 	后退
 * redo 	前进
 * cut 	剪切
 * copy 	复制
 * paste 	粘贴
 * plainpaste 	粘贴为无格式文本
 * wordpaste 	从Word粘贴
 * selectall 	全选
 * justifyleft 	左对齐
 * justifycenter 	居中
 * justifyright 	右对齐
 * justifyfull 	两端对齐
 * insertorderedlist 	编号
 * insertunorderedlist 	项目符号
 * indent 	增加缩进
 * outdent 	减少缩进
 * subscript 	下标
 * superscript 	上标
 * formatblock 	段落
 * fontname 	字体
 * fontsize 	文字大小
 * forecolor 	文字颜色
 * hilitecolor 	文字背景
 * bold 	粗体
 * italic 	斜体
 * underline 	下划线
 * strikethrough 	删除线
 * removeformat 	删除格式
 * image 	图片
 * flash 	Flash
 * media 	视音频
 * table 	表格
 * hr 	插入横线
 * emoticons 	插入表情
 * link 	超级链接
 * unlink 	取消超级链接
 * fullscreen 	全屏显示
 * about 	关于
 * print 	打印
 * code 	插入程序代码
 * map 	Google地图
 * baidumap 	百度地图
 * lineheight 	行距
 * clearhtml 	清理HTML代码
 * pagebreak 	插入分页符
 * quickformat 	一键排版
 * insertfile 	插入文件
 * template 	插入模板
 * anchor 	插入锚点
 */

/**
 * htmlTags 默认参数, Object的key为HTML标签名，value为HTML属性数组，”.”开始的属性表示style属性
 * 	{
 *  	font : ['color', 'size', 'face', '.background-color'],
 *      span : [
 *      	'.color', '.background-color', '.font-size', '.font-family', '.background',
 *          '.font-weight', '.font-style', '.text-decoration', '.vertical-align', '.line-height'
 *      ],
 *      div : [
 *          'align', '.border', '.margin', '.padding', '.text-align', '.color',
 *          '.background-color', '.font-size', '.font-family', '.font-weight', '.background',
 *          '.font-style', '.text-decoration', '.vertical-align', '.margin-left'
 *      ],
 *      table: [
 *          'border', 'cellspacing', 'cellpadding', 'width', 'height', 'align', 'bordercolor',
 *          '.padding', '.margin', '.border', 'bgcolor', '.text-align', '.color', '.background-color',
 *          '.font-size', '.font-family', '.font-weight', '.font-style', '.text-decoration', '.background',
 *          '.width', '.height', '.border-collapse'
 *      ],
 *      'td,th': [
 *      	'align', 'valign', 'width', 'height', 'colspan', 'rowspan', 'bgcolor',
 *          '.text-align', '.color', '.background-color', '.font-size', '.font-family', '.font-weight',
 *          '.font-style', '.text-decoration', '.vertical-align', '.background', '.border'
 *      ],
 *      a : ['href', 'target', 'name'],
 *      embed : ['src', 'width', 'height', 'type', 'loop', 'autostart', 'quality', '.width', '.height', 'align', 'allowscriptaccess'],
 *      img : ['src', 'width', 'height', 'border', 'alt', 'title', 'align', '.width', '.height', '.border'],
 *      'p,ol,ul,li,blockquote,h1,h2,h3,h4,h5,h6' : [
 *      	'align', '.text-align', '.color', '.background-color', '.font-size', '.font-family', '.background',
 *          '.font-weight', '.font-style', '.text-decoration', '.vertical-align', '.text-indent', '.margin-left'
 *      ],
 *      pre : ['class'],
 *      hr : ['class', '.page-break-after'],
 *      br,tbody,tr,strong,b,sub,sup,em,i,u,strike,s,del' : []
 *	}
 */

/**
 * colorTable 默认参数
 * 	[
 *  	['#E53333', '#E56600', '#FF9900', '#64451D', '#DFC5A4', '#FFE500'],
 *      ['#009900', '#006600', '#99BB00', '#B8D100', '#60D978', '#00D5FF'],
 *      ['#337FE5', '#003399', '#4C33E5', '#9933E5', '#CC33E5', '#EE33EE'],
 *      ['#FFFFFF', '#CCCCCC', '#999999', '#666666', '#333333', '#000000']
 * 	]
 */
