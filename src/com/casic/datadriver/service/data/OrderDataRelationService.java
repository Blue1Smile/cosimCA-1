package com.casic.datadriver.service.data;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.web.query.QueryFilter;

import com.casic.datadriver.dao.data.OrderDataRelationDao;
import com.casic.datadriver.model.data.OrderDataRelation;
/**
 * The Class OrderDataRelationService.
 */
@Service
public class OrderDataRelationService extends BaseService<OrderDataRelation> {

    /** The OrderDataRelation dao. */
    @Resource
    private OrderDataRelationDao orderDataRelationDao;

    /**
     * Adds the DD OrderDataRelation.
     *
     * @param OrderDataRelation
     *            the OrderDataRelation
     * @return true, if successful
     */
    public boolean addDDOrderDataRelation(OrderDataRelation OrderDataRelation) {
        this.orderDataRelationDao.add(OrderDataRelation);
        return true;
    }

    /*
     * (non-Javadoc)
     *
     * @see com.hotent.core.service.GenericService#getEntityDao()
     */
    @Override
    protected IEntityDao<OrderDataRelation, Long> getEntityDao() {
        return this.orderDataRelationDao;
    }

    /**
     * Query OrderDataRelation basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<OrderDataRelation> queryOrderDataRelationBasicInfoList(QueryFilter queryFilter) {
        return this.orderDataRelationDao.queryOrderDataRelationBasicInfoList(queryFilter);
    }

    /**
     * Query OrderDataRelation basic info list.
     *
     * @param ddtaskId
     *            the query filter
     * @return the list
     */
    public List<OrderDataRelation> queryOrderDataRelationByddTaskID(long ddtaskId) {
        return this.orderDataRelationDao.queryOrderDataRelationByddTaskID(ddtaskId);
    }



    /**
     * Query OrderDataRelation basic info list.
     *
     * @param ddtaskId
     *            the query filter
     * @return the list
     */
    public List<OrderDataRelation> queryPublishDataRelationByddTaskID(long ddtaskId) {
        return this.orderDataRelationDao.queryPublishDataRelationByddTaskID(ddtaskId);
    }


    /**
     * Adds the DD OrderDataRelation.
     * @param ddDataTaskId
     *            the OrderDataRelation
     * @return true, if successful
     */
    public void delPublishByddDataTaskId(Long ddDataTaskId) {
        this.orderDataRelationDao.delPublishByddDataTaskId(ddDataTaskId);

    }

    /**
     * Adds the DD OrderDataRelation.
     * @param ddDataTaskId
     *            the OrderDataRelation
     * @return true, if successful
     */
    public void delOrderByddDataTaskId(Long ddDataTaskId) {
        this.orderDataRelationDao.delOrderByddDataTaskId(ddDataTaskId);
    }
}
