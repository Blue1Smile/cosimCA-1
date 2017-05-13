package com.casic.datadriver.dao.data;

import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.QueryParameters;
import com.casic.datadriver.model.data.PrivateData;
import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;
import org.springframework.stereotype.Repository;

import java.util.List;

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
     * 添加一个数据
     */
    public void addSingleData(PrivateData privateData) {
        this.add(privateData);
    }

    /**
     * 获取所有数据
     */
    public List<PrivateData> getAll() {
        return this.getAll();
    }

    /**
     * 根据数据ID获取数据
     */
    public PrivateData getDataById(Long dataId) {
        return this.getUnique("getDataById", dataId);
    }

    /**
     * 根据数据ParentID获取数据
     */
    public List<PrivateData> getDataListByPId(Long parentId) {
        return this.getBySqlKey("getDataListByPId", parentId);
    }

    /**
     * 获取任务发布的数据
     */
    public List<PrivateData> getPubListByTaskId(Long taskId) {
        return this.getBySqlKey("getPubListByTaskId", taskId);
    }

    /**
     * 获取任务未发布的数据
     */
    public List<PrivateData> getUnPubListByTaskId(Long taskId) {
        return this.getBySqlKey("getUnPubListByTaskId", taskId);
    }

    /**
     * 获取任务订阅的数据
     */
    public List<PrivateData> getOrdListByTaskId(Long taskId) {
        return this.getBySqlKey("getOrdListByTaskId", taskId);
    }

    /**
     * 获取任务未订阅的数据
     */
    public List<PrivateData> getUnOrdListByTaskId(Long taskId) {
        return this.getBySqlKey("getUnOrdListByTaskId", taskId);
    }

    /**
     * 获取任务所有数据
     */
    public List<PrivateData> getDataListByTaskId(Long taskId) {
        return this.getBySqlKey("getDataListByTaskId", taskId);
    }

    /**
     * 获取项目所有数据
     */
    public List<PrivateData> getDataListByProId(QueryParameters queryParameters) {
        return this.getBySqlKey("getDataListByProId", queryParameters);
    }

    /**
     * 更新数据
     */
    public void updateData(PrivateData privateData) {
        this.update(privateData);
    }

    /**
     * 根据ID删除单个数据
     */
    public void delDataById(Long dataId) {
        this.delBySqlKey("delDataById", dataId);
    }

    /**
     * 根据任务ID删除单个数据
     */
    public void delByTaskId(Long taskId) {
        this.delBySqlKey("delByTaskId", taskId);
    }
}
