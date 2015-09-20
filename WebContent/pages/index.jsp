<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="common/include.jsp"%>
<title>Offering</title>
</head>
<body>
	<div id="header" class="header">
		<div class="wrap">
			<a class="logo" href="<%=baseUrl%>"></a>
			<div class="userinfo">
				<ul id="nologin" <%if (userName != null ){%>style="display:none;"<%}%>>
					<li style="margin-right:25px">
				    	<a href="javascript:void(0);" onclick="downloadApp();">APP下载</a>
				    </li>
					<li style="margin-right:50px"><a href="javascript:void(0);" onClick="showDialog(1);">成为大拿</a></li>
					<li><a href="javascript:void(0);" onClick="showDialog(2);">注册</a></li>
					<li style="margin:0px 5px">|</li>
					<li><a href="javascript:void(0);" onClick="showDialog(1);">登录</a></li>
				</ul>
				<ul id="userinfo" <%if (userName == null){%>style="display:none;"<%}%>>
				    <li style="margin-right:25px">
				    	<a href="javascript:void(0);" onclick="downloadApp();">APP下载</a>
				    </li>
					<li style="margin-right:50px">
						<a href="<%=baseUrl%>/activity" id="activity" <%if ("1".equals(userType)){%>style="display:none;"<%}%>>发布活动</a>
						<a href="<%=baseUrl%>/greater" id="greater" <%if ("2".equals(userType)){%>style="display:none;"<%}%>>成为大拿</a>
					</li>
					<li>欢迎回来，<span id="showusername"><%if (userName != null ){%><%=userName%><%}%></span> <a href="javascript:void(0);" onClick="logout();">退出</a></li>
				</ul>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="banner">
		<div id="slides">
			<ul class="bxslider">
			  <li><img src="<%=baseUrl%>/images/1-offering-bg1.png" /></li>
			  <li><img src="<%=baseUrl%>/images/1-offering-bg2.png"/></li>
			  <li><img src="<%=baseUrl%>/images/1-offering-bg3.png"/></li>
			</ul>
		</div>
	</div>
	<div class="content">
		<div class="wrap kouhao"></div>
		<div class="line"></div>
		<div class="companyinfo"></div>
		<div class="waitforyou"></div>
		<div class="danalist"></div>
		<%if (userName == null){%>
		<a href="javascript:void(0);" class="join gotologin"></a>
		<%}else if ("2".equals(userType)){%>
		<a href="<%=baseUrl%>/greater" class="join"></a>
		<%}else if ("1".equals(userType)){%>
		<a href="<%=baseUrl%>/activity" class="join"></a>
		<%}%>
		<div class="shareex"></div>
	</div>
	<div class="footer">
	</div>
<script  type="text/x-jquery-tmpl"  id="dialog">
<div class="model">
<div class="close"></div>
<div class="dialogcontent">
	<div class="dialogtitle">
		<div class="logo"></div>
		<div class="loginbtn">登录</div>
		<div class="registerbtn">注册</div>
		<div class="irrow" style="LEFTSTYLE"></div>
	</div>
	<div class="">
		<div class="logindiv" style="LOGINSTYLE">
			<p class="loginerror"></p>
			<p>
				<label for="account" class="label-account"></label>
				<input name="account" id="account" type="text" class="input" autocomplete="off" placeholder="手机号"></input>
			</p>
			<p>
				<label for="password" class="label-password"></label>
				<input name="password"  id="password" type="password" class="input" autocomplete="off" placeholder="密码"></input>
			</p>
			<p  style="line-height: 25px;">
				<a href="javascript:void(0);" class="button" onclick="login();">登录</a>
			</p>
		</div>
		<div class="registerdiv" style="REGSTYLE">
			<p class="regerror"></p>
			<p>
				<label for="phone" class="label-phone"></label>
				<input name="phone" id="phone" type="text" class="input" autocomplete="off" placeholder="手机号"></input>
				<a href="javascript:void(0);" id="getcaptcha">获取验证码</a>
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
		<div class="otherlogin"></div>
		<div class="otherlist"></div>
	</div>
</div>
</div>
</script>
<script type="text/javascript">
$(document).ready(function(){
	/**
	$('#slides').slides({
		preload: true,
		preloadImage: '<%=baseUrl%>/images/loading.gif',
		effect: 'slide',
		container: 'slides_container',
		pagination: true,
		fadeSpeed: 1500, 
		slideSpeed: 800,
		autoHeight: true,
		play: 5000
		
	});
	**/
	 $('.bxslider').bxSlider({
		  auto: true
	});
	 $(window).scroll(function () {
       if($(window).scrollTop() > 0){
    	   $("#header").addClass("headerfix");
       }else{
    	   $("#header").removeClass("headerfix");
       }
    });
	 
	$('.gotologin').bind('click',function(){
		var rel = $(this).attr('href');
		if(rel == 'javascript:void(0);'){
			showDialog(1);
		}
	}) ;
	
	$('.close').live('click',function(){
		TINY.box.hide();
	});

	$('.loginbtn').live('click',function(){
		$('.irrow').css({left: '40px'});
		$('.logindiv').show();
		$('.registerdiv').hide();
	});

	$('.registerbtn').live('click',function(){
		$('.irrow').css({left: '220px'});
		$('.logindiv').hide();
		$('.registerdiv').show();
	});
	
	$("#getcaptcha").live("click",function(){
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
				
			},
			error:function(textStatus,errorThrown){
				if(data.code != 0)
					$('.regerror').html(data.msg);
			}
		});
	});

});

function showDialog(type){
	var content = $('#dialog').html();
	var html ='';
	if(type == 1){
		html = content.replace("LOGINSTYLE", "display:block").replace("REGSTYLE", "display:none").replace("LEFTSTYLE", "left:40px");
	}else{
		html = content.replace("LOGINSTYLE", "display:none").replace("REGSTYLE", "display:block").replace("LEFTSTYLE", "left:220px");
	};
	TINY.box.show(html,0,0,0,1);
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
				$('#showusername').html(data.nickname);
				if(data.type == 2){
					$("#activity").show();
					$("#greater").hide();
					$(".gotologin").attr('href', "<%=baseUrl%>"+'/activity');
				}else{
					$("#activity").hide();
					$("#greater").show();
					$(".gotologin").attr('href', "<%=baseUrl%>"+'/greater');
				}
				$('#nologin').hide();
				$('#userinfo').show();
				TINY.box.hide();
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
				//$('.regerror').html('注册成功');
				//TINY.box.hide();
				window.location.href=baseUrl+"/greater";
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
</script>
</body>
</html>
