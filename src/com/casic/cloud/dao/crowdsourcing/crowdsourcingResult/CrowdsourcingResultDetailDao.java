package com.casic.cloud.dao.crowdsourcing.crowdsourcingResult;

import java.util.List;
import org.springframework.stereotype.Repository;
import com.hotent.core.db.BaseDao;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.util.BeanUtils;
import com.casic.cloud.model.crowdsourcing.crowdsourcingResult.CrowdsourcingResultDetail;
/**
 *<pre>
 * 对象功能:cloud_crowdsourcing_result_detail Dao类
 * 开发公司:中国航天科工集团
 * 开发人员:ziapple
 * 创建时间:2013-07-09 17:15:19
 *</pre>
 */
@Repository
public class CrowdsourcingResultDetailDao extends BaseDao<CrowdsourcingResultDetail>
{
	@Override
	public Class<?> getEntityClass()
	{
		return CrowdsourcingResultDetail.class;
	}

	public List<CrowdsourcingResultDetail> getByMainId(Long id) {
		return this.getBySqlKey("getCrowdsourcingResultDetailList", id);
	}
	
	public void delByMainId(Long id) {
		this.delBySqlKey("delByMainId", id);
	}
}