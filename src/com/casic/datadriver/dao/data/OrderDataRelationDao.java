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
     *            the query filter
     * @return the list
     */
    public List<OrderDataRelation> getCanBeOrderDataList(long projectId) {
        return this.getBySqlKey("getCanBeOrderDataList", projectId);
    }
    /**
     * Query OrderDataRelation basic info list.
     *
     *            the query filter
     * @return the list
     */
    public List<OrderDataRelation> getOrderDataRelationList(Long ddtaskId) {
        return this.getBySqlKey("getOrderDataRelationList", ddtaskId);
    }




    /**
     * Query OrderDataRelation basic info list.
     *
     * @param ddtaskId
     *            the query filter
     * @return the list
     */
    public List<OrderDataRelation> getPublishDataRelationList(Long ddtaskId) {
        return this.getBySqlKey("getPublishDataRelationList", ddtaskId);
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

    public OrderDataRelation getOrderDataRelationById(long id){
        return this.getUnique("getOrderDataRelationById", id);
    }

    public void delOrderByddDataId(long dataId){this.getBySqlKey("delOrderByddDataId", dataId);}


}
