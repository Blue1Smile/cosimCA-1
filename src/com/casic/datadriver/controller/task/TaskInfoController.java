package com.casic.datadriver.controller.task;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.casic.datadriver.model.project.ProjectStart;
import com.casic.datadriver.model.task.TaskStart;
import com.casic.datadriver.service.project.ProjectStartService;
import com.casic.datadriver.service.task.TaskStartService;
import com.hotent.platform.auth.ISysUser;
import com.hotent.platform.model.system.SysUser;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.model.project.Project;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.model.data.OrderDataRelation;
import com.casic.datadriver.model.task.ProTaskDependance;
import com.casic.datadriver.service.task.ProTaskDependanceService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.casic.datadriver.service.data.PrivateDataService;
import com.casic.datadriver.service.data.OrderDataRelationService;
import com.casic.datadriver.service.project.ProjectService;
import com.casic.datadriver.model.data.PrivateData;
import com.hotent.core.bpm.model.ProcessTask;
import com.hotent.core.encrypt.EncryptUtil;
import com.hotent.core.util.BeanUtils;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.web.util.RequestUtil;

import com.hotent.platform.auth.ISysUser;
import com.hotent.platform.model.system.SysUser;
import com.hotent.platform.service.system.SysUserService;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import org.apache.bcel.generic.NEW;
import org.apache.commons.collections.ListUtils;
import org.freehep.graphicsio.swf.LineStyleArray;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.casic.datadriver.controller.data.PrivateDataController;
import com.casic.datadriver.controller.AbstractController;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.query.QueryFilter;

import java.util.*;

import java.net.URLDecoder;
import java.util.Iterator;

import org.jdom.output.XMLOutputter;
import org.jdom.output.Format;

import org.jdom.Element;
import org.jdom.Document;
import org.jdom.input.SAXBuilder;

import java.io.*;

@Controller
@RequestMapping("/datadriver/task/")
public class TaskInfoController extends AbstractController {

    /**
     * The task service.
     */
    @Resource
    private TaskInfoService taskInfoService;
    @Resource
    private ProTaskDependanceService proTaskDependanceService;
    @Resource
    private PrivateDataService privateDataService;
    @Resource
    private OrderDataRelationService orderDataRelationService;
    @Resource
    private SysUserService sysUserService;
    @Resource
    private ProjectService projectService;
    @Resource
    private TaskStartService taskStartService;
    @Resource
    private ProjectStartService projecStartService;


    /**
     * @param request  the request
     * @param response the response
     * @throws Exception the exception
     */
    @RequestMapping("save")
    @Action(description = "task")
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;

        TaskInfo taskInfo = getFormObject(request);
        ProTaskDependance proTaskDependance = new ProTaskDependance();
        proTaskDependance.setDdProjectId(taskInfo.getDdTaskProjectId());
        try {
            if (taskInfo.getDdTaskId() == null || taskInfo.getDdTaskId() == 0) {
                taskInfo.setDdTaskId(UniqueIdUtil.genId());
                taskInfo.setDdTaskChildType("createpanel");
                taskInfoService.addDDTask(taskInfo);
                proTaskDependance.setDdTaskId(UniqueIdUtil.genId());
                proTaskDependance.setDdTaskId(taskInfo.getDdTaskId());
                proTaskDependanceService.addDDProTaskDependance(proTaskDependance);
                resultMsg = getText("record.added", "添加完成");
            } else {
                taskInfoService.updateDDTask(taskInfo);
                resultMsg = getText("record.updated", "更新完成");
            }
            writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    private TaskInfo getFormObject(HttpServletRequest request) throws Exception {
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[]{"yyyy-MM-dd"})));

        String json = RequestUtil.getString(request, "json");
        JSONObject obj = JSONObject.fromObject(json);

        Map<String, Class> map = new HashMap<String, Class>();
        map.put("privateDataList", PrivateData.class);
        TaskInfo taskinfo = (TaskInfo) JSONObject.toBean(obj, TaskInfo.class, map);

        return taskinfo;
    }


    /**
     * Query task basic info list.
     * 根据项目id查询项目任务或者查询所有项目
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("list")
    @Action(description = "任务列表")
    public ModelAndView queryTaskBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long id = RequestUtil.getLong(request, "id");
        List<TaskInfo> taskInfoList = new ArrayList<TaskInfo>();
        if (id == 0 || id == null) {
            taskInfoList = taskInfoService.getAll();
        } else {
            taskInfoList = taskInfoService.queryTaskInfoByProjectId(id);
        }
        //根据责任人id得到当前用户的所有项目
        List<Project> projectList = projectService.queryProjectlistByRes(ContextUtil.getCurrentUserId());
        //找到当前用户的所有负责的已经启动的项目
        List<Project> project_list = new ArrayList<Project>();
        for (int i = 0; i < projectList.size(); i++) {
            if (projectList.get(i).getDdProjectState() == null) {
                project_list.get(i).setDdProjectState(project_list.get(i).STATUS_UNSTART);
            }
            if (projectList.get(i).getDdProjectState() == 1) {
                project_list.add(projectList.get(i));
            }
        }

        //找到当前用户的所有可以审核的任务
        List<TaskInfo> checkTaskInfoList = new ArrayList<TaskInfo>();
        for (int i = 0; i < project_list.size(); i++) {
            List<TaskInfo> taskInfo_list = taskInfoService.queryTaskInfoByProjectId(project_list.get(i).getDdProjectId());
            for (int j = 0; j < taskInfo_list.size(); j++) {
                TaskInfo task = taskInfo_list.get(j);
                if (task.getDdTaskState() == null) {
                    task.setDdTaskState(task.STATUS_UNSTART);
                }
                if (task.getDdTaskState() == 0) {
                    checkTaskInfoList.add(task);
                }
            }
        }
        ModelAndView mv = this.getAutoView().addObject("taskList", taskInfoList)
                .addObject("projectId", id).addObject("taskCheckList", checkTaskInfoList);
        return mv;
    }


    /**
     * 添加任务
     *
     * @param request  the request
     * @param response the response
     * @return the add
     * @throws Exception the exception
     */
    @RequestMapping("addtask")
    @Action(description = "添加任务")
    public ModelAndView addtask(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        ResultMessage resultMessage = null;
        ModelAndView mv = new ModelAndView();
        try {
            List<ISysUser> sysUserList = sysUserService.getAll();
            Long id = RequestUtil.getLong(request, "id");
            Project project = projectService.getById(id);
            mv = this.getAutoView().addObject("projectItem", project).addObject("sysUserList", sysUserList);
            resultMessage = new ResultMessage(ResultMessage.Success, "创建成功");
        } catch (Exception ex) {
            resultMessage = new ResultMessage(ResultMessage.Fail, "创建失败" + ex.getMessage());
        }
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

        String preUrl = RequestUtil.getPrePage(request);
        ResultMessage message = null;
        try {
            Long[] TaskId = RequestUtil.getLongAryByStr(request, "id");
            taskInfoService.delAll(TaskId);
            message = new ResultMessage(ResultMessage.Success, "删除成功");

        } catch (Exception ex) {
            message = new ResultMessage(ResultMessage.Fail, "删除失败" + ex.getMessage());
        }
        addMessage(message, request);
        response.sendRedirect(preUrl);
    }

    /**
     * 编辑任务
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("edit")
    @Action(description = "任务编辑")
    public ModelAndView edit(HttpServletRequest request) throws Exception {

        String time = "2017年12月10日";
        ISysUser executorName;
        Long id = RequestUtil.getLong(request, "id");
        String returnUrl = RequestUtil.getPrePage(request);
        TaskInfo taskInfo = taskInfoService.getById(id);
        if (taskInfo.getDdTaskResponsiblePerson() != null) {
            executorName = sysUserService.getById(taskInfo.getDdTaskResponsiblePerson());
        } else {
            executorName = ContextUtil.getCurrentUser();
        }

        List<PrivateData> privateDataList = taskInfoService.getPrivateDataList(id);

        List<ISysUser> sysUserList = sysUserService.getAll();
//        Date date=new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        if (taskInfo.getDdTaskPlanEndTime() != null) {
            time = df.format(taskInfo.getDdTaskPlanEndTime());
        } else {
            Date date = new Date();
            time = df.format(date);
        }

        return getAutoView().addObject("TaskInfo", taskInfo)
                .addObject("endtime", time)
                .addObject("privateDataList", privateDataList)
                .addObject("returnUrl", returnUrl)
                .addObject("sysUserList", sysUserList)
                .addObject("executorName", executorName);
    }

    /**
     * @param bin the bin
     */
    @InitBinder
    public void initBinder(ServletRequestDataBinder bin) {
        bin.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
    }

    @RequestMapping("get")
    @Action(description = "获取")
    public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long id = RequestUtil.getLong(request, "id");
        TaskInfo taskInfo = taskInfoService.getById(id);
        return getAutoView().addObject("TaskInfo", taskInfo);
    }


    @RequestMapping("publishconfig")
    @Action(description = "发布任务数据")
    public ModelAndView queryPrivateDataBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long id = RequestUtil.getLong(request, "id");
        String returnUrl = RequestUtil.getPrePage(request);
        List<PrivateData> privateDataList = new ArrayList<PrivateData>();
        List<OrderDataRelation> publishDataRelationList = orderDataRelationService.queryPublishDataRelationByddTaskID(id);

        //循环获取发布数据ID，查找私有数据
        for (int i = 0; i < publishDataRelationList.size(); i++) {
            OrderDataRelation orderDataRelation = publishDataRelationList.get(i);
            PrivateData privateData = privateDataService.getById(orderDataRelation.getDdDataId());
            privateDataList.add(privateData);
        }
        ModelAndView mv = this.getAutoView().addObject("privateDataList",
                this.privateDataService.queryPrivateDataByddTaskID(id))
                .addObject("publishDataRelationList", privateDataList);
        return mv;
    }


    @RequestMapping("orderconfig")
    @Action(description = "订阅任务数据")
    public ModelAndView queryAllPrivateDataBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<PrivateData> privateDataList = new ArrayList<PrivateData>();
        //根据id获取任务
        Long id = RequestUtil.getLong(request, "id");
        TaskInfo taskInfo = taskInfoService.getById(id);
        //获取项目id
        Long ProjectId = taskInfo.getDdTaskProjectId();
        //根据项目id获取任务list
        List<TaskInfo> task_list = this.taskInfoService.queryTaskInfoByProjectId(ProjectId);
        List<PrivateData> privateData = new ArrayList<PrivateData>();
        //获取所有发布数据的私有数据列表
//        for (TaskInfo taskInfolist : task_list) {
        for (int i = 0; i < task_list.size(); i++) {
            Long ddtaskId = task_list.get(i).getDdTaskId();
//            Long ddtaskId = taskInfo.getDdTaskId();
            List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.queryPublishDataRelationByddTaskID(ddtaskId);
            for (OrderDataRelation orderDataRelation : orderDataRelation_list) {

                Long ddDataId = orderDataRelation.getDdDataId();
                List<PrivateData> taskPrivateDatas = this.privateDataService.getByddDataId(ddDataId);
                privateData.addAll(taskPrivateDatas);
            }
        }
        List<OrderDataRelation> orderDataRelationList = orderDataRelationService.queryOrderDataRelationByddTaskID(id);
        //循环获取订阅数据ID，查找私有数据
        for (int i = 0; i < orderDataRelationList.size(); i++) {
            OrderDataRelation orderDataRelation = orderDataRelationList.get(i);
            PrivateData privateDataforOrderData = privateDataService.getById(orderDataRelation.getDdDataId());
            privateDataList.add(privateDataforOrderData);
        }

        ModelAndView mv = this.getAutoView().addObject("privateDataList", privateData)
                .addObject("nowTaskId", String.valueOf(id))
                .addObject("orderDataRelationList", privateDataList);
        return mv;
    }


    @RequestMapping("savepublish")
    @Action(description = "保存发布")
    public void savepublish(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long[] ddDataIds = RequestUtil.getLongAry(request, "ddDataId");
        Long[] ddDataTaskIds = RequestUtil.getLongAry(request, "ddDataTaskId");
        //  System.out.print(ddDataIds.length);
        for (int i = 0; i < ddDataTaskIds.length; i++) {
            this.orderDataRelationService.delPublishByddDataTaskId(ddDataTaskIds[i]);
        }
        for (int i = 0; i < ddDataIds.length; i++) {
            OrderDataRelation orderDataRelation = new OrderDataRelation();
            orderDataRelation.setDdOrderDataId(UniqueIdUtil.genId());
            Long DataId = Long.valueOf(Long.valueOf(ddDataIds[i]));
            orderDataRelation.setDdOrderType(0L);
            orderDataRelation.setDdDataId(DataId);
            orderDataRelation.setDdTaskId(ddDataTaskIds[i]);
            TaskInfo taskInfo = taskInfoService.getById(ddDataTaskIds[i]);
            orderDataRelation.setDdDataName(taskInfo.getDdTaskName());
            this.orderDataRelationService.addDDOrderDataRelation(orderDataRelation);
        }
    }


    @RequestMapping("saveorder")
    @Action(description = "保存订阅")
    public void saveorder(HttpServletRequest request, HttpServletResponse response) throws Exception {

        Long nowTaskId = RequestUtil.getLong(request, "id");

        Long[] ddDataIds = RequestUtil.getLongAry(request, "ddDataId");
        Long[] ddDataTaskIds = RequestUtil.getLongAry(request, "ddDataTaskId");
        //  System.out.print(ddDataIds.length);

        for (int i = 0; i < ddDataTaskIds.length; i++) {
            this.orderDataRelationService.delOrderByddDataTaskId(ddDataTaskIds[i]);

        }

        for (int i = 0; i < ddDataIds.length; i++) {
            OrderDataRelation orderDataRelation = new OrderDataRelation();
            orderDataRelation.setDdOrderDataId(UniqueIdUtil.genId());
            Long DataId = Long.valueOf(ddDataIds[i]);
            orderDataRelation.setDdOrderType(1L);
            orderDataRelation.setDdDataId(DataId);
            orderDataRelation.setDdTaskId(nowTaskId);
            this.orderDataRelationService.addDDOrderDataRelation(orderDataRelation);
        }

    }


//    @RequestMapping("savealldata")
//    @Action(description = "保存订阅和发布关系")
//    public void savealldata(HttpServletRequest request, HttpServletResponse response) throws Exception {
//
//        Long nowTaskId = RequestUtil.getLong(request, "id");
//
//        List<PrivateData> privateDataListbyTaskItem = new ArrayList<PrivateData>();
//        privateDataListbyTaskItem = request.getParameter("privateDataListbyTaskItem");
////        Long[] ddDataIds = RequestUtil.getLongAry(request, "ddDataId");
////        Long[] ddDataTaskIds = RequestUtil.getLongAry(request, "ddDataTaskId");
////        //  System.out.print(ddDataIds.length);
////
////        for (int i = 0; i < ddDataTaskIds.length; i++) {
////            this.orderDataRelationService.delOrderByddDataTaskId(ddDataTaskIds[i]);
////
////        }
//
////        for (int i = 0; i < ddDataIds.length; i++) {
////            OrderDataRelation orderDataRelation = new OrderDataRelation();
////            orderDataRelation.setDdOrderDataId(UniqueIdUtil.genId());
////            Long DataId = Long.valueOf(ddDataIds[i]);
////            orderDataRelation.setDdOrderType(1L);
////            orderDataRelation.setDdDataId(DataId);
////            orderDataRelation.setDdTaskId(nowTaskId);
////            this.orderDataRelationService.addDDOrderDataRelation(orderDataRelation);
////        }
//
//
//    }


    /**
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("userlist")
    @Action(description = "用户列表")
    public ModelAndView userlist(HttpServletRequest request, HttpServletResponse response) throws Exception {
        TaskInfo taskInfo = getFormObject(request);
        Long TaskId = RequestUtil.getLong(request, "TaskId");
        Long projectId = RequestUtil.getLong(request, "projectId");
        QueryFilter queryFilter = new QueryFilter(request, "sysUserItem");
        ModelAndView mv = this.getAutoView().addObject("sysUserList",
                this.sysUserService.getUserByQuery(queryFilter)).addObject("TaskId", TaskId)
                .addObject("projectId", projectId).addObject("TaskInfo", taskInfo);
        return mv;
    }

    /**
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("chooseuser")
    @Action(description = "用户选择")
    public ModelAndView saveUser(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String msg = request.getParameter("fullname");
        String fullname = new String(msg.getBytes("ISO-8859-1"), "UTF-8");

//        Long TaskId = RequestUtil.getLong(request, "TaskId");
        Long projectId = RequestUtil.getLong(request, "projectId");
        Long userId = RequestUtil.getLong(request, "UserId");

        ModelAndView mv = new ModelAndView("redirect:addtask.ht");
        mv.addObject("userId", userId).addObject("taskPerson", fullname).addObject("id", projectId);

        return mv;
    }


    /**
     * 2016/1/7/
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("taskcheck")
    @Action(description = "私有任务列表")
    public ModelAndView taskcheck(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        //根据责任人id得到当前用户的所有项目
        List<Project> projectList = projectService.queryProjectlistByRes(ContextUtil.getCurrentUserId());
        //找到当前用户的所有负责的已经启动的项目
        List<Project> project_list = new ArrayList<Project>();
        for (int i = 0; i < projectList.size(); i++) {
            List<ProjectStart> projectStartList = projecStartService.queryByProjectId(projectList.get(i).getDdProjectId());
            if (projectStartList.get(0).getDdProjectStartStatus() == 1) {
                Project project = projectService.getById(projectStartList.get(0).getDdProjectId());
                project_list.add(project);
            }
        }
        //找到当前用户的所有可以审核的任务
        List<TaskInfo> taskInfoList = new ArrayList<TaskInfo>();
        for (int i = 0; i < project_list.size(); i++) {
            List<TaskInfo> taskInfo_list = taskInfoService.queryTaskInfoByProjectId(project_list.get(i).getDdProjectId());
            for (int j = 0; j < taskInfo_list.size(); j++) {
                TaskStart taskStart = taskStartService.queryTaskStartByTaskId(taskInfo_list.get(j).getDdTaskId()).get(0);
                if (taskStart.getDdTaskStatus() == 0) {
                    taskInfoList.add(taskInfoService.getById(taskStart.getDdTaskId()));
                }
            }
        }
        ModelAndView mv = this.getAutoView().addObject("taskCheckList", taskInfoList);
        return mv;
    }


    /**
     * 2016/1/8/修改
     * 返回任务发布订购数据列表
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("check")
    @Action(description = "返回任务发布订购数据列表")
    public ModelAndView check(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddTaskId = RequestUtil.getLong(request, "id");
        //获得发布数据列表
        List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.queryPublishDataRelationByddTaskID(ddTaskId);
        List<PrivateData> privateData = new ArrayList<PrivateData>();
        for (OrderDataRelation orderDataRelation : orderDataRelation_list) {
            Long ddDataId = orderDataRelation.getDdDataId();
            List<PrivateData> taskPrivateDatas = this.privateDataService.getByddDataId(ddDataId);
            privateData.addAll(taskPrivateDatas);
        }
        ModelAndView mv = this.getAutoView().addObject("privateDataList",
                privateData);
        return mv;
    }

    /**
     * 2016/1/8/
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("rejecttask")
    @Action(description = "驳回任务")
    public void rejecttask(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            Long ddTaskId = RequestUtil.getLong(request, "id");
            List<TaskStart> taskStart_list = taskStartService.queryTaskStartByTaskId(ddTaskId);
            //判断任务的当前状态，只有在正在提交中才允许驳回
            if (taskStart_list.get(0).getDdTaskStatus() == 0) {
                taskStart_list.get(0).setDdTaskStatus(TaskStart.STATUS_RUNNING);
                taskStartService.update(taskStart_list.get(0));
            } else {
                String resultMsg = null;
                writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Fail);
            }
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }


    /**
     * 进入任务控制台
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */


    @RequestMapping("stepinto")
    @Action(description = "进入项目")
    public ModelAndView stepinto(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long taskId = RequestUtil.getLong(request, "id");
        TaskInfo taskInfo = taskInfoService.getById(taskId);
        List<PrivateData> privateDataListbyTask = new ArrayList<PrivateData>();
        //任务已发布私有数据
        List<PrivateData> publishDataList = new ArrayList<PrivateData>();
        privateDataListbyTask = this.privateDataService.queryPrivateDataByddTaskID(taskId);
        List<OrderDataRelation> publishDataRelationList = orderDataRelationService.queryPublishDataRelationByddTaskID(taskId);

        //循环获取发布数据ID，查找任务的所有私有数据

        for (int i = 0; i < publishDataRelationList.size(); i++) {
            OrderDataRelation orderDataRelation = publishDataRelationList.get(i);
            PrivateData privateData = privateDataService.getById(orderDataRelation.getDdDataId());
            publishDataList.add(privateData);
        }

//        privateDataListbyTask.removeAll(publishDataList);
//        privateDataListbyTask = ListUtils.subtract(privateDataListbyTask, publishDataList);

        if (privateDataListbyTask.size() > 0 && publishDataList.size() > 0) {
            Integer Length1 = privateDataListbyTask.size();
            for (int i = 0; i < publishDataList.size(); i++) {
                for (int j = 0; j < Length1; j++) {
                    Long ddDataId1 = publishDataList.get(i).getDdDataId();
                    Long ddDataId2 = privateDataListbyTask.get(j).getDdDataId();
                    if (ddDataId1.equals(ddDataId2)) {
                        privateDataListbyTask.remove(j);
                        Length1 = privateDataListbyTask.size();
                        j--;
                    }
                }
            }
        }


        List<PrivateData> OrderPrivatedataList = new ArrayList<PrivateData>();
        //获取项目id
        Long ProjectId = taskInfo.getDdTaskProjectId();
        //根据项目id获取任务list
        List<TaskInfo> task_list = this.taskInfoService.queryTaskInfoByProjectId(ProjectId);
        List<PrivateData> canBeOrderPrivatedataList = new ArrayList<PrivateData>();
        //获取所有发布数据的私有数据列表
        for (int i = 0; i < task_list.size(); i++) {
            Long ddtaskId = task_list.get(i).getDdTaskId();
            List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.queryPublishDataRelationByddTaskID(ddtaskId);
            for (OrderDataRelation orderDataRelation : orderDataRelation_list) {

                Long ddDataId = orderDataRelation.getDdDataId();
                List<PrivateData> taskPrivateDatas = this.privateDataService.getByddDataId(ddDataId);
                canBeOrderPrivatedataList.addAll(taskPrivateDatas);
            }
        }
        List<OrderDataRelation> orderDataRelationList = orderDataRelationService.queryOrderDataRelationByddTaskID(taskId);
        //循环获取订阅数据ID，查找私有数据
        for (int i = 0; i < orderDataRelationList.size(); i++) {
            OrderDataRelation orderDataRelation = orderDataRelationList.get(i);
            PrivateData privateDataforOrderData = privateDataService.getById(orderDataRelation.getDdDataId());
            OrderPrivatedataList.add(privateDataforOrderData);
        }

        if (OrderPrivatedataList.size() > 0 && canBeOrderPrivatedataList.size() > 0) {
            Integer Length2 = canBeOrderPrivatedataList.size();
            for (int i = 0; i < OrderPrivatedataList.size(); i++) {
                for (int j = 0; j < Length2; j++) {
                    Long ddDataId1 = OrderPrivatedataList.get(i).getDdDataId();
                    Long ddDataId2 = canBeOrderPrivatedataList.get(j).getDdDataId();
                    if (ddDataId1.equals(ddDataId2)) {
                        canBeOrderPrivatedataList.remove(j);
                        Length2 = canBeOrderPrivatedataList.size();
                        j--;
                    }
                }
            }
        }

        return getAutoView().addObject("TaskInfo", taskInfo)
                .addObject("privateDataListbyTask", privateDataListbyTask)
                .addObject("publishDataList", publishDataList)
                .addObject("canBeOrderPrivatedataList", canBeOrderPrivatedataList)
                .addObject("OrderPrivatedataList", OrderPrivatedataList);
    }

    /**
     * 2017/2/8/
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("onchangetaskinfo")
    @Action(description = "更改任务详情")
    public void onchangetaskinfo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            long taskId = RequestUtil.getLong(request, "taskId");
            String json = request.getParameter("strJson");
            JSONObject obj = JSONObject.fromObject(json);
            Iterator<String> sIterator = obj.keys();
            String key = sIterator.next();
            TaskStart taskStart = taskStartService.getByTaskId(taskId);
            TaskInfo taskInfo = taskInfoService.getById(taskId);
            switch (Integer.parseInt(key)) {
                case 0:
                    long temp0 = obj.getLong("0");
                    if (taskStart != null) {
                        taskStart.setDdTaskResponcePerson(temp0);
                        taskStartService.update(taskStart);
                    }

                    taskInfo.setDdTaskResponsiblePerson(temp0);
                    break;
                case 1:
                    long temp1 = obj.getLong("1");
                    taskInfo.setDdTaskPriority(temp1);
                    break;
                case 2:
                    String temp2 = obj.getString("2");
                    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD",
                            Locale.ENGLISH);
                    Date parsedDate = sdf.parse(temp2);
                    taskInfo.setDdTaskPlanEndTime(parsedDate);
                    break;
                case 3:
                    String temp3 = obj.getString("3");
                    taskInfo.setDdTaskDescription(temp3);
                    break;
            }


            taskInfoService.updateDDTask(taskInfo);
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * 任务从新建拖拽到发布
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */

    @RequestMapping("savepublishdata")


    @Action(description = "任务拖拽到发布")
    private void savepublishdata(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long dataId = RequestUtil.getLong(request, "id");
        long taskId = RequestUtil.getLong(request, "taskId");

        String parent = RequestUtil.getString(request, "parent");

        if (parent.equals("privatepanel")) {
            List<OrderDataRelation> publishDataList = new ArrayList<OrderDataRelation>();
            publishDataList = orderDataRelationService.queryPublishDataRelationByddTaskID(taskId);

            //更新orderDataRelation
            for (int i = 0; i < publishDataList.size(); i++) {
                if (publishDataList.get(i).getDdDataId().equals(dataId) && publishDataList.get(i).getDdOrderType().equals(0L)) {
                    long OrderDataId = publishDataList.get(i).getDdOrderDataId();
                    orderDataRelationService.delById(OrderDataId);
                }
            }
        }

        if (parent.equals("publishpanel")) {

            OrderDataRelation orderDataRelation = new OrderDataRelation();
            orderDataRelation.setDdOrderDataId(UniqueIdUtil.genId());
            orderDataRelation.setDdOrderType(0L);
            orderDataRelation.setDdDataId(dataId);
            orderDataRelation.setDdTaskId(taskId);
            PrivateData privateData = privateDataService.getById(dataId);
            orderDataRelation.setDdDataName(privateData.getDdDataName());
            this.orderDataRelationService.addDDOrderDataRelation(orderDataRelation);
        }
    }
}
