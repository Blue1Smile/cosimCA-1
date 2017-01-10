package com.casic.datadriver.service.project;

import java.util.List;

import javax.annotation.Resource;

import com.casic.datadriver.dao.task.ProTaskDependanceDao;
import com.casic.datadriver.dao.task.TaskInfoDao;
import com.casic.datadriver.model.task.ProTaskDependance;
import com.hotent.core.util.BeanUtils;
import com.hotent.core.util.UniqueIdUtil;
import org.springframework.stereotype.Service;

import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.web.query.QueryFilter;

import com.casic.datadriver.dao.project.ProjectDao;
import com.casic.datadriver.model.project.Project;
import com.casic.datadriver.model.task.TaskInfo;
/**
 * The Class ProjectService.
 */
@Service
public class ProjectService extends BaseService<Project> {

	/** The project dao. */
	@Resource
	private ProjectDao projectDao;

	@Resource
	private TaskInfoDao taskInfoDao;

    @Resource
    private ProTaskDependanceDao proTaskDependanceDao;

    public ProjectService()
    {
    }
	/**
	 * Adds the DD project.
	 *
	 * @param project
	 *            the project
	 * @return true, if successful
	 */
	public boolean addDDProject(Project project) throws Exception {
		this.projectDao.add(project);
        addSubList(project);
		return true;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.hotent.core.service.GenericService#getEntityDao()
	 */
	@Override
	protected IEntityDao<Project, Long> getEntityDao() {
		return this.projectDao;
	}

	/**20161202
	 * Query project basic info list.
	 *
	 * @param queryFilter
	 *            the query filter
	 * @return the list
	 */
	public List<Project> queryProjectBasicInfoList(QueryFilter queryFilter) {
		return this.projectDao.queryProjectBasicInfoList(queryFilter);
	}

    private void delByPk(Long id){
        taskInfoDao.delByMainId(id);
    }

    public void delAll(Long[] lAryId) {
        for(Long id:lAryId){
            delByPk(id);
            projectDao.delById(id);
        }
    }
    /**20161202 根据项目来添加任务
     */
    public void addAll(Project project) throws Exception{
        add(project);
        addSubList(project);
    }
    /**20161202 根据项目来添加任务
     */
    public void updateAll(Project project) throws Exception{
        update(project);
        delByPk(project.getDdProjectId());
        addSubList(project);
    }
    /**20161202 根据项目来添加任务
     */
    public void addSubList(Project project) throws Exception{
        List<TaskInfo> taskInfoList=project.getTaskInfoList();
        if(BeanUtils.isNotEmpty(taskInfoList)){
            for(TaskInfo taskInfo:taskInfoList){
                taskInfo.setDdTaskProjectId(project.getDdProjectId());
                taskInfo.setDdTaskProjectName(project.getDdProjectName());
                taskInfo.setDdTaskId(UniqueIdUtil.genId());
                addProTaskDep(taskInfo);
                taskInfoDao.add(taskInfo);
            }
        }
    }

    public void addProTaskDep(TaskInfo taskInfo) throws Exception{
        ProTaskDependance proTaskDependance = new ProTaskDependance();
        proTaskDependance.setDdProjectId(taskInfo.getDdTaskProjectId());
        proTaskDependance.setDdTaskId(UniqueIdUtil.genId());
        proTaskDependance.setDdTaskId(taskInfo.getDdTaskId());
        proTaskDependanceDao.add(proTaskDependance);
    }

    /**20161202 根据项目来添加任务
     */
    public List<TaskInfo> getTaskInfoList(Long id) {
        return taskInfoDao.getByMainId(id);
    }
    /**20161202 根据项目来添加任务
     */
    public List<TaskInfo> getAllTaskInfoList(QueryFilter queryFilter) {
        return taskInfoDao.getAllInstance(queryFilter);
    }

    /**20170107 根据责任人查询项目
     */
    public List<Project> queryProjectlistByRes(Long ddProjectResponsiblePersonId) {
        return projectDao.queryProjectlistByRes(ddProjectResponsiblePersonId);
    }

}
