package com.casic.datadriver.dao.project;

import com.hotent.core.db.BaseDao;
import com.casic.datadriver.model.project.ProjectStart;
import org.springframework.stereotype.Repository;

/**
 * Created by dodo on 2016/12/3.
 */
@Repository
public class ProjectStartDao extends BaseDao<ProjectStart> {

    @Override
    public Class<?> getEntityClass()
    {
        return ProjectStart.class;
    }

}
