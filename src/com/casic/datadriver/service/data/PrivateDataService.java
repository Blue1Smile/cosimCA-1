package com.casic.datadriver.service.data;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;

import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.web.query.QueryFilter;

import com.casic.datadriver.dao.data.PrivateDataDao;
import com.casic.datadriver.model.data.PrivateData;
/**
 * The Class PrivateDataService.
 */
@Service
public class PrivateDataService extends BaseService<PrivateData> {

    /** The privateData dao. */
    @Resource
    private PrivateDataDao privateDataDao;

    public boolean addDDPrivateData(PrivateData privateData) {
        this.privateDataDao.add(privateData);
        return true;
    }


    protected IEntityDao<PrivateData, Long> getEntityDao() {
        return this.privateDataDao;
    }


    public List<PrivateData> queryPrivateDataBasicInfoList(QueryFilter queryFilter) {
        return this.privateDataDao.queryPrivateDataBasicInfoList(queryFilter);
    }

    public List<PrivateData> queryPrivateDataByddTaskID(long id) {
        return this.privateDataDao.queryPrivateDataByddTaskID(id);
    }

    /**
     * 2016/12/4/ÐÞ¸Ä
     */

    public List<PrivateData> getByddDataId(long id) {
        return this.privateDataDao.getByddDataId(id);
    }

    /**
     * 2017/02/16/
     */

    public PrivateData getDataById(long id) {
        return this.privateDataDao.getDataById(id);
    }

    /**
     * 2016/12/4/ÐÞ¸Ä
     */
    public void updatedata(PrivateData privateData){

        this.privateDataDao.updatedata(privateData);
    }
}
