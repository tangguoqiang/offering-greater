<%@page import="com.offering.common.constant.GloabConstant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="common/include.jsp"%>
<link type="text/css" href="<%=baseUrl%>/css/jquery.Jcrop.min.css" rel="stylesheet" />
<link href="<%=baseUrl%>/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="<%=baseUrl%>/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=baseUrl%>/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=baseUrl%>/js/jquery.color.js"></script>
<script type="text/javascript" src="<%=baseUrl%>/js/jquery.Jcrop.js"></script>
<script src="<%=baseUrl%>/js/bootstrap.min.js" type="text/javascript"></script>
<%if(userName == null){
	response.sendRedirect(baseUrl);
}%>

<style type="text/css">

/* Apply these styles only when #preview-pane has
   been placed within the Jcrop widget */
.jcrop-holder #preview-pane {
  display: block;
  position: absolute;
  z-index: 2000;
  top: 10px;
  right: -280px;
  padding: 6px;
  border: 1px rgba(0,0,0,.4) solid;
  background-color: white;

  -webkit-border-radius: 6px;
  -moz-border-radius: 6px;
  border-radius: 6px;

  -webkit-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
  -moz-box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
  box-shadow: 1px 1px 5px 2px rgba(0, 0, 0, 0.2);
}

/* The Javascript code will set the aspect ratio of the crop
   area based on the size of the thumbnail preview,
   specified here */
#preview-pane .preview-container {
  width: 100px;
  height: 100px;
  overflow: hidden;
}

</style>
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
		<div style="width: 100px;height: 100px;margin: 36px auto;">
			<img id="icon" style="border-radius:50px;width: 100px;height: 100px;cursor: pointer;" src="images/cover3.png"/>
		</div>
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
	<div class="footer"></div>
	
	<div class="modal fade" id="uploadModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">附件上传</h4>
	      </div>
	      <div class="modal-body" >
	        <form class="form-horizontal">
			  <div class="form-group">
			    <div class="col-sm-9">
				    <div class="col-sm-9">
				      	<input type="file" class="form-control" id="fileToUpload" name="fileToUpload">
				    </div>
			    </div>
			   </div>
			   <div class="form-group" >
			    <div class="col-sm-8">
				   <div class="jc-demo-box">
  						<img class="img-responsive" src="" id="uploadImage" alt="图片区域" align="middle"/>
					</div>
			    </div>
			    <div class="col-sm-4">
			    	<div id="preview-pane">
					    <div class="preview-container">
					      	<img  id="previewImage" style="width: 100px;height: 100px;" src="" class="jcrop-preview" alt="预览区域" align="middle"/>
					   	</div>
					</div>
				</div>
			  </div>
			</form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" onclick="upload()">上传</button>
	      </div>
	    </div>
	  </div>
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
	
	$("#icon").bind("click",function(){
		$("#uploadModal").modal("show");
	});
	
	$('#fileToUpload').bind('change', function(){
		var reader = new FileReader();
		reader.onload = function(e) {
			var xsize = $('#preview-pane .preview-container').width();
			var ysize = $('#preview-pane .preview-container').height();
			$('#uploadImage').attr("src",e.target.result);
			$('#previewImage').attr("src",e.target.result);
			$('#uploadImage').Jcrop({
				  onChange: updatePreview,
				  onSelect: updatePreview,
				  aspectRatio: xsize / ysize
				},function(){
				  // Use the API to get the real image size
				  var bounds = this.getBounds();
				  boundx = bounds[0];
				  boundy = bounds[1];
				  // Store the API in the jcrop_api variable
				  jcrop_api = this;
				
				  // Move the preview into the jcrop container for css positioning
				  //$('#preview-pane').appendTo(jcrop_api.ui.holder);
				}); 
		}
		reader.readAsDataURL(this.files[0]);
		this.files = [];
	})
	
	function updatePreview(c)
	{
		var xsize = $('#preview-pane .preview-container').width();
		var ysize = $('#preview-pane .preview-container').height();
		var pimg = $('#preview-pane .preview-container img');
		console.log('init',[xsize,ysize]);
	  	if (parseInt(c.w) > 0)
	  	{
	    	var rx = xsize / c.w;
	    	var ry = ysize / c.h;

	    	pimg.css({
	      		width: Math.round(rx * boundx) + 'px',
	      		height: Math.round(ry * boundy) + 'px',
	      		marginLeft: '-' + Math.round(rx * c.x) + 'px',
	      		marginTop: '-' + Math.round(ry * c.y) + 'px'
	    	});
	  }
	}
});

</script>
</body>
</html>