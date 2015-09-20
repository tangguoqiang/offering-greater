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
<link href="<%=baseUrl%>/css/base.css" rel="stylesheet" type="text/css"/>
<script src="<%=baseUrl%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=baseUrl%>/js/jquery.slides.min.js" type="text/javascript"></script>
<script src="<%=baseUrl%>/js/tinybox.js" type="text/javascript"></script>
<script type="text/javascript">
	var baseUrl = '<%=baseUrl%>';
	var userId = '<%=userId%>';
	var userName = '<%=userName%>';
	var rcToken = '<%=rcToken%>';
	var serverUrl="http://121.201.24.60:8080/offering"
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