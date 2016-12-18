package com.casic.datadriver.dao.data;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.casic.datadriver.model.data.DataStruct;
import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;

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
