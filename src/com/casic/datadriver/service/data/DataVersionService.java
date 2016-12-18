package com.casic.datadriver.service.data;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.casic.datadriver.model.data.DataVersion;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.web.query.QueryFilter;
import com.casic.datadriver.dao.data.DataVersionDao;
/**
 * The Class DataVersionService.
 */
@Service
public class DataVersionService extends BaseService<DataVersion> {

    /** The dataVersion dao. */
    @Resource
    private DataVersionDao dataVersionDao;

    /**
     * Adds the DD dataVersion.
     *
     * @param dataVersion
     *            the dataVersion
     * @return true, if successful
     */
    public boolean addDDDataVersion(DataVersion dataVersion) {
        this.dataVersionDao.add(dataVersion);
        return true;
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.hotent.core.service.GenericService#getEntityDao()
     */
    @Override
    protected IEntityDao<DataVersion, Long> getEntityDao() {
        return this.dataVersionDao;
    }

    /**
     * Query dataVersion basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<DataVersion> queryDataVersionBasicInfoList(QueryFilter queryFilter) {
        return this.dataVersionDao.queryDataVersionBasicInfoList(queryFilter);
    }

}
