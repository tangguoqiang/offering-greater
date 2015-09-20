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
				</ul>
			</div>
		</div>
	</div>
	<div class="footer">
		<img src="images/down.png" width="100%"></div>
	</div>
	<div class="mask" id="mask"></div>
	
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
Date.prototype.format = function(fmt)   
{ //author: meizz   
  var o = {   
    "M+" : this.getMonth()+1,                 //月份   
    "d+" : this.getDate(),                    //日   
    "h+" : this.getHours(),                   //小时   
    "m+" : this.getMinutes(),                 //分   
    "s+" : this.getSeconds(),                 //秒   
    "q+" : Math.floor((this.getMonth()+3)/3), //季度   
    "S"  : this.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}; 

var activityId="";
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
		activityId="";
		$("#title").val("");
		$("#time").val("");
		$("#address").val("");
		$("#remark").val("");
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
			if(data == null)
				return;
			$(".avatar").css("background-image","url("+serverUrl+data.url+")");
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
				$("#activities").append("<li><img groupId=\""+rec.id+"\" status=\"" + rec.status
						+"\" src=\""+serverUrl+rec.url+"\" width=\"285\" height=\"180\" onclick=\"openTalk(this)\"/>"
						+(rec.status==3?"<div class=\"approve\"></div>":"")
						+"<div class=\"title\">"+rec.title +"</div>"
						+"<div class=\"info\"><span class=\"address\">" + rec.address +"</span>"
						+"<span  class=\"time\">"+formatTime(rec.startTime)+"</span></div></li>");
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
			id:activityId,
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

function openTalk(el){
	var status = $(el).attr("status");
	var groupId=$(el).attr("groupId");
	if(status == 3)
	{
		$('.add-activity-btn').trigger("click");
		$.ajax({
			type:'post',
			url:"<%=baseUrl%>"+'/activity/getActivityInfo',
			data:{
				id:groupId
			},
			dataType:'json',
			success:function(data){
				activityId=groupId;
				$("#time").val(data.startTime);
				$("#address").val(data.address);
				$("#remark").val(data.remark);
				$("#title").val(data.title);
			},
			error:function(textStatus,errorThrown){
			}
		});
	}
	else
		window.open(baseUrl+"/talk?groupId="+groupId,"talk"+groupId);
}

function formatTime(value)
{
	if(typeof value=="undefined" || value.trim() == "")
		return "";
	var d = new Date();
	d.setTime(parseInt(value));
	return d.format("yyyy-MM-dd hh:mm");
}
</script>
</body>
</html>