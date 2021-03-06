package com.hotent.platform.service.system;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.model.TaskExecutor;
import com.hotent.core.service.BaseService;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.platform.model.system.UserUnder;
import com.hotent.platform.auth.ISysUser;
import com.hotent.platform.dao.system.SysUserDao;
import com.hotent.platform.dao.system.UserUnderDao;

/**
 * 对象功能:下属管理 Service类
 * 开发公司:
 * 开发人员:ray
 * 创建时间:2012-07-05 10:08:08
 */
@Service
public class UserUnderService extends BaseService<UserUnder>
{
	@Resource
	private UserUnderDao dao;
	@Resource
	private SysUserDao sysUserDao;
	
	public UserUnderService()
	{
	}
	
	@Override
	protected IEntityDao<UserUnder, Long> getEntityDao() 
	{
		return dao;
	}

	
	/**
	 * 获取某用户的下属用户
	 * @param userId
	 * @return
	 */
	public List<UserUnder> getMyUnderUser(Long userId){
		return dao.getMyUnderUser(userId);
	}
	
	/**
	 * 添加下属用户。
	 * @param userId	领导ID
	 * @param userIds	下属用户ID使用逗号分隔。
	 * @param userNames	下属用户名称使用逗号分隔。
	 * @throws Exception 
	 */
	public void addMyUnderUser(Long userId,String userIds,String userNames) throws Exception {
		String[] idArray=userIds.split(",");
		String[] nameArray=userNames.split(",");
		UserUnder userUnder=new UserUnder();
		userUnder.setUserid(userId);
		for(int i=0;i<idArray.length;i++){
			userUnder.setId(UniqueIdUtil.genId());			
			userUnder.setUnderuserid(Long.parseLong(idArray[i]));
			userUnder.setUnderusername(nameArray[i]);
			if(dao.isExistUser(userUnder)>0)  continue;
			dao.add(userUnder);
		}
	}

	

	/**
	 * 获取我的下属用户ID集合。
	 * @param userId
	 * @return
	 */
	public Set<String> getMyUnderUserId(Long userId){
		Set<String> list=new HashSet<String>();
		List<UserUnder> listUser= dao.getMyUnderUser(userId);
		for(UserUnder user:listUser){
			list.add(user.getUnderuserid().toString());
		}
		return list;
	} 
	
	/**
	 * 根据用户获取领导Id号。
	 * @param userId
	 * @return
	 */
	public Set<TaskExecutor> getMyLeader(Long userId){
		Set<TaskExecutor> list=new HashSet<TaskExecutor>();
		List<UserUnder> userList= dao.getMyLeader(userId);
		for(UserUnder user:userList){
			list.add(TaskExecutor.getTaskUser( user.getUserid().toString(),user.getLeaderName()));
		}
		return list;
	}
	
	/**
	 * 根据用户获取领导。
	 * @param userId
	 * @return
	 */
	public List<ISysUser> getMyLeaders(Long userId){		
		return sysUserDao.getUserByUnderUserId(userId);
	}
}
