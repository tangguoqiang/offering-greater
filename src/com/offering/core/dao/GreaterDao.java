package com.offering.core.dao;

import com.offering.bean.Greater;

public interface GreaterDao extends BaseDao<Greater>{

	/**
	 * 根据id获取大拿信息
	 * @param id
	 * @return
	 */
	Greater getGreaterInfo(String id);
	
	/**
	 * 更新大拿信息
	 * @param greater
	 */
	void updateGreater(Greater greater);
}
