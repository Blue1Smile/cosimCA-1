package com.casic.datadriver.dao.task;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hotent.core.util.ContextUtil;
import org.springframework.stereotype.Repository;

import com.casic.datadriver.model.task.ProTaskDependance;
import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;

/**
 * The Class ProTaskDependanceDao.
 */
@Repository
public class ProTaskDependanceDao extends BaseDao<ProTaskDependance> {

    /**
     * Query proTaskDependance basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<ProTaskDependance> queryProTaskDependanceBasicInfoList(QueryFilter queryFilter) {
        return this.getBySqlKey("queryProTaskDependanceBasicInfoList", queryFilter);
    }

    /*
     * (non-Javadoc)
     *
     * @see com.hotent.core.db.GenericDao#getEntityClass()
     */
    @Override
    public Class<?> getEntityClass() {
        return ProTaskDependance.class;
    }

    public void deleteByProjectIdAndTaskId(Long ddProjectID,Long ddTaskID){

       this.deleteByProjectIdAndTaskId( ddProjectID,ddTaskID);
      //  Map<String,Object> m=new HashMap<String,Object>();
     //   m.put("ddProjectID", ddProjectID);
     //   m.put("ddTaskID",ddTaskID);
      //  return this.getBySqlKey("deleteByProjectIdAndTaskId", m);
    }

    /**
     * 映射MAP，删除任务依赖关系
     *
     */
    public void delByMainId(Long classId) {
        this.delBySqlKey("delByMainId", classId);
    }

}
