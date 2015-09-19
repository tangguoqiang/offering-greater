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
	<div class="header">
		<div class="wrap">
			<div class="logo"></div>
			<div class="userinfo">
				<ul id="nologin" <%if (userName != null ){%>style="display:none;"<%}%>>
					<li style="margin-right:50px"><a href="javascript:void(0);" onClick="showDialog(1);">成为大拿</a></li>
					<li><a href="javascript:void(0);" onClick="showDialog(2);">注册</a></li>
					<li style="margin:0px 5px">|</li>
					<li><a href="javascript:void(0);" onClick="showDialog(1);">登录</a></li>
				</ul>
				<ul id="userinfo" <%if (userName == null){%>style="display:none;"<%}%>>
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
	<div class="banner-box">
		<div class="bd">
	        <ul>          	    
	            <li>
	                <div class="m-width">
	                	<a href="javascript:void(0);"><img src="<%=baseUrl%>/images/backgroud.png" width="100%"/></a>
	                </div>
	            </li>
	            <li>
	                <div class="m-width">
	                	<a href="javascript:void(0);"><img src="<%=baseUrl%>/images/backgroud3.png" width="100%"/></a>
	                </div>
	            </li>
	            <li>
	                <div class="m-width">
	                	<a href="javascript:void(0);"><img src="<%=baseUrl%>/images/backgroud.png" width="100%"/></a>
	                </div>
	            </li>
	        </ul>
	    </div>
	    <div class="banner-btn">
	        <a class="prev" href="javascript:void(0);"></a>
	        <a class="next" href="javascript:void(0);"></a>
	        <div class="hd"><ul></ul></div>
	    </div>
	</div>
	<div class="content">
		<div class="wrap kouhao">
			<div class="index-lighter"></div>
			<div class="index-model"></div>
			<div class="index-rich"></div>
		</div>
		<div class="line">
		</div>
		<div class="companyinfo">
			<div class="company tencent"></div>
			<div class="company baidu"></div>
			<div class="company huawei"></div>
			<div class="company alibaba"></div>
			<div class="company netease"></div>
		</div>
		<div class="waitforyou"></div>
		<div class="danalist">
			<div class="dana mayun"></div>
			<div class="dana mayun"></div>
			<div class="dana mayun"></div>
			<div class="dana mayun"></div>
			<div class="dana mayun"></div>
		</div>
		<div class="join"></div>
		<div class="shareex"></div>
	</div>
	<div class="footer">
		<img src="<%=baseUrl%>/images/down.png" width="100%"></div>
	</div>
	<div class="mask" id="mask"></div>
	<div class="model" id="dialog">
		<div class="close"></div>
		<div class="dialogcontent">
			<div class="dialogtitle">
				<img src="<%=baseUrl%>/images/backgroud.png" width="100%"/>
				<div class="loginbtn">登录</div>
				<div class="registerbtn">注册</div>
			</div>
			<div class="">
				<div class="logindiv">
					<p style="margin-top:40px">
						<label for="account" class="label-account"></label>
						<input name="account" id="account" type="text" class="input" autocomplete="off" placeholder="邮箱或手机号"></input>
					</p>
					<p>
						<label for="password" class="label-password"></label>
						<input name="password"  id="password" type="password" class="input" autocomplete="off" placeholder="密码"></input>
					</p>
					<p  style="line-height: 25px;">
						<a href="javascript:void(0);" class="button" onclick="login();">登录</a>
					</p>
				</div>
				<div class="registerdiv">
					<p style="margin-top:40px">
						<label for="phone" class="label-phone"></label>
						<input name="phone" id="phone" type="text" class="input" autocomplete="off" placeholder="手机号"></input>
					</p>
					<p>
						<label for="captcha" class="label-captcha"></label>
						<input name="captcha" type="text" class="input" autocomplete="off" placeholder="验证码"></input>
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
				<div class="otherlist">
					<div class="logintype qq"></div>
					<div class="logintype wechat"></div>
					<div class="logintype weibo"></div>
				</div>
			</div>
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function(){
	$(".prev,.next").hover(function(){
		$(this).stop(true,false).fadeTo("show",0.9);
	},function(){
		$(this).stop(true,false).fadeTo("show",0.4);
	});
	
	$(".banner-box").slide({
		titCell:".hd ul",
		mainCell:".bd ul",
		effect:"fold",
		interTime:3500,
		delayTime:500,
		autoPlay:true,
		autoPage:true, 
		trigger:"click" 
	});	
	$('.close').bind('click',function(){
		$("#mask").hide();
		$('#dialog').hide();
	});

	$('.loginbtn').bind('click',function(){
		$('.logindiv').show();
		$('.registerdiv').hide();
	});

	$('.registerbtn').bind('click',function(){
		$('.logindiv').hide();
		$('.registerdiv').show();
	});
});
//兼容火狐、IE8
function showMask(){
	$("#mask").css("height",$(document).height());
	$("#mask").css("width",$(document).width());
	$("#mask").show();
}
//让指定的DIV始终显示在屏幕正中间
function dialog(type){ 
	var top = ($(window).height() - $("#dialog").height())/2; 
	var left = ($(window).width() - $("#dialog").width())/2; 
	var scrollTop = $(document).scrollTop(); 
	var scrollLeft = $(document).scrollLeft(); 
	if(type == 1){
		$('.logindiv').show();
		$('.registerdiv').hide();
	}else{
		$('.registerdiv').show();
		$('.logindiv').hide();
	}
	$('#dialog').css( { position : 'fixed', 'top' : top + scrollTop, left : left + scrollLeft } ).show();
}
function showDialog(type){
	showMask();
	dialog(type);
}

function login() {
	$.ajax({
		type:'post',
		url:"<%=baseUrl%>"+'/login',
		data:{
			phone:$("#account").val(),
			password:$("#password").val()
		},
		dataType:'json',
		success:function(data){
			if(data.success){
				$('#showusername').html(data.nickname);
				if(data.type == 2){
					$("#activity").show();
					$("#greater").hide();
				}
				$('#nologin').hide();
				$('#userinfo').show();
				$("#mask").hide();
				$('#dialog').hide();
			}else{
				alert(data.msg);
			}
		},
		error:function(textStatus,errorThrown){
		}
	});
	
}

function register() {
	$.ajax({
		type:'post',
		url:"<%=baseUrl%>"+'/register',
		data:{
			phone:$("#phone").val(),
			captcha:$("#captcha").val(),
			password:$("#repassword").val()
		},
		dataType:'json',
		success:function(data){
			if(data.success){
				alert('注册成功');
				$("#mask").hide();
				$('#dialog').hide();
			}else{
				alert(data.msg);
			}
		},
		error:function(textStatus,errorThrown){
		}
	});
}
</script>
</body>
</html>