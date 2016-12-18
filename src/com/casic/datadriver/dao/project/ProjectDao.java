package com.casic.datadriver.dao.project;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.casic.datadriver.model.project.Project;
import com.hotent.core.db.BaseDao;
import com.hotent.core.web.query.QueryFilter;

/**
 * The Class ProjectDao.
 */
@Repository
public class ProjectDao extends BaseDao<Project> {

	/**
	 * Query project basic info list.
	 *
	 * @param queryFilter
	 *            the query filter
	 * @return the list
	 */
	public List<Project> queryProjectBasicInfoList(QueryFilter queryFilter) {
		return this.getBySqlKey("queryProjectBasicInfoList", queryFilter);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see com.hotent.core.db.GenericDao#getEntityClass()
	 */
	@Override
	public Class<?> getEntityClass() {
		return Project.class;
	}

}
