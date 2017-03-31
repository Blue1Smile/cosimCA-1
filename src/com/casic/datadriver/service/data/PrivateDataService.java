package com.casic.datadriver.service.data;

import com.casic.datadriver.dao.data.DataStructDao;
import com.casic.datadriver.dao.data.PrivateDataDao;
import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.data.DataStruct;
import com.casic.datadriver.model.data.PrivateData;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.platform.auth.ISysUser;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.expression.ParseException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * The Class PrivateDataService.
 */
@Service
public class PrivateDataService extends BaseService<PrivateData> {

    /**
     * The privateData dao.
     */
    @Resource
    private PrivateDataDao privateDataDao;

    @Resource
    private DataStructDao dataStructDao;

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

    public List<PrivateData> selectByStructid(Long Structid) {
        return this.privateDataDao.selectByStructid(Structid);
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


    public void updatedata(PrivateData privateData) {
        this.privateDataDao.updatedata(privateData);
    }

    public List<PrivateData> getListByIdPage(PageInfo pageInfo) {
        return this.privateDataDao.getListByIdPage(pageInfo);
    }

    public List<PrivateData> getPublishDataList(Long taskId) {
        return this.privateDataDao.getPublishDataList(taskId);
    }

    public List<PrivateData> getPublishListPage(PageInfo pageInfo) {
        return this.privateDataDao.getPublishListPage(pageInfo);
    }

    public static String getValue(HSSFCell cell) {
        String value = "";
        if (cell == null) {
            value = "";
        } else {
            value = cell.getStringCellValue();
        }
        return value;
    }

    private List<PrivateData> readBrandPeriodSorXls(InputStream is,Long taskId,Long projectId)
            throws IOException, ParseException {
        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(is);
        List<PrivateData> brandMobileInfos = new ArrayList<PrivateData>();
        List<DataStruct> DataStructlist = new ArrayList<DataStruct>();
        PrivateData brandMobileInfo;
        DataStruct datastruct;
        // 循环工作表Sheet
        for (int numSheet = 0; numSheet < hssfWorkbook.getNumberOfSheets(); numSheet++) {
            //根据表单序号获取表单
            HSSFSheet hssfSheet = hssfWorkbook.getSheetAt(numSheet);
            if (hssfSheet == null) {
                continue;
            }

            // 循环行Row
            for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
                brandMobileInfo = new PrivateData();
                datastruct = new DataStruct();
                HSSFRow hssfRow = hssfSheet.getRow(rowNum);
                brandMobileInfo.setDdDataId(UniqueIdUtil.genId());
                datastruct.setDdStructId(UniqueIdUtil.genId());
                for (int i = 0; i < hssfRow.getLastCellNum(); i++) {
                    brandMobileInfo.setDdDataName(String.valueOf(hssfRow.getCell(2)));
                    brandMobileInfo.setDdDataEngName(String.valueOf(hssfRow.getCell(3)));
                    brandMobileInfo.setDdDataType(String.valueOf(hssfRow.getCell(4)));
                    brandMobileInfo.setDdDataLastestValue(String.valueOf(hssfRow.getCell(6)));
//                   阈值定义问题
//                    brandMobileInfo.setDdDataSensitiveness(Long.valueOf(String.valueOf(hssfRow.getCell(5))));
                    brandMobileInfo.setDdDataUnit(String.valueOf(hssfRow.getCell(7)));
                    brandMobileInfo.setDdDataTaskId(taskId);
                    brandMobileInfo.setDdDataNodeId(datastruct.getDdStructId());
                    brandMobileInfo.setDdDataPublishType(Long.valueOf(0));
                    brandMobileInfo.setDdDataSubmiteState(Long.valueOf(0));
                    ISysUser sysUser = ContextUtil.getCurrentUser();
                    brandMobileInfo.setDdDataCreatePerson(sysUser.getUserId());
                    Date now = new Date();
                    brandMobileInfo.setDdDataCreateTime(now);

                    datastruct.setDdTaskId(taskId);
                    datastruct.setDdProjectId(projectId);
                    datastruct.setDdStructName(String.valueOf(hssfRow.getCell(0)));
                    datastruct.setDdEngName(String.valueOf(hssfRow.getCell(1)));
                    datastruct.setDdCreateTime(now);
                    datastruct.setDdParentId(sysUser.getUserId());

                    brandMobileInfos.add(brandMobileInfo);
                    DataStructlist.add(datastruct);
                }

            }
        }

        for (int a = 0; a < brandMobileInfos.size(); a++) {
            this.privateDataDao.add(brandMobileInfos.get(a));
        }

        for (int a = 0; a < DataStructlist.size(); a++) {
            this.privateDataDao.add(brandMobileInfos.get(a));
        }

        return brandMobileInfos;
    }

    public int importBrandPeriodSort(InputStream in,Long taskId,Long projectId) throws Exception {
        List<PrivateData> brandMobileInfos = readBrandPeriodSorXls(in,taskId,projectId);

        return brandMobileInfos.size();
    }

}
