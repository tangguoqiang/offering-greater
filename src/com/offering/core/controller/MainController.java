package com.offering.core.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.offering.bean.Greater;
import com.offering.bean.User;
import com.offering.common.constant.GloabConstant;
import com.offering.common.utils.CCPUtils;
import com.offering.common.utils.MD5Util;
import com.offering.common.utils.RCUtils;
import com.offering.common.utils.Utils;
import com.offering.core.service.MainService;
import com.offering.core.service.UserService;

@Controller
public class MainController {
	
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
	@RequestMapping(value = "/",  method ={RequestMethod.POST,RequestMethod.GET})
	public String frontdoor(HttpSession session) {
//		User user = (User)session.getAttribute("user");
		return "pages/index";
	}

	/**
	 * 管理员入口操作
	 * 
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/admin",  method ={RequestMethod.POST,RequestMethod.GET})
	public String door(HttpSession session) {
		User user = (User)session.getAttribute("user");
		if(user != null){
			return "pages/adminindex";
		}else{
			return "pages/adminlogin";
		}
	}
	
	@RequestMapping(value = "/greater",  method ={RequestMethod.POST,RequestMethod.GET})
	public String greater(HttpSession session) {
//		User user = (User)session.getAttribute("user");
		return "pages/greater";
	}
	
	@RequestMapping(value = "/activity",  method ={RequestMethod.POST,RequestMethod.GET})
	public String activity(HttpSession session) {
//		User user = (User)session.getAttribute("user");
		return "pages/activity";
	}
	
	/**
	 * 新增大拿
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/becomeGreater", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> addGreater(
			@RequestParam("userid") String userid,
			@RequestParam("nickname")String nickname,
			@RequestParam("company")String company,
			@RequestParam("post")String post,
			@RequestParam("experience")String experience,
			@RequestParam("tags")String tags,
			@RequestParam("job")String job,
			HttpServletRequest req){
		Map<String, Object> m = new HashMap<String, Object>();
		Greater greater = new Greater();
		User user = userService.getUserInfoById(userid);
		user.setNickname(nickname);
		user.setType(GloabConstant.USER_TYPE_GREATER);
		greater.setCompany(company);
		greater.setJob(job);
		greater.setPost(post);
		greater.setExperience(experience);
		greater.setTags(tags);
		greater.setIsshow(GloabConstant.YESNO_NO);
		userService.insertGreater(user, greater);
		m.put("success", true);
		return m;
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
			@RequestParam("password")String password,HttpServletRequest req) {
		Map<String, Object> m = new HashMap<String, Object>();
		User user = userService.getUserInfoByPhone(phone,MD5Util.string2MD5(password));
		if(user != null){
			m.put("success", true);
			m.put("username", user.getName());
			m.put("nickname", user.getNickname());
			m.put("type", user.getType());
			if(Utils.isEmpty(user.getRc_token()))
			{
				String rc_token = RCUtils.getToken(user.getId(), user.getNickname(), "");
				userService.updateRCToken(user.getId(), rc_token);
				user.setRc_token(rc_token);
				m.put("rc_token", rc_token);
			}
		}else{
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
		req.getSession().setAttribute("user",null);
		return m;
	}
	
	/**
	 * 注册用户
	 * @param user
	 * @return
	 */
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> saveUser(@RequestParam("phone") String phone,
			@RequestParam("password")String password,String code,HttpServletRequest req){
		Map<String, Object> m = new HashMap<String, Object>();
		if(code == null || !code.equals(idCodeMap.get(phone)))
		{
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
		if(isExists){
			m.put("success", false);
			m.put("msg", "该手机已注册！");
		}else{
			if(Utils.isEmpty(user.getId())){
				//新增用户
				userService.insertUser(user);
			}else{
				//更新用户信息
				userService.updateUser(user);
			}
			m.put("success", true);
		}
		
		User returnUser = userService.getUserInfoByPhone(phone,null);
		if(returnUser != null){
			m.put("success", true);
			if(Utils.isEmpty(returnUser.getRc_token()))
			{
				String rc_token = RCUtils.getToken(returnUser.getId(), returnUser.getNickname(), "");
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
	public Map<String, Object> resetPass(String userName,
			String oldPass,String newPass) {
		Map<String, Object> m = new HashMap<String, Object>();
		User user = mainService.getUserInfo(userName,MD5Util.string2MD5(oldPass));
		if(user != null){
			mainService.resetPass(userName,MD5Util.string2MD5(newPass));
			m.put("success", true);
		}else{
			m.put("success", false);
			m.put("msg", "旧密码输入错误！");
		}
		return m;
	}
	
	/**
	 * 获取验证码
	 * @param phone
	 * @return
	 */
	@RequestMapping(value = "/getCode",method={RequestMethod.POST})
	@ResponseBody
	public Map<String, Object> getCode(String phone,String type,HttpServletRequest req) {
		Map<String, Object> m = Utils.checkParam(req, new String[]{"phone"});
		if(m != null)
			return m;
		
		
		User user = new User();
		user.setPhone(phone);
		boolean isExists = userService.isExistUser(user);
		if(GloabConstant.CODE_REG.equals(type) && isExists)
		{
			return Utils.failture("该号码已经注册！");
		}
		
		if(GloabConstant.CODE_FINDPASS.equals(type) && !isExists)
		{
			return Utils.failture("该号码还未注册！");
		}
		
		if(timeMap.containsKey(phone))
		{
			if(System.currentTimeMillis() - timeMap.get(phone) <= 6000)
			{
				return Utils.failture("一分钟内只能申请一次验证码!");
			}
		}
		String idCode = Utils.createIdCode();
		String msg = CCPUtils.sendSMS(phone, idCode);
		if(Utils.isEmpty(msg))
		{
			//TODO 验证码时效性实现 memcache或redis
			idCodeMap.put(phone, idCode);
			timeMap.put(phone, System.currentTimeMillis());
			return Utils.success(null);
		}else
			return Utils.failture(msg);
	}
	
	/**
	 * 聊天入口
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/talk",  method ={RequestMethod.GET})
	public String talk(String groupId,HttpSession session,Model model) {
		model.addAttribute("groupId", groupId);
		return "pages/talk";
	}
}

