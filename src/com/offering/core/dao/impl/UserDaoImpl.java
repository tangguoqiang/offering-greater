package com.offering.core.dao.impl;

import java.sql.Types;

import org.springframework.stereotype.Repository;

import com.offering.bean.ParamInfo;
import com.offering.bean.User;
import com.offering.common.constant.GloabConstant;
import com.offering.common.utils.Utils;
import com.offering.core.dao.UserDao;

@Repository
public class UserDaoImpl extends BaseDaoImpl<User> implements UserDao{

	/**
	 * 根据用户id获取用户信息
	 * @param userId
	 * @return
	 */
	public User getUserInfoById(String userId){
		StringBuilder sql = new StringBuilder();
		sql.append("select T1.id,password,token,phone,T1.name,nickname,industry,T1.type, ")
		   .append("schoolId,T2.name as schoolName,major,grade,T3.name AS gradeName,url,rc_token, ")
		   .append("background_url ")
		   .append("from USER_INFO T1 ")
		   .append("LEFT JOIN SYS_SCHOOL T2 ON T2.ID=T1.schoolId ")
		   .append("LEFT JOIN SYS_DICT T3 ON T3.CODE=T1.grade AND T3.groupName=? ")
		   .append("WHERE T1.id=?");
		ParamInfo paramInfo = new ParamInfo();
		paramInfo.setTypeAndData(Types.VARCHAR, GloabConstant.GROUP_GRADE);
		paramInfo.setTypeAndData(Types.BIGINT, userId);
		return getRecord(sql.toString(),paramInfo,User.class);
	}
	
	/**
	 * 更新用户
	 * @param user
	 * @return
	 */
	public void updateUser(User user){
		StringBuilder sql = new StringBuilder();
		sql.append("update USER_INFO set ");
		ParamInfo paramInfo = new ParamInfo();
		
		if(!Utils.isEmpty(user.getPhone()))
		{
			sql.append("phone=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, user.getPhone());
		}
		
		if(!Utils.isEmpty(user.getNickname()))
		{
			sql.append("nickname=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, user.getNickname());
		}
		
		if(!Utils.isEmpty(user.getSchoolId()))
		{
			sql.append("schoolId=?,");
			paramInfo.setTypeAndData(Types.BIGINT, user.getSchoolId());
		}
		
		if(!Utils.isEmpty(user.getMajor()))
		{
			sql.append("major=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, user.getMajor());
		}
		
		if(!Utils.isEmpty(user.getType()))
		{
			sql.append("type=?,");
			paramInfo.setTypeAndData(Types.CHAR, user.getType());
		}
		
		if(!Utils.isEmpty(user.getGrade()))
		{
			sql.append("grade=?,");
			paramInfo.setTypeAndData(Types.CHAR, user.getGrade());
		}
		
		if(!Utils.isEmpty(user.getUrl()))
		{
			sql.append("url=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, user.getUrl());
		}
		
		if(!Utils.isEmpty(user.getBackground_url()))
		{
			sql.append("background_url=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, user.getBackground_url());
		}
		
		if(!Utils.isEmpty(user.getIndustry()))
		{
			sql.append("industry=?,");
			paramInfo.setTypeAndData(Types.VARCHAR, user.getIndustry());
		}
		
		if(sql.toString().endsWith(","))
		{
			sql.replace(sql.length() - 1, sql.length(), "");
			sql.append(" where id=?");
			paramInfo.setTypeAndData(Types.BIGINT, user.getId());
			
			updateRecord(sql.toString(), paramInfo);
		}
	}
}
