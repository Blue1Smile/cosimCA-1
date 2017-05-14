package com.casic.datadriver.controller.datacenter;


import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.QueryParameters;
import com.casic.datadriver.model.data.DataStruct;
import com.casic.datadriver.model.data.DataVersion;
import com.casic.datadriver.model.data.OrderDataRelation;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.model.task.TaskStart;
import com.casic.datadriver.service.data.DataStructService;
import com.casic.datadriver.service.data.DataVersionService;
import com.casic.datadriver.service.data.OrderDataRelationService;
import com.casic.datadriver.service.data.PrivateDataService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.casic.datadriver.service.task.TaskStartService;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.util.RequestUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author 2016/11/14
 */
@Controller
@RequestMapping("/datadriver/personaltask/")
public class PersonalTaskController extends AbstractController {

    @Resource
    private TaskInfoService taskInfoService;
    @Resource
    private PrivateDataService privateDataService;
    @Resource
    private OrderDataRelationService orderDataRelationService;
    @Resource
    private TaskStartService taskStartService;
    @Resource
    private DataVersionService dataVersionService;
    @Resource
    private DataStructService dataStructService;


    /**
     * 2016/12/4/
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("taskList")
    @Action(description = "个人任务列表")
    public void taskList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
//        List<TaskStart> taskStartList = taskStartService.queryTaskStartByResponceId(ContextUtil.getCurrentUserId());
        List<TaskInfo> UserTaskInfo_list = taskInfoService.queryTaskInfoByResponceId(ContextUtil.getCurrentUserId());
        List<TaskInfo> taskInfo_list = new ArrayList<TaskInfo>();

        for (int i = 0; i < UserTaskInfo_list.size(); i++) {
            Long ddTaskId = UserTaskInfo_list.get(i).getDdTaskId();
            TaskInfo taskInfo = taskInfoService.getById(ddTaskId);
            if (taskInfo.getDdTaskChildType() == null) {
                taskInfo.setDdTaskState(taskInfo.createpanel);
                taskInfo.setDdTaskChildType("createpanel");
            }
            if (taskInfo.getDdTaskChildType().equals("publishpanel") || taskInfo.getDdTaskChildType().equals("checkpanel")) {
                taskInfo_list.add(taskInfo);
            }
        }
        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        JSONObject jsonObject = new JSONObject();
        for (int i = 0; i < taskInfo_list.size(); i++) {
            TaskInfo taskInfo = taskInfo_list.get(i);
            jsonObject.put("ddTaskId", taskInfo.getDdTaskId());
            jsonObject.put("ddTaskPriority", taskInfo.getDdTaskPriority());
            jsonObject.put("ddTaskState", taskInfo.getDdTaskState());
            jsonObject.put("ddTaskProjectName", taskInfo.getDdTaskProjectName());
            jsonObject.put("ddTaskName", taskInfo.getDdTaskName());

            switch (taskInfo.getDdTaskPriority()){
                case 3:
                    jsonObject.put("priority", "紧急");
                    break;
                case 2:
                    jsonObject.put("priority", "重要");
                    break;
                default:
                    jsonObject.put("priority", "一般");
                    break;
            }
            switch (taskInfo.getDdTaskState()) {
                case 0:
                    jsonObject.put("state", "新建");
                    break;
                case 1:
                    jsonObject.put("state", "已发布");
                    break;
                case 2:
                    jsonObject.put("state", "审核中");
                    break;
                case 3:
                    jsonObject.put("state", "已完成");
                    break;
                default:
                    jsonObject.put("state", "未知");
                    break;
            }
            jsonMembers.add(jsonObject);
        }
//        json.put("total", taskInfo_list.size());
//        json.put("rows", jsonMembers);
        String jsonstring = formatJson(jsonMembers.toString());
        System.out.println(json.toString());
        PrintWriter out = null;
        out = response.getWriter();
        out.append(jsonstring);
        out.flush();
        out.close();
    }

    @RequestMapping("submitpublish")
    @Action(description = "发布数据")
    public ModelAndView querysubmitpublish(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddTaskId = RequestUtil.getLong(request, "id");
        List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.getPublishDataRelationList(ddTaskId);
        List<PrivateData> privateData_list = new ArrayList<PrivateData>();
        for (int i = 0; i < orderDataRelation_list.size(); i++) {
            OrderDataRelation orderDataRelation = orderDataRelation_list.get(i);
            PrivateData privateData = privateDataService.getById(orderDataRelation.getDdDataId());
            privateData_list.add(privateData);
        }
        ModelAndView mv = this.getAutoView().addObject("privateDataList",
                privateData_list).addObject("taskId", ddTaskId);
        return mv;
    }

//    @RequestMapping("showorder")
//    @Action(description = "订阅数据查看")
//    public ModelAndView queryshoworder(HttpServletRequest request, HttpServletResponse response)
//            throws Exception {
//        Long ddTaskId = RequestUtil.getLong(request, "id");
//        List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.getOrderDataRelationList(ddTaskId);
//        List<PrivateData> privateData = new ArrayList<PrivateData>();
//        for (OrderDataRelation orderDataRelation : orderDataRelation_list) {
//
//            Long ddDataId = orderDataRelation.getDdDataId();
//            List<PrivateData> taskPrivateDatas = this.privateDataService.getByddDataId(ddDataId);
//            privateData.addAll(taskPrivateDatas);
//        }
//        ModelAndView mv = this.getAutoView().addObject("privateDataList",
//                privateData).addObject("taskId", ddTaskId);
//        return mv;
//    }

    /**
     * 进入任务控制台
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("todotask")
    @Action(description = "进入任务")
    public ModelAndView todotask(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long taskId = RequestUtil.getLong(request, "id");
        TaskInfo taskInfo = taskInfoService.getById(taskId);
        List<TaskInfo> taskInfoList = taskInfoService.queryTaskInfoByResponceId(taskInfo.getDdTaskResponsiblePerson());
        return getAutoView().addObject("TaskInfo", taskInfo)
                .addObject("taskInfoList", taskInfoList);
    }

    /**
     * 进入任务数据发布
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("showdata")
    @Action(description = "显示私有和发布")
    public ModelAndView showdata(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long taskId = RequestUtil.getLong(request, "id");
        Long projectId = RequestUtil.getLong(request, "projectId");
        return getAutoView().addObject("taskId", taskId).addObject("projectId", projectId);
    }

    /**
     * 进入任务数据订阅
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("showorder")
    @Action(description = "显示订阅和已订阅")
    public ModelAndView showorder(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long taskId = RequestUtil.getLong(request, "id");
        Long projectId = RequestUtil.getLong(request, "projectId");
        return getAutoView().addObject("taskId", taskId).addObject("projectId", projectId);
    }

    /**
     * 分页函数
     * by 杜
     * 数据库分页
     */
    private PageInfo pagination(Long pageSize, Long pageNumber, Long id) {
        PageInfo pageInfo = new PageInfo();
        pageInfo.setPageSize((pageNumber - 1) * pageSize);
        pageInfo.setPageNumber(pageSize);
        pageInfo.setId(id);
        return pageInfo;
    }

    /**
     * 显示私有数据列表
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("showprivatedata")
    @Action(description = "显示私有数据")
    public void showprivatedata(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            response.setContentType("application/json");
            JSONObject jsonObject = new JSONObject();
            JSONObject json = new JSONObject();
            JSONArray jsonMembers = new JSONArray();

            //任务已发布私有数据
            Long pageSize = RequestUtil.getLong(request, "pageSize");
            Long pageNumber = RequestUtil.getLong(request, "pageNumber");
            long taskId = RequestUtil.getLong(request, "id");

            PageInfo pageInfo = pagination(pageSize, pageNumber, taskId);

//            List<PrivateData> privateDataList = privateDataService.getListByIdPage(pageInfo);
//
//            List<PrivateData> privateDataListTotal = privateDataService.queryPrivateDataByddTaskID(taskId);

//            List<OrderDataRelation> publishDataRelationList = orderDataRelationService.getPublishDataRelationList(taskId);
//            //任务私有数据
//
//            for (int i = 0; i < publishDataRelationList.size(); i++) {
//                OrderDataRelation publishDataRelation = publishDataRelationList.get(i);
//                PrivateData privateData = privateDataService.getById(publishDataRelation.getDdDataId());
//                publishDataList.add(privateData);
//            }

            //获取没有被发布的私有数据
//            if (privateDataListbyTask.size() > 0 && publishDataList.size() > 0) {
//                Integer Length1 = privateDataListbyTask.size();
//                for (int i = 0; i < publishDataList.size(); i++) {
//                    for (int j = 0; j < Length1; j++) {
//                        Long ddDataId1 = publishDataList.get(i).getDdDataId();
//                        Long ddDataId2 = privateDataListbyTask.get(j).getDdDataId();
//                        if (ddDataId1.equals(ddDataId2)) {
//                            privateDataListbyTask.remove(j);
//                            Length1 = privateDataListbyTask.size();
//                            j--;
//                        }
//                    }
//                }
//            }//获取私有数据结束
            PrivateData tempPrivateData = new PrivateData();
//            for (int i = 0; i < privateDataList.size(); i++) {
//                tempPrivateData = privateDataList.get(i);
//                jsonObject.put("ddDataLastestValue", tempPrivateData.getDdDataLastestValue());
//                jsonObject.put("ddDataCreatePerson", tempPrivateData.getDdDataCreatePerson());
//                jsonObject.put("ddDataCreateTime", tempPrivateData.getDdDataCreateTime());
//                jsonObject.put("ddDataDescription", tempPrivateData.getDdDataDescription());
//                jsonObject.put("ddDataId", tempPrivateData.getDdDataId());
//                jsonObject.put("ddDataIsDelivery", tempPrivateData.getDdDataIsDelivery());
//                jsonObject.put("ddDataName", tempPrivateData.getDdDataName());
//                jsonObject.put("ddDataPublishType", tempPrivateData.getDdDataPublishType());
//                jsonObject.put("ddDataSensitiveness", tempPrivateData.getDdDataSensitiveness());
//                jsonObject.put("ddDataSubmiteState", tempPrivateData.getDdDataSubmiteState());
//                jsonObject.put("ddDataTaskId", tempPrivateData.getDdDataTaskId());
//                jsonObject.put("ddDataTaskName", tempPrivateData.getDdDataTaskName());
//                jsonObject.put("ddDataType", tempPrivateData.getDdDataType());
//
//                jsonMembers.add(jsonObject);
//            }
//            json.put("total", privateDataListTotal.size());
            json.put("rows", jsonMembers);

            String jsonstring = formatJson(json.toString());
            PrintWriter out = null;
            out = response.getWriter();
            out.append(jsonstring);
            out.flush();
            out.close();
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * 显示发布数据列表
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("showpublishdata")
    @Action(description = "发布数据列表")
    public void showpublishdata(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            response.setContentType("application/json");
            JSONObject jsonObject = new JSONObject();
            JSONObject json = new JSONObject();
            JSONArray jsonMembers = new JSONArray();
            Long pageSize = RequestUtil.getLong(request, "pageSize");
            Long pageNumber = RequestUtil.getLong(request, "pageNumber");
            long taskId = RequestUtil.getLong(request, "id");
//            List<PrivateData> publishDataListTotal = privateDataService.getPublishDataList(taskId);


            PageInfo pageInfo = pagination(pageSize, pageNumber, taskId);
//            List<PrivateData> publishDataList = privateDataService.getPublishListPage(pageInfo);
            PrivateData tempPrivateData = new PrivateData();
//            for (int i = 0; i < publishDataList.size(); i++) {
//                tempPrivateData = publishDataList.get(i);
//
//                jsonObject.put("ddDataLastestValue", tempPrivateData.getDdDataLastestValue());
//                jsonObject.put("ddDataCreatePerson", tempPrivateData.getDdDataCreatePerson());
//                jsonObject.put("ddDataCreateTime", tempPrivateData.getDdDataCreateTime());
//                jsonObject.put("ddDataDescription", tempPrivateData.getDdDataDescription());
//                jsonObject.put("ddDataId", tempPrivateData.getDdDataId());
//                jsonObject.put("ddDataIsDelivery", tempPrivateData.getDdDataIsDelivery());
//                jsonObject.put("ddDataName", tempPrivateData.getDdDataName());
//                jsonObject.put("ddDataPublishType", tempPrivateData.getDdDataPublishType());
//                jsonObject.put("ddDataSensitiveness", tempPrivateData.getDdDataSensitiveness());
//                jsonObject.put("ddDataSubmiteState", tempPrivateData.getDdDataSubmiteState());
//                jsonObject.put("ddDataTaskId", tempPrivateData.getDdDataTaskId());
//                jsonObject.put("ddDataTaskName", tempPrivateData.getDdDataTaskName());
//                jsonObject.put("ddDataType", tempPrivateData.getDdDataType());
//
//                jsonMembers.add(jsonObject);
//            }
//            json.put("total", publishDataListTotal.size());
            json.put("rows", jsonMembers);

            String jsonstring = formatJson(json.toString());
            PrintWriter out = null;
            out = response.getWriter();
            out.append(jsonstring);
            out.flush();
            out.close();
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * 显示可订阅数据列表
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("canbeorderprivatedata")
    @Action(description = "可订阅数据列表")
    public void canbeorderprivatedata(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            response.setContentType("application/json");
            JSONObject jsonObject = new JSONObject();
            JSONObject json = new JSONObject();
            JSONArray jsonMembers = new JSONArray();
            long taskId = RequestUtil.getLong(request, "id");

            TaskInfo taskInfo = taskInfoService.getById(taskId);
            //获取项目id
            Long ProjectId = taskInfo.getDdTaskProjectId();
            //根据项目id获取任务list
            List<TaskInfo> task_list = this.taskInfoService.queryTaskInfoByProjectId(ProjectId);
            //保证任务列表不包括任务本身
            Iterator<TaskInfo> it = task_list.iterator();

            while (it.hasNext()) {
                TaskInfo taskTempList = it.next();
                if (taskTempList.getDdTaskId() == taskId) {
                    it.remove();
                }
            }

            List<PrivateData> OrderPrivatedataList = new ArrayList<PrivateData>();
            List<OrderDataRelation> orderDataRelationList = orderDataRelationService.getOrderDataRelationList(taskId);

            //循环获取已订阅数据ID，查找私有数据
            for (int i = 0; i < orderDataRelationList.size(); i++) {
                OrderDataRelation orderDataRelation = orderDataRelationList.get(i);
                PrivateData privateDataforOrderData = privateDataService.getById(orderDataRelation.getDdDataId());
                OrderPrivatedataList.add(privateDataforOrderData);
            }//获取已订阅数据结束

            List<PrivateData> canBeOrderPrivatedataList = new ArrayList<PrivateData>();
            PrivateData taskPrivateDatas = new PrivateData();
            //获取所有可订阅数据列表
            for (int i = 0; i < task_list.size(); i++) {
                Long ddtaskId = task_list.get(i).getDdTaskId();
                List<OrderDataRelation> publishDataRelation_list = this.orderDataRelationService.getPublishDataRelationList(ddtaskId);

                for (OrderDataRelation orderDataRelation : publishDataRelation_list) {
                    Long ddDataId = orderDataRelation.getDdDataId();
                    taskPrivateDatas = this.privateDataService.getDataById(ddDataId);
                    canBeOrderPrivatedataList.add(taskPrivateDatas);
                }
            }//获取可订阅数据列表结束

            PrivateData tempPrivateData = new PrivateData();
//            for (int i = 0; i < canBeOrderPrivatedataList.size(); i++) {
//                tempPrivateData = canBeOrderPrivatedataList.get(i);
//                jsonObject.put("ddDataLastestValue", tempPrivateData.getDdDataLastestValue());
//                jsonObject.put("ddDataCreatePerson", tempPrivateData.getDdDataCreatePerson());
//                jsonObject.put("ddDataCreateTime", tempPrivateData.getDdDataCreateTime());
//                jsonObject.put("ddDataDescription", tempPrivateData.getDdDataDescription());
//                jsonObject.put("ddDataId", tempPrivateData.getDdDataId());
//                jsonObject.put("ddDataIsDelivery", tempPrivateData.getDdDataIsDelivery());
//                jsonObject.put("ddDataName", tempPrivateData.getDdDataName());
//                jsonObject.put("ddDataPublishType", tempPrivateData.getDdDataPublishType());
//                jsonObject.put("ddDataSensitiveness", tempPrivateData.getDdDataSensitiveness());
//                jsonObject.put("ddDataSubmiteState", tempPrivateData.getDdDataSubmiteState());
//                jsonObject.put("ddDataTaskId", tempPrivateData.getDdDataTaskId());
//                jsonObject.put("ddDataTaskName", tempPrivateData.getDdDataTaskName());
//                jsonObject.put("ddDataType", tempPrivateData.getDdDataType());
//
//                for (int j = 0; j < OrderPrivatedataList.size(); j++) {
//                    Long ddDataId1 = OrderPrivatedataList.get(j).getDdDataId();
//                    if (ddDataId1.equals(tempPrivateData.getDdDataId())) {
//                        jsonObject.put("ddOrderType", 1);
//                        break;
//                    } else {
//                        jsonObject.put("ddOrderType", 0);
//                    }
//                }
//                jsonMembers.add(jsonObject);
//            }
            json.put("total", canBeOrderPrivatedataList.size());
            json.put("rows", jsonMembers);

            String jsonstring = formatJson(json.toString());
            PrintWriter out = null;
            out = response.getWriter();
            out.append(jsonstring);
            out.flush();
            out.close();
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * 显示已订阅数据列表
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("orderprivatedata")
    @Action(description = "已订阅数据列表")
    public void orderprivatedata(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            response.setContentType("application/json");
            JSONObject jsonObject = new JSONObject();
            JSONObject json = new JSONObject();
            JSONArray jsonMembers = new JSONArray();
            long taskId = RequestUtil.getLong(request, "id");
            List<PrivateData> OrderPrivatedataList = new ArrayList<PrivateData>();
            List<OrderDataRelation> orderDataRelationList = orderDataRelationService.getOrderDataRelationList(taskId);
            //循环获取已订阅数据ID，查找私有数据
            for (int i = 0; i < orderDataRelationList.size(); i++) {
                OrderDataRelation orderDataRelation = orderDataRelationList.get(i);
                PrivateData privateDataforOrderData = privateDataService.getById(orderDataRelation.getDdDataId());
                OrderPrivatedataList.add(privateDataforOrderData);
            }//获取已订阅数据结束
            PrivateData tempPrivateData = new PrivateData();
//            for (int i = 0; i < OrderPrivatedataList.size(); i++) {
//                tempPrivateData = OrderPrivatedataList.get(i);
//                jsonObject.put("ddDataLastestValue", tempPrivateData.getDdDataLastestValue());
//                jsonObject.put("ddDataCreatePerson", tempPrivateData.getDdDataCreatePerson());
//                jsonObject.put("ddDataCreateTime", tempPrivateData.getDdDataCreateTime());
//                jsonObject.put("ddDataDescription", tempPrivateData.getDdDataDescription());
//                jsonObject.put("ddDataId", tempPrivateData.getDdDataId());
//                jsonObject.put("ddDataIsDelivery", tempPrivateData.getDdDataIsDelivery());
//                jsonObject.put("ddDataName", tempPrivateData.getDdDataName());
//                jsonObject.put("ddDataPublishType", tempPrivateData.getDdDataPublishType());
//                jsonObject.put("ddDataSensitiveness", tempPrivateData.getDdDataSensitiveness());
//                jsonObject.put("ddDataSubmiteState", tempPrivateData.getDdDataSubmiteState());
//                jsonObject.put("ddDataTaskId", tempPrivateData.getDdDataTaskId());
//                jsonObject.put("ddDataTaskName", tempPrivateData.getDdDataTaskName());
//                jsonObject.put("ddDataType", tempPrivateData.getDdDataType());
//                jsonObject.put("ddOrderType", 1);
//
//                jsonMembers.add(jsonObject);
//            }
            json.put("total", OrderPrivatedataList.size());
            json.put("rows", jsonMembers);

            String jsonstring = formatJson(json.toString());
            PrintWriter out = null;
            out = response.getWriter();
            out.append(jsonstring);
            out.flush();
            out.close();
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }


    @RequestMapping("submitpublishjson")
    @Action(description = "向前端传送发布的json")
    public void getSubmitPublishJson(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        Long pageSize = RequestUtil.getLong(request, "pageSize");
        Long pageNumber = RequestUtil.getLong(request, "pageNumber");

        PageInfo pageinfo = new PageInfo();

        pageinfo.setPageSize((pageNumber - 1) * pageSize);
        pageinfo.setPageNumber(pageSize);

        response.setContentType("application/json");

        try {
            Long taskId = RequestUtil.getLong(request, "id");
            pageinfo.setId(taskId);
            int allnum = this.orderDataRelationService.getPublishDataRelationList(taskId).size();
            List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.queryPublishDataRelationByddTaskIDF(pageinfo);
            List<PrivateData> privateData_list = new ArrayList<PrivateData>();
            JSONObject jsonObject = new JSONObject();
            for (int i = 0; i < orderDataRelation_list.size(); i++) {
                OrderDataRelation orderDataRelation = orderDataRelation_list.get(i);
                PrivateData privateData = privateDataService.getById(orderDataRelation.getDdDataId());
//            privateData_list.add(privateData);
                jsonObject.put("ddDataId", privateData.getDdDataId());
                jsonObject.put("ddDataTaskId", privateData.getDdDataTaskId());
                jsonObject.put("ddDataType", privateData.getDdDataType());
                jsonObject.put("ddDataTaskName", privateData.getDdDataTaskName());
                jsonObject.put("ddDataName", privateData.getDdDataName());
                jsonObject.put("ddDataLastestValue", privateData.getDdDataLastestValue());
                jsonMembers.add(jsonObject);
            }
            json.put("total", allnum);
            json.put("rows", jsonMembers);
//        String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
            String jsonstring = formatJson(json.toString());
            PrintWriter out = null;
            out = response.getWriter();
            out.append(jsonstring);
            out.flush();
            out.close();
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    @RequestMapping("showorderjson")
    @Action(description = "向前端传送发布的json")
    public void showorderjson(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        Long pageSize = RequestUtil.getLong(request, "pageSize");
        Long pageNumber = RequestUtil.getLong(request, "pageNumber");

        PageInfo pageinfo = new PageInfo();

        pageinfo.setPageSize((pageNumber - 1) * pageSize);
        pageinfo.setPageNumber(pageSize);

        response.setContentType("application/json");


        try {
            Long taskId = RequestUtil.getLong(request, "id");
            pageinfo.setId(taskId);
            int allnum = this.orderDataRelationService.getOrderDataRelationList(taskId).size();
            List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.queryOrderDataRelationByddTaskIDF(pageinfo);
            List<PrivateData> privateData_list = new ArrayList<PrivateData>();
            JSONObject jsonObject = new JSONObject();
            for (int i = 0; i < orderDataRelation_list.size(); i++) {
                OrderDataRelation orderDataRelation = orderDataRelation_list.get(i);
                PrivateData privateData = privateDataService.getById(orderDataRelation.getDdDataId());
//            privateData_list.add(privateData);
                jsonObject.put("ddDataId", privateData.getDdDataId());
                jsonObject.put("ddDataTaskId", privateData.getDdDataTaskId());
                jsonObject.put("ddDataType", privateData.getDdDataType());
                jsonObject.put("ddDataTaskName", privateData.getDdDataTaskName());
                jsonObject.put("ddDataName", privateData.getDdDataName());
                jsonObject.put("ddDataLastestValue", privateData.getDdDataLastestValue());
                jsonMembers.add(jsonObject);
            }
            json.put("total", allnum);
            json.put("rows", jsonMembers);
//        String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
            String jsonstring = formatJson(json.toString());
            PrintWriter out = null;
            out = response.getWriter();
            out.append(jsonstring);
            out.flush();
            out.close();
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    //格式化json
    //TODO:需要修改注意在哪些地方用到
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

    //添加空格
    private static void addIndentBlank(StringBuilder sb, int indent) {
        for (int i = 0; i < indent; i++) {
            sb.append('\t');
        }
    }


    @RequestMapping("refreshlastvalue")
    @Action(description = "更新最新值")
    public void refreshlastvalue(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            String json = request.getParameter("strJson");
            JSONObject obj = JSONObject.fromObject(json);

            Map<String, Class> map = new HashMap<String, Class>();
            map.put("privateData", PrivateData.class);
            PrivateData privateData = (PrivateData) JSONObject.toBean(obj, PrivateData.class, map);
//            privateDataService.updatedata(privateData);
            //添加数据版本记录
            DataVersion dataVersion = new DataVersion();
            dataVersion.setDdDataVersionId(UniqueIdUtil.genId());
            dataVersion.setDdDataId(privateData.getDdDataId());
            dataVersion.setDdDataRecordPersonId(ContextUtil.getCurrentUser().getUserId());
            java.util.Date currentTime = new java.util.Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dateString = formatter.format(currentTime);
            dataVersion.setDdDataRecordTime(dateString);
            dataVersion.setDdDataValue(privateData.getDdDataLastestValue());
            dataVersionService.addDDDataVersion(dataVersion);
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }


    @RequestMapping("submittask")
    @Action(description = "提交任务")
    public ModelAndView submittask(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddTaskId = RequestUtil.getLong(request, "id");

        List<OrderDataRelation> publishRelationList = orderDataRelationService.getPublishDataRelationList(ddTaskId);
//        List<DataStruct> publishListWithoutValue = new ArrayList<DataStruct>();
        List<PrivateData> childListWithoutValue = new ArrayList<PrivateData>();

        try {
//            List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.getPublishDataRelationList(ddTaskId);
            List<TaskStart> taskStart_list = taskStartService.queryTaskStartByTaskId(ddTaskId);

            TaskInfo taskInfo = taskInfoService.getById(ddTaskId);
            if (taskInfo.getDdTaskState() == null || taskInfo.getDdTaskChildType() == null) {
                taskInfo.setDdTaskState(taskInfo.createpanel);
                taskInfo.setDdTaskChildType("createpanel");
            }
            //判断任务的当前状态，只有在正在执行中才允许提交

            if (taskStart_list.get(0).getDdTaskStatus().equals(taskStart_list.get(0).publishpanel) &&
                    taskInfo.getDdTaskChildType().equals("publishpanel")) {

//                for (int i = 0; i < publishRelationList.size(); i++) {
//                    DataStruct dataStruct = dataStructService.getById(publishRelationList.get(i).getDdDataId());
//                    List<PrivateData> childList = privateDataService.selectByStructid(dataStruct.getDdStructId());
//                    int childLength = childList.size();
//                    for (int j=0;j<childList.size();j++){
//                          if(childList.get(j).getDdDataLastestValue()==null){
//                              childLength--;
//                          }
//                        if(childLength<childList.size()){
//                            publishListWithoutValue.add(dataStruct);
//                        }
//                    }
//                }
                if (taskStart_list.get(0).getDdTaskStatus().equals(taskStart_list.get(0).publishpanel) &&
                        taskInfo.getDdTaskChildType().equals("publishpanel")) {

//                    for (int i = 0; i < publishRelationList.size(); i++) {
//                        DataStruct dataStruct = dataStructService.getById(publishRelationList.get(i).getDdDataId());
////                        List<PrivateData> childList = privateDataService.selectByStructid(dataStruct.getDdStructId());
//                        int childLength = childList.size();
//                        for (int j = 0; j < childList.size(); j++) {
//                            if (childList.get(j).getDdDataLastestValue() == null) {
//                                PrivateData childData = childList.get(j);
//                                //暂时用datapath存放结构体名
//                                childData.setDdDataPath(dataStruct.getDdStructName());
//                                childListWithoutValue.add(childData);
//                            }
//                        }
//                    }

                    if (childListWithoutValue.size() == 0) {
                        taskStart_list.get(0).setDdTaskStatus(TaskStart.checkpanel);
                        taskStartService.update(taskStart_list.get(0));
                        taskInfo.setDdTaskChildType("checkpanel");
                        taskInfo.setDdTaskState(taskInfo.checkpanel);
                        taskInfoService.update(taskInfo);
                    }
                }
            } else {
                String resultMsg = null;
                writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Fail);
            }
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
        return getAutoView().addObject("childListWithoutValue", childListWithoutValue)
                .addObject("valueLength", childListWithoutValue.size()).addObject("ddTaskId", ddTaskId);
    }


    @RequestMapping("recovertask")
    @Action(description = "收回任务")
    public void recovertask(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String preUrl = RequestUtil.getPrePage(request);
        try {
            Long ddTaskId = RequestUtil.getLong(request, "id");

            List<TaskStart> taskStart_list = taskStartService.queryTaskStartByTaskId(ddTaskId);
            TaskInfo taskInfo = taskInfoService.getById(ddTaskId);
            if (taskInfo.getDdTaskState() == null || taskInfo.getDdTaskChildType() == null) {
                taskInfo.setDdTaskState(taskInfo.createpanel);
                taskInfo.setDdTaskChildType("createpanel");
            }
            //判断任务的当前状态，只有已提交的任务才允许收回
            if (taskStart_list.get(0).getDdTaskStatus().equals(taskStart_list.get(0).checkpanel) && taskInfo.getDdTaskChildType().equals("checkpanel")) {
                taskStart_list.get(0).setDdTaskStatus(TaskStart.publishpanel);
                taskStartService.update(taskStart_list.get(0));

                taskInfo.setDdTaskChildType("publishpanel");
                taskInfo.setDdTaskState(taskInfo.publishpanel);
                taskInfoService.update(taskInfo);
            } else {
                String resultMsg = null;
                writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Fail);
            }
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
        response.sendRedirect(preUrl);
    }


    @RequestMapping("showfiveversion")
    @Action(description = "显示五条最新的数据版本")
    public void showfiveversion(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        response.setContentType("application/json");

        try {
            String dataId = request.getParameter("ddDataId");
//            JSONObject jsonObject = new JSONObject();
//           Long dataId = RequestUtil.getLong(request, "ddDataId");
//
//            List<DataVersion> dateVersion_list = this.dataVersionService.queryDataVersionListByddDataId(dataId);
//            JSONObject jsonObject = new JSONObject();
//            for (int i = 0; i < dateVersion_list.size(); i++) {
//                DataVersion dataVersion = dateVersion_list.get(i);
//                jsonObject.put("ddDataVersionId", dataVersion.getDdDataVersionID());
//                jsonObject.put("ddDataId", dataVersion.getDdDataId());
//                jsonObject.put("ddDataRecordTime", dataVersion.getDdDataRecordTime());
//                jsonObject.put("ddDataRecordPersonId", dataVersion.getDdDataRecordPersonId());
//                jsonObject.put("ddDataValue", dataVersion.getDdDataValue());
//                jsonMembers.add(jsonObject);
//            }
//            json.put("total", dateVersion_list.size());
//            json.put("rows", jsonMembers);
////        String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
//            String jsonstring = formatJson(json.toString());
//            PrintWriter out = null;
//            out = response.getWriter();
//            out.append(jsonstring);
//            out.flush();
//            out.close();
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }

    }

    /**
     * 可订阅拖拽到订阅实现
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("canordertoorder")
    @Action(description = "可订阅拖拽到订阅")
    public void canordertoorder(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long dataId = RequestUtil.getLong(request, "id");
        Long taskId = RequestUtil.getLong(request, "taskId");
        String parent = RequestUtil.getString(request, "parent");
        try {
            //已订阅到可订阅
            if (parent.equals("canorderpanel")) {
                QueryParameters queryparameters = new QueryParameters();
                queryparameters.setId(taskId);
                queryparameters.setType(dataId);
                orderDataRelationService.delDDOrderDataRelation(queryparameters);
            }
            //可订阅到已订阅
            if (parent.equals("orderpanel")) {
                DataStruct dataStruct = dataStructService.getStructById(dataId);
                OrderDataRelation orderdatarelation = new OrderDataRelation();

                orderdatarelation.setDdTaskId(taskId);
                orderdatarelation.setDdDataId(dataStruct.getDdStructId());
                orderdatarelation.setDdOrderDataId(UniqueIdUtil.genId());
                orderdatarelation.setDdDataName(dataStruct.getDdStructName());
                orderdatarelation.setDdOrderType(1l);
                orderdatarelation.setDdProjectId(dataStruct.getDdProjectId());

                orderDataRelationService.add(orderdatarelation);
            }
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * 私有和发布数据之间的拖拽
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("createtopublish")
    @Action(description = "私有和发布数据之间的拖拽")
    public void createtopublish(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = "状态变更";
        Long dataId = RequestUtil.getLong(request, "id");
        DataStruct dataStruct1 = dataStructService.getStructById(dataId);
        Long taskId = dataStruct1.getDdTaskId();
        String parent = RequestUtil.getString(request, "parent");
        PrivateData privateData = new PrivateData();
        OrderDataRelation orderDataRelation = new OrderDataRelation();
        try {
            //发布到私有
            if (parent.equals("createpanel")) {
                DataStruct dataStruct = dataStructService.getStructById(dataId);
                if (orderDataRelationService.getBeOrderDataByDataId(dataId).size() == 0) {
                    dataStruct.setDdPublishState((short) 0);
                    dataStructService.update(dataStruct);
                    QueryParameters queryparameters = new QueryParameters();
                    queryparameters.setId(taskId);
                    queryparameters.setType(dataId);
                    orderDataRelationService.delDDPublishDataRelation(queryparameters);
//                    List<OrderDataRelation> taskOrderRelationList =
//                    for()
                } else {
                    return;
                }
            }
            //私有到发布
            if (parent.equals("publishpanel")) {
                DataStruct dataStruct = dataStructService.getById(dataId);
                dataStruct.setDdPublishState((short) 1);
                dataStructService.update(dataStruct);

                orderDataRelation.setDdOrderDataId(UniqueIdUtil.genId());
                orderDataRelation.setDdDataId(dataId);
                orderDataRelation.setDdTaskId(dataStruct.getDdTaskId());
                orderDataRelation.setDdDataName(dataStruct.getDdStructName());
                orderDataRelation.setDdOrderType(0L);
                orderDataRelation.setDdProjectId(dataStruct.getDdProjectId());
                orderDataRelationService.add(orderDataRelation);
            }
            writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }


}

