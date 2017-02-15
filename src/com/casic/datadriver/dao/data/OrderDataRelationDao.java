package com.casic.datadriver.dao.data;

import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.data.OrderDataRelation;
import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * The Class OrderDataRelationDao.
 */
@Repository
public class OrderDataRelationDao extends BaseDao<OrderDataRelation> {

    /**
     * Query OrderDataRelation basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<OrderDataRelation> queryOrderDataRelationBasicInfoList(QueryFilter queryFilter) {
        return this.getBySqlKey("queryOrderDataRelationBasicInfoList", queryFilter);
    }
    /**
     * Query OrderDataRelation basic info list.
     *
     *            the query filter
     * @return the list
     */
    public List<OrderDataRelation> queryOrderDataRelationByddTaskID(Long ddtaskId) {
        return this.getBySqlKey("queryOrderDataRelationByddTaskID", ddtaskId);
    }




    /**
     * Query OrderDataRelation basic info list.
     *
     * @param ddtaskId
     *            the query filter
     * @return the list
     */
    public List<OrderDataRelation> queryPublishDataRelationByddTaskID(Long ddtaskId) {
        return this.getBySqlKey("queryPublishDataRelationByddTaskID", ddtaskId);
    }

    public List<OrderDataRelation> queryPublishDataRelationByddTaskIDF(PageInfo model) {
        return this.getBySqlKey("queryPublishDataRelationByddTaskIDF", model);
    }
    /*
     * (non-Javadoc)
     *
     * @see com.hotent.core.db.GenericDao#getEntityClass()
     */
    @Override
    public Class<?> getEntityClass() {
        return OrderDataRelation.class;
    }

    public void delPublishByddDataTaskId(long ddDataTaskId) {
        this.getBySqlKey("delPublishByddDataTaskId", ddDataTaskId);
    }


    public void delOrderByddDataTaskId(long ddDataTaskId) {
        this.getBySqlKey("delOrderByddDataTaskId", ddDataTaskId);
    }

//    public int queryPublishDataRelationByddTaskID(int ddDataTaskId){
//
//       return  this.getBySqlKey("queryPublishDataRelationByddTaskID", ddDataTaskId);
//
//    }


}
