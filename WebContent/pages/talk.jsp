<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="common/include.jsp"%>
<script src="<%=baseUrl%>/js/RongIMClient-0.9.13.min.js" type="text/javascript"></script>
</head>
<body style="background-color:#ededeb;">
<div class="header activityheaderbg" id="header">
	<div class="wrap">
		<a class="logo"></a>
		<div class="userinfo">
			<ul>
				<li>欢迎回来，<span id="showusername"><%if (userName != null ){%><%=userName%><%}%></span> <a href="javascript:void(0);" onClick="logout();">退出</a></li>
			</ul>
		</div>
		<div class="clear"></div>
	</div>
</div>
<div class="talkcontent">
<input id="groupId" value="${groupId}" style="visibility: hidden;">
	<div class="wrap">
		<div class="left">
			<div class="activity">
				<img id="image" src="" width="285" height="180"/>
				<div id="title" class="title"></div>
				<div class="info"><span id="address" class="address"></span><span id="time" class="time"><span></div>
			</div>
			<div class="member">
				<div>全部成员</div>
				<ul>
					<li></li>
				</ul>
			</div>
		</div>
		<div class="right">
			<div id="talkContent" class="content">
			   <!-- 	<div class="message_content">
	                <div class="face"><img src="images/qq.png" /></div>
	                <div class="message">abcdefg<br />test<br />test<br />test<br /></div>
	            </div>
	            <div class="message_content">
	             	<div class="face fr"><img src="images/qq.png" /></div>
	                <div class="messageleft fr">abcdefg<br />test<br />test<br />test<br /></div>
	               
	            </div> -->
			</div>
			<textarea id="sendContent"></textarea>
			<a class="send">发送</a>
		</div>
	</div>
</div>
<div class="footer" style="margin-top: 60px;float:left;"></div>
	
<script type="text/javascript">
var isconnect = false;
$(document).ready(function(){
	//测试 pvxdm17jx829r   生产 uwd1c0sxd3lt1
	if(product_model == "0")
		RongIMClient.init("pvxdm17jx829r");
	else
		RongIMClient.init("uwd1c0sxd3lt1");
	//获取融云token
	var token;
	if(rcToken == null || rcToken=="")
	{
		alert("融云token不能为空！");
		token = "yy4tgzxTIdWgTEF/BhE+x0vtZK49NiyFqz+o0Ek1+ouxye7SGYnl7VhCaQ4v1OnZGtLExsA8DT/V7K1CbxOuKw==";
		window.close();
	}
	else{
		token = rcToken;
	}
	 // 连接融云服务器。
    RongIMClient.connect(token,{
            onSuccess: function (userId) {
                // 此处处理连接成功。
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
                console.log("失败:" + info);
            }
        });
	 
    // 设置连接监听状态 （ status 标识当前连接状态）
    // 连接状态
    RongIMClient.setConnectionStatusListener({
       onChanged: function (status) {
           switch (status) {
                   case RongIMClient.ConnectionStatus.CONNECTED:
                       console.log('链接成功');
                       isconnect=true;
                       //TODO   需要开启消息漫游
                       //RongIMClient.getInstance().getHistoryMessages(RongIMClient.ConversationType.GROUP,
                    	//	   $("#groupId").val(),
                    	//	   20,{
                    	//	    onSuccess:function(symbol,HistoryMessages){
                    		      // symbol为boolean值，如果为true则表示还有剩余历史消息可拉取，为false的话表示没有剩余历史消息可供拉取。
                    		      // HistoryMessages 为拉取到的历史消息列表
                    		//      for(var i=0,len=HistoryMessages.length;i<len;i++)
                    		//   	  {
                    		//    	  alert(HistoryMessages.get(i).getContent());
                    		//   	  }
                    		//    },onError:function(e){
                    		      // APP未开启消息漫游或处理异常
                    		      // throw new ERROR ......
                    		//    }
                    	//	   });
                       break;
                   case RongIMClient.ConnectionStatus.CONNECTING:
                       console.log('正在链接');
                       break;
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
                   writeMessage(message.getSenderUserId(),message.getContent(),false);
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
           }
       }
   });
 	
 	$(".send").bind("click",function(){
 		if($("#sendContent").val().trim() == "")
 			return;
 		sendMessage($("#sendContent").val());
 	});
 	
 	$("#sendContent").keyup(function(e){
 		if(e.keyCode==13){
 			if($("#sendContent").val().trim() == "")
 	 			return;
 	 		sendMessage($("#sendContent").val());
 		}
 	}); 
 	
 	loadGreaterInfo();
});

function loadGreaterInfo(){
	$.ajax({
		type:'post',
		url:"<%=baseUrl%>"+'/activity/getActivityInfo',
		data:{
			id:$("#groupId").val()
		},
		dataType:'json',
		success:function(data){
			$("#image").attr("src",serverUrl + data.url);
			$("#title").text(data.title);
			$("#time").text(data.startTime);
			$("#address").text(data.address);
			//$("#remark").val(data.remark);
		},
		error:function(textStatus,errorThrown){
		}
	});
}

function sendMessage(content){
	 var msg = RongIMClient.TextMessage.obtain(content);
	 RongIMClient.getInstance().sendMessage(RongIMClient.ConversationType.GROUP, $("#groupId").val(), 
			 msg, null, {
	                // 发送消息成功
	                onSuccess: function () {
	                	writeMessage(userId,content,true);
	                	$("#sendContent").val("");
	                },
	                onError: function (errorCode) {
	                	alert(errorCode);
	                    var info = '';
	                    switch (errorCode) {
	                        case RongIMClient.callback.ErrorCode.TIMEOUT:
	                            info = '超时';
	                            break;
	                        case RongIMClient.callback.ErrorCode.UNKNOWN_ERROR:
	                            info = '未知错误';
	                            break;
	                        case RongIMClient.SendErrorStatus.REJECTED_BY_BLACKLIST:
	                            info = '在黑名单中，无法向对方发送消息';
	                            break;
	                        case RongIMClient.SendErrorStatus.NOT_IN_DISCUSSION:
	                            info = '不在讨论组中';
	                            break;
	                        case RongIMClient.SendErrorStatus.NOT_IN_GROUP:
	                            info = '不在群组中';
	                            break;
	                        case RongIMClient.SendErrorStatus.NOT_IN_CHATROOM:
	                            info = '不在聊天室中';
	                            break;
	                        default :
	                            info = x;
	                            break;
	                    }
	                    console.alert('发送失败:' + info);
	                }
	            }
	        );
}

function writeMessage(userId,content,isMyself){
	RongIMClient.getInstance().getUserInfo(userId,{
		 onSuccess:function(info){
			 $("#talkContent").append("<div class=\"message_content\">"
						+"<div class=\""+(isMyself?"face fr":"face")+"\"><img src=\""+info.getPortraitUri()+"\" /></div>"
						+"<div class=\""+(isMyself?"messageleft fr":"message")+"\">"+content+"</div></div>");
			 $("#talkContent").scrollTop($("#talkContent")[0].scrollHeight);
		 },onError:function(){
		     //失败
		 }
	});
}
</script>
</body>
</html>