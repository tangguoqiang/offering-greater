package com.offering.core.dao.impl;

import java.sql.Types;

import org.springframework.stereotype.Repository;

import com.offering.bean.Greater;
import com.offering.bean.ParamInfo;
import com.offering.common.constant.GloabConstant;
import com.offering.common.utils.Utils;
import com.offering.core.dao.GreaterDao;

@Repository
public class GreaterDaoImpl extends BaseDaoImpl<Greater> implements GreaterDao{

	/**
	 * 根据id获取大拿信息
	 * @param id
	 * @return
	 */
	public Greater getGreaterInfo(String id){
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT T1.id,T2.nickname,T2.url,T1.company,T1.post,T2.industry,T1.workYears, ")
		   .append("T1.online_startTime,T1.online_endTime,T1.tags,T1.introduce, ")
		   .append("T4.name industryName,T2.schoolId,T3.name schoolName ")
		   .append("FROM USER_GREATER T1 ")
		   .append("INNER JOIN USER_INFO T2 ON T2.ID=T1.ID ")
		   .append("LEFT JOIN SYS_SCHOOL T3 ON T3.id=T2.schoolId ")
		   .append("LEFT JOIN SYS_DICT T4 ON T4.code=T2.industry AND T4.groupName=? ")
		   .append("WHERE T1.id=? ");
		ParamInfo paramInfo = new ParamInfo();
		paramInfo.setTypeAndData(Types.VARCHAR,GloabConstant.GROUP_INDUSTRY);
		paramInfo.setTypeAndData(Types.BIGINT, id);
		return getRecord(sql.toString(), paramInfo, Greater.class);
	}
	
	/**
	 * 更新大拿信息
	 * @param greater
	 */
	public void updateGreater(Greater greater){
		StringBuilder sql = new StringBuilder();
		sql.append("UPDATE USER_GREATER SET ");
		ParamInfo paramInfo = new ParamInfo();
		if(!Utils.isEmpty(greater.getCompany()))
		{
			sql.append("company=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, greater.getCompany());
		}
		
		if(!Utils.isEmpty(greater.getPost()))
		{
			sql.append("post=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, greater.getPost());
		}
		
		if(!Utils.isEmpty(greater.getWorkYears()))
		{
			sql.append("workYears=?,");
			paramInfo.setTypeAndData(Types.INTEGER, greater.getWorkYears());
		}
		
		if(!Utils.isEmpty(greater.getOnline_startTime()))
		{
			sql.append("online_startTime=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, greater.getOnline_startTime());
		}
		
		if(!Utils.isEmpty(greater.getOnline_endTime()))
		{
			sql.append("online_endTime=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, greater.getOnline_endTime());
		}
		
		if(!Utils.isEmpty(greater.getTags()))
		{
			sql.append("tags=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, greater.getTags());
		}
		
		if(!Utils.isEmpty(greater.getIntroduce()))
		{
			sql.append("introduce=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, greater.getIntroduce());
		}
		
		if(sql.toString().endsWith(","))
		{
			sql.replace(sql.length() - 1, sql.length(), "");
			sql.append(" where id=?");
			paramInfo.setTypeAndData(Types.BIGINT, greater.getId());
			
			updateRecord(sql.toString(), paramInfo);
		}
	}
}
