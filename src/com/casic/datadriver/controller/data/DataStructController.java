package com.casic.datadriver.controller.data;


import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.QueryParameters;
import com.casic.datadriver.model.data.DataStruct;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.service.data.DataStructService;
import com.casic.datadriver.service.data.PrivateDataService;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.core.web.util.RequestUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.service.data.PrivateDataService;
//import com.fr.base.core.json.JSONArray;
import com.hotent.core.util.ContextUtil;
import com.hotent.platform.auth.ISysUser;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.JSONArray;

import net.sf.json.util.JSONUtils;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import static com.casic.cloud.controller.console.ConsoleController.formatJson;


/**
 *
 * @author 2016/11/14 0014.
 */
@Controller
@RequestMapping("/datadriver/data/")
public class DataStructController extends AbstractController {

    /** The dataStruct service. */
    @Resource
    private DataStructService dataStructService;

    @Resource
    private PrivateDataService privateDataService;

    /**
     * 添加结构化数据、文件、模型.
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @throws Exception
     *             the exception
     */
    @RequestMapping("save")
    @Action(description = "添加dataStruct")
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;
        String json = RequestUtil.getString(request, "json");
        DataStruct dataStruct = getFormObject(request);

        ISysUser sysUser = ContextUtil.getCurrentUser();
        dataStruct.setDdCreator(sysUser.getUsername());

        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = formatter.format(currentTime);
//        dataStruct.setDdCreateTime(dateString);
        JSONObject dataStructJson = JSONObject.fromObject(json);
        JSONArray childDataArray = dataStructJson.getJSONArray("privateDataList");

        try {

            if (dataStruct.getDdStructId()==null||dataStruct.getDdStructId()==0) {
                dataStruct.setDdStructId((Long) UniqueIdUtil.genId());
                dataStructService.addDDDataStruct(dataStruct);
                JSONObject dataJson = JSONObject.fromObject(childDataArray.get(0).toString());
                //如果是结构型数据包括多个属性值
                if(dataJson.size()==4) {
                    for (int i = 0; i < childDataArray.size(); i++) {
                        JSONObject childDataJson = JSONObject.fromObject(childDataArray.get(i).toString());

                        DataStruct childDataStruct = new DataStruct();
                        childDataStruct.setDdDescription(childDataJson.getString("ddDataDescription"));
                        childDataStruct.setDdTaskId(dataStruct.getDdTaskId());
                        childDataStruct.setDdCreateTime(dataStruct.getDdCreateTime());
                        childDataStruct.setDdParentId(dataStruct.getDdStructId());
                        childDataStruct.setDdCreator(dataStruct.getDdCreator());
//                        childDataStruct.setDdDepth();
                        childDataStruct.setDdOrderState(dataStruct.getDdOrderState());
                        childDataStruct.setDdStructName(childDataJson.getString("ddDataName"));
                        dataStructService.addDDDataStruct(childDataStruct);

//                        PrivateData childPrivateData = new PrivateData();
//                        childPrivateData.setDdDataId(UniqueIdUtil.genId());
//                        childPrivateData.setDdDataParentId(dataStruct.getDdStructId());
//                        childPrivateData.setDdDataPublishType(0l);
//                        childPrivateData.setDdDataName(privateDataJson.getString("ddDataName"));
//                        childPrivateData.setDdDataTaskId(dataStruct.getDdTaskId());
//                        childPrivateData.setDdDataType(privateDataJson.getString("ddDataType"));
//                        childPrivateData.setDdDataDescription(privateDataJson.getString("ddDataDescription"));

                    }
                    resultMsg = getText("record.added", "cloud_account_info");


                }
                //如果是只有一个属性的结构型数据
                else{
                    PrivateData childPrivateData = new PrivateData();
                    childPrivateData.setDdDataId(UniqueIdUtil.genId());
                    childPrivateData.setDdDataParentId(dataStruct.getDdStructId());
                    childPrivateData.setDdDataPublishType(0l);
                    childPrivateData.setDdDataName(dataStruct.getDdStructName());
                    childPrivateData.setDdDataTaskId(dataStruct.getDdTaskId());
                    childPrivateData.setDdDataType(dataStruct.getDdType().toString());
                    childPrivateData.setDdDataDescription(dataStruct.getDdDescription());
                    }
                resultMsg = getText("record.added", "cloud_account_info");

            } else {
                dataStructService.update(dataStruct);
                resultMsg = getText("record.updated", "cloud_account_info");
            }
            writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

//
//    int length=0;
//    int[] childLength = new int[length];
//
//    for(int i=0;i<length;i++){
//        childLength[i]=0;
//
//    }
//    try {
//        if (dataStruct.getDdStructId() != null || dataStruct.getDdStructId() != 0) {
//            dataStruct.setDdStructId((Long) UniqueIdUtil.genId());
//            dataStructService.addDDDataStruct(dataStruct);
//            for(int i=0;i<length;i++){
//                if(childLength[i]==0){
//                    PrivateData privateData=new PrivateData();
//                    privateData.setDdDataParentId(dataStruct.getDdStructId());
//                    privateData.setDdDataId(UniqueIdUtil.genId());
//                    privateData.setDdDataPublishType(0l);
//                    privateDataService.addDDPrivateData(privateData);
//                }
//                else{
//                    DataStruct childDataStruct = this.getFormObject(request, DataStruct.class);
//                    childDataStruct.setDdStructId((Long) UniqueIdUtil.genId());
//                    dataStructService.addDDDataStruct(childDataStruct);
//                    for(int j=0;j<childLength[i];j++){
//                        PrivateData privateData=new PrivateData();
//                        privateData.setDdDataParentId(childDataStruct.getDdStructId());
//                        privateData.setDdDataId(UniqueIdUtil.genId());
//                        privateData.setDdDataPublishType(0l);
//                        privateDataService.addDDPrivateData(privateData);
//                    }
//
//                }
//
//                resultMsg = getText("record.added", "cloud_account_info");
//
//
//            }
//        } else {
//            dataStructService.update(dataStruct);
//            resultMsg = getText("record.updated", "cloud_account_info");
//        }
//        writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
//    } catch (Exception e) {
//        writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
//    }


    private DataStruct getFormObject(HttpServletRequest request) throws Exception {
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[]{"yyyy-MM-dd"})));

        String json = RequestUtil.getString(request, "json");
        JSONObject obj = JSONObject.fromObject(json);

        Map<String, Class> map = new HashMap<String, Class>();
        map.put("privateDataList", PrivateData.class);
        DataStruct dataStruct = (DataStruct) JSONObject.toBean(obj, DataStruct.class, map);

        return dataStruct;
    }
    /**
     * Query dataStruct basic info list.
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @return the list
     * @throws Exception
     *             the exception
     */
    @RequestMapping("list")
    @Action(description = "����������ѯ��Ŀ������Ϣ�б�")
    public ModelAndView queryDataStructBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        QueryFilter queryFilter = new QueryFilter(request, "DataStructItem");
        ModelAndView mv = this.getAutoView().addObject("dataStructList",
                this.dataStructService.queryDataStructBasicInfoList(queryFilter));
        return mv;
    }

    /**
     * Del.
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @throws Exception
     *             the exception
     */
    @RequestMapping("del")
    public void del(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.del(request, response, this.dataStructService);
    }

    /**
     *
     * @param bin
     *            the bin
     */
    @InitBinder
    public void initBinder(ServletRequestDataBinder bin) {
        bin.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
    }


    /**
     * 查询私有数据
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("showstructdata")
    @Action(description = "根据任务查询私有数据")
    public void showstructdata(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setCharacterEncoding("UTF-8");


        Long pageSize =RequestUtil.getLong(request, "pageSize");
        Long  pageNumber = RequestUtil.getLong(request, "pageNumber");
        Long id= RequestUtil.getLong(request, "id");
        response.setContentType("application/json");
        Long a = pageSize * (pageNumber - 1);
        Long b = pageSize * (pageNumber);
//        ModelCenterModel temp;88
        List<DataStruct> structdata_list = dataStructService.getStructByTaskId(id);

        if (b > structdata_list.size()) {
            b = Long.valueOf(structdata_list.size());
        }

        JSONObject json=CombinationJSON(a,b,structdata_list);
//        String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
//            system.out(json.toString());
        PrintWriter out = null;
        out = response.getWriter();
        out.append(jsonstring);
        out.flush();
        out.close();

    }

    /**
     * 组合JSON使用，仅在私有数据显示时使用
     *
     * @param a:分页使用,第几页
     * @param b:查询结果条数
     * @param list:查询结果list
     * @throws Exception
     */
    public JSONObject CombinationJSON(long a,long b,List<DataStruct> list)
    {
        JSONObject json=new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        JSONObject jsonObject = new JSONObject();
        for (int i = Math.toIntExact(a); i < b; i++) {
            DataStruct mymode = list.get(i);
            jsonObject.put("ddStructId", mymode.getDdStructId());
            jsonObject.put("ddOrderState", mymode.getDdOrderState());
            jsonObject.put("ddStructName", mymode.getDdStructName());
            jsonObject.put("ddParentId", mymode.getDdParentId());
            jsonObject.put("ddTaskId", mymode.getDdTaskId());
            jsonObject.put("ddType", mymode.getDdType());
            jsonObject.put("ddOrderState", mymode.getDdOrderState());
            jsonObject.put("ddProjectId", mymode.getDdProjectId());
//            jsonObject.put("num", mymode.getDdDataId());
            jsonMembers.add(jsonObject);
        }

        json.put("total", list.size());
        json.put("rows", jsonMembers);

        return json;
    }

    /**
     * 根据私有数据ID查询结构化数据
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("showprivatedata")
    @Action(description = "根据私有数据ID查询结构化数据")
    public void selectPrivateByStructid(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setCharacterEncoding("UTF-8");
        JSONObject json=new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        JSONObject jsonObject = new JSONObject();

        Long pageSize =RequestUtil.getLong(request, "pageSize");
        Long  pageNumber = RequestUtil.getLong(request, "pageNumber");
        Long id= RequestUtil.getLong(request, "id");
        response.setContentType("application/json");
//        Long a = pageSize * (pageNumber - 1);
//        Long b = pageSize * (pageNumber);
//        ModelCenterModel temp;88
        List<PrivateData> privateData_list = privateDataService.selectByStructid(id);
//
//
//
//        if (b > structdata_list.size()) {
//            b = Long.valueOf(structdata_list.size());
//        }
//
//
        for (int i =0; i <privateData_list.size(); i++) {
            PrivateData tempPrivateData = privateData_list.get(i);
            jsonObject.put("ddDataLastestValue", tempPrivateData.getDdDataLastestValue());
            jsonObject.put("ddDataCreatePerson", tempPrivateData.getDdDataCreatePerson());
            jsonObject.put("ddDataCreateTime", tempPrivateData.getDdDataCreateTime());
            jsonObject.put("ddDataDescription", tempPrivateData.getDdDataDescription());
            jsonObject.put("ddDataId", tempPrivateData.getDdDataId());
            jsonObject.put("ddDataIsDelivery", tempPrivateData.getDdDataIsDelivery());
            jsonObject.put("ddDataName", tempPrivateData.getDdDataName());
            jsonObject.put("ddDataPublishType", tempPrivateData.getDdDataPublishType());
            jsonObject.put("ddDataSensitiveness", tempPrivateData.getDdDataSensitiveness());
            jsonObject.put("ddDataSubmiteState", tempPrivateData.getDdDataSubmiteState());
            jsonObject.put("ddDataTaskId", tempPrivateData.getDdDataTaskId());
            jsonObject.put("ddDataTaskName", tempPrivateData.getDdDataTaskName());
            jsonObject.put("ddDataType", tempPrivateData.getDdDataType());
            jsonObject.put("ddDataUnit", tempPrivateData.getDdDataUnit());

            jsonMembers.add(jsonObject);
        }
//
        json.put("total", privateData_list.size());
        json.put("rows", jsonMembers);
//        String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
//            system.out(json.toString());
        PrintWriter out = null;
        out = response.getWriter();
        out.append(jsonstring);
        out.flush();
        out.close();

    }

    /**
     * 根据任务查询发布数据
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("showpublishdata")
    @Action(description = "根据任务查询发布数据")
    public void showpublishdata(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setCharacterEncoding("UTF-8");


        Long pageSize =RequestUtil.getLong(request, "pageSize");
        Long  pageNumber = RequestUtil.getLong(request, "pageNumber");
        Long id= RequestUtil.getLong(request, "id");
        response.setContentType("application/json");
        Long a = pageSize * (pageNumber - 1);
        Long b = pageSize * (pageNumber);
        QueryParameters queryparameters = new QueryParameters();
        queryparameters.setId(id);
        queryparameters.getBackupsL(1);
        List<DataStruct> structdata_list = dataStructService.getStructByPublish(queryparameters);

        if (b > structdata_list.size()) {
            b = Long.valueOf(structdata_list.size());
        }

        JSONObject json=CombinationJSON(a,b,structdata_list);
//      String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
//      system.out(json.toString());
        PrintWriter out = null;
        out = response.getWriter();
        out.append(jsonstring);
        out.flush();
        out.close();

    }

    /**
     * 根据任务id查询已订阅数据
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("showsubscriptiondata")
    @Action(description = "根据任务查询订阅数据")
    public void showsubscriptiondata(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setCharacterEncoding("UTF-8");
        Long pageSize =RequestUtil.getLong(request, "pageSize");
        Long  pageNumber = RequestUtil.getLong(request, "pageNumber");
        Long id= RequestUtil.getLong(request, "id");
        response.setContentType("application/json");
        Long a = pageSize * (pageNumber - 1);
        Long b = pageSize * (pageNumber);
        QueryParameters queryparameters = new QueryParameters();

        queryparameters.setId(id);
        queryparameters.getBackupsL(1);

        List<DataStruct> structdata_list = dataStructService.getStructByTaskAndOId(queryparameters);

        if (b > structdata_list.size()) {
            b = Long.valueOf(structdata_list.size());
        }

        JSONObject json=CombinationJSON(a,b,structdata_list);
//      String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
//      system.out(json.toString());
        PrintWriter out = null;
        out = response.getWriter();
        out.append(jsonstring);
        out.flush();
        out.close();

    }

    /**
     * 根据项目id查询项目中已发布的数据
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("showpublishdataByProid")
    @Action(description = "根据项目id查询项目中已发布的数据")
    public void showpublishdataByProid(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setCharacterEncoding("UTF-8");
        Long pageSize =RequestUtil.getLong(request, "pageSize");
        Long  pageNumber = RequestUtil.getLong(request, "pageNumber");
        Long id= RequestUtil.getLong(request, "id");
        response.setContentType("application/json");
        Long a = pageSize * (pageNumber - 1);
        Long b = pageSize * (pageNumber);
        QueryParameters queryparameters = new QueryParameters();

        queryparameters.setId(id);
        queryparameters.getBackupsL(1);

        List<DataStruct> structdata_list = dataStructService.getStructByProjectAndPId(queryparameters);

        if (b > structdata_list.size()) {
            b = Long.valueOf(structdata_list.size());
        }

        JSONObject json=CombinationJSON(a,b,structdata_list);
//      String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
//      system.out(json.toString());
        PrintWriter out = null;
        out = response.getWriter();
        out.append(jsonstring);
        out.flush();
        out.close();

    }
//:
//
}
