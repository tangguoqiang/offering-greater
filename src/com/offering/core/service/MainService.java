package com.offering.core.service;

import java.util.List;

import com.offering.bean.Greater;
import com.offering.bean.School;
import com.offering.bean.Topic;
import com.offering.bean.User;

/**
 * 入口service
 * @author gtang
 *
 */
public interface MainService {

	/**
	 * 根据用户名和密码获取用户信息
	 * @param username
	 * @param password
	 * @return
	 */
	public User getUserInfo(String username,String password);
	
	/**
	 * 修改密码
	 * @param username
	 * @param password
	 */
	public void resetPass(String username,String password);
	
	
	/**
	 * 成为大拿
	 * @param greater
	 */
	void becomeGreater(Greater greater);
	
	/**
	 * 更新大拿信息
	 * @param greater
	 */
	void updateGreater(Greater greater);
	
	/**
	 * 根据id获取大拿信息
	 * @param id
	 * @return
	 */
	Greater getGreaterInfo(String id);
	
	/**
	 * 根据id获取话题列表
	 * @param greaterId
	 * @return
	 */
	List<Topic> listTopics(String greaterId);
	
	/**
	 * 根据id获取话题信息
	 * @param id
	 * @return
	 */
	Topic getTopicInfo(String id);
	
	/**
	 * 新增/编辑话题
	 * @param topic
	 * @return
	 */
	String saveTopic(Topic topic);
	
	/**
	 * 删除话题
	 * @param id
	 */
	void delTopic(String id);
	
	/**
	 * 获取学校数据i
	 * @return
	 */
	List<School> listSchools();
}
