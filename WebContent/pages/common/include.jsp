<%@page import="com.offering.bean.User"%>
<%
	String baseUrl = request.getContextPath();
	String userName = null,auth = null,userId = null,userType = null,rcToken = null; 
	if(request.getSession().getAttribute("user") != null){
		User user = (User)request.getSession().getAttribute("user");
		//用户名
		userName = user.getNickname();
		userId = user.getId();
		userType = user.getType();
		rcToken = user.getRc_token();
	}
	
%>
	<script src="<%=baseUrl%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
	<script src="<%=baseUrl%>/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"></script>
 	<link href="<%=baseUrl%>/css/base.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript">
	var baseUrl = '<%=baseUrl%>';
	var userId = '<%=userId%>';
	var userName = '<%=userName%>';
	var rcToken = '<%=rcToken%>';
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