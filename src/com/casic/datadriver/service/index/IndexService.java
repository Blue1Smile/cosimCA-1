package com.casic.datadriver.service.index;


import com.casic.datadriver.dao.index.IndexInfoDao;
import com.casic.datadriver.model.index.IndexInfo;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
    /**
     * Created by Administrator on 2016/11/18 0018.
     */
    @Service
    public class IndexService extends BaseService<IndexInfo> {



        @Resource
        private IndexInfoDao indexDao;

        public boolean addDDIndex(IndexInfo index) {
            this.indexDao.add(index);
            return true;
        }


        @Override
        protected IEntityDao<IndexInfo, Long> getEntityDao() {
            // TODO Auto-generated method stub
            return this.indexDao;
        }





}
