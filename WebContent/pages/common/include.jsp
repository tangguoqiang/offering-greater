<%@page import="com.offering.common.constant.GloabConstant"%>
<%@page import="com.offering.bean.User"%>
<%
	String baseUrl = request.getContextPath();
	//测试 http://121.201.24.60:8080/offering/ 正式 http://www.myoffering.cn:8080/offering
	String serverUrl = "0".equals(GloabConstant.PRODUCT_MODEL) 
						? "http://121.201.24.60:8080/offering/" : "http://www.myoffering.cn:8080/offering";
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
<link type="text/css" href="<%=baseUrl%>/css/jquery-ui-1.8.17.custom.css" rel="stylesheet" />
<link type="text/css" href="<%=baseUrl%>/css/jquery-ui-timepicker-addon.css" rel="stylesheet" />
<link href="<%=baseUrl%>/css/jquery.bxslider.css" rel="stylesheet" />
<script src="<%=baseUrl%>/js/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="<%=baseUrl%>/js/jquery.bxslider.min.js" type="text/javascript"></script>
<script src="<%=baseUrl%>/js/jquery.slides.min.js" type="text/javascript"></script>
<script src="<%=baseUrl%>/js/tinybox.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=baseUrl%>/js/ajaxfileupload.js"></script>
<script type="text/javascript" src="<%=baseUrl%>/js/jquery-ui-1.8.17.custom.min.js"></script>
<script type="text/javascript" src="<%=baseUrl%>/js/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="<%=baseUrl%>/js/jquery-ui-timepicker-zh-CN.js"></script>
<script type="text/javascript">
	var product_model = '<%=GloabConstant.PRODUCT_MODEL%>';
	var baseUrl = '<%=baseUrl%>';
	var userId = '<%=userId%>';
	var userName = '<%=userName%>';
	var rcToken = '<%=rcToken%>';
	var serverUrl='<%=serverUrl%>';
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
