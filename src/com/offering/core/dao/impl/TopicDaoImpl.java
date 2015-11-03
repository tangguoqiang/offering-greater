package com.offering.core.dao.impl;

import java.sql.Types;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.offering.bean.ParamInfo;
import com.offering.bean.Topic;
import com.offering.common.utils.Utils;
import com.offering.core.dao.TopicDao;

/**
 * 话题dao实现
 * @author surfacepro3
 *
 */
@Repository
public class TopicDaoImpl extends BaseDaoImpl<Topic> implements TopicDao{
	
	/**
	 * 根据大拿批量获取话题数据
	 * @param greaterId
	 * @return
	 */
	public List<Topic> listTopicsByGreaterId(String greaterId)
	{
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT T1.id,T1.greaterId,T1.title,T1.content ")
		   .append("FROM TOPIC_INFO T1 ")
		   .append("WHERE greaterId=? ");
		ParamInfo paramInfo = new ParamInfo();
		paramInfo.setTypeAndData(Types.BIGINT, greaterId);
		sql.append("ORDER BY id DESC ");
		
		return getRecords(sql.toString(),paramInfo,Topic.class);
	}
	
	/**
	 * 根据id获取话题信息
	 * @param id
	 * @return
	 */
	public Topic getTopicInfo(String id){
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT T1.id,T1.greaterId,T1.title,T1.content ")
		   .append("FROM TOPIC_INFO T1 ")
		   .append("WHERE T1.id=? ");
		ParamInfo paramInfo = new ParamInfo();
		paramInfo.setTypeAndData(Types.BIGINT, id);
		
		return getRecord(sql.toString(),paramInfo,Topic.class);
	}
	
	/**
	 * 更新话题信息
	 * @param topic
	 */
	public void updateTopic(Topic topic){
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE TOPIC_INFO SET ");
		ParamInfo paramInfo = new ParamInfo();
		if(!Utils.isEmpty(topic.getTitle()))
		{
			sql.append("title=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, topic.getTitle());
		}
		
		if(!Utils.isEmpty(topic.getContent()))
		{
			sql.append("content=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, topic.getContent());
		}
		
		
		if(sql.toString().endsWith(","))
		{
			sql.replace(sql.length() - 1, sql.length(), "");
			sql.append(" where id=?");
			paramInfo.setTypeAndData(Types.BIGINT, topic.getId());
			
			updateRecord(sql.toString(), paramInfo);
		}
	}

}
