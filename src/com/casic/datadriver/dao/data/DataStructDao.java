package com.casic.datadriver.dao.data;

import com.casic.datadriver.model.QueryParameters;
import com.casic.datadriver.model.data.DataStruct;
import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * The Class DataStructDao.
 */
@Repository
public class DataStructDao extends BaseDao<DataStruct> {

    /**
     * Query dataStruct basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<DataStruct> queryDataStructBasicInfoList(QueryFilter queryFilter) {
        return this.getBySqlKey("queryDataStructBasicInfoList", queryFilter);
    }

    public List<DataStruct> getStructByTaskId(Long id) {
        return this.getBySqlKey("getStructByTaskId", id);
    }

    public List<DataStruct> getStructByPublish(QueryParameters queryparameters) {
        return this.getBySqlKey("getStructByPublish", queryparameters);
    }

    public List<DataStruct> getStructByTaskAndOId(QueryParameters queryparameters) {
        return this.getBySqlKey("getStructByTaskAndOId", queryparameters);
    }

    public List<DataStruct> getStructByProjectAndPId(QueryParameters queryparameters) {
        return this.getBySqlKey("getStructByProjectAndPId", queryparameters);
    }

    public void addDataStruct(DataStruct datastruct) {
        this.getBySqlKey("addDataStruct", datastruct);
    }

    public DataStruct getStructById(Long id) {
        return this.getUnique("getStructById", id);
    }

    /*
     * (non-Javadoc)
     *
     * @see com.hotent.core.db.GenericDao#getEntityClass()
     */
    @Override
    public Class<?> getEntityClass() {
        return DataStruct.class;
    }

}
