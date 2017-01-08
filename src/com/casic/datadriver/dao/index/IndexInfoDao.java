package com.casic.datadriver.dao.index;

import com.casic.datadriver.model.index.IndexInfo;
import com.hotent.core.db.BaseDao;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class IndexInfoDao extends BaseDao <IndexInfo> {

    @Override
    public Class getEntityClass() {
        // TODO Auto-generated method stub
        return IndexInfo.class;
    }

    public List<IndexInfo> getByProjectId(Long projectId){
        return this.getBySqlKey("getIndexInfoList", projectId);
    }
}