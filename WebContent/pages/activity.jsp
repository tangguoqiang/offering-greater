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
</head>
<body style="background: #ededeb;">
	<div class="header" style="position:static;background: #ffffff;">
		<div class="wrap">
			<div class="logo"></div>
			<div class="userinfo">
				<ul>
					<li style="margin-right:50px"><a href="<%=baseUrl%>/activity">发布活动</a></li>
					<li>欢迎回来，<span id="showusername"><%if (userName != null ){%><%=userName%><%}%></span> <a href="javascript:void(0);" onClick="logout();">退出</a></li>
				</ul>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="activitycontent">
		<div class="wrap">
			<div class="left">
				<div id="baseinfo" class="baseinfo">
					<div class="avatar" style="margin:0px auto 20px auto;"></div>
					<div id="name" class="name"></div>
					<p id="company"></p>
					<p id="post"></p>
				</div>
				<div id="work" class="work">
					<div class="title">工作经历</div>
				</div>
				<div id="job" class="work">
					<div class="title">心得</div>
				</div>
			</div>
			<div class="right">
				<ul id="activities">
					<li>
						<div class ="add-activity-btn">
							<div class="add"></div>
							<div class="addtext">发布活动</div>
						</div>
					</li>
					<!-- <li>
						<img src="images/cover1.png" width="285" height="180"/>
						<div class="approve"></div>
						<div class="title">老罗装逼自传</div>
						<div class="info"><span class="address">上海展览中心</span><span  class="time">2015-07-01 PM 22:00<span></div>
					</li>
					<li>
						<img src="images/cover2.png" width="285" height="180"/>
						<div class="title">老罗装逼自传</div>
						<div class="info"><span class="address">上海展览中心</span><span  class="time">2015-07-01 PM 22:00<span></div>
					</li>
					<li>
						<img src="images/cover3.png" width="285" height="180"/>
						<div class="title">老罗装逼自传</div>
						<div class="info"><span class="address">上海展览中心</span><span  class="time">2015-07-01 PM 22:00<span></div>
					</li> -->
				</ul>
			</div>
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
	<div class="model2" id="dialog2">
		<div class="close2"></div>
		<div class="dialogcontent">
			<div class="dialogtitle">
				<img src="images/cover3.png" width="100%"/>
			</div>
			<div class="">
				<p>
					<input id="title" name="title" type="text" class="input" autocomplete="off" placeholder="分享主题"></input>
				</p>
				<p>
					<input id="time" name="time" type="text" class="input" autocomplete="off" placeholder="时间"></input>
				</p>
				<p>
					<input id="address" name="address" type="text" class="input" autocomplete="off" placeholder="地点"></input>
				</p>
				<p>
					<textarea id="remark" placeholder="主题说明"></textarea>
				</p>
			</div>
			<div id="releaseBtn" class="send-activity">发布</div>
		</div>
	</div>
<script type="text/javascript">
$(document).ready(function(){
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

	$('.add-activity-btn').bind('click',function(){
		showMask();
		var top = ($(window).height() - $("#dialog2").height())/2; 
		var left = ($(window).width() - $("#dialog2").width())/2; 
		var scrollTop = $(document).scrollTop(); 
		var scrollLeft = $(document).scrollLeft(); 
		$('#dialog2').css( { position : 'absolute', 'top' : top + scrollTop, left : left + scrollLeft } ).show();
	});
	$('.close2').bind('click',function(){
		$("#mask").hide();
		$('#dialog2').hide();
	});
	//发布活动
	$('#releaseBtn').bind('click',realeaseActivity);
	loadGreaterInfo();
	//加载活动数据
	loadActivities();
});

function loadGreaterInfo(){
	$.ajax({
		type:'post',
		url:"<%=baseUrl%>"+'/greater/getGreaterInfo',
		data:{
			id:'<%=userId%>'
		},
		dataType:'json',
		success:function(data){
			$("#name").text(data.nickname);
			$("#company").text(data.company);
			$("#post").text(data.post);
			var tag = data.tags;
			if(tag != null)
			{
				var tags = tag.split(",");
				for(var i=0,len=tags.length;i<len;i++)
				{
					$("#baseinfo").append("<p>"+tags[i]+"</p>");
				}
			}
			
			$("#work").append("<p>"+data.experience+"</p>");
			$("#job").append("<p>"+data.job+"</p>");
		},
		error:function(textStatus,errorThrown){
		}
	});
}

function loadActivities(){
	$.ajax({
		type:'post',
		url:"<%=baseUrl%>"+'/activity/listActivities',
		data:{
			createrId:'<%=userId%>'
		},
		dataType:'json',
		success:function(data){
			$("#activities li").each(function(i,el){
				if(i != 0)
					$(el).remove();
			});
			var recs = data.records;
			var rec;
			for(var i = 0,len = recs.length;i<len;i++)
			{
				rec=recs[i];
				$("#activities").append("<li><img src=\"\" width=\"285\" height=\"180\"/>"
						+"<div class=\"approve\"></div>"
						+"<div class=\"title\">"+rec.title +"</div>"
						+"<div class=\"info\"><span class=\"address\">" + rec.address +"</span>"
						+"<span  class=\"time\">"+rec.startTime+"</span></div></li>");
			}
		},
		error:function(textStatus,errorThrown){
		}
	});
}

function realeaseActivity(){
	$.ajax({
		type:'post',
		url:"<%=baseUrl%>"+'/activity/releaseActivity',
		data:{
			title:$("#title").val(),
			startTime:$("#time").val(),
			address:$("#address").val(),
			remark:$("#remark").val(),
			createrId:'<%=userId%>'
		},
		dataType:'json',
		success:function(data){
			if(data.success){
				loadActivities();
				$("#mask").hide();
				$('#dialog2').hide();
			}else{
				alert(data.msg);
			}
		},
		error:function(textStatus,errorThrown){
		}
	});
}
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