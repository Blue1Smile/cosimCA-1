package com.casic.datadriver.service.task;

import java.util.List;

import javax.annotation.Resource;

import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.model.project.Project;
import com.hotent.core.util.BeanUtils;
import com.hotent.core.util.UniqueIdUtil;
import org.springframework.stereotype.Service;

import com.casic.datadriver.model.task.TaskInfo;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.web.query.QueryFilter;
import com.casic.datadriver.dao.task.TaskInfoDao;
import com.casic.datadriver.dao.data.PrivateDataDao;
import com.casic.datadriver.dao.task.ProTaskDependanceDao;
/**
 * The Class TaskInfoService.
 */
@Service
public class TaskInfoService extends BaseService<TaskInfo> {

    /** The task dao. */
    @Resource
    private TaskInfoDao taskInfoDao;

    @Resource
    private PrivateDataDao privateDataDao;

    @Resource
    private ProTaskDependanceDao proTaskDependanceDao;
    /**
     * Adds the DD taskInfo.
     *
     * @param taskInfo
     *            the taskInfo
     * @return true, if successful
     */
    public boolean addDDTask(TaskInfo taskInfo) throws Exception {
        this.taskInfoDao.add(taskInfo);
        addSubList(taskInfo);
        return true;
    }

    public boolean updateDDTask(TaskInfo taskInfo) throws Exception {
        update(taskInfo);
//        delByPk(taskInfo.getDdTaskId());
//        addSubList(taskInfo);
        return true;
    }
    /*
     * (non-Javadoc)
     * 
     * @see com.hotent.core.service.GenericService#getEntityDao()
     */
    @Override
    protected IEntityDao<TaskInfo, Long> getEntityDao() {
        return this.taskInfoDao;
    }

    /**
     * Query task basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<TaskInfo> queryTaskBasicInfoList(QueryFilter queryFilter) {
        return this.taskInfoDao.queryTaskBasicInfoList(queryFilter);
    }


    /**
     * Query task basic info list.
     *
     *            the query filter
     * @return the list
     */
    public List<TaskInfo> queryTaskInfoByProjectId(long ProjectId) {
        return this.taskInfoDao.queryTaskInfoByProjectId(ProjectId);
    }

    /**
     * 获取任务负责人ID
     *
     *            the query filter
     * @return the list
     */
    public TaskInfo getUserIdbyTaskId(long taskId) {
        return this.taskInfoDao.getById(taskId);
    }

    /**
     * Query task basic info list.
     *
     *            the query filter
     * @return the list
     */
    public List<TaskInfo> queryTaskInfoByResponceId(long ResponceId) {
        return this.taskInfoDao.queryTaskInfoByResponceId(ResponceId);
    }


    /**根据任务信息添加私有数据
     */
    public void addSubList(TaskInfo taskInfo) throws Exception{
        List<PrivateData> privateDataList=taskInfo.getPrivateDataList();
        if(BeanUtils.isNotEmpty(privateDataList)){
            for(PrivateData privateData:privateDataList){
                privateData.setDdDataTaskId(taskInfo.getDdTaskId());
                privateData.setDdDataId(UniqueIdUtil.genId());
                privateDataDao.add(privateData);
            }
        }
    }

    /**20161202 根据任务更新私有数据
     */
    public void updateSubList(TaskInfo taskInfo) throws Exception{
        List<PrivateData> privateDataList=taskInfo.getPrivateDataList();
        if(BeanUtils.isNotEmpty(privateDataList)){
            for(PrivateData privateData:privateDataList){
                privateDataDao.update(privateData);
            }
        }
    }
    public List<PrivateData> getPrivateDataList(Long id) {
        return privateDataDao.getByMainId(id);
    }

    public List<PrivateData> getAllPrivateDataList(QueryFilter queryFilter) {
        return privateDataDao.getAllInstance(queryFilter);
    }
    /**删除关系表
     */
    private void delByPk(Long id){
        proTaskDependanceDao.delByTaskId(id);
        privateDataDao.delByMainId(id);
    }
    /**删除任务和关系表
     */
    public void delAll(Long[] lAryId) {
        for(Long id:lAryId){
            delByPk(id);
            taskInfoDao.delById(id);
        }
    }
    public List<TaskInfo> getByProIdAndUserIdF(PageInfo pageInfo){return this.taskInfoDao.getByProIdAndUserIdF(pageInfo);}

}
