package com.casic.datadriver.dao.flow;

import com.hotent.core.db.BaseDao;
import org.springframework.stereotype.Repository;

/**
 * Created by dodo on 2016/12/27.
 */
@Repository
public class ProcessDao extends BaseDao<Process> {

    @Override
    public Class<?> getEntityClass() {
        return Process.class;
    }
}
