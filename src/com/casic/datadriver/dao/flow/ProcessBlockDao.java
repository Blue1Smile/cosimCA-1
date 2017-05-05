package com.casic.datadriver.dao.flow;

import com.casic.datadriver.model.flow.ProcessBlock;
import com.hotent.core.db.BaseDao;
import org.springframework.stereotype.Repository;
/**
 * Created by blue on 2017/5/4.
 */
@Repository

public class ProcessBlockDao extends BaseDao<ProcessBlock>{

    @Override
    public Class<?> getEntityClass() {
        return ProcessBlock.class;
    }

}
