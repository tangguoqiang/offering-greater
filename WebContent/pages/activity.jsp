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
	<div class="header activityheaderbg" id="header">
		<div class="wrap">
			<a class="logo" href="<%=baseUrl%>"></a>
			<div class="userinfo">
				<ul>
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
					<img id="icon" style="margin:0px auto 20px auto;height: 100px;width: 100px;border-radius: 50px;"></img>
					<div id="name" class="name"></div>
					<!-- <p id="company"></p>
					<p id="post"></p> -->
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
	<div class="footer"></div>
<script  type="text/x-jquery-tmpl" id="dialog">
	<div class="model2">
		<div class="close2"></div>
		<div class="dialogcontent">
			<div class="dialogtitle">
				<img src="<%=serverUrl%>/download/userImages/1.jpg" width="100%" id="activitybg"/>
				<div class="down"></div>
			</div>
			<div class="activity-tpl-list">
				<ul>
					<li class="item first" rel="/download/userImages/1.jpg"><img src="<%=serverUrl%>/download/userImages/1.jpg" width="135" height="75"/></li>
					<li class="item" rel="/download/userImages/2.jpg"><img src="<%=serverUrl%>/download/userImages/2.jpg" width="135" height="75"/></li>
					<li class="item first" rel="/download/userImages/4.jpg"><img src="<%=serverUrl%>/download/userImages/4.jpg" width="135" height="75"/></li>
					<li class="item" rel="/download/userImages/5.jpg"><img src="<%=serverUrl%>/download/userImages/5.jpg" width="135" height="75"/></li>
				</ul>
				<div class="up"></div>
			</div>
			<div class="" style="margin-top:6px;">
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
			<input id="url" type="hide" value="/download/userImages/1.jpg">
			<div id="releaseBtn" class="send-activity">发布</div>
		</div>
	</div>
</script>
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
	var leftheight =$('.left').height();
	var rightheight =$('.right').height();
	var height = leftheight>rightheight ? leftheight : rightheight;
	$('.activitycontent').css({'height': height+20});

	$('.add-activity-btn').bind('click',function(){
		var html = $('#dialog').html();
		TINY.box.show(html,0,0,0,1);
		activityId="";
		$("#title").val("");
		$("#time").val("");
		$("#address").val("");
		$("#remark").val("");
		setTimeout(function(){
			 $("#time").datetimepicker({
	            showSecond: true,
	            timeFormat: 'hh:mm:ss',
	            stepHour: 1,
	            stepMinute: 1,
	            stepSecond: 1
	        });
		},1000);
	});
	$('.close2').live('click',function(){
		TINY.box.hide();
	});
	//发布活动
	$('#releaseBtn').live('click',realeaseActivity);
	loadGreaterInfo();
	//加载活动数据
	loadActivities();
	 $(window).scroll(function () {
       if($(window).scrollTop() > 0){
    	   $("#header").addClass("headerfix");
       }else{
    	   $("#header").removeClass("headerfix");
       }
    });
	 
	$('.down').live('click',function(){
		$('.activity-tpl-list').show();
		$('.activity-tpl-list').stop().animate({top:"185px",speed: 800});
	});
	$('.up').live('click',function(){
		$('.activity-tpl-list').stop().animate({top:"0px",speed: 800,});
		setTimeout(function(){
			$('.activity-tpl-list').hide();
		},600);
	});
	
	$('.item').live('click',function(){
		var url = $(this).attr('rel');
		$('#url').val(url);
		$("#activitybg").attr('src', "<%=serverUrl%>"+url);
		$('.activity-tpl-list').stop().animate({top:"0px",speed: 800});
		setTimeout(function(){
			$('.activity-tpl-list').hide();
		},600);
	});
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
			$("#icon").attr("src",serverUrl+data.url);
			$("#name").text(data.nickname);
			//$("#company").text(data.company);
			//$("#post").text(data.post);
			var tag = data.tags;
			if(tag != null)
			{
				var tags = tag.split(",");
				for(var i=0,len=tags.length;i<len;i++)
				{
					$("#baseinfo").append("<p>"+tags[i]+"</p>");
				}
			}
			
			$("#work").append("<p>"+data.experience.replace(/\\n/g,"<br>")+"</p>");
			$("#job").append("<p>"+data.job.replace(/\\n/g,"<br>")+"</p>");
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
			url:$("#url").val(),
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
				TINY.box.hide();
			}else{
				alert(data.msg);
			}
		},
		error:function(textStatus,errorThrown){
		}
	});
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
				setTimeout(function(){
				activityId=groupId;
				$("#activitybg").attr('src', '<%=serverUrl%>'+data.url);
				$("#time").val(data.startTime);
				$("#address").val(data.address);
				$("#remark").val(data.remark);
				$("#title").val(data.title);
				},1000);
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