package com.offering.core.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.offering.bean.School;
import com.offering.core.dao.SchoolDao;

@Repository
public class SchoolDaoImpl extends BaseDaoImpl<School> implements SchoolDao{

	/**
	 * 获取学校数据
	 * @return
	 */
	public List<School> listSchools(){
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT id,name FROM SYS_SCHOOL ");
		
		return getRecords(sql.toString(), null, School.class);
	}
}
