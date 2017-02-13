package com.casic.datadriver.service.major;

import com.casic.datadriver.dao.major.MajorDao;
import com.casic.datadriver.model.major.Major;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 忠 on 2017/2/7.
 */
@Service
public class MajorService extends BaseService<Major> {
    @Resource
    private MajorDao majordao;

    @Override
    protected IEntityDao<Major, Long> getEntityDao() {
        return this.majordao;
    }

    public List<Major> findById(long Id) {
        return this.majordao.findById(Id);
    }
    public List<Major> findByPid(long Pid) {
        return this.majordao.findByPid(Pid);
    }

}
