package com.offering.core.dao;

import java.util.List;

import com.offering.bean.School;

public interface SchoolDao extends BaseDao<School>{

	/**
	 * 获取学校数据
	 * @return
	 */
	List<School> listSchools();
}
