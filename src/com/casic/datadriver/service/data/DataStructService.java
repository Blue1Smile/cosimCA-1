package com.casic.datadriver.service.data;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.web.query.QueryFilter;

import com.casic.datadriver.dao.data.DataStructDao;
import com.casic.datadriver.model.data.DataStruct;
/**
 * The Class DataStructService.
 */
@Service
public class DataStructService extends BaseService<DataStruct> {

    /** The dataStruct dao. */
    @Resource
    private DataStructDao dataStructDao;

    /**
     * Adds the DD dataStruct.
     *
     * @param dataStruct
     *            the dataStruct
     * @return true, if successful
     */
    public boolean addDDDataStruct(DataStruct dataStruct) {
        this.dataStructDao.add(dataStruct);
        return true;
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.hotent.core.service.GenericService#getEntityDao()
     */
    @Override
    protected IEntityDao<DataStruct, Long> getEntityDao() {
        return this.dataStructDao;
    }

    /**
     * Query dataStruct basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<DataStruct> queryDataStructBasicInfoList(QueryFilter queryFilter) {
        return this.dataStructDao.queryDataStructBasicInfoList(queryFilter);
    }

}
