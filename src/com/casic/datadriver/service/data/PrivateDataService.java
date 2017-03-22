package com.casic.datadriver.service.data;

import com.casic.datadriver.dao.data.PrivateDataDao;
import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.data.PrivateData;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.web.query.QueryFilter;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
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
     * 2016/12/4/�޸�
     */

    public List<PrivateData> getByddDataId(long id) {
        return this.privateDataDao.getByddDataId(id);
    }

    public List<PrivateData> getBymodel(PageInfo model) {
        return this.privateDataDao.getBymodel(model);
    }

    /**
     * 2017/02/16/
     */

    public PrivateData getDataById(long id) {
        return this.privateDataDao.getDataById(id);
    }


    public void updatedata(PrivateData privateData){
        this.privateDataDao.updatedata(privateData);
    }

    public List<PrivateData> getListByIdPage(PageInfo pageInfo){
        return this.privateDataDao.getListByIdPage(pageInfo);
    }

    public List<PrivateData> getPublishDataList(Long taskId){
        return this.privateDataDao.getPublishDataList(taskId);
    }

    public List<PrivateData> getPublishListPage(PageInfo pageInfo){
        return this.privateDataDao.getPublishListPage(pageInfo);
    }

}
