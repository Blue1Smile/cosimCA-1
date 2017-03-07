package com.casic.datadriver.service.data;

import com.casic.datadriver.dao.data.DataStructMemberDao;
import com.casic.datadriver.model.data.DataStructMember;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.web.query.QueryFilter;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by blue on 2017/3/6.
 */
@Service
public class DataStructMemberService extends BaseService<DataStructMember> {

    /** The DataStructMember dao. */
    @Resource
    private DataStructMemberDao dataStructMemberDao;

    /**
     * Adds the DD dataSnapshot.
     *
     * @param dataSnapshot
     *            the dataSnapshot
     * @return true, if successful
     */
    public boolean addDDDataStructMember(DataStructMember dataSnapshot) {
        this.dataStructMemberDao.add(dataSnapshot);
        return true;
    }

    /*
     * (non-Javadoc)
     *
     * @see com.hotent.core.service.GenericService#getEntityDao()
     */
    @Override
    protected IEntityDao<DataStructMember, Long> getEntityDao() {
        return this.dataStructMemberDao;
    }

    /**
     * Query dataSnapshot basic info list.
     *
     * @param queryFilter
     *            the query filter
     * @return the list
     */
    public List<DataStructMember> queryDataStructMemberBasicInfoList(QueryFilter queryFilter) {
        return this.dataStructMemberDao.queryDataStructMemberBasicInfoList(queryFilter);
    }




}
