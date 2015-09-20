package com.offering.core.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.offering.bean.Greater;
import com.offering.bean.User;
import com.offering.common.constant.GloabConstant;
import com.offering.common.utils.MD5Util;
import com.offering.common.utils.RCUtils;
import com.offering.common.utils.Utils;
import com.offering.core.service.MainService;
import com.offering.core.service.UserService;

@Controller
public class MainController {
	
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
		User user = (User)session.getAttribute("user");
		return "pages/greater";
	}
	
	@RequestMapping(value = "/activity",  method ={RequestMethod.POST,RequestMethod.GET})
	public String activity(HttpSession session) {
		User user = (User)session.getAttribute("user");
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
			@RequestParam("username") String username,
			@RequestParam("nickname")String nickname,
			@RequestParam("company")String company,
			@RequestParam("specialty")String specialty,
			@RequestParam("experience")String experience,
			@RequestParam("tags")String tags,
			@RequestParam("job")String job,
			HttpServletRequest req){
		Map<String, Object> m = new HashMap<String, Object>();
		Greater greater = new Greater();
		User user = userService.getUserInfoByNickName(username);
		user.setType(GloabConstant.USER_TYPE_GREATER);
		greater.setCompany(company);
		greater.setJob(job);
		greater.setExperience(experience);
		greater.setSpecialty(specialty);
		greater.setTags(tags);
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
			@RequestParam("password")String password,HttpServletRequest req){
		Map<String, Object> m = new HashMap<String, Object>();
		User user = new User();
		user.setPhone(phone);
		user.setPassword(MD5Util.string2MD5(password));
		user.setType(GloabConstant.USER_TYPE_NORMAL);
		boolean isExists = userService.isExistUser(user);
		if(isExists){
			m.put("success", false);
			m.put("msg", "用户名已经存在！");
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
	 * 文件下载
	 * @param path
	 * @param fileName
	 * @return
	 */
	@RequestMapping(value = "/download/{path}/{fileName}.{suff}",method={RequestMethod.GET,RequestMethod.POST})
	public void dowload(@PathVariable("path")String path, 
			@PathVariable("fileName")String fileName,@PathVariable("suff")String suff,
			HttpServletResponse rep){
		rep.setHeader("Content-Disposition", "attachment; filename=" + fileName + "." + suff);  
		rep.setContentType("image/*");  
		String filePath = GloabConstant.ROOT_DIR + path + "/" + fileName + "." + suff;
		FileInputStream fis = null; 
        OutputStream os = null; 
        try {
        	fis = new FileInputStream(filePath);
            os = rep.getOutputStream();
            int count = 0;
            byte[] buffer = new byte[1024*8];
            while ( (count = fis.read(buffer)) != -1 ){
              os.write(buffer, 0, count);
              os.flush();
            }
        }catch(Exception e){
        	e.printStackTrace();
        }finally {
            try {
				fis.close();
				os.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
	}
	
	/**
	 * 微信分享页面-活动
	 * 
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/wxshare/activity_{id}",  method ={RequestMethod.POST,RequestMethod.GET})
	public String share_wx_activity(@PathVariable("id")String id,Model model) {
		model.addAttribute("activityId", id);
		return "pages/wx/share";
	}
	
	/**
	 * 微信分享页面-群成员
	 * 
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/wxshare/groupmember_{id}",  method ={RequestMethod.POST,RequestMethod.GET})
	public String share_wx_group(@PathVariable("id")String id,Model model) {
		model.addAttribute("groupId", id);
		return "pages/wx/share_group";
	}
	
	/**
	 * 微信打开APP页面
	 * 
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/wxshare/open_app",  method ={RequestMethod.POST,RequestMethod.GET})
	public String open_app() {
		return "pages/wx/open_app";
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
