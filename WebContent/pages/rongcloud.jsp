<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="common/include.jsp"%>
<script src="<%=baseUrl%>/js/RongIMClient-0.9.13.min.js" type="text/javascript"></script>
<title>Offering</title>
</head>
<body>
	<div class="header">
		<div class="wrap">
			<div class="logo"></div>
			<div class="userinfo">
				<ul id="nologin" <%if (userName != null ){%>style="display:none;"<%}%>>
					<li style="margin-right:50px"><a href="javascript:void(0);" onClick="showDialog(1);">成为大拿</a></li>
					<li><a href="javascript:void(0);" onClick="showDialog(2);">注册</a></li>
					<li style="margin:0px 5px">|</li>
					<li><a href="javascript:void(0);" onClick="showDialog(1);">登录</a></li>
				</ul>
				<ul id="userinfo" <%if (userName == null){%>style="display:none;"<%}%>>
					<li style="margin-right:50px">
						<a href="<%=baseUrl%>/activity" id="activity" <%if ("1".equals(userType)){%>style="display:none;"<%}%>>发布活动</a>
						<a href="<%=baseUrl%>/greater" id="greater" <%if ("2".equals(userType)){%>style="display:none;"<%}%>>成为大拿</a>
					</li>
					<li>欢迎回来，<span id="showusername"><%if (userName != null ){%><%=userName%><%}%></span> <a href="javascript:void(0);" onClick="logout();">退出</a></li>
				</ul>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="banner-box">
		<div class="bd">
	        <ul>          	    
	            <li>
	                <div class="m-width">
	                	<a href="javascript:void(0);"><img src="<%=baseUrl%>/images/backgroud.png" width="100%"/></a>
	                </div>
	            </li>
	            <li>
	                <div class="m-width">
	                	<a href="javascript:void(0);"><img src="<%=baseUrl%>/images/backgroud3.png" width="100%"/></a>
	                </div>
	            </li>
	            <li>
	                <div class="m-width">
	                	<a href="javascript:void(0);"><img src="<%=baseUrl%>/images/backgroud.png" width="100%"/></a>
	                </div>
	            </li>
	        </ul>
	    </div>
	    <div class="banner-btn">
	        <a class="prev" href="javascript:void(0);"></a>
	        <a class="next" href="javascript:void(0);"></a>
	        <div class="hd"><ul></ul></div>
	    </div>
	</div>
	<div class="content">
		<div class="wrap kouhao">
			<div class="index-lighter"></div>
			<div class="index-model"></div>
			<div class="index-rich"></div>
		</div>
		<div class="line">
		</div>
		<div class="companyinfo">
			<div class="company tencent"></div>
			<div class="company baidu"></div>
			<div class="company huawei"></div>
			<div class="company alibaba"></div>
			<div class="company netease"></div>
		</div>
		<div class="waitforyou"></div>
		<div class="danalist">
			<div class="dana mayun"></div>
			<div class="dana mayun"></div>
			<div class="dana mayun"></div>
			<div class="dana mayun"></div>
			<div class="dana mayun"></div>
		</div>
		<div class="join"></div>
		<div class="shareex"></div>
	</div>
	<div class="footer">
		<img src="<%=baseUrl%>/images/down.png" width="100%"></div>
	</div>
	<div class="mask" id="mask"></div>
	<div class="model" id="dialog">
		<div class="close"></div>
		<div class="dialogcontent">
			<div class="dialogtitle">
				<img src="<%=baseUrl%>/images/backgroud.png" width="100%"/>
				<div class="loginbtn">登录</div>
				<div class="registerbtn">注册</div>
			</div>
			<div class="">
				<div class="logindiv">
					<p style="margin-top:40px">
						<label for="account" class="label-account"></label>
						<input name="account" id="account" type="text" class="input" autocomplete="off" placeholder="邮箱或手机号"></input>
					</p>
					<p>
						<label for="password" class="label-password"></label>
						<input name="password"  id="password" type="password" class="input" autocomplete="off" placeholder="密码"></input>
					</p>
					<p  style="line-height: 25px;">
						<a href="javascript:void(0);" class="button" onclick="login();">登录</a>
					</p>
				</div>
				<div class="registerdiv">
					<p style="margin-top:40px">
						<label for="phone" class="label-phone"></label>
						<input name="phone" id="phone" type="text" class="input" autocomplete="off" placeholder="手机号"></input>
					</p>
					<p>
						<label for="captcha" class="label-captcha"></label>
						<input name="captcha" type="text" class="input" autocomplete="off" placeholder="验证码"></input>
					</p>
					<p>
						<label for="repassword" class="label-password"></label>
						<input name="repassword" id="repassword" type="password" class="input" autocomplete="off" placeholder="密码，至少6位"></input>
					</p>
					<p style="line-height: 25px;">
						<a href="javascript:void(0);"  class="button" onclick="register();">注册</a>
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
<script type="text/javascript">
$(document).ready(function(){
	RongIMClient.init("pvxdm17jx829r");
	//获取融云token
	var token="C7JCzsxBhkb1pgv23/clDkvtZK49NiyFqz+o0Ek1+osfNsSvf31DORzAC+FSibWhr6cr+57zpGDV7K1CbxOuKw==";
	
	 // 连接融云服务器。
    RongIMClient.connect(token,{
            onSuccess: function (userId) {
                // 此处处理连接成功。
                alert("Login successfully.");
                console.log("Login successfully." + userId);
            },
            onError: function (errorCode) {
                // 此处处理连接错误。
                var info = '';
                switch (errorCode) {
                       case RongIMClient.callback.ErrorCode.TIMEOUT:
                            info = '超时';
                            break;
                       case RongIMClient.callback.ErrorCode.UNKNOWN_ERROR:
                            info = '未知错误';
                            break;
                       case RongIMClient.ConnectErrorStatus.UNACCEPTABLE_PROTOCOL_VERSION:
                            info = '不可接受的协议版本';
                            break;
                       case RongIMClient.ConnectErrorStatus.IDENTIFIER_REJECTED:
                            info = 'appkey不正确';
                            break;
                       case RongIMClient.ConnectErrorStatus.SERVER_UNAVAILABLE:
                            info = '服务器不可用';
                            break;
                       case RongIMClient.ConnectErrorStatus.TOKEN_INCORRECT:
                            info = 'token无效';
                            break;
                       case RongIMClient.ConnectErrorStatus.NOT_AUTHORIZED:
                            info = '未认证';
                            break;
                       case RongIMClient.ConnectErrorStatus.REDIRECT:
                            info = '重新获取导航';
                            break;
                       case RongIMClient.ConnectErrorStatus.PACKAGE_ERROR:
                            info = '包名错误';
                            break;
                       case RongIMClient.ConnectErrorStatus.APP_BLOCK_OR_DELETE:
                            info = '应用已被封禁或已被删除';
                            break;
                       case RongIMClient.ConnectErrorStatus.BLOCK:
                            info = '用户被封禁';
                            break;
                       case RongIMClient.ConnectErrorStatus.TOKEN_EXPIRE:
                            info = 'token已过期';
                            break;
                       case RongIMClient.ConnectErrorStatus.DEVICE_ERROR:
                            info = '设备号错误';
                            break;
                }
                alert("失败:" + info);
                console.log("失败:" + info);
            }
        });
	 
    // 设置连接监听状态 （ status 标识当前连接状态）
    // 连接状态
    RongIMClient.setConnectionStatusListener({
       onChanged: function (status) {
           switch (status) {
                   //链接成功
                   case RongIMClient.ConnectionStatus.CONNECTED:
                       console.log('链接成功');
                       break;
                   //正在链接
                   case RongIMClient.ConnectionStatus.CONNECTING:
                       console.log('正在链接');
                       break;
                   //重新链接
                   case RongIMClient.ConnectionStatus.RECONNECT:
                       console.log('重新链接');
                       break;
                   //其他设备登陆
                   case RongIMClient.ConnectionStatus.OTHER_DEVICE_LOGIN:
                   //连接关闭
                   case RongIMClient.ConnectionStatus.CLOSURE:
                   //未知错误
                   case RongIMClient.ConnectionStatus.UNKNOWN_ERROR:
                   //登出
                   case RongIMClient.ConnectionStatus.LOGOUT:
                   //用户已被封禁
                   case RongIMClient.ConnectionStatus.BLOCK:
                       break;
           }
       }});
	 
 	// 消息监听器
    RongIMClient.getInstance().setOnReceiveMessageListener({
       // 接收到的消息
       onReceived: function (message) {
           // 判断消息类型
           switch(message.getMessageType()){
               case RongIMClient.MessageType.TextMessage:
                   // do something...
                   break;
               case RongIMClient.MessageType.ImageMessage:
                   // do something...
                   break;
               case RongIMClient.MessageType.VoiceMessage:
                   // do something...
                   break;
               case RongIMClient.MessageType.RichContentMessage:
                   // do something...
                   break;
               case RongIMClient.MessageType.LocationMessage:
                   // do something...
                   break;
               case RongIMClient.MessageType.DiscussionNotificationMessage:
                   // do something...
                   break;
               case RongIMClient.MessageType.InformationNotificationMessage:
                   // do something...
                   break;
               case RongIMClient.MessageType.ContactNotificationMessage:
                   // do something...
                   break;
               case RongIMClient.MessageType.ProfileNotificationMessage:
                   // do something...
                   break;
               case RongIMClient.MessageType.CommandNotificationMessage:
                   // do something...
                   break;
               case RongIMClient.MessageType.UnknownMessage:
                   // do something...
                   break;
               default:
                   // 自定义消息
                   // do something...
           }
       }
   });
});
</script>
</body>
</html>