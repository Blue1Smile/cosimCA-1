package com.casic.datadriver.dao.index;

import com.hotent.core.db.BaseDao;
import org.springframework.stereotype.Repository;
import com.casic.datadriver.model.index.Index;
@Repository
public class IndexDao extends BaseDao <Index> {

    @Override
    public Class getEntityClass() {
        // TODO Auto-generated method stub
        return Index.class;
    }









}