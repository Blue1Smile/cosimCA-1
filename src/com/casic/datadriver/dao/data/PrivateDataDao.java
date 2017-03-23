package com.casic.datadriver.dao.data;

import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.data.PrivateData;
import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * The Class PrivateDataDao.
 */
@Repository
public class PrivateDataDao extends BaseDao<PrivateData> {

    /**
     * Query privateData basic info list.
     *
     * @param queryFilter
     * @return the list
     */
    public List<PrivateData> queryPrivateDataBasicInfoList(QueryFilter queryFilter) {
        return this.getBySqlKey("queryPrivateDataBasicInfoList", queryFilter);
    }

    public PrivateData getDataById(long id){
        return this.getUnique("getDataById", id);
    }

    /**
     * Query privateData basic info list.
     *
     * @return the list
     */
    public List<PrivateData> queryPrivateDataByddTaskID(long id) {
        return this.getBySqlKey("queryPrivateDataByddTaskID", id);
    }

    public List<PrivateData> getBymodel(PageInfo model) {
        return this.getBySqlKey("getBymodel", model);
    }

    /**
     * 2016/12/4/�޸�
     */
    public List<PrivateData> getByddDataId(long id) {
        return this.getBySqlKey("getByddDataId", id);
    }

    /*
     * (non-Javadoc)
     *
     * @see com.hotent.core.db.GenericDao#getEntityClass()
     */
    @Override
    public Class<?> getEntityClass() {
        return PrivateData.class;
    }

    /**
     * ӳ��MAP��ɾ�������б���ʱû�õ�
     * 20161202
     */
    public void delByMainId(Long classId) {
        this.delBySqlKey("delByMainId", classId);
    }

    public List<PrivateData> getByMainId(Long classId) {
        return this.getBySqlKey("getPrivateDataList", classId);
    }

    /**
     * mapper�л�ûʵ��
     */
    public List<PrivateData> getAllInstance(QueryFilter queryFilter) {
        return this.getBySqlKey("getAllPrivateDataList", queryFilter);
    }
    /**
     * 2016/12/4/�޸�
     */
    public void updatedata(PrivateData privateData){

        this.getBySqlKey("updatedata",privateData);
    }

    public List<PrivateData> getListByIdPage(PageInfo pageInfo){
        return this.getBySqlKey("getListByIdPage", pageInfo);
    }

    public List<PrivateData> getPublishDataList(Long taskId){
        return this.getBySqlKey("getPublishDataList", taskId);
    }

    public List<PrivateData> getPublishListPage(PageInfo pageInfo){
        return this.getBySqlKey("getPublishListPage", pageInfo);
    }

}
