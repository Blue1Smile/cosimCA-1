package com.hotent.platform.model.system;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import com.hotent.core.model.BaseModel;
/**
 * 对象功能:子系统资源 Model对象
 * 开发公司:广州宏天软件有限公司
 * 开发人员:csx
 * 创建时间:2011-12-05 17:00:54
 */
public class Resources extends BaseModel
{
	//LOGO路径
	public final static String LOGO_PATH="/styles/default/images/logo";
	//ICON路径
	public final static String ICON_PATH="/styles/default/images/resicon";
	//图标类型
	public final static String ICON_TYPE = "PNG|JPG|JPEG|GIF";
	//扩展的功能按钮图标路径
	public final static String ICON_EXTEND="/styles/default/images/extendIcon";
	//扩展功能样式文件位置
	public final static String EXTEND_CSS_PATH="/styles/default/css/form.css";
	
	
	public final static String ICON_DEFAULT_FOLDER="/styles/default/images/icon/tree_folder.gif";
	public final static String ICON_DEFAULT_LEAF="/styles/default/images/icon/tree_file.gif";
	
	/**
	 * 根结点的父ID
	 */
	public final static long ROOT_PID=-1;//重要
	/**
	 * 根结点的ID
	 */
	public final static long ROOT_ID=0;
	
	/**
	 * 根结点的icon
	 */
	public final static String ROOT_ICON="/styles/default/images/icon/remoteupload.gif";
	
	/**
	 * 是否打开0否，1是。
	 */
	public final static Short IS_OPEN_N=0;
	public final static Short IS_OPEN_Y=1;
	/**
	 * 是否文件夹0否，1是
	 */
	public final static Short IS_FOLDER_N=0;
	public final static Short IS_FOLDER_Y=1;
	/**
	 * 是否显示到菜单0否，1是
	 */
	public final static Short IS_DISPLAY_IN_MENU_N=0;
	public final static Short IS_DISPLAY_IN_MENU_Y=1;
	
	
	public final static String IS_CHECKED_N="false";
	public final static String IS_CHECKED_Y="true";
	
	// resId
	protected Long resId;
	// 资源名称
	protected String resName;
	// 别名（系统中唯一)
	protected String alias;
	// 同级排序
	protected Integer sn;
	// 图标
	protected String icon;
	// 父ID
	protected Long parentId;
	// 默认地址
	protected String defaultUrl;
	// 栏目
	protected Short isFolder=IS_FOLDER_N;
	// 显示到菜单
	protected Short isDisplayInMenu;
	// 默认打开
	protected Short isOpen;
	// systemId
	protected Long systemId;
	//路径
	protected String path;
	//是否选中
	protected String checked=IS_CHECKED_N;
	
	private List<Resources> children = new ArrayList<Resources>();

	public String getChecked() {
		return checked;
	}
	public void setChecked(String checked) {
		this.checked = checked;
	}
	
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public void setResId(Long resId) 
	{
		this.resId = resId;
	}
	/**
	 * 返回 resId
	 * @return
	 */
	public Long getResId() 
	{
		return resId;
	}

	public void setResName(String resName) 
	{
		this.resName = resName;
	}
	/**
	 * 返回 资源名称
	 * @return
	 */
	public String getResName() 
	{
		return resName;
	}

	public void setAlias(String alias) 
	{
		this.alias = alias;
	}
	/**
	 * 返回 别名（系统中唯一)
	 * @return
	 */
	public String getAlias() 
	{
		return alias;
	}
 
	public void setSn(Integer sn) 
	{
		this.sn = sn;
	}
	/**
	 * 返回 同级排序
	 * @return
	 */
	public Integer getSn() 
	{
		return sn;
	}

	public void setIcon(String icon) 
	{
		this.icon = icon;
	}
	/**
	 * 返回 图标
	 * @return
	 */
	public String getIcon() 
	{
		if(icon==null||icon.indexOf(".")<0){
			if(isFolder!=null&&isFolder.equals(IS_FOLDER_Y)){
				icon=ICON_DEFAULT_FOLDER;
			}else if(isFolder!=null&&isFolder.equals(IS_FOLDER_N)){
				icon=ICON_DEFAULT_LEAF;
			}
		}
		return icon;
	}

	public void setParentId(Long parentId) 
	{
		this.parentId = parentId;
	}
	/**
	 * 返回 父ID
	 * @return
	 */
	public Long getParentId() 
	{
		return parentId;
	}

	public void setDefaultUrl(String defaultUrl) 
	{
		this.defaultUrl = defaultUrl;
	}
	/**
	 * 返回 默认地址
	 * @return
	 */
	public String getDefaultUrl() 
	{
		return defaultUrl;
	}

	public void setIsFolder(Short isFolder) 
	{
		this.isFolder = isFolder;
	}
	/**
	 * 返回 栏目
	 * @return
	 */
	public Short getIsFolder() 
	{
		return isFolder;
	}

	public void setIsDisplayInMenu(Short isDisplayInMenu) 
	{
		this.isDisplayInMenu = isDisplayInMenu;
	}
	/**
	 * 返回 显示到菜单
	 * @return
	 */
	public Short getIsDisplayInMenu() 
	{
		return isDisplayInMenu;
	}

	public void setIsOpen(Short isOpen) 
	{
		this.isOpen = isOpen;
	}
	/**
	 * 返回 默认打开
	 * @return
	 */
	public Short getIsOpen() 
	{
		return isOpen;
	}
	/**
	 * 返回 默认打开
	 * @return
	 */
	public String getOpen() 
	{
		if(isOpen!=null&&isOpen.shortValue()==1)return "true";
		else return "false";
	}


	public void setSystemId(Long systemId) 
	{
		this.systemId = systemId;
	}
	/**
	 * 返回 systemId
	 * @return
	 */
	public Long getSystemId() 
	{
		return systemId;
	}
   
   	public List<Resources> getChildren() {
		return children;
	}
	public void setChildren(List<Resources> children) {
		this.children = children;
	}
	/**
	 * @see Object#equals(Object)
	 */
	public boolean equals(Object object) 
	{
		if (!(object instanceof Resources)) 
		{
			return false;
		}
		Resources rhs = (Resources) object;
		return new EqualsBuilder()
		.append(this.resId, rhs.resId)
		.append(this.resName, rhs.resName)
		.append(this.alias, rhs.alias)
		 
		.append(this.sn, rhs.sn)
		.append(this.icon, rhs.icon)
		.append(this.parentId, rhs.parentId)
		.append(this.defaultUrl, rhs.defaultUrl)
		.append(this.isFolder, rhs.isFolder)
		.append(this.isDisplayInMenu, rhs.isDisplayInMenu)
		.append(this.isOpen, rhs.isOpen)
		.append(this.systemId, rhs.systemId)
		.isEquals();
	}

	/**
	 * @see Object#hashCode()
	 */
	public int hashCode() 
	{
		return new HashCodeBuilder(-82280557, -700257973)
		.append(this.resId) 
		.append(this.resName) 
		.append(this.alias) 
		 
		.append(this.sn) 
		.append(this.icon) 
		.append(this.parentId) 
		.append(this.defaultUrl) 
		.append(this.isFolder) 
		.append(this.isDisplayInMenu) 
		.append(this.isOpen) 
		.append(this.systemId) 
		.toHashCode();
	}

	/**
	 * @see Object#toString()
	 */
	public String toString() 
	{
		return new ToStringBuilder(this)
		.append("resId", this.resId) 
		.append("resName", this.resName) 
		.append("alias", this.alias) 
		 
		.append("sn", this.sn) 
		.append("icon", this.icon) 
		.append("parentId", this.parentId) 
		.append("defaultUrl", this.defaultUrl) 
		.append("isFolder", this.isFolder) 
		.append("isDisplayInMenu", this.isDisplayInMenu) 
		.append("isOpen", this.isOpen) 
		.append("systemId", this.systemId) 
		.toString();
	}
   
  

}