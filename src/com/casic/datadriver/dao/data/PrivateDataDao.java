package com.casic.datadriver.dao.data;

import java.util.List;

import com.casic.datadriver.model.task.TaskInfo;
import org.springframework.stereotype.Repository;

import com.casic.datadriver.model.data.PrivateData;
import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;

/**
 * The Class PrivateDataDao.
 */
@Repository
public class PrivateDataDao extends BaseDao<PrivateData> {

    /**
     * Query privateData basic info list.
     *
     * @param queryFilter
     * @return the list
     */
    public List<PrivateData> queryPrivateDataBasicInfoList(QueryFilter queryFilter) {
        return this.getBySqlKey("queryPrivateDataBasicInfoList", queryFilter);
    }



    /**
     * Query privateData basic info list.
     *
     * @param queryFilter
     * @return the list
     */
    public List<PrivateData> queryPrivateDataByddTaskID(long id) {
        return this.getBySqlKey("queryPrivateDataByddTaskID", id);
    }



    /**
     * 2016/12/4/修改
     */
    public List<PrivateData> getByddDataId(long id) {
        return this.getBySqlKey("getByddDataId", id);
    }

    /*
     * (non-Javadoc)
     *
     * @see com.hotent.core.db.GenericDao#getEntityClass()
     */
    @Override
    public Class<?> getEntityClass() {
        return PrivateData.class;
    }

    /**
     * 映射MAP，删除任务列表，暂时没用到
     * 20161202
     */
    public void delByMainId(Long classId) {
        this.delBySqlKey("delByMainId", classId);
    }

    public List<PrivateData> getByMainId(Long classId) {
        return this.getBySqlKey("getPrivateDataList", classId);
    }

    /**
     * mapper中还没实现
     */
    public List<PrivateData> getAllInstance(QueryFilter queryFilter) {
        return this.getBySqlKey("getAllPrivateDataList", queryFilter);
    }
    /**
     * 2016/12/4/修改
     */
    public void updatedata(PrivateData privateData){

        this.getBySqlKey("updatedata",privateData);
    }
}
