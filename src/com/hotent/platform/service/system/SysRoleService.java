package com.hotent.platform.service.system;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hotent.core.cache.ICache;
import com.hotent.core.util.AppUtil;
import com.hotent.core.util.BeanUtils;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.platform.auth.IAuthenticate;
import com.hotent.platform.auth.ISysRole;
import com.hotent.platform.dao.system.ResourcesDao;
import com.hotent.platform.dao.system.ResourcesUrlDao;
import com.hotent.platform.dao.system.RoleResourcesDao;
import com.hotent.platform.dao.system.UserRoleDao;
import com.hotent.platform.model.system.ResourcesUrlExt;
import com.hotent.platform.model.system.RoleResources;
import com.hotent.platform.model.system.SysOrgRole;
import com.hotent.platform.model.system.UserRole;

/**
 * 对象功能:系统角色表 Service类
 * 开发公司:广州宏天软件有限公司
 * 开发人员:csx
 * 创建时间:2011-11-18 16:24:10
 */
@Service
public class SysRoleService
{
	@Resource
	private ResourcesDao resourcesDao;
	@Resource
	private ResourcesUrlDao resourcesUrlDao;
	
	@Resource
	UserRoleDao userRoleDao;
	@Resource
	private RoleResourcesDao roleResourcesDao;
	@Resource
	private SysOrgRoleService sysOrgRoleService;
	
	@Resource
	private IAuthenticate iAuthenticate;

	
	public SysRoleService()
	{
	}
	
	public void add(ISysRole role){
		iAuthenticate.add(role);
	}
	
	public void delById(Long id){
		iAuthenticate.delById(ISysRole.class, id);
	}
	
	public void delByIds(Long[] ids){
		iAuthenticate.delByIds(ISysRole.class, ids);
	}
	
	public void update(ISysRole role){
		iAuthenticate.update(role);
	}
	
	public ISysRole getById(Long id){
		return iAuthenticate.getRoleByRoleId(id);
	}
	
	public List<ISysRole> getAll()	{
		return iAuthenticate.getAllRoles();
	}
	
	public List<ISysRole> getAll(QueryFilter queryFilter){
		return iAuthenticate.queryRole(queryFilter);
	}
	
	/**
	 * 判断角色是否存在
	 * @param roleName
	 * @return
	 */
	public boolean isExistRoleAlias(String alias){
		return iAuthenticate.isExistRoleAlias(alias);
	}
	
	/**
	 * 判断角色是否存在。
	 * 用于更新时判断。
	 * @param alias	角色别名
	 * @param roleId	角色id。
	 * @return
	 */
	public boolean isExistRoleAliasForUpd(String alias,Long roleId){
		return iAuthenticate.isExistRoleAliasForUpd(alias,roleId);
	}
	
	/**
	 * 查询所有角色及子系统
	 * @param queryFilter
	 * @return
	 */
	public List<ISysRole> getRoleList(QueryFilter queryFilter){
		return iAuthenticate.queryRole(queryFilter);
	}
	
	/**
	 * 根据UserId取得系统角色
	 * @param userId
	 * @return
	 */
	public List<ISysRole> getByUserId(Long userId){
		return iAuthenticate.getRolesUserHas(userId);
	}
	
	/**
	 * 根据系统id获取角色。
	 * @param systemId
	 * @return
	 */
	public List<ISysRole> getBySystemId(Long systemId){
		return iAuthenticate.getRoleBySystemId(systemId);
	}
	
	/**
	 * 返回某个用户的所有角色列表Id
	 * @param userId
	 * @return
	 */
	public String getRoleIdsByUserId(Long userId){
		StringBuffer sb=new StringBuffer("");
		List<ISysRole> sysRoleList=getByUserId(userId);
		for(ISysRole sysRole:sysRoleList){
			sb.append(sysRole.getRoleId()).append(",");
		}
		if(sysRoleList.size()>0){
			sb.deleteCharAt(sb.length()-1);
		}
		return sb.toString();
	}
	
	/**
	 * 获取所有子系统的角色
	 * @param queryFilter
	 * @return
	 */
	public List<ISysRole> getRoleTree(QueryFilter queryFilter){
		return iAuthenticate.queryRole(queryFilter);
	}
	

	
	/**
	 * 根据系统ID获取资源的URL和角色映射对象。
	 * <br>
	 * <pre>
	 * 	ResourcesUrlExt 的url字段和role 别名。
	 * 		1.从SYS_RES 的 defaultUrl获取。
	 * 		2.从SYS_RESURL 表中获取。
	 * </pre>
	 * @param systemId
	 * @return
	 */
	public List<ResourcesUrlExt> getUrlRightMap(Long systemId){
		//根据resourcesUrl的url
		List<ResourcesUrlExt> urlList=resourcesUrlDao.getUrlAndRoleBySystemId(systemId);
		//resources的defaultUrl
		List<ResourcesUrlExt> defaultUrlList=resourcesDao.getDefaultUrlAndRoleBySystemId(systemId);
		List<ResourcesUrlExt> returnList=new ArrayList<ResourcesUrlExt>();
		if(urlList!=null&&urlList.size()>0)
			returnList.addAll(urlList);
		if(defaultUrlList!=null&&defaultUrlList.size()>0)
			returnList.addAll(defaultUrlList);
		return returnList;
	}
	
	/**
	 * 根据系统id获取系统的功能和角色别名映射对象。
	 * 用于在页面判断功能是否可用。
	 * @param systemId
	 * @return
	 */
	public List<ResourcesUrlExt> getFunctionRoleList(Long systemId){
		List<ResourcesUrlExt> defaultUrlList=resourcesDao.getFunctionAndRoleBySystemId(systemId);
		return defaultUrlList;
	}
	
//	/**
//	 * 根据系统的URL获取功能。
//	 * @param defaultUrl
//	 * @return
//	 */
//	public List<ResourcesUrlExt> getSubSystemFunction(String alias){
//		List<ResourcesUrlExt> defaultUrlList=resourcesDao.getSubSystemsFuncByAlias(alias);
//		return defaultUrlList;
//	}
	
	/**
	 * 根据子系统的访问地址获取子系统的资源。
	 * @param defaultUrl
	 * @return
	 */
//	public List<ResourcesUrlExt> getSubSystemResources(String alias){
//		//根据resourcesUrl的url
//		List<ResourcesUrlExt> urlList=resourcesUrlDao.getSubSystemResByAlias(alias);
//		//resources的defaultUrl
//		List<ResourcesUrlExt> defaultUrlList=resourcesDao.getSubSystemResByAlias(alias);
//		
//		
//		List<ResourcesUrlExt> returnList=new ArrayList<ResourcesUrlExt>();
//		if(urlList!=null&&urlList.size()>0)
//			returnList.addAll(urlList);
//		if(defaultUrlList!=null&&defaultUrlList.size()>0)
//			returnList.addAll(defaultUrlList);
//		return returnList;
//	}
	
	/**
	 * 复制原角色下的所有特性。
	 * <pre>
	 * 	1.添加角色。
	 *  2.用户角色映射表。
	 *  3.添加角色和资源映射。
	 *  4.添加角色和系统的映射。
	 * </pre>
	 * @param sysRole
	 * @param userRoleList
	 * @throws Exception
	 */
	public void copyRole(ISysRole sysRole,long oldRoleId) throws Exception{
		//查询原用户拥有的系统资源特性
		List<RoleResources> roleResourcesList=roleResourcesDao.getRoleRes(oldRoleId);
		//查询原用户下拥有的人员
		List<UserRole> userRoleList=userRoleDao.getUserRoleByRoleId(oldRoleId);
		
		Long newRoleId=sysRole.getRoleId();
		//向角色表中添加数据
		iAuthenticate.add(sysRole);
	    //向用户角色映射表中添加数据
		for(UserRole userRole:userRoleList){
			UserRole ur=(UserRole) userRole.clone();
			ur.setUserRoleId(UniqueIdUtil.genId());
			ur.setRoleId(newRoleId);
			userRoleDao.add(ur);
		}
		//向角色资源映射表中添加数据
		for(RoleResources rores:roleResourcesList){
			RoleResources roleres=(RoleResources)rores.clone();
			roleres.setRoleResId(UniqueIdUtil.genId());
			roleres.setRoleId(newRoleId);
			roleResourcesDao.add(roleres);
		}
		
	}
	
	/**
	 *取得子系统角色资源
	 * @param defaultUrl
	 * @return
	 */
	public List<ISysRole> loadSecurityRole(String systemId, String roleName ){
		return iAuthenticate.getRoleBySystemId(systemId, roleName);
	}
	
	/**
	 * 根据用户ID和组织ID获取用户角色
	 * <pre>
	 * 1、用户和角色有映射关系，可以获取到用户所拥有的角色；
	 * 2、组织和角色有映射关系，可以获取到组织所拥有的角色；
	 * 3、用户可以切换当前组织，根据用户ID和当前组织ID可以获取到2个角色列表的并集。
	 * </pre>
	 * @param userId
	 * @param orgId
	 * @return
	 */
	public List<String> getRolesByUserIdAndOrgId(Long userId,Long orgId){
		List<String> totalRoles=new ArrayList<String>();
		//根据用户获取
		List<String> userRoles= getUserRoles(userId);
		
		if(BeanUtils.isNotEmpty(userRoles)){
			totalRoles.addAll(userRoles);
		}
		//根据组织获取。
		if(orgId>0){
			List<String> roleRoles= getOrgRoles(orgId);
			if(BeanUtils.isNotEmpty(roleRoles)){
				totalRoles.addAll(roleRoles);
			}
		}
		return totalRoles;
	}
	
	/**
	 * 根据用户角色关系获取角色。
	 * @param userId
	 * @return
	 */
	private List<String> getUserRoles(Long userId){
		ICache iCache = (ICache) AppUtil.getBean(ICache.class);
		String urerKey=SecurityUtil.UserRole + userId;
		List<String> list=(List<String>)iCache.getByKey(urerKey);
		if(BeanUtils.isNotEmpty(list)) return list;
		
		//获取用户角色。
		List<ISysRole> userRoleList= iAuthenticate.getRolesUserHas(userId);
		
		List<String> userRoles=new ArrayList<String>();
		if(BeanUtils.isNotEmpty(userRoleList)){
			for(ISysRole role:userRoleList){
				userRoles.add(role.getAlias());
			}
			//加入缓存
			iCache.add(urerKey, userRoles);
		}
		return userRoles;
	}
	
	/**
	 * 根据组织Id获取角色。
	 * @param orgId
	 * @return
	 */
	private List<String> getOrgRoles(Long orgId){
		ICache iCache = (ICache) AppUtil.getBean(ICache.class);
		String orgKey=SecurityUtil.OrgRole + orgId;
		List<String> list=(List<String>)iCache.getByKey(orgKey);
		//从缓存获取
		if(BeanUtils.isNotEmpty(list))
			return list;
		//根据缓存读取。
		List<SysOrgRole> orgRoles = sysOrgRoleService.getRolesByOrgId(orgId);
		
		List<String> roles=new ArrayList<String>();
		if(BeanUtils.isNotEmpty(orgRoles)){
			for(SysOrgRole sysOrgRole:orgRoles){
				ISysRole role=sysOrgRole.getRole();
				if(role==null) continue;
				roles.add(role.getAlias());
			}
			//加入缓存。
			iCache.add(orgKey, roles);
		}
		return roles;
	}
}
