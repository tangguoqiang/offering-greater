<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="common/include.jsp"%>
<title>Offering</title>
<style type="text/css">
.nav-tabs>li.active>a, .nav-tabs>li.active>a:hover, .nav-tabs>li.active>a:focus
	{
	color:#2a6496;
	background-color: #eee
	cursor: default;
	border: 1px solid #ddd;
	border-bottom-color: transparent
}

.nav-tabs>li>a {
	color:#555;
}
</style>
</head>
<body style="background: #ededeb;">
	<nav class="navbar navbar-default navbar-fixed-top">
	    <div class="navbar-header" style="margin-left: 10%;">
	      <a class="navbar-brand" href="<%=baseUrl%>" >
	        <img alt="offering" src="images/logo.png">
	      </a>
	    </div>
	    <div class="collapse navbar-collapse" style="margin-top: 10px;margin-right: 5%;">
	      <ul id="nologin" class="nav navbar-nav navbar-right" style="display: none;">
	        <li><a href="javascript:void(0);" onclick="downloadApp();">APP下载</a></li>
	        <li><a href="javascript:void(0);" onClick="showDialog(1);">成为大拿</a></li>
	        <li style="margin-right: -20px;"><a href="javascript:void(0);" onClick="showDialog(2);">注册</a></li>
			<li><a href="javascript:void(0);" onClick="showDialog(1);">登录</a></li>
	      </ul>
	      <ul id="userinfo" class="nav navbar-nav navbar-right" style="display: none;">
	        <li><a href="javascript:void(0);" onclick="downloadApp();">APP下载</a></li>
	        <li><a id="greater" href="javascript:void(0);">成为大拿</a></li>
			<li><a id="activity" href="javascript:void(0);">发布活动</a></li>
			<li>
				<p class="navbar-text navbar-right" onfocus="e.preventDefault(); ">欢迎回来： <span id="showusername"></span> </p>
				<!-- <img id="icon" class="img-circle" style="width:6%;cursor: pointer;" src="" alt=""/> -->
			</li>
			<li>
				<a href="javascript:void(0);">
					<img id="icon" class="img-circle" style="margin-top: -8px;height:40px;width:40px;cursor: pointer;" alt=""/>
				</a>
			</li>
			<li id="loginOut"><a href="javascript:void(0);" onClick="logout();">退出</a></li>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	<div id="mainDiv" style="padding-top: 70px;"></div>
	<div class="footer"></div>
	
	<div class="modal fade" id="loginModal">
	  <div class="modal-dialog" style="width: 305px;">
	    <div class="modal-content">
	      <div class="modal-header" style="background-image: url('./images/regidter_bg.png');height: 164px;">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <div class="logo"></div>
	      </div>
	      <div class="modal-body" style="margin-top: -50px;">
	      	 <ul id="myTabs" class="nav nav-tabs" role="tablist" style="border: 0px;">
			    <li role="presentation" class="active" style="float: left;margin-left: 30px;">
			    	<a style="border: 0px;background: none;font-weight: bold;" href="#login" aria-controls="login" role="tab" data-toggle="tab">登陆</a>
			    </li>
			    <li role="presentation" style="float: right;margin-right: 30px;font-weight: bold;">
			    	<a href="#register" style="border: 0px;background: none;" aria-controls="register" role="tab" data-toggle="tab">注册</a>
			    </li>
			  </ul>
	        <div class="tab-content" style="height: 240px;">
			  <div role="tabpanel" class="tab-pane fade in active" style="border: false;" id="login">
			  	<div class="logindiv">
					<p class="loginerror"></p>
					<p>
						<label for="account" class="label-account"></label>
						<input name="account" id="account" type="text" autocomplete="off" placeholder="手机号"></input>
					</p>
					<p>
						<label for="password" class="label-password"></label>
						<input name="password"  id="password" type="password" class="input" autocomplete="off" placeholder="密码"></input>
					</p>
					<p  style="line-height: 25px;">
						<a href="javascript:void(0);" class="button" onclick="login();">登录</a>
					</p>
				</div>
			  </div>
			  <div role="tabpanel" class="tab-pane fade" style="border: false;" id="register">
			  	<div class="registerdiv">
					<p class="regerror"></p>
					<p>
						<label for="phone" class="label-phone"></label>
						<input name="phone" id="phone" type="text" class="input" autocomplete="off" placeholder="手机号"></input>
						<a style="position: absolute;left: 170px;top:2px;color:#fecb18;width: 100px;Z-index:1050;margin-right: 5px;" href="javascript:void(0);" id="getcaptcha">获取验证码</a>
					</p>
					<p>
						<label for="captcha" class="label-captcha"></label>
						<input name="captcha" id="captcha" type="text" class="input" autocomplete="off" placeholder="验证码"></input>
					</p>
					<p>
						<label for="repassword" class="label-password"></label>
						<input name="repassword" id="repassword" type="password" class="input" autocomplete="off" placeholder="密码，至少6位"></input>
					</p>
					<p style="line-height: 25px;">
						<a href="javascript:void(0);"  class="button" onclick="register();">注册</a>
					</p>
				</div>
			  </div>
			</div>
			<!-- <div class="otherlogin"></div> -->
			<!-- <div class="otherlist"></div> -->
	      </div>
	    </div>
	  </div>
	</div>
<script type="text/javascript">
var USER_GREATER = "<%=GloabConstant.USER_TYPE_GREATER%>";
$(document).ready(function(){
	if(userName == null || userName == "null"){
		$('#nologin').show();
		$('#userinfo').hide();
	}else{
		$('#nologin').hide();
		$('#userinfo').show();
		$('#showusername').html(userName);
		if('<%=url%>' != "")
			$("#icon").attr("src",serverUrl+ '<%=url%>');
		
		if(USER_GREATER == userType){
			$("#activity").show();
			$("#greater").hide();
		}else{
			$("#activity").hide();
			$("#greater").show();
		}
	}
	
	$("#mainDiv").load("pages/index.html");
	
	$("#greater").on("click",function(){
		$("#mainDiv").load("pages/greater.html");
	});
	
	$("#activity").on("click",function(){
		$("#mainDiv").load("pages/activity.html");
	});
	
	$("#getcaptcha").on("click",function(){
		var phone = $("#phone").val();
		if(phone == ''){
			$('.regerror').html('手机号不能为空');
			return false;
		}
		$.ajax({
			type:'post',
			url:"<%=baseUrl%>"+'/getCode',
			data:{
				phone:phone,
				type:0
			},
			dataType:'json',
			success:function(data){
				$('.regerror').html('验证码获取成功，请在一分钟内完成注册!');
			},
			error:function(textStatus,errorThrown){
				if(data.code != 0)
					$('.regerror').html(data.msg);
			}
		});
	});
	
	$("#icon").on("click",function(){
		$("#mainDiv").load("pages/userInfo.html");
	});
});

function showDialog(type){
	$("#loginModal").modal("show");
	if(type == 1){
		$('#myTabs a:first').tab('show');
	}else{
		$('#myTabs a:last').tab('show');
	}
}

function login() {
	var phone = $("#account").val();
	var password = $("#password").val();
	if(phone == ''){
		$('.loginerror').html('手机号不能为空');
		return false;
	}
	if(password == ''){
		$('.loginerror').html('密码不能为空');
		return false;
	}
	$.ajax({
		type:'post',
		url:"<%=baseUrl%>"+'/login',
		data:{
			phone:phone,
			password:password
		},
		dataType:'json',
		success:function(data){
			if(data.success){
				window.location.reload();
			}else{
				$('.loginerror').html(data.msg);
			}
		},
		error:function(textStatus,errorThrown){
		}
	});
	
}

function register() {
	var phone = $("#phone").val();
	var captcha = $("#captcha").val();
	var password = $("#repassword").val();
	if(phone == ''){
		$('.regerror').html('手机号不能为空');
		return false;
	}
	if(captcha == ''){
		$('.regerror').html('验证码不能为空');
		return false;
	}
	if(password == ''){
		$('.regerror').html('密码不能为空');
		return false;
	}
	$.ajax({
		type:'post',
		url:"<%=baseUrl%>"+'/register',
		data:{
			phone:phone,
			code:captcha,
			password:password
		},
		dataType:'json',
		success:function(data){
			if(data.success){
				window.location.reload();
			}else{
				$('.regerror').html(data.msg);
			}
		},
		error:function(textStatus,errorThrown){
		}
	});
}

function downloadApp(){
	window.open("http://www.myoffering.cn");
}

function logout(){
	$.ajax({
        async:false,
        type:"post",
        url:baseUrl+"/logout",
        data:{
        },
        dataType:"json",
        success : function(data){
        	if(data.success){
        		window.location.reload();
        	}
        },
        error:function(XMLHttpRequest, textStatus, errorThrown){
        }
    });
}
</script>
</body>
</html>
