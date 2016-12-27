package com.casic.datadriver.service.flow;

import com.casic.datadriver.dao.flow.ProcessDao;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import org.springframework.stereotype.Service;

/**
 * Created by dodo on 2016/12/27.
 */
@Service
public class ProcessService extends BaseService<Process> {
    private ProcessDao processDao;

    @Override
    protected IEntityDao<Process, Long> getEntityDao() {
        return this.processDao;
    }
}
