package com.offering.core.controller;

import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cloopen.rest.sdk.utils.encoder.BASE64Decoder;
import com.offering.bean.Greater;
import com.offering.bean.ImageCoord;
import com.offering.bean.Topic;
import com.offering.bean.User;
import com.offering.common.constant.GloabConstant;
import com.offering.common.utils.CCPUtils;
import com.offering.common.utils.CCPUtils.SmsType;
import com.offering.common.utils.ImageUtil;
import com.offering.common.utils.MD5Util;
import com.offering.common.utils.RCUtils;
import com.offering.common.utils.Utils;
import com.offering.core.service.MainService;
import com.offering.core.service.UserService;

@Controller
public class MainController {

	private final static Logger LOG = Logger.getLogger(MainController.class);
	private Map<String, String> idCodeMap = new HashMap<String, String>();
	private Map<String, Long> timeMap = new HashMap<String, Long>();

	@Autowired
	private MainService mainService;

	@Autowired
	private UserService userService;

	/**
	 * 入口操作
	 * 
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/", method = { RequestMethod.POST,
			RequestMethod.GET })
	public String frontdoor(HttpSession session) {
		// User user = (User)session.getAttribute("user");
		return "pages/index";
	}

	/**
	 * 管理员入口操作
	 * 
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin", method = { RequestMethod.POST,
			RequestMethod.GET })
	public String door(HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user != null) {
			return "pages/adminindex";
		} else {
			return "pages/adminlogin";
		}
	}

	@RequestMapping(value = "/greater", method = { RequestMethod.POST,
			RequestMethod.GET })
	public String greater(HttpSession session) {
		// User user = (User)session.getAttribute("user");
		return "pages/greater";
	}

	@RequestMapping(value = "/activity", method = { RequestMethod.POST,
			RequestMethod.GET })
	public String activity(HttpSession session) {
		// User user = (User)session.getAttribute("user");
		return "pages/activity";
	}

	/**
	 * 登陆操作
	 * 
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> login(@RequestParam("phone") String phone,
			@RequestParam("password") String password, HttpServletRequest req) {
		Map<String, Object> m = new HashMap<String, Object>();
		User user = userService.getUserInfoByPhone(phone,
				MD5Util.string2MD5(password));
		if (user != null) {
			m.put("success", true);
			m.put("username", user.getName());
			m.put("nickname", user.getNickname());
			m.put("type", user.getType());
			m.put("url", user.getUrl());
			if (Utils.isEmpty(user.getRc_token())) {
				String rc_token = RCUtils.getToken(user.getId(),
						user.getNickname(), "");
				userService.updateRCToken(user.getId(), rc_token);
				user.setRc_token(rc_token);
				m.put("rc_token", rc_token);
			}
		} else {
			m.put("success", false);
			m.put("msg", "用户名或密码错误！");
		}
		req.getSession().setAttribute("user", user);
		return m;
	}

	/**
	 * 注销操作
	 * 
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> logout(HttpServletRequest req) {
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("success", true);
		req.getSession().setAttribute("user", null);
		return m;
	}

	/**
	 * 注册用户
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveUser(@RequestParam("phone") String phone,
			@RequestParam("password") String password, String code,
			HttpServletRequest req) {
		Map<String, Object> m = new HashMap<String, Object>();
		if (code == null || !code.equals(idCodeMap.get(phone))) {
			m.put("success", false);
			m.put("msg", "验证码错误，验证失败！");
			return m;
		}

		User user = new User();
		user.setPhone(phone);
		user.setPassword(MD5Util.string2MD5(password));
		user.setNickname(phone);
		user.setType(GloabConstant.USER_TYPE_NORMAL);
		boolean isExists = userService.isExistUser(user);
		if (isExists) {
			m.put("success", false);
			m.put("msg", "该手机已注册！");
		} else {
			if (Utils.isEmpty(user.getId())) {
				// 新增用户
				userService.insertUser(user);
			} else {
				// 更新用户信息
				userService.updateUser(user);
			}
			m.put("success", true);
		}

		User returnUser = userService.getUserInfoByPhone(phone, null);
		if (returnUser != null) {
			m.put("success", true);
			if (Utils.isEmpty(returnUser.getRc_token())) {
				String rc_token = RCUtils.getToken(returnUser.getId(),
						returnUser.getNickname(), "");
				userService.updateRCToken(returnUser.getId(), rc_token);
				returnUser.setRc_token(rc_token);
			}
			req.getSession().setAttribute("user", returnUser);
		}

		return m;
	}

	/**
	 * 密码修改
	 * 
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/resetPass", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> resetPass(String userName, String oldPass,
			String newPass) {
		Map<String, Object> m = new HashMap<String, Object>();
		User user = mainService.getUserInfo(userName,
				MD5Util.string2MD5(oldPass));
		if (user != null) {
			mainService.resetPass(userName, MD5Util.string2MD5(newPass));
			m.put("success", true);
		} else {
			m.put("success", false);
			m.put("msg", "旧密码输入错误！");
		}
		return m;
	}

	/**
	 * 获取验证码
	 * 
	 * @param phone
	 * @return
	 */
	@RequestMapping(value = "/getCode", method = { RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getCode(String phone, String type,
			HttpServletRequest req) {
		Map<String, Object> m = Utils.checkParam(req, new String[] { "phone" });
		if (m != null)
			return m;

		User user = new User();
		user.setPhone(phone);
		boolean isExists = userService.isExistUser(user);
		if (GloabConstant.CODE_REG.equals(type) && isExists) {
			return Utils.failture("该号码已经注册！");
		}

		if (GloabConstant.CODE_FINDPASS.equals(type) && !isExists) {
			return Utils.failture("该号码还未注册！");
		}

		if (timeMap.containsKey(phone)) {
			if (System.currentTimeMillis() - timeMap.get(phone) <= 6000) {
				return Utils.failture("一分钟内只能申请一次验证码!");
			}
		}
		String idCode = Utils.createIdCode();
		String msg = CCPUtils.sendSMS(phone, SmsType.IDCODE, 
				new String[]{idCode,GloabConstant.EFFECT_TIME});
		if (Utils.isEmpty(msg)) {
			idCodeMap.put(phone, idCode);
			timeMap.put(phone, System.currentTimeMillis());
			return Utils.success(null);
		} else
			return Utils.failture(msg);
	}
	
	/**
	 * 新增大拿
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/becomeGreater", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> becomeGreater(Greater greater,String image, 
			ImageCoord coord,HttpServletRequest req) {
		Pattern pattern = Pattern.compile("data:image/(.*?);base64,");
		Matcher match = pattern.matcher(image);
		String suff = null;
		if (match.find()) {
			suff = match.group(1);
			LOG.info(suff);
			image = image.replace(match.group(), "");
		}
		BASE64Decoder decoder = new BASE64Decoder();
		
		String imageName = "";
		try {
			byte[] decodedBytes = decoder.decodeBuffer(image);
			imageName = "greater_" +System.currentTimeMillis() 
					+ "_" + greater.getId() + "." + ("jpeg".equals(suff) ? "jpg" :suff);
			String imgFilePath = GloabConstant.ROOT_DIR +"userImages/"+ imageName;
			FileOutputStream out = new FileOutputStream(imgFilePath);
			out.write(decodedBytes);
			out.close();
			
			ImageUtil.cutImage(imgFilePath, imgFilePath, 
					suff,coord);
		} catch (Exception e) {
			e.printStackTrace();
		}

		Map<String, Object> m = new HashMap<String, Object>();
		
		greater.setUrl("/download/userImages/" + imageName);
		mainService.becomeGreater(greater);
		
		m.put("success", true);
		m.put("url", greater.getUrl());
		return m;
	}
	
	/**
	 * 更新大拿信息
	 * 
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/updateGreater", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateGreater(Greater greater,String image, 
			ImageCoord coord,HttpServletRequest req) {
		if(!Utils.isEmpty(image)){
			Pattern pattern = Pattern.compile("data:image/(.*?);base64,");
			Matcher match = pattern.matcher(image);
			String suff = null;
			if (match.find()) {
				suff = match.group(1);
				LOG.info(suff);
				image = image.replace(match.group(), "");
			}
			BASE64Decoder decoder = new BASE64Decoder();
			
			String imageName = "";
			try {
				byte[] decodedBytes = decoder.decodeBuffer(image);
				imageName = "greater_" +System.currentTimeMillis() 
						+ "_" + greater.getId() + "." + ("jpeg".equals(suff) ? "jpg" :suff);
				String imgFilePath = GloabConstant.ROOT_DIR +"userImages/"+ imageName;
				FileOutputStream out = new FileOutputStream(imgFilePath);
				out.write(decodedBytes);
				out.close();
				
				ImageUtil.cutImage(imgFilePath, imgFilePath, 
						suff,coord);
			} catch (Exception e) {
				e.printStackTrace();
			}
			greater.setUrl("/download/userImages/" + imageName);
		}

		Map<String, Object> m = new HashMap<String, Object>();
		mainService.updateGreater(greater);
		m.put("success", true);
		m.put("url", greater.getUrl());
		return m;
	}
	
	/**
	 * 获取大拿信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/getGreaterInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getGreaterInfo(String id) {
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("success", true);
		m.put("greater", mainService.getGreaterInfo(id));
		return m;
	}
	
	/**
	 * 获取话题列表
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/listTopics", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> listTopics(String id) {
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("success", true);
		m.put("topics", mainService.listTopics(id));
		return m;
	}
	
	/**
	 * 获取话题信息
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/getTopicInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getTopicInfo(String id) {
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("success", true);
		m.put("topic", mainService.getTopicInfo(id));
		return m;
	}
	
	/**
	 * 删除话题
	 * @param topic
	 * @return
	 */
	@RequestMapping(value = "/delTopic", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delTopic(String id) {
		Map<String, Object> m = new HashMap<String, Object>();
		mainService.delTopic(id);
		m.put("success", true);
		return m;
	}
	
	/**
	 * 新增/编辑话题
	 * @param topic
	 * @return
	 */
	@RequestMapping(value = "/saveTopic", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveTopic(Topic topic) {
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("success", true);
		m.put("id", mainService.saveTopic(topic));
		return m;
	}

	/**
	 * 聊天入口
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/talk", method = { RequestMethod.GET })
	public String talk(String groupId, HttpSession session, Model model) {
		model.addAttribute("groupId", groupId);
		return "pages/talk";
	}
	
	/**
	 * 注销操作
	 * 
	 * @return
	 */
	@RequestMapping(value = "/listSchools", method = {RequestMethod.POST,RequestMethod.GET})
	@ResponseBody
	public Map<String, Object> listSchools() {
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("success", true);
		m.put("value", mainService.listSchools());
		return m;
	}
}
