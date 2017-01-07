package com.casic.datadriver.dao.index;

import com.casic.datadriver.model.index.IndexInfo;
import com.hotent.core.db.BaseDao;
import org.springframework.stereotype.Repository;

@Repository
public class IndexInfoDao extends BaseDao <IndexInfo> {

    @Override
    public Class getEntityClass() {
        // TODO Auto-generated method stub
        return IndexInfo.class;
    }









}