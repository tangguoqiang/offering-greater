package com.offering.common.utils;

import java.util.HashMap;
import java.util.Set;

import org.apache.log4j.Logger;

import com.cloopen.rest.sdk.CCPRestSDK;

/**
 * 容联接口
 * 
 * @author surfacepro3
 *
 */
public class CCPUtils {

	private final static Logger LOG = Logger.getLogger(CCPUtils.class);

	private final static String BASE_URL = "app.cloopen.com";
	private final static String PORT = "8883";
	private final static String ACCOUNT_ID = "8a48b5514e8a7522014e95a8e6b70db6";
	private final static String AUTH_TOKEN = "37a358acd0614e54a701f99f9fe3fa01";
	private final static String APP_ID = "8a48b5514e8a7522014e95aa68650db8";

	// 验证码模板id-28642 导师注册确认模板id-47344
	private final static String TEMPLATE_IDCODE = "28642";
	private final static String TEMPLATE_GREATER = "47344";

	public enum SmsType {
		IDCODE, GREATER;
	}

	/**
	 * 发送模板信息
	 * 
	 * @param phoneNum
	 *            手机号
	 * @param idCode
	 *            验证码
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static String sendSMS(String phoneNum, SmsType type, String[] datas) {
		CCPRestSDK restAPI = new CCPRestSDK();
		// 初始化服务器地址和端口，沙盒环境配置成sandboxapp.cloopen.com，生产环境配置成app.cloopen.com，端口都是8883.
		restAPI.init(BASE_URL, PORT);
		// 初始化主账号名称和主账号令牌
		restAPI.setAccount(ACCOUNT_ID, AUTH_TOKEN);
		// 初始化应用ID。如切换到生产环境，请使用自己创建应用的APPID
		restAPI.setAppId(APP_ID);
		String template = "";
		switch (type) {
		case IDCODE:
			template = TEMPLATE_IDCODE;
			break;
		case GREATER:
			template = TEMPLATE_GREATER;
			break;
		default:
			return "";
		}
		HashMap<String, Object> result = restAPI.sendTemplateSMS(phoneNum,
				template, datas);
		LOG.debug("SDKTestVoiceVerify result=" + result);
		if ("000000".equals(result.get("statusCode"))) {
			// 正常返回输出data包体信息（map）
			HashMap data = (HashMap) result.get("data");
			Set<String> keySet = data.keySet();
			for (String key : keySet) {
				Object object = data.get(key);
				LOG.debug(key + " = " + object);
			}
			return "";
		} else {
			// 异常返回输出错误码和错误信息
			LOG.error("错误码=" + result.get("statusCode") + " 错误信息= "
					+ result.get("statusMsg"));
			return result.get("statusMsg").toString();
		}
	}
}
