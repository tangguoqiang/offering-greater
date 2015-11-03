package com.offering.core.dao;

import java.util.List;

import com.offering.bean.Topic;

/**
 * 话题dao
 * @author surfacepro3
 *
 */
public interface TopicDao extends BaseDao<Topic>{

	/**
	 * 根据大拿批量获取话题数据
	 * @param greaterId
	 * @return
	 */
	List<Topic> listTopicsByGreaterId(String greaterId);
	
	/**
	 * 根据id获取话题信息
	 * @param id
	 * @return
	 */
	Topic getTopicInfo(String id);
	
	/**
	 * 更新话题信息
	 * @param topic
	 */
	void updateTopic(Topic topic);
	
}
