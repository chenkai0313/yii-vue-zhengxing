<?php
	use yii\helpers\Html;
	?>
<html lang="zh-cn">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
		<title>错误提示</title>
		<meta name="format-detection" content="telephone=no, address=no">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<!-- apple devices fullscreen -->
		<meta name="apple-touch-fullscreen" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
		<meta name="keywords" content="">
		<!--<link rel="shortcut icon" href="http://mp.fjzlh.net/attachment/images/global/wechat.jpg">-->

			<?=Html::cssFile('@web/css/bootstrap.min.css') ?>
			<?=Html::cssFile('@web/css/common.min.css') ?>

		<body class="">
			<div class="container container-fill">
				<div class="jumbotron clearfix alert alert-danger" style="width:80%;margin:0 auto;margin-top:100px;">
					<div class="row">
						<div class="col-xs-12 col-sm-3 col-lg-2">
							<i class="fa fa-5x fa-times-circle"></i>
						</div>
						<div class="col-xs-12 col-sm-8 col-md-9 col-lg-10">
							<h2></h2>
							<p><?php echo $message ?></p>
							<p>
								<a href="<?php echo $href?>"><span id="jumpTo">3</span>秒后系统会自动跳转</a> 
							</p>
							<p>[
								<a href="javascript:history.go(-1);">点击这里返回上一页</a>]
							</p>
						</div>
					</div>
				</div>
				<div class="text-center footer" style="margin:10px 0; width:100%; text-align:center; word-break:break-all;">
					&nbsp;&nbsp; </div>
				
			</div>
			<style>
				h5 {
					color: #555;
				}
			</style>
			<script type="text/javascript">       
function countDown(secs,surl){           
 var jumpTo = document.getElementById('jumpTo');  
 jumpTo.innerHTML=secs;    
 if(--secs>0){       
     setTimeout("countDown("+secs+",'"+surl+"')",1000);       
     }       
 else{         
     location.href=surl;       
     -ma  
     }       
 }       
 countDown(<?php echo $time?>,"<?php echo $href?>");
</script>   
		</body>

</html>