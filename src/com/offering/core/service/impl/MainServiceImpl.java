package com.offering.core.service.impl;

import java.sql.Types;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.offering.bean.Greater;
import com.offering.bean.ParamInfo;
import com.offering.bean.School;
import com.offering.bean.Topic;
import com.offering.bean.User;
import com.offering.common.constant.GloabConstant;
import com.offering.common.utils.CCPUtils;
import com.offering.common.utils.Utils;
import com.offering.common.utils.CCPUtils.SmsType;
import com.offering.core.dao.BaseDao;
import com.offering.core.dao.GreaterDao;
import com.offering.core.dao.SchoolDao;
import com.offering.core.dao.TopicDao;
import com.offering.core.dao.UserDao;
import com.offering.core.service.MainService;

/**
 * 入口service的实现
 * @author gtang
 *
 */
@Service
public class MainServiceImpl implements MainService{
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private GreaterDao greaterDao;
	
	@Autowired
	private TopicDao topicDao;
	
	@Autowired
	private SchoolDao schoolDao;

	@Autowired
	public BaseDao<User> mainDao;
	
	/**
	 * 根据用户名和密码获取用户信息
	 * @param username
	 * @param password
	 * @return
	 */
	public User getUserInfo(String username,String password){
		String sql = " select id,name,type,status from USER_INFO WHERE name=? AND password=?";
		ParamInfo paramInfo = new ParamInfo();
		paramInfo.setTypeAndData(Types.VARCHAR, username);
		paramInfo.setTypeAndData(Types.VARCHAR, password);
		return mainDao.getRecord(sql,paramInfo,User.class);
	}
	
	/**
	 * 根据用户id获取用户信息
	 * @param id
	 * @return
	 */
	public User getUserInfoById(String id){
		return userDao.getUserInfoById(id);
	}
	
	/**
	 * 修改密码
	 * @param username
	 * @param password
	 */
	public void resetPass(String username,String password){
		String sql = "update USER_INFO set password =? WHERE name=? ";
		ParamInfo paramInfo = new ParamInfo();
		paramInfo.setTypeAndData(Types.VARCHAR, password);
		paramInfo.setTypeAndData(Types.VARCHAR, username);
		mainDao.updateRecord(sql, paramInfo);
	}
	
	/**
	 * 成为大拿
	 * @param greater
	 */
	@Transactional
	public void becomeGreater(Greater greater)
	{
		User user = new User();
		user.setId(greater.getId());
		user.setNickname(greater.getNickname());
		user.setIndustry(greater.getIndustry());
		user.setType(GloabConstant.USER_TYPE_GREATER);
		user.setUrl(greater.getUrl());
		user.setSchoolId(greater.getSchoolId());
		userDao.updateUser(user);
		
		if(!Utils.isEmpty(greater.getTags())){
			greater.setTags(greater.getTags().replaceAll("[，,]", ","));
		}
		greater.setIsshow(GloabConstant.YESNO_NO);
		greaterDao.insertRecord(greater, "USER_GREATER");
		
		//发送短信通知
		User u = userDao.getUserInfoById(greater.getId());
		CCPUtils.sendSMS(u.getPhone(), SmsType.GREATER, 
						null);
	}
	
	/**
	 * 更新大拿信息
	 * @param greater
	 */
	@Transactional
	public void updateGreater(Greater greater){
		User user = new User();
		user.setId(greater.getId());
		user.setNickname(greater.getNickname());
		user.setIndustry(greater.getIndustry());
		user.setUrl(greater.getUrl());
		user.setSchoolId(greater.getSchoolId());
		userDao.updateUser(user);
		
		if(!Utils.isEmpty(greater.getTags())){
			greater.setTags(greater.getTags().replaceAll("[，,]", ","));
		}
		greaterDao.updateGreater(greater);
	}
	
	/**
	 * 根据id获取大拿信息
	 * @param id
	 * @return
	 */
	public Greater getGreaterInfo(String id){
		return greaterDao.getGreaterInfo(id);
	}
	
	/**
	 * 根据id获取话题列表
	 * @param greaterId
	 * @return
	 */
	public List<Topic> listTopics(String greaterId){
		return topicDao.listTopicsByGreaterId(greaterId);
	}
	
	/**
	 * 根据id获取话题信息
	 * @param id
	 * @return
	 */
	public Topic getTopicInfo(String id){
		return topicDao.getTopicInfo(id);
	}
	
	/**
	 * 新增/编辑话题
	 * @param topic
	 * @return
	 */
	public String saveTopic(Topic topic){
		if(Utils.isEmpty(topic.getId())){
			return topicDao.insertRecord(topic, "TOPIC_INFO")+"";
		}else{
			topicDao.updateTopic(topic);
			return topic.getId();
		}
	}
	
	/**
	 * 删除话题
	 * @param id
	 */
	public void delTopic(String id){
		topicDao.delRecordById(id, "TOPIC_INFO");
	}
	
	/**
	 * 获取学校数据
	 * @return
	 */
	public List<School> listSchools(){
		return schoolDao.listSchools();
	}
}
