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
	<div class="header" id="header">
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
	<div>
		<img src="images/backgroud3.png" width="100%"/>
	</div>
	<div class="content" >
		<div class="avatar"><input type="file" id="fileToUpload" name="fileToUpload"></div>
		<div class="fill">
			<div class="msg" id="msg"></div>
			<p>
				<label>姓名</label>
				<input id="nickname" value="" placeholder="昵称">
			</p>
			<p>
				<label>公司</label>
				<input id="company" value=""  placeholder="你的公司">
			</p>
			<p>
				<label>职位</label>
				<input id="post" value="" placeholder="你的职位">
			</p>
			<p>
				<label>领域</label>
				<input id="field" value="" placeholder="你的领域">
			</p>
			<p>
				<label>大学</label>
				<input id="university" value="" placeholder="你的大学">
			</p>
			<div class="title">工作经历</div>
			<p style="height:120px">
				<textarea id="experience"></textarea>
			</p>
			<div class="title">心得</div>
			<p  style="height:120px">
				<textarea  id="job"></textarea>
			</p>
			<a class="button2" id="create">提交申请</a>
		</div>
	</div>
	<div class="footer">
	</div>
<script type="text/javascript">
var isClick = false;
$(document).ready(function(){
	 $(window).scroll(function () {
       if($(window).scrollTop() > 0){
    	   $("#header").addClass("headerfix");
       }else{
    	   $("#header").removeClass("headerfix");
       }
    });
	$('#create').bind('click',function(){
		if(isClick == true){return false;}
		isClick = true;
		var nickname = $("#nickname").val();
		var company = $("#company").val();
		var post = $("#post").val();
		var field =  $("#field").val();
		var university =  $("#university").val();
		var experience =  $("#experience").val();
		var job = $("#job").val();
		var msg = '';
		if(nickname == ''){
			msg = "姓名不能为空";
			$("#msg").html(msg);
			$('#msg').show();
			return false;
		}
		if(company == ''){
			msg = "公司不能为空";
			$("#msg").html(msg);
			$('#msg').show();
			return false;
		}
		if(post == ''){
			msg = "职位不能为空";
			$("#msg").html(msg);
			$('#msg').show();
			return false;
		}
		if(field == ''){
			msg = "领域不能为空";
			$("#msg").html(msg);
			$('#msg').show();
			return false;
		}
		if(university == ''){
			msg = "大学不能为空";
			$("#msg").html(msg);
			$('#msg').show();
			return false;
		}
		if(experience == ''){
			msg = "工作经历不能为空";
			$("#msg").html(msg);
			$('#msg').show();
			return false;
		}
		if(job == ''){
			msg = "心得不能为空";
			$("#msg").html(msg);
			$('#msg').show();
			return false;
		}
		var tag = field+','+university;
		if($("#fileToUpload").val() == ''){
			msg = "请选择上传头像";
			$("#msg").html(msg);
			$('#msg').show();
			return false;
		 }
		$.ajax({
			type:'post',
			url:"<%=baseUrl%>"+'/becomeGreater',
			data:{
				userid:'<%=userId%>',
				nickname:nickname,
				company:company,
				post:post,
				experience:experience,
				tags:tag,
				job:job,
			},
			dataType:'json',
			success:function(data){
				isClick = false;
				if(data.success){
					$.ajaxFileUpload({
				 		url:"<%=baseUrl%>/greater/uploadImage",
				 		secureuri:false,
				 		type:'GET',
				 		fileElementId:'fileToUpload',
				 		dataType: 'json',
				 		data:{
				 			id:'<%=userId%>',
				 			uploadType: 0
				 		},
				 		success: function (result, status){
				 			$("#msg").html('提交成功！');
							$('#msg').show();
							setTimeout(function(){
								window.location.href = '<%=baseUrl%>'+'/activity';
							},1500 );
				 		},
				 		error: function (data, status, e){
				 		}
				 	});
				}else{
					$("#msg").html(data.msg);
					$('#msg').show();
				}
			},
			error:function(textStatus,errorThrown){
				isClick = false;
			}
		});
		 

	});

});


</script>
</body>
</html>