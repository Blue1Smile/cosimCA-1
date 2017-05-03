package com.casic.datadriver.controller.data;


import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.QueryParameters;
import com.casic.datadriver.model.data.DataStruct;
import com.casic.datadriver.model.data.OrderDataRelation;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.service.data.DataStructService;
import com.casic.datadriver.service.data.OrderDataRelationService;
import com.casic.datadriver.service.data.PrivateDataService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.core.web.util.RequestUtil;
import com.hotent.platform.auth.ISysUser;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
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
import java.util.*;

import static com.casic.cloud.controller.console.ConsoleController.formatJson;

//import com.fr.base.core.json.JSONArray;


/**
 * @author 2016/11/14 0014.
 */
@Controller
@RequestMapping("/datadriver/data/")
public class DataStructController extends AbstractController {

    /**
     * The dataStruct service.
     */
    @Resource
    private DataStructService dataStructService;

    @Resource
    private TaskInfoService taskInfoServiceDataService;

    @Resource
    private PrivateDataService privateDataService;

    @Resource
    private OrderDataRelationService orderdatarelationservice;


    /**
     * 添加结构化数据、文件、模型.
     *
     * @param request  the request
     * @param response the response
     * @throws Exception the exception
     */
    @RequestMapping("save")
    @Action(description = "添加dataStruct")
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;

        String json = RequestUtil.getString(request, "json");
        DataStruct dataStruct = getFormObject(request);
        //添加创建者名称和id
        ISysUser sysUser = ContextUtil.getCurrentUser();
        dataStruct.setDdCreatorId(sysUser.getUserId());
        dataStruct.setDdCreator(sysUser.getUsername());
        //添加当前时间
        Date currentTime = new Date();
        dataStruct.setDdCreateTime(currentTime);
        //添加所属任务名称和项目id
        TaskInfo ownerTask = taskInfoServiceDataService.getById(dataStruct.getDdTaskId());
        dataStruct.setDdProjectId(ownerTask.getDdTaskProjectId());
        dataStruct.setDdTaskName(ownerTask.getDdTaskName());
        //添加数据状态信息
        Short type = 0;
        dataStruct.setDdOrderState(type);
        dataStruct.setDdPublishState(type);
        dataStruct.setDdSubmitState(type);
        List<PrivateData> privateDataList = dataStruct.getPrivateDataList();
        try {
            if (dataStruct.getDdStructId() == null || dataStruct.getDdStructId() == 0) {
                dataStruct.setDdStructId(UniqueIdUtil.genId());
                dataStructService.addDDDataStruct(dataStruct);
                //如果是结构型数据包括多个属性值
                if (dataStruct.getDdType().equals(1)) {
                    for (int i = 0; i < privateDataList.size(); i++) {
                        //存储child信息

                        PrivateData childPrivateData = new PrivateData();
                        childPrivateData.setDdDataId(UniqueIdUtil.genId());
                        childPrivateData.setDdDataName(privateDataList.get(i).getDdDataName());
                        childPrivateData.setDdDataType(privateDataList.get(i).getDdDataType());
                        childPrivateData.setDdDataEngName(privateDataList.get(i).getDdDataEngName());
                        childPrivateData.setDdDataDescription(privateDataList.get(i).getDdDataDescription());
                        childPrivateData.setDdDataTaskId(dataStruct.getDdTaskId());
                        childPrivateData.setDdDataPublishType(0l);
                        childPrivateData.setDdDataSubmiteState(0l);
                        childPrivateData.setDdDataCreatePerson(dataStruct.getDdCreatorId());
                        childPrivateData.setDdDataCreateTime(dataStruct.getDdCreateTime());
                        childPrivateData.setDdDataTaskName(dataStruct.getDdTaskName());
                        childPrivateData.setDdDataParentId(dataStruct.getDdStructId());
                        childPrivateData.setDdDataUnit(privateDataList.get(i).getDdDataUnit());
                        privateDataService.add(childPrivateData);
                    }
                }
                //如果是只有一个属性的结构型数据
                else {
                    PrivateData childPrivateData = new PrivateData();
                    childPrivateData.setDdDataId(UniqueIdUtil.genId());

                    childPrivateData.setDdDataName(dataStruct.getDdStructName());
                    childPrivateData.setDdDataType(dataStruct.getDdType());
                    childPrivateData.setDdDataDescription(dataStruct.getDdDescription());

                    childPrivateData.setDdDataTaskId(dataStruct.getDdTaskId());
                    childPrivateData.setDdDataPublishType(0l);
                    childPrivateData.setDdDataSubmiteState(0l);
                    childPrivateData.setDdDataCreatePerson(dataStruct.getDdCreatorId());
                    childPrivateData.setDdDataCreateTime(dataStruct.getDdCreateTime());
                    childPrivateData.setDdDataTaskName(dataStruct.getDdTaskName());
                    childPrivateData.setDdDataParentId(dataStruct.getDdStructId());
                    childPrivateData.setDdDataUnit(dataStruct.getDdUnitForPrivate());
                    privateDataService.add(childPrivateData);
                }
            }
            resultMsg = getText("record.added", "结构数据");
            writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }

    }

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
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("list")
    @Action(description = "结构化数据列表")
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
     * @param request  the request
     * @param response the response
     * @throws Exception the exception
     */
    @RequestMapping("del")
    public void del(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        super.del(request, response, this.dataStructService);
        String preUrl = RequestUtil.getPrePage(request);
        try {
            Long ddStructId = RequestUtil.getLong(request, "id");
            dataStructService.delById(ddStructId);
            privateDataService.delBySructId(ddStructId);
        } catch (Exception ex) {
        }
        response.sendRedirect(preUrl);
    }

    /**
     * @param bin the bin
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

        Long pageSize = RequestUtil.getLong(request, "pageSize");
        Long pageNumber = RequestUtil.getLong(request, "pageNumber");
        Long taskid = RequestUtil.getLong(request, "id");
        response.setContentType("application/json");
        Long a = pageSize * (pageNumber - 1);
        Long b = pageSize * (pageNumber);
        List<DataStruct> structdata_list = dataStructService.getStructByTaskId(taskid);
//        List<PrivateData> privateDataList = privateDataService.selectByStructid();

        if (b > structdata_list.size()) {
            b = Long.valueOf(structdata_list.size());
        }

        JSONObject json = CombinationJSON(a, b, taskid, structdata_list);
//        String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
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

    public JSONObject CombinationJSON(long a, long b, long taskId, List<DataStruct> list) {

        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        JSONObject jsonObject = new JSONObject();
        for (int i = Math.toIntExact(a); i < b; i++) {
            DataStruct mymode = list.get(i);
            jsonObject.put("ddStructId", mymode.getDdStructId());
            jsonObject.put("ddStructName", mymode.getDdStructName());
            jsonObject.put("ddParentId", mymode.getDdParentId());
            jsonObject.put("ddTaskId", mymode.getDdTaskId());
            jsonObject.put("ddTaskName", mymode.getDdTaskName());
            jsonObject.put("ddType", mymode.getDdType());
            jsonObject.put("ddOrderState", mymode.getDdOrderState());
            jsonObject.put("ddProjectId", mymode.getDdProjectId());
            jsonObject.put("ddPublishState", mymode.getDdPublishState());
            jsonObject.put("ddBeOrder", mymode.getDdBeOrder());
            switch (mymode.getDdType())
            {
                case 0 :
                    jsonObject.put("shujuleixing", "数值");

                    break;
                case 1 :
                    jsonObject.put("shujuleixing", "结构型数据");
                    break;
                case 2 :
                    jsonObject.put("shujuleixing", "文件");
                    break;
                case 3 :
                    jsonObject.put("shujuleixing", "模型");
                    break;
                default :
                    jsonObject.put("shujuleixing", "其它");
                    break;
            }
//FIXME:已经在具体函数中判断
//            QueryParameters queryparameters = new QueryParameters();
//            queryparameters.setId(taskId);
//            queryparameters.setType(mymode.getDdStructId());
//            int num = orderdatarelationservice.getDDOrderDataRelation(queryparameters).size();
//            if (num > 0) {
//                jsonObject.put("exist", 1);
//            } else if (num == 0) {
//                jsonObject.put("exist", 0);
//            }
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
        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        JSONObject jsonObject = new JSONObject();

        Long pageSize = RequestUtil.getLong(request, "pageSize");
        Long pageNumber = RequestUtil.getLong(request, "pageNumber");
        Long id = RequestUtil.getLong(request, "id");
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
        for (int i = 0; i < privateData_list.size(); i++) {
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
            switch (tempPrivateData.getDdDataType())
            {
                case 0 :
                    jsonObject.put("ddDataUnit", tempPrivateData.getDdDataUnit());
                    break;
                case 1 :
                    jsonObject.put("ddDataUnit", "--");
                    break;
                case 2 :
                    jsonObject.put("ddDataUnit", "--");
                    break;
                case 3 :
                    jsonObject.put("ddDataUnit", "--");
                    break;
                default :
                    jsonObject.put("ddDataUnit", "其它");
                    break;
            }
//            jsonObject.put("ddDataUnit", tempPrivateData.getDdDataUnit());

            jsonObject.put("ddDataType", tempPrivateData.getDdDataType());
            switch (tempPrivateData.getDdDataType())
            {
                case 0 :
                    jsonObject.put("shujuleixing", "数值");
                    break;
                case 1 :
                    jsonObject.put("shujuleixing", "结构化数据");
                    break;
                case 2 :
                    jsonObject.put("shujuleixing", "文件");
                    break;
                case 3 :
                    jsonObject.put("shujuleixing", "模型");
                break;
                default :
                    jsonObject.put("shujuleixing", "其它");
                    break;
            }
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


        Long pageSize = RequestUtil.getLong(request, "pageSize");
        Long pageNumber = RequestUtil.getLong(request, "pageNumber");
        Long id = RequestUtil.getLong(request, "id");
        response.setContentType("application/json");
        Long a = pageSize * (pageNumber - 1);
        Long b = pageSize * (pageNumber);
        QueryParameters queryparameters = new QueryParameters();
        queryparameters.setId(id);
        queryparameters.setBackupsL(Long.valueOf(1));
        List<DataStruct> structdata_list = dataStructService.getStructByPublish(queryparameters);

        if (b > structdata_list.size()) {
            b = Long.valueOf(structdata_list.size());
        }

        JSONObject json = CombinationJSON(a, b, id, structdata_list);

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
    @RequestMapping("showOrder")
    @Action(description = "显示任务已经订阅的数据")
    public void showOrder(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setCharacterEncoding("UTF-8");
        Integer pageSize = RequestUtil.getInt(request, "pageSize");
        Integer pageNumber = RequestUtil.getInt(request, "pageNumber");
        Long taskId = RequestUtil.getLong(request, "id");
        response.setContentType("application/json");
        Integer a = pageSize * (pageNumber - 1);
        Integer b = pageSize * (pageNumber);

//        List<DataStruct> structdata_list = dataStructService.getStructByTaskAndOId(queryparameters);
        List<OrderDataRelation> OrderDataRelation_list = orderdatarelationservice.getOrderDataRelationList(taskId);
        List<DataStruct> dataStructList = new ArrayList<DataStruct>();
        //循环获取已订阅数据ID，查找私有数据
        for (int i = 0; i < OrderDataRelation_list.size(); i++) {
            OrderDataRelation orderDataRelation = OrderDataRelation_list.get(i);
            DataStruct dataStruct = dataStructService.getById(orderDataRelation.getDdDataId());
            dataStructList.add(dataStruct);
        }//获取已订阅数据结束

        if (b > dataStructList.size()) {
            b = dataStructList.size();
        }

        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        JSONObject jsonObject = new JSONObject();

        for (int i = a; i < b; i++) {
            DataStruct mymode = dataStructList.get(i);
            jsonObject.put("ddStructId", mymode.getDdStructId());
            jsonObject.put("ddStructName", mymode.getDdStructName());
            jsonObject.put("ddCatkey", mymode.getDdCatkey());
            jsonObject.put("ddCreateTime", mymode.getDdCreateTime());
            jsonObject.put("ddCreator", mymode.getDdCreator());
            jsonObject.put("ddCreatorId", mymode.getDdCreatorId());
            jsonObject.put("ddDepth", mymode.getDdDepth());
            jsonObject.put("ddDescription", mymode.getDdDescription());
            jsonObject.put("ddEngName", mymode.getDdEngName());
            jsonObject.put("ddIsLeaf", mymode.getDdIsLeaf());
            jsonObject.put("ddNodePath", mymode.getDdNodePath());
            jsonObject.put("ddOrderState", mymode.getDdOrderState());
            jsonObject.put("ddParentId", mymode.getDdParentId());
            jsonObject.put("ddProjectId", mymode.getDdProjectId());
            jsonObject.put("ddPublishState", mymode.getDdPublishState());
            jsonObject.put("ddSubmitState", mymode.getDdSubmitState());
            jsonObject.put("ddTaskId", mymode.getDdTaskId());
            jsonObject.put("ddTaskName", mymode.getDdTaskName());
            jsonObject.put("ddType", mymode.getDdType());
            switch (mymode.getDdType())
            {
                case 0 :
                    jsonObject.put("shujuleixing", "数值");
                    break;
                case 1 :
                    jsonObject.put("shujuleixing", "结构化数据");
                    break;
                case 2 :
                    jsonObject.put("shujuleixing", "文件");
                    break;
                case 3 :
                    jsonObject.put("shujuleixing", "模型");
                    break;
                default :
                    jsonObject.put("shujuleixing", "其它");
                    break;
            }
            jsonMembers.add(jsonObject);
        }
        json.put("total", OrderDataRelation_list.size());
        json.put("rows", jsonMembers);
//      String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
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
    @RequestMapping("showCanBeOrder")
    @Action(description = "显示可被订阅数据")
    public void showCanBeOrder(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setCharacterEncoding("UTF-8");
        Long pageSize = RequestUtil.getLong(request, "pageSize");
        Long pageNumber = RequestUtil.getLong(request, "pageNumber");

        Long taskId = RequestUtil.getLong(request, "taskId");

        Long projectId = RequestUtil.getLong(request, "projectId");
        response.setContentType("application/json");
        Long a = pageSize * (pageNumber - 1);
        Long b = pageSize * (pageNumber);
        QueryParameters queryparameters = new QueryParameters();
        JSONObject json = new JSONObject();

        queryparameters.setId(projectId);
        queryparameters.setBackupsL(Long.valueOf(1));
        List<DataStruct> structdata_list = dataStructService.getStructByProjectAndPId(queryparameters);

        if (b > structdata_list.size()) {
            b = Long.valueOf(structdata_list.size());
        }

        List<OrderDataRelation> relationListBeOrder = orderdatarelationservice.getOrderDataRelationList(taskId);
        List<DataStruct> canBeOrderList = new ArrayList<DataStruct>();
        for (DataStruct canBeOrder : structdata_list) {
            boolean flag = false;
            for (OrderDataRelation beOrder : relationListBeOrder) {
                if (canBeOrder.getDdStructId().equals(beOrder.getDdDataId())) {
                    flag = true;
                    break;
                }
            }
            if (flag) {
                canBeOrder.setDdBeOrder(1);
            } else {
                canBeOrder.setDdBeOrder(0);
            }
            canBeOrderList.add(canBeOrder);
        }
        if (canBeOrderList.isEmpty()) {
            return;
        } else {
            json = CombinationJSON(a, b, taskId, canBeOrderList);
        }

//      String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
        PrintWriter out = null;
        out = response.getWriter();
        out.append(jsonstring);
        out.flush();
        out.close();
    }
}
