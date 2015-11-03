package com.offering.core.dao;

import com.offering.bean.User;

public interface UserDao extends BaseDao<User>{

	/**
	 * 根据用户id获取用户信息
	 * @param userId
	 * @return
	 */
	User getUserInfoById(String userId);
	
	/**
	 * 更新用户
	 * @param user
	 * @return
	 */
	void updateUser(User user);
}
