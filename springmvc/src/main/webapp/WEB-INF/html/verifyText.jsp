<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
        <title>verify插件demo</title>
		<link rel="stylesheet" type="text/css" href="../resources/css/verify.css">
		
		<script>
			(function () {
			  if (!window.Promise) {
				document.writeln('<script src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.1.1/es6-promise.min.js"><' + '/' + 'script>');
			  }
			})();
		</script>
		<style>
			.btn{
				border: none;
				outline: none;
				width: 300px;
				height: 40px;
				line-height: 40px;
				text-align: center;
				cursor: pointer;
				background-color: #409EFF;
				color: #fff;
				font-size: 16px;
				letter-spacing: 1em;
			}
		</style>
    </head>
    <body>
		<div class="box">
			<h1>verify---anji</h1>
			<p>前后端联合交互的验证码插件</p>
			
			<br><br>
	
			<h3>滑动嵌入式（slider-embed）</h3>
			<div id="mpanel1" >
			</div>
			<h3>滑动弹出式（slider-popup）</h3>
			用户名：<input type="text"  id="name" placeholder="用户名" /> <br/><br/>
			密&nbsp;&nbsp;&nbsp;码：<input type="text"  id="pass" placeholder="密码" /><br/><br/>
			<button class="btn" id='btn'>点击我</button>
			<div id="mpanel2" style="margin-top:50px;">
			</div>
			
			<h3>点选嵌入式（point-embed）</h3>
			<div id="mpanel3" style="margin-top:50px;">
			</div>
			<h3>点选弹出式（point-popup）</h3>
			<button class="btn" id='btn2'>点击我</button>
			<div id="mpanel4" style="margin-top:50px;">
			</div>
		</div>
		<script type="text/javascript" src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.1/jquery.js" ></script>
		<script src="../resources/js/crypto-js.js"></script>
		<script src="../resources/js/ase.js"></script>
        <script src="../resources/js/verify.js" ></script>
        
        <script>
			// 初始化验证码  嵌入式
        	$('#mpanel1').slideVerify({
				//baseUrl:'https://captcha.anji-plus.com/captcha-api',  //服务器请求地址, 默认地址为安吉服务器;
				// baseUrl:'http://localhost:8080/captcha_springmvc_war_exploded',  //local-spring-mvc;
				 baseUrl:'http://localhost:8081/captcha',  //local-spring-boot;
				mode:'fixed',
				imgSize : {       //图片的大小对象
		        	width: '400px',
		        	height: '200px',
				},
				barSize:{
					width: '400px',
					height: '40px',
				},
		        ready : function() {  //加载完毕的回调
		    	},
		        success : function(params) { //成功的回调
					// 返回的二次验证参数 合并到验证通过之后的逻辑 参数中回传服务器
					let data = {};
					data["params"] = params;
					data['user'] = "强哥";
					data['password'] = "1235656";
					$.ajax({
						async: true,
						url: "http://localhost:8081/captcha/captcha/verify.do",
						cache: true,
						type: "post",
						//data: params,
						data:JSON.stringify(data),
						contentType:"application/json",
						success: function (materData) {
							console.log(materData)
						},
						error: function (e) {
							console.log(e)
						}
					});

		        },
		        error : function(e) {        //失败的回调
				 	console.log(e)
		        }
			});
			
			// // 初始化验证码  弹出式
			$('#mpanel2').slideVerify({
				baseUrl:'https://captcha.anji-plus.com/captcha-api',  //服务器请求地址, 默认地址为安吉服务器;
				mode:'pop',     //展示模式
				containerId:'btn',//pop模式 必填 被点击之后出现行为验证码的元素id
				imgSize : {       //图片的大小对象,有默认值{ width: '310px',height: '155px'},可省略
					width: '400px',
					height: '200px',
				},
				barSize:{          //下方滑块的大小对象,有默认值{ width: '310px',height: '50px'},可省略
					width: '400px',
					height: '40px',
				},
				beforeCheck:function(){  //检验参数合法性的函数  mode ="pop"有效
					// var flag = true;
					// //实现: 参数合法性的判断逻辑, 返回一个boolean值
					// return flag
					var name = $("#name").val()
					var pass = $('#pass').val()
					console.log(name, pass);
					if (name == '' || pass == '') {
						alert("请完胜输入信息。")
						return false
					}else {
						return true
					}
					
				},
				ready : function() {},  //加载完毕的回调
				success : function(params) { //成功的回调
					// params为返回的二次验证参数 需要在接下来的实现逻辑回传服务器
					// 例如: login($.extend({}, params))  
				},
				error : function() {}        //失败的回调
			});
			
			// 初始化验证码  嵌入式
			$('#mpanel3').pointsVerify({
				baseUrl:'https://captcha.anji-plus.com/captcha-api',  //服务器请求地址, 默认地址为安吉服务器;
				// baseUrl:'http://10.108.12.12:8080',  //服务器请求地址, 默认地址为安吉服务器;
				mode:'fixed',
		    	imgSize : {
		        	width: '500px',
		        	height: '255px',
		        },
		        ready : function() {
		    	},
		        success : function(params) {
					//返回的二次验证参数 合并到验证通过之后的逻辑 参数中回传服务器
		        },
		        error : function() {
		        }
		        
		    });
			// // 初始化验证码  弹出式
		    $('#mpanel4').pointsVerify({
					// baseUrl: 'http://10.108.12.4:8088',
				baseUrl:'https://captcha.anji-plus.com/captcha-api',  //服务器请求地址, 默认地址为安吉服务器;
				containerId:'btn2', // pop模式 必填 被点击之后出现行为验证码的元素id
				mode:'pop',
				imgSize : {       //图片的大小对象
		        	width: '400px',
		        	height: '200px',
				},
		        ready : function() {
		    	},
		        success : function(params) {
					//返回的二次验证参数 合并到验证通过之后的逻辑 参数中回传服务器
		        },
		        error : function() {
		        }
		    });
        </script>
    </body>
 
</html>