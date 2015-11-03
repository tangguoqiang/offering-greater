<%@page import="com.offering.common.constant.GloabConstant"%>
<%@page import="com.offering.bean.User"%>
<%
	String baseUrl = request.getContextPath();
	//测试 http://121.201.24.60:8080/offering/ 正式 http://www.myoffering.cn:8080/offering
	String serverUrl = "0".equals(GloabConstant.PRODUCT_MODEL) 
						? "http://121.201.24.60:8080/offering/" : "http://www.myoffering.cn:8080/offering";
	String userName = null,auth = null,userId = null,userType = null,rcToken = null,url = null; 
	if(request.getSession().getAttribute("user") != null){
		User user = (User)request.getSession().getAttribute("user");
		//用户名
		userName = user.getNickname();
		userId = user.getId();
		userType = user.getType();
		rcToken = user.getRc_token();
		url = user.getUrl();
	}
	
%>
<link href="css/base.css" rel="stylesheet" type="text/css"/>
<%-- <link href="<%=baseUrl%>/css/jquery-ui-1.8.17.custom.css" rel="stylesheet" type="text/css"/> --%>
<link href="css/jquery-ui.min.css" rel="stylesheet" type="text/css"/>
<link href="css/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
<link href="css/jquery.bxslider.css" rel="stylesheet" />
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="css/bootstrap-theme.min.css" rel="stylesheet" type="text/css"/>
<link href="css/jquery.Jcrop.min.css" rel="stylesheet" type="text/css"/>
<!-- <link href="css/jquery.searchselect.css" rel="stylesheet" type="text/css"/> -->

<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.bxslider.min.js"></script>
<script type="text/javascript" src="js/jquery.slides.min.js"></script>
<script type="text/javascript" src="js/tinybox.js"></script>
<script type="text/javascript" src="js/ajaxfileupload.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<!-- <script type="text/javascript" src="js/jquery-ui-1.8.17.custom.min.js"></script> -->
<script type="text/javascript" src="js/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="js/jquery-ui-timepicker-zh-CN.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery.color.js"></script>
<script type="text/javascript" src="js/jquery.Jcrop.js"></script>
<!-- <script type="text/javascript" src="js/jquery.searchselect.min.js"></script>
<script type="text/javascript" src="js/jquery.slimscroll.min.js"></script> -->
<script type="text/javascript" src="js/bootstrap-suggest.min.js"></script>
<script type="text/javascript">
	var product_model = '<%=GloabConstant.PRODUCT_MODEL%>';
	var baseUrl = '<%=baseUrl%>';
	var userId = '<%=userId%>';
	var userName = '<%=userName%>';
	var rcToken = '<%=rcToken%>';
	var serverUrl='<%=serverUrl%>';
	var userType='<%=userType%>';
</script>
