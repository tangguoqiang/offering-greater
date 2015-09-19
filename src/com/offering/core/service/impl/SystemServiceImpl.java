package com.offering.core.service.impl;

import java.sql.Types;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.offering.bean.Comcode;
import com.offering.bean.ParamInfo;
import com.offering.bean.School;
import com.offering.bean.Suggest;
import com.offering.common.utils.Utils;
import com.offering.core.dao.BaseDao;
import com.offering.core.service.SystemService;

@Service
public class SystemServiceImpl implements SystemService{

	@Autowired
	private BaseDao<School> schoolDao;
	@Autowired
	private BaseDao<Comcode> comcodeDao;
	@Autowired
	private BaseDao<Suggest> suggestDao;
	
	public List<School> listSchools(String province)
	{
		StringBuilder sql = new StringBuilder();
		sql.append(" select id,name,province from SYS_SCHOOL ");
		if(!Utils.isEmpty(province))
		{
			sql.append("where province=? ");
			ParamInfo paramInfo = new ParamInfo();
			paramInfo.setTypeAndData(Types.VARCHAR, province);
			return schoolDao.getRecords(sql.toString(),paramInfo,School.class);
		}
		return schoolDao.getRecords(sql.toString(),null,School.class);
	}
	
	public List<Comcode> getComcodeByGroup(String group)
	{
		StringBuilder sql = new StringBuilder();
		sql.append(" select code,name from SYS_DICT WHERE groupName=? ");
		ParamInfo paramInfo = new ParamInfo();
		paramInfo.setTypeAndData(Types.VARCHAR, group);
		return comcodeDao.getRecords(sql.toString(),paramInfo,Comcode.class);
	}
	
	public void insertSuggest(Suggest s)
	{
		suggestDao.insertRecord(s, "SYS_SUGGEST");
	}
}
