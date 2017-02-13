package com.casic.datadriver.dao.task;

import java.util.List;

import com.casic.datadriver.model.task.TaskInfo;
import org.springframework.stereotype.Repository;

import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;

/**
 * The Class taskDao.
 */
@Repository
public class TaskInfoDao extends BaseDao<TaskInfo> {

    /**
     * Query task basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<TaskInfo> queryTaskBasicInfoList(QueryFilter queryFilter) {
        return this.getBySqlKey("queryTaskBasicInfoList", queryFilter);
    }

    /**
     * Query task basic info list.
     *
     *            the query filter
     * @return the list
     */
    public List<TaskInfo> queryTaskInfoByProjectId(long ProjectID) {
        return this.getBySqlKey("queryTaskInfoByProjectId", ProjectID);
    }

    /**
     * Query task basic info list.
     *
     *            the query filter
     * @return the list
     */
    public List<TaskInfo> queryTaskInfoByResponceId(long ResponceId) {
        return this.getBySqlKey("queryTaskInfoByResponceId", ResponceId);
    }

    /*
     * (non-Javadoc)
     *
     * @see com.hotent.core.db.GenericDao#getEntityClass()
     */
    @Override
   public Class<?> getEntityClass() {
        return TaskInfo.class;
    }

    /**
     * ӳ��MAP��������ĿID��ȡ�����б�classId����ĿID
     * 20161202
     */
    public List<TaskInfo> getByMainId(Long classId) {
        return this.getBySqlKey("getTaskInfoList", classId);
    }

    /**
     * ӳ��MAP����ȡ���������б���ʱû�õ�
     * 20161202
     */
    public List<TaskInfo> getAllInstance(QueryFilter queryFilter) {
        return this.getBySqlKey("getAllTaskInfoList", queryFilter);
    }

    /**
     * ӳ��MAP��ɾ�������б���ʱû�õ�
     * 20161202
     */
    public void delByMainId(Long classId) {
        this.delBySqlKey("delByMainId", classId);
    }

}
