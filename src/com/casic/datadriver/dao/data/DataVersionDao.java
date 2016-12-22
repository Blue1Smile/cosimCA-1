package com.casic.datadriver.dao.data;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.casic.datadriver.model.data.DataVersion;
import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;

/**
 * The Class DataVersionDao.
 */
@Repository
public class DataVersionDao extends BaseDao<DataVersion> {

    /**
     * Query dataVersion basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<DataVersion> queryDataVersionBasicInfoList(QueryFilter queryFilter) {
        return this.getBySqlKey("queryDataVersionBasicInfoList", queryFilter);
    }

    /**
     * 2016.12.22
     * Query dataVersion basic info list by DataId.
     *
     * @return the list
     */
    public List<DataVersion> queryDataVersionListByddDataId(Long  ddDataId) {
        return this.getBySqlKey("queryDataVersionListByddDataId", ddDataId);
    }



    /*
     * (non-Javadoc)
     *
     * @see com.hotent.core.db.GenericDao#getEntityClass()
     */
    @Override
    public Class<?> getEntityClass() {
        return DataVersion.class;
    }

}
