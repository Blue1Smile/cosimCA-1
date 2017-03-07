package com.casic.datadriver.dao.data;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.casic.datadriver.model.data.DataStructMember;
import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;

/**
 * The Class DataStructMemberDao.
 */
@Repository
public class DataStructMemberDao extends BaseDao<DataStructMember> {

    /**
     * Query dataStruct basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<DataStructMember> queryDataStructMemberBasicInfoList(QueryFilter queryFilter) {
        return this.getBySqlKey("queryDataStructMemberBasicInfoList", queryFilter);
    }

    /*
     * (non-Javadoc)
     *
     * @see com.hotent.core.db.GenericDao#getEntityClass()
     */
    @Override
    public Class<?> getEntityClass() {
        return DataStructMember.class;
    }
}
