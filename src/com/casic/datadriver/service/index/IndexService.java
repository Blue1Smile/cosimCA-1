package com.casic.datadriver.service.index;


import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import org.springframework.stereotype.Service;


import javax.annotation.Resource;
import com.casic.datadriver.model.index.Index;
import com.casic.datadriver.dao.index.IndexDao;
    /**
     * Created by Administrator on 2016/11/18 0018.
     */
    @Service
    public class IndexService extends BaseService<Index> {



        @Resource
        private IndexDao indexDao;

        public boolean addDDIndex(Index index) {
            this.indexDao.add(index);
            return true;
        }


        @Override
        protected IEntityDao<Index, Long> getEntityDao() {
            // TODO Auto-generated method stub
            return this.indexDao;
        }





}
