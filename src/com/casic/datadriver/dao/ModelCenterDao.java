package com.casic.datadriver.dao;

import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.modelcenter.ModelCenterModel;
import com.hotent.core.db.BaseDao;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by 忠 on 2017/2/28.
 */
@Repository
public class ModelCenterDao   extends BaseDao<ModelCenterModel> {

    @Override
    public Class getEntityClass() {
        return ModelCenterModel.class;
    }


    public List<ModelCenterModel> querytoolBymodeltype(long modeltype) {
        return this.getBySqlKey("querytoolBymodeltype", modeltype);
    }

    public List<ModelCenterModel> querytoolBymodeltypeF(PageInfo model) {
        return this.getBySqlKey("querytoolBymodeltypeF", model);
    }

    public List<ModelCenterModel> querytoolBymodelname(PageInfo model) {
        return this.getBySqlKey("querytoolBymodelname", model);}

    public List<ModelCenterModel> querytoolBymodelnameF(PageInfo modelname) {
        return this.getBySqlKey("querytoolBymodelnameF", modelname);}

    public void del(Long id) {
        this.getBySqlKey("delmodel", id);}
}
