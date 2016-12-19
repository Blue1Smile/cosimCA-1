package com.casic.datadriver.controller.task;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.hotent.platform.service.system.SysUserService;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import org.apache.bcel.generic.NEW;
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
    private  ProjectService projectService;
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
     *根据项目id查询项目任务或者查询所有项目
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
        List<TaskInfo> taskInfoList=  new ArrayList<TaskInfo>();

        if (id == null || id == 0) {
             taskInfoList = taskInfoService.getAll();
        } else {
             taskInfoList = taskInfoService.queryTaskInfoByProjectId(id);
        }
        ModelAndView mv = this.getAutoView().addObject("taskList", taskInfoList)
                .addObject("projectId", id);
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
        Long id = RequestUtil.getLong(request, "id");
        List<TaskInfo> taskInfoList = taskInfoService.queryTaskInfoByProjectId(id);
        Project project = projectService.getById(id);
//        QueryFilter queryFilter = new QueryFilter(request, "TaskItem");
        ModelAndView mv = this.getAutoView().addObject("taskList", taskInfoList)
                .addObject("projectItem", project);
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
//        super.del(request, response, this.taskInfoService);
        String preUrl = RequestUtil.getPrePage(request);
        ResultMessage message = null;
        try {
            Long[] TaskId = RequestUtil.getLongAryByStr(request, "id");

            taskInfoService.delAll(TaskId);
//        TaskInfo taskInfo = this.getFormObject(request, TaskInfo.class);
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
        Long id = RequestUtil.getLong(request, "id");
        String returnUrl = RequestUtil.getPrePage(request);
        TaskInfo taskInfo = taskInfoService.getById(id);
        List<PrivateData> privateDataList = taskInfoService.getPrivateDataList(id);
        if (taskInfo.getDdTaskPerson() == null) {
            //获取负责任ID
            Long userId = RequestUtil.getLong(request, "userId");
            //获取任务负责任姓名
            String msg = RequestUtil.getString(request, "taskPerson");
            String taskPerson = new String(msg.getBytes("ISO-8859-1"), "UTF-8");
            taskInfo.setDdTaskResponsiblePerson(userId);
            taskInfo.setDdTaskPerson(taskPerson);
        }
        return getAutoView().addObject("TaskInfo", taskInfo)
                .addObject("privateDataList", privateDataList)
                .addObject("returnUrl", returnUrl);
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

    /**
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("userlist")
    @Action(description = "用户列表")
    public ModelAndView userlist(HttpServletRequest request, HttpServletResponse response) throws Exception {

        Long TaskId = RequestUtil.getLong(request, "TaskId");
        QueryFilter queryFilter = new QueryFilter(request, "sysUserItem");
        ModelAndView mv = this.getAutoView().addObject("sysUserList",
                this.sysUserService.getUserByQuery(queryFilter)).addObject("TaskId", TaskId);
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

        Long TaskId = RequestUtil.getLong(request, "TaskId");
        Long userId = RequestUtil.getLong(request, "UserId");

        ModelAndView mv = new ModelAndView("redirect:edit.ht");
        mv.addObject("id", TaskId)

                .addObject("userId", userId)
                .addObject("taskPerson", fullname);
        return mv;
    }

}
