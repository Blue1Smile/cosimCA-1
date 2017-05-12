package com.casic.datadriver.service.data;

import com.casic.datadriver.dao.data.DataStructDao;
import com.casic.datadriver.dao.data.OrderDataRelationDao;
import com.casic.datadriver.dao.data.PrivateDataDao;
import com.casic.datadriver.model.QueryParameters;
import com.casic.datadriver.model.data.DataStruct;
import com.casic.datadriver.model.data.PrivateData;
import com.hotent.core.db.IEntityDao;
import com.hotent.core.service.BaseService;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.platform.auth.ISysUser;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
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

import static com.casic.datadriver.controller.ModelCenterController.addIndentBlank;

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
    private OrderDataRelationDao orderDataRelationDao;

    @Resource
    private DataStructDao dataStructDao;

    public boolean addDDPrivateData(PrivateData privateData) {
        this.privateDataDao.add(privateData);
        return true;
    }


    protected IEntityDao<PrivateData, Long> getEntityDao() {
        return this.privateDataDao;
    }

    /**
     * 添加一个数据
     */
    public void addSingleData(PrivateData privateData) {
        privateDataDao.addSingleData(privateData);
    }

    /**
     * 获取所有数据
     */
    public List<PrivateData> getAll() {
       return privateDataDao.getAll();
    }

    /**
     * 根据数据ID获取数据
     */
    public PrivateData getDataById(Long dataId) {
        return privateDataDao.getDataById(dataId);
    }

    /**
     * 根据数据ParentID获取数据
     */
    public List<PrivateData> getDataListByPId(Long parentId) {
        return privateDataDao.getDataListByPId(parentId);
    }

    /**
     * 获取任务发布的数据
     */
    public String getPubListByTaskId(Long taskId) {

        return null;
    }
    public static String formatJson(String jsonStr) {
        if (null == jsonStr || "".equals(jsonStr)) return "";
        StringBuilder sb = new StringBuilder();
        char last = '\0';
        char current = '\0';
        int indent = 0;
        for (int i = 0; i < jsonStr.length(); i++) {
            last = current;
            current = jsonStr.charAt(i);
            switch (current) {
                case '{':
                case '[':
                    sb.append(current);
                    sb.append('\n');
                    indent++;
                    addIndentBlank(sb, indent);
                    break;
                case '}':
                case ']':
                    sb.append('\n');
                    indent--;
                    addIndentBlank(sb, indent);
                    sb.append(current);
                    break;
                case ',':
                    sb.append(current);
                    if (last != '\\') {
                        sb.append('\n');
                        addIndentBlank(sb, indent);
                    }
                    break;
                default:
                    sb.append(current);
            }
        }

        return sb.toString();
    }
    /**
     * 获取任务未发布的数据
     */
    public List<PrivateData> getUnPubListByTaskId(Long taskId) {
        return privateDataDao.getUnPubListByTaskId(taskId);
    }

    /**
     * 获取任务订阅的数据
     */
    public List<PrivateData> getOrdListByTaskId(Long taskId) {
        return privateDataDao.getOrdListByTaskId(taskId);
    }

    /**
     * 获取任务未订阅的数据
     */
    public List<PrivateData> getUnOrdListByTaskId(Long taskId) {
        return privateDataDao.getUnOrdListByTaskId(taskId);
    }

    /**
     * 获取任务输出数据(私有)
     */
    public String getOutputdataByTaskId(Long taskId) {
        return ToJson(privateDataDao.getDataListByTaskId(taskId));
    }

    /**
     * 获取任务输入数据(项目)
     */
    public String getInputdataByprojectId(Long projectId,Long taskId) {
        List<PrivateData> allPrivateData = privateDataDao.getDataListByProId(projectId);
        QueryParameters queryParameters = null;
        JSONObject jsonObject = new JSONObject();
        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        queryParameters.setId(taskId);
        for(int i = 0; i < allPrivateData.size(); i++)
        {
            PrivateData mymodel = allPrivateData.get(i);
            queryParameters.setType(mymodel.getDdDataId());
            jsonObject.put("dataId",mymodel.getDdDataId());
            jsonObject.put("dataName",mymodel.getDdDataName());
            jsonObject.put("filePath",mymodel.getDdDataPath());
            jsonObject.put("parentId",mymodel.getDdDataParentId());
            jsonObject.put("taskId",mymodel.getDdDataTaskId());
            jsonObject.put("dataType",mymodel.getDdDataType());
            jsonObject.put("dataDescription",mymodel.getDdDataDescription());
            jsonObject.put("publishState",mymodel.getDdDataPublishState());
            jsonObject.put("orderState",mymodel.getDdDataOrderState());
            jsonObject.put("submitState",mymodel.getDdDataIsSubmit());
            jsonObject.put("taskName",mymodel.getDdDataTaskName());
            jsonObject.put("creator",mymodel.getDdDataCreator());
            jsonObject.put("createTime",mymodel.getDdDataCreateTime());
            jsonObject.put("projectId",mymodel.getDdDataProjId());
            jsonObject.put("creatorId",mymodel.getDdDataCreatorId());
            jsonObject.put("dataUnit",mymodel.getDdDataUnit());
            jsonObject.put("dataValue",mymodel.getDdDataLastestValue());
            if(orderDataRelationDao.getDDOrderDataRelation(queryParameters).size()>0)
            {
                jsonObject.put("torderState",1) ;//已经订阅该数据
            }else{
                jsonObject.put("torderState",0) ;//没有订阅该数据
            }
            jsonMembers.add(jsonObject);
        }
        return formatJson(jsonMembers.toString());
    }

    /**
     * 更新数据
     */
    public void updateData(PrivateData privateData) {
        privateDataDao.updateData(privateData);
    }

    /**
     * 根据任务ID删除单个数据
     */
    public void delByTaskId(Long taskId) {
        privateDataDao.delByTaskId(taskId);
    }

    /**
     * 生成输出json
     */
    public String ToJson(List<PrivateData> list)
    {
        JSONObject jsonObject = new JSONObject();
        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();

        for (int i = 0; i < list.size(); i++) {
            PrivateData mymodel = list.get(i);
            jsonObject.put("dataId",mymodel.getDdDataId());
            jsonObject.put("dataName",mymodel.getDdDataName());
            jsonObject.put("filePath",mymodel.getDdDataPath());
            jsonObject.put("parentId",mymodel.getDdDataParentId());
            jsonObject.put("taskId",mymodel.getDdDataTaskId());
            jsonObject.put("dataType",mymodel.getDdDataType());
            jsonObject.put("dataDescription",mymodel.getDdDataDescription());
            jsonObject.put("publishState",mymodel.getDdDataPublishState());
            jsonObject.put("orderState",mymodel.getDdDataOrderState());
            jsonObject.put("submitState",mymodel.getDdDataIsSubmit());
            jsonObject.put("taskName",mymodel.getDdDataTaskName());
            jsonObject.put("creator",mymodel.getDdDataCreator());
            jsonObject.put("createTime",mymodel.getDdDataCreateTime());
            jsonObject.put("projectId",mymodel.getDdDataProjId());
            jsonObject.put("creatorId",mymodel.getDdDataCreatorId());
            jsonObject.put("dataUnit",mymodel.getDdDataUnit());
            jsonObject.put("dataValue",mymodel.getDdDataLastestValue());
            jsonMembers.add(jsonObject);
        }
//        json.put("rows", jsonMembers);
//        String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(jsonMembers.toString());
        System.out.println(jsonstring);
        return jsonstring;
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

    private List<PrivateData> readBrandPeriodSorXls(InputStream is, Long taskId, Long projectId,String taskname)
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
            String str = null;
            Long StructId = Long.valueOf(0);
            // 循环行Row
            for (int rowNum = 1; rowNum <= hssfSheet.getLastRowNum(); rowNum++) {
                brandMobileInfo = new PrivateData();
                datastruct = new DataStruct();
                HSSFRow hssfRow = hssfSheet.getRow(rowNum);

                ISysUser sysUser = ContextUtil.getCurrentUser();
                Date now = new Date();
                Integer DataType = 0;
                switch (String.valueOf(hssfRow.getCell(4))) {
                    case "结构化数据":
                        DataType = 1;
                        break;
                    case "文件":
                        DataType = 2;
                        break;
                    case "模型":
                        DataType = 3;
                        break;
                    case "数值":
                        DataType = 0;
                        break;
                }

                if (!String.valueOf(hssfRow.getCell(0)).equals(str)) {
                    str = String.valueOf(hssfRow.getCell(0));
                    StructId = UniqueIdUtil.genId();
                    datastruct.setDdTaskName(taskname);
                    datastruct.setDdStructId(StructId);
                    datastruct.setDdTaskId(taskId);
                    datastruct.setDdProjectId(projectId);
                    datastruct.setDdStructName(String.valueOf(hssfRow.getCell(0)));
                    datastruct.setDdEngName(String.valueOf(hssfRow.getCell(1)));
                    datastruct.setDdCreateTime(now);
                    datastruct.setDdType(DataType);
                    datastruct.setDdParentId(sysUser.getUserId());
                    datastruct.setDdOrderState((short)0);
                    datastruct.setDdPublishState((short)0);
                    datastruct.setDdSubmitState((short)0);
                    DataStructlist.add(datastruct);
                }
                brandMobileInfo.setDdDataId(UniqueIdUtil.genId());


                brandMobileInfo.setDdDataName(String.valueOf(hssfRow.getCell(2)));
                brandMobileInfo.setDdDataEngName(String.valueOf(hssfRow.getCell(3)));
//                brandMobileInfo.setDdDataType(DataType);
                brandMobileInfo.setDdDataLastestValue(String.valueOf(hssfRow.getCell(6)));
                brandMobileInfo.setDdDataTaskName(taskname);
//                   阈值定义问题
//                    brandMobileInfo.setDdDataSensitiveness(Long.valueOf(String.valueOf(hssfRow.getCell(5))));
                brandMobileInfo.setDdDataUnit(String.valueOf(hssfRow.getCell(7)));
                brandMobileInfo.setDdDataTaskId(taskId);
//                brandMobileInfo.setDdDataNodeId(StructId);
//                brandMobileInfo.setDdDataPublishType(Long.valueOf(0));
//                brandMobileInfo.setDdDataSubmiteState(Long.valueOf(0));
//
//                brandMobileInfo.setDdDataCreatePerson(sysUser.getUserId());
                brandMobileInfo.setDdDataCreateTime(now);


                brandMobileInfos.add(brandMobileInfo);

//                }

            }
        }

        for (int a = 0; a < brandMobileInfos.size(); a++) {
            this.privateDataDao.add(brandMobileInfos.get(a));
        }

        for (int a = 0; a < DataStructlist.size(); a++) {
            this.dataStructDao.addDataStruct(DataStructlist.get(a));
        }

        return brandMobileInfos;
    }

    public int importBrandPeriodSort(InputStream in, Long taskId, Long projectId,String taskname) throws Exception {
        List<PrivateData> brandMobileInfos = readBrandPeriodSorXls(in, taskId, projectId,taskname);

        return brandMobileInfos.size();
    }

}
