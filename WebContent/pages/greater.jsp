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

</script>
</body>
</html>