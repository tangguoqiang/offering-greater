<%@page import="com.offering.common.constant.GloabConstant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="common/include.jsp"%>
<%if(userName == null){
	response.sendRedirect(baseUrl);
}%>
<body style="background-color:#ededeb">
	<div class="header">
		<div class="wrap">
			<div class="logo"></div>
			<div class="userinfo">
				<ul>
					<li>欢迎回来，<span id="showusername"><%if (userName != null ){%><%=userName%><%}%></span> <a href="javascript:void(0);" onClick="logout();">退出</a></li>
				</ul>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div>
		<img src="images/backgroud3.png" width="100%"/>
	</div>
	<div class="content" >
		<div class="avatar"></div>
		<div class="fill">
			<p>
				<label>姓名</label>
				<input id="nickname" value="老罗">
			</p>
			<p>
				<label>性别</label>
				<input type="radio" name="sex" value="1" checked="checked" />男 
				<input type="radio" name="sex" value="女" />女 
			</p>
			<p>
				<label>公司</label>
				<input id="company" value="锤子科技">
			</p>
			<p>
				<label>职位</label>
				<input id="job" value="CEO">
			</p>
			<p>
				<label>领域</label>
				<select id="specialty">
					<option value="互联网">互联网</option>
				</select>
			</p>
			<p>
				<label>大学</label>
				<select>
					<option>延边二中</option>
				</select>
			</p>
			<p>
				<label>是否成为一对一嘉宾</label>
				<input>
			</p>
			<div class="title">工作经历</div>
			<p style="height:120px">
				<textarea id="experience"></textarea>
			</p>
			<div class="title">心得</div>
			<p  style="height:120px">
				<textarea  id="tags"></textarea>
			</p>
			<a class="button2" id="create">提交申请</a>
		</div>
	</div>
	<div class="footer">
		<img src="images/down.png" width="100%"></div>
	</div>
	<div class="mask" id="mask"></div>
	<div class="model" id="dialog">
		<div class="close"></div>
		<div class="dialogcontent">
			<div class="dialogtitle">
				<img src="images/backgroud.png" width="100%"/>
				<div class="loginbtn">登录</div>
				<div class="registerbtn">注册</div>
			</div>
			<div class="">
				<div class="logindiv">
					<p style="margin-top:40px">
						<label for="account" class="label-account"></label>
						<input name="account" type="text" class="input" autocomplete="off" placeholder="邮箱或手机号"></input>
					</p>
					<p>
						<label for="password" class="label-password"></label>
						<input name="password" type="password" class="input" autocomplete="off" placeholder="密码"></input>
					</p>
					<p  style="line-height: 25px;">
						<a href="javascirpt:void(0);" class="button">登录</a>
					</p>
				</div>
				<div class="registerdiv">
					<p style="margin-top:40px">
						<label for="username" class="label-phone"></label>
						<input name="username" type="text" class="input" autocomplete="off" placeholder="手机号"></input>
					</p>
					<p>
						<label for="captcha" class="label-captcha"></label>
						<input name="captcha" type="text" class="input" autocomplete="off" placeholder="验证码"></input>
					</p>
					<p>
						<label for="password" class="label-password"></label>
						<input name="password" type="password" class="input" autocomplete="off" placeholder="密码，至少6位"></input>
					</p>
					<p style="line-height: 25px;">
						<a href="javascirpt:void(0);"  class="button">注册</a>
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
var isClick = false;
$(document).ready(function(){
	$('#create').bind('click',function(){
		$.ajax({
			type:'post',
			url:"<%=baseUrl%>"+'/becomeGreater',
			data:{
				username:'<%=userName%>',
				nickname:$("#nickname").val(),
				company:$("#company").val(),
				specialty:$("#specialty").val(),
				experience:$("#experience").val(),
				tags:$("#tags").val(),
				job:$("#job").val(),
			},
			dataType:'json',
			success:function(data){
				if(data.success){
					alert('提交成功！');
				}else{
					alert(data.msg);
				}
			},
			error:function(textStatus,errorThrown){
			}
		});
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
</script>
</body>
</html>