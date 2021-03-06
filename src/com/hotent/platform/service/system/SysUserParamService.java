package com.hotent.platform.service.system;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.platform.dao.system.SysUserParamDao;
import com.hotent.platform.model.system.SysUserParam;

/**
 * 对象功能:人员参数属性 Service类
 * 开发公司:
 * 开发人员:csx
 * 创建时间:2012-02-24 10:04:50
 */
@Service
public class SysUserParamService extends BaseService<SysUserParam>
{
	@Resource
	private SysUserParamDao sysUserParamDao;
	
	public SysUserParamService()
	{
	}
	
	@Override
	protected IEntityDao<SysUserParam, Long> getEntityDao() 
	{
		return sysUserParamDao;
	}
	
	/**
	 * 添加用户参赛数。
	 * @param userId		用户id
	 * @param valueList		用户参数列表。
	 */
	public void add(long userId,List<SysUserParam> valueList){
		sysUserParamDao.delByUserId(userId);
		if(valueList==null||valueList.size()==0)return;
		for(SysUserParam p:valueList){
			sysUserParamDao.add(p);
		}
	}
	
	/**
	 * 根据用户id获取用户参数。
	 * @param userId
	 * @return
	 */
	public List<SysUserParam> getByUserId(long userId){
		return sysUserParamDao.getBySqlKey("getByUserId", userId);
	}
}
