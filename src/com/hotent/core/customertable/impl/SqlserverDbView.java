package com.hotent.core.customertable.impl;


import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.jdbc.core.RowMapper;




import com.hotent.core.customertable.BaseDbView;
import com.hotent.core.customertable.ColumnModel;
import com.hotent.core.customertable.IDbView;
import com.hotent.core.customertable.SqlTypeConst;
import com.hotent.core.customertable.TableModel;
import com.hotent.core.customertable.colmap.OracleColumnMap;
import com.hotent.core.customertable.colmap.SqlServerColumnMap;
import com.hotent.core.page.PageBean;
import com.hotent.core.util.StringUtil;

/**
 * sqlserver 视图实现。
 * @author ray
 *
 */
public class SqlserverDbView extends BaseDbView implements IDbView {
	
	private final String sqlAllView="select name from sysobjects where xtype='V'";
	private final String SQL_GET_COLUMNS = "SELECT "
			+ "B.NAME TABLE_NAME,A.NAME NAME, C.NAME TYPENAME, A.MAX_LENGTH LENGTH, A.IS_NULLABLE IS_NULLABLE,A.PRECISION PRECISION,A.SCALE SCALE,  "
			+ "(SELECT COUNT(*) FROM SYS.IDENTITY_COLUMNS WHERE SYS.IDENTITY_COLUMNS.OBJECT_ID = A.OBJECT_ID AND A.COLUMN_ID = SYS.IDENTITY_COLUMNS.COLUMN_ID) AS AUTOGEN, "
			+ "(SELECT CAST(VALUE AS VARCHAR) FROM SYS.EXTENDED_PROPERTIES WHERE SYS.EXTENDED_PROPERTIES.MAJOR_ID = A.OBJECT_ID AND SYS.EXTENDED_PROPERTIES.MINOR_ID = A.COLUMN_ID) AS DESCRIPTION, "
			+ " 0 AS IS_PK "
			+ "FROM  " 
			+ "SYS.COLUMNS A, SYS.VIEWS B, SYS.TYPES C "
			+ "WHERE  "
			+ "A.OBJECT_ID = B.OBJECT_ID  "
			+ "AND A.SYSTEM_TYPE_ID=C.SYSTEM_TYPE_ID "
			+ "AND B.NAME='%s' "
			+ "AND C.NAME<>'SYSNAME' "
			+ "ORDER BY A.COLUMN_ID";
	
	private final String SQL_GET_COLUMNS_BATCH = "SELECT "
			+ "B.NAME TABLE_NAME,A.NAME NAME, C.NAME TYPENAME, A.MAX_LENGTH LENGTH, A.IS_NULLABLE IS_NULLABLE,A.PRECISION PRECISION,A.SCALE SCALE,  "
			+ "(SELECT COUNT(*) FROM SYS.IDENTITY_COLUMNS WHERE SYS.IDENTITY_COLUMNS.OBJECT_ID = A.OBJECT_ID AND A.COLUMN_ID = SYS.IDENTITY_COLUMNS.COLUMN_ID) AS AUTOGEN, "
			+ "(SELECT CAST(VALUE AS VARCHAR) FROM SYS.EXTENDED_PROPERTIES WHERE SYS.EXTENDED_PROPERTIES.MAJOR_ID = A.OBJECT_ID AND SYS.EXTENDED_PROPERTIES.MINOR_ID = A.COLUMN_ID) AS DESCRIPTION, "
			+ " 0 AS IS_PK "
			+ "FROM  " 
			+ "SYS.COLUMNS A, SYS.VIEWS B, SYS.TYPES C "
			+ "WHERE  "
			+ "A.OBJECT_ID = B.OBJECT_ID  "
			+ "AND A.SYSTEM_TYPE_ID=C.SYSTEM_TYPE_ID "
			+ "AND C.NAME<>'SYSNAME' ";
	@Override
	public List<String> getViews(String viewName) {
		String sql=sqlAllView;
		if(StringUtil.isNotEmpty(viewName)){
			sql+=" and name like '"+viewName+"%'";
		}
		return this.jdbcTemplate.queryForList(sql,String.class);
		
	}
	
	
	
	
	public String getType(String type){
		if(type.indexOf("int")>-1 || type.equals("real") || type.equals("numeric") || type.indexOf("money")>-1)
			return ColumnModel.COLUMNTYPE_NUMBER;
		else if(type.indexOf("date")>-1){
			return ColumnModel.COLUMNTYPE_DATE;
		}
		return ColumnModel.COLUMNTYPE_VARCHAR;
	}


	@Override
	public List<String> getViews(String viewName, PageBean pageBean)
			throws Exception {
		String sql=sqlAllView;
		if(StringUtil.isNotEmpty(viewName)){
			sql+=" AND NAME LIKE '"+viewName+"%'";
		}
		return getForList(sql, pageBean, String.class,SqlTypeConst.SQLSERVER);
	}


	@Override
	public List<TableModel> getViewsByName(String viewName, PageBean pageBean) throws Exception {
		jdbcHelper.setCurrentDb(currentDb);
		String sql=sqlAllView;
		if(StringUtil.isNotEmpty(viewName)){
			sql+=" AND NAME LIKE '"+viewName+"%'";
		}
		
		RowMapper<TableModel> rowMapper=new RowMapper<TableModel>() {
			@Override
			public TableModel mapRow(ResultSet rs, int row)
					throws SQLException {
				TableModel tableModel=new TableModel();
				tableModel.setName(rs.getString("NAME"));
				tableModel.setComment(tableModel.getName());
				return tableModel;
			}
		};
		List<TableModel> tableModels=getForList(sql, pageBean, rowMapper, SqlTypeConst.SQLSERVER);
		//获取列对象
		List<String> tableNames=new ArrayList<String>();
		//get all table names
		for(TableModel model:tableModels){
			tableNames.add(model.getName());
		}
		//batch get table columns
		Map<String,List<ColumnModel>> tableColumnsMap = getColumnsByTableName(tableNames);
		//extract table columns from map by table name;
		for(Entry<String, List<ColumnModel>> entry:tableColumnsMap.entrySet()){
			//set TableModel's columns
			for(TableModel model:tableModels){
				if(model.getName().equalsIgnoreCase(entry.getKey())){
					model.setColumnList(entry.getValue());
				}
			}
		}
		return tableModels;
	}

	/**
	 * 根据表名获取列
	 * 
	 * @param tableName
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private List<ColumnModel> getColumnsByTableName(String tableName) {
		String sql = String.format(SQL_GET_COLUMNS, tableName);
		jdbcHelper.setCurrentDb(currentDb);
		Map map = new HashMap();
		List<ColumnModel> list = jdbcHelper.queryForList(sql, map,new SqlServerColumnMap());
		for(ColumnModel model:list){
			model.setTableName(tableName);
		}
		return list;
	}

	/**
	 * 根据表名获取列。此方法使用批量查询方式。
	 * @param tableName
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private Map<String,List<ColumnModel>> getColumnsByTableName(List<String> tableNames){
		String sql=SQL_GET_COLUMNS_BATCH;
		Map<String, List<ColumnModel>> map = new HashMap<String, List<ColumnModel>>();
		if(tableNames!=null && tableNames.size()==0){
			return map;
		}else{
			StringBuffer buf=new StringBuffer();
			for(String str:tableNames){
				buf.append("'"+str+"',");
			}
			buf.deleteCharAt(buf.length()-1);
			sql+=" AND B.NAME IN ("+buf.toString()+") ";
		}
		jdbcHelper.setCurrentDb(currentDb);
		List<ColumnModel> columnModels= jdbcHelper.queryForList(sql, new HashMap<String,Object>(), new SqlServerColumnMap());
		for(ColumnModel columnModel:columnModels){
			String tableName= columnModel.getTableName();
			if(map.containsKey(tableName)){
				map.get(tableName).add(columnModel);
			}else{
				List<ColumnModel> cols=new ArrayList<ColumnModel>();
				cols.add(columnModel);
				map.put(tableName, cols);
			}
		}
		return map;
	}

	

}
