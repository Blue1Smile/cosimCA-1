package com.casic.datadriver.controller.project;


import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.IOException;
import java.io.InputStream;


import com.casic.datadriver.model.data.DataStruct;
import com.casic.datadriver.model.data.OrderDataRelation;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.model.flow.ProcessFlow;
import com.casic.datadriver.model.flow.ProjectProcessAssocia;
import com.casic.datadriver.model.project.ProjectStart;
import com.casic.datadriver.model.task.TaskStart;
import com.casic.datadriver.service.data.DataStructService;
import com.casic.datadriver.service.data.OrderDataRelationService;
import com.casic.datadriver.service.data.PrivateDataService;
import com.casic.datadriver.service.flow.ProcessFlowService;
import com.casic.datadriver.service.flow.ProjectProcessAssociaService;
import com.casic.datadriver.service.task.TaskStartService;
import com.hotent.core.util.ContextUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.casic.datadriver.model.project.Project;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.service.ProjectStartCmd;
import com.casic.datadriver.service.project.ProjectService;
import com.casic.datadriver.service.project.ProjectStartService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.casic.datadriver.service.task.ProTaskDependanceService;
import com.casic.datadriver.model.task.ProTaskDependance;
import com.hotent.core.annotion.Action;
import com.hotent.core.bpm.model.ProcessCmd;
import com.hotent.core.bpm.util.BpmUtil;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.util.ExceptionUtil;
import com.hotent.core.util.StringUtil;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.controller.BaseController;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.core.web.util.RequestUtil;
import com.hotent.platform.auth.ISysUser;
import com.hotent.platform.service.bpm.thread.MessageUtil;
import com.hotent.platform.service.system.ResourcesService;
import com.hotent.platform.service.system.SubSystemService;
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
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 项目管理
 *
 * @author dodo 2016/11/14 0014.
 */
@Controller
@RequestMapping("/datadriver/project/")
public class ProjectController extends BaseController {

    /**
     * The project service.
     */
    @Resource
    private ResourcesService resourcesService;
    @Resource
    private SubSystemService subSystemService;
    @Resource
    private ProjectService projectService;
    @Resource
    private ProjectStartService projectStartService;
    @Resource
    private TaskInfoService taskInfoService;
    @Resource
    private ProTaskDependanceService proTaskDependanceService;
    @Resource
    private TaskStartService taskStartService;
    @Resource
    private ProjectProcessAssociaService projectProcessAssociaService;
    @Resource
    private ProcessFlowService processFlowService;
    @Resource
    private OrderDataRelationService orderDataRelationService;
    @Resource
    private PrivateDataService privateDataService;
    @Resource
    private DataStructService dataStructService;
    /**
     * 保存项目
     *
     * @param request  the request
     * @param response the response
     * @throws Exception the exception
     */
    @RequestMapping("save")
    @Action(description = "添加或更新project")
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;
        Project project = getFormObject(request);
        try {
            if (project.getDdProjectId() == null || project.getDdProjectId() == 0) {
                project.setDdProjectId(UniqueIdUtil.genId());
                //获取当前用户
                ISysUser sysUser = ContextUtil.getCurrentUser();

                project.setDdProjectCreatorId(sysUser.getUserId());

                Date currentTime = new Date();
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String dateString = formatter.format(currentTime);

                project.setDdProjectCreateDatatime(dateString);

                projectService.addDDProject(project);
                resultMsg = getText("added", "项目信息");
            } else {
                projectService.updateAll(project);
                resultMsg = getText("updated", "项目信息");
            }
            writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * 取得对象实体
     *
     * @param request
     * @return
     * @throws Exception
     */
    protected Project getFormObject(HttpServletRequest request) throws Exception {

        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[]{"yyyy-MM-dd"})));

        String json = RequestUtil.getString(request, "json");
        JSONObject obj = JSONObject.fromObject(json);

        Map<String, Class> map = new HashMap<String, Class>();
        map.put("taskInfoList", TaskInfo.class);
        Project project = (Project) JSONObject.toBean(obj, Project.class, map);

        return project;
    }


    /**
     * 查询项目列表
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("list")
    @Action(description = "根据条件查询项目基本信息列表")
    public ModelAndView queryProjectBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long userId = ContextUtil.getCurrentUserId();
        List<Project> projectList = this.projectService.queryProjectBasicInfoList(userId);

        for (int i = 0; i < projectList.size(); i++) {
            Project nowProject = projectList.get(i);
            List<ProTaskDependance> proTaskDependanceList = proTaskDependanceService.getProTaskDependanceList(nowProject.getDdProjectId());
            int listLengthStart = 0;
            int listLengthComplete = 0;
            for (int j = 0; j < proTaskDependanceList.size(); j++) {
                TaskInfo nowTask = taskInfoService.getById(proTaskDependanceList.get(j).getDdTaskId());
                if (nowTask.getDdTaskChildType().equals("publishpanel") || nowTask.getDdTaskChildType().equals("checkpanel")) {
                    listLengthStart++;
                }
                if (nowTask.getDdTaskChildType().equals("completepanel")) {
                    listLengthComplete++;
                }
            }
            if (listLengthComplete == proTaskDependanceList.size() && listLengthComplete != 0) {
                projectList.get(i).setDdProjectPhaseId(projectList.get(i).complete);
            } else {
                if (listLengthStart > 0) {
                    projectList.get(i).setDdProjectPhaseId(projectList.get(i).start);
                } else {
                    projectList.get(i).setDdProjectPhaseId(projectList.get(i).unstart);
                }
            }
        }
        ModelAndView mv = this.getAutoView().addObject("projectList",
                projectList);
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
        Long projectId = RequestUtil.getLong(request, "id");
        String resultMsg = null;

        try {
//            获取项目的所有任务列表
//            List<TaskInfo>  taskInfoList = taskInfoService.queryTaskInfoByProjectId(projectId);
//            List<TaskInfo>  publishTaskList = new ArrayList<TaskInfo>();
//            for(int i=0;i<taskInfoList.size();i++){
//                TaskInfo taskInfo = taskInfoList.get(i);
//                if(taskInfo.getDdTaskChildType().equals("publishpanel")){
//                    publishTaskList.add(taskInfoList.get(i));
//                }
//            }
            projectService.delById(projectId);

            //删除所有任务
            List<TaskInfo>  taskInfoList = taskInfoService.queryTaskInfoByProjectId(projectId);
                for(int i =0;i<taskInfoList.size();i++){
                    Long taskId = taskInfoList.get(i).getDdTaskId();
//                    taskStartService.delByTaskId(taskId);
                    List<DataStruct> dataStructList = dataStructService.getStructByTaskId(taskInfoList.get(i).getDdTaskId());
                    //删除所有数据结构
                    for(int j=0;j<dataStructList.size();j++){
                        Long structId = dataStructList.get(j).getDdStructId();
                        dataStructService.delById(structId);
                        List<PrivateData> childDataList = privateDataService.selectByStructid(structId);
                        //删除所有私有数据
                        for(int k=0;k<childDataList.size();k++){
                            privateDataService.delById(childDataList.get(k).getDdDataId());
                        }

                    }
                    //删除所有模型，文件




                    taskInfoService.delById(taskId);
                }

            resultMsg = getText("added", "项目信息");
                writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
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
     * 编辑项目信息
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("edit")
    @Action(description = "编辑项目信息")
    public ModelAndView edit(HttpServletRequest request) throws Exception {
        Long id = RequestUtil.getLong(request, "id");
        String returnUrl = RequestUtil.getPrePage(request);
        Project project = projectService.getById(id);
        List<TaskInfo> taskInfoList = projectService.getTaskInfoList(id);

        return getAutoView().addObject("Project", project)
                .addObject("taskInfoList", taskInfoList)
                .addObject("returnUrl", returnUrl);
    }


    /**
     * 取得dd_project明细
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("get")
    @Action(description = "查看明细")
    public ModelAndView get(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long id = RequestUtil.getLong(request, "id");
        Project Project = projectService.getById(id);
        return getAutoView().addObject("Project", Project);
    }

    /**
     * 项目设置
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("setup")
    @Action(description = "项目设置")
    public ModelAndView setup(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long id = RequestUtil.getLong(request, "id");
        Project Project = projectService.getById(id);
        String creatorName = ContextUtil.getCurrentUser().getFullname();
        Long creatorId = ContextUtil.getCurrentUser().getUserId();
        return getAutoView().addObject("Project", Project).addObject("creatorName", creatorName).addObject("creatorId", creatorId);
    }

//    /**
//     * 启动项目 dd_project_start
//     *
//     * @param request
//     * @param response
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping("start")
//    @Action(description = "启动项目")
//    public void start(HttpServletRequest request, HttpServletResponse response) throws Exception {
//
//        PrintWriter out = response.getWriter();
//
//        try {
////			if(!Token.isTokenStringValid(request.getParameter(Token.TOKEN_STRING_NAME), request.getSession())) {
////				ResultMessage resultMessage = new ResultMessage(
////						ResultMessage.Fail, "非法访问!");
////				out.print(resultMessage);
////			}
//            Long id = RequestUtil.getLong(request, "id");
//
//            ProcessCmd processCmd = BpmUtil.getProcessCmd(request);
//            processCmd.setCurrentUserId(ContextUtil.getCurrentUserId().toString());
//
//            ProjectStartCmd projectStartCmd = new ProjectStartCmd();
//            projectStartCmd.setStartUser(ContextUtil.getCurrentUser());
//            projectStartCmd.setCurrentUser(ContextUtil.getCurrentUser());
//
//            projectStartCmd.setProcessCmd(processCmd);
//            projectStartService.startProject(id, projectStartCmd);
//            //更新项目状态
//            Project project = projectService.getById(id);
//            project.setDdProjectState(Project.STATUS_RUNNING);
//            projectService.update(project);
//            ResultMessage resultMessage = new ResultMessage(
//                    ResultMessage.Success, "启动流程成功!");
//            out.print(resultMessage);
//        } catch (Exception ex) {
//            ex.printStackTrace();
//            String str = MessageUtil.getMessage();
//            if (StringUtil.isNotEmpty(str)) {
//                ResultMessage resultMessage = new ResultMessage(
//                        ResultMessage.Fail, "创建业务实例失败:\r\n" + str);
//                out.print(resultMessage);
//            } else {
//                String message = ExceptionUtil.getExceptionMessage(ex);
//                ResultMessage resultMessage = new ResultMessage(
//                        ResultMessage.Fail, message);
//                out.print(resultMessage);
//            }
//        }
//    }

    /**
     * 项目指标
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("indexedit")
    @Action(description = "查看明细")
    public ModelAndView indexedit(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long id = RequestUtil.getLong(request, "id");
        Project Project = projectService.getById(id);
        return getAutoView().addObject("Project", Project);
    }

    /**
     * 进入项目控制台
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("stepinto")
    @Action(description = "进入项目")
    public ModelAndView stepinto(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long projectId = RequestUtil.getLong(request, "id");
        Project project = projectService.getById(projectId);
        Long userId = project.getDdProjectCreatorId();
//        List<TaskInfo> taskInfoList = new ArrayList<TaskInfo>();
//        List<TaskInfo> createTaskInfoList = new ArrayList<TaskInfo>();
//        List<TaskInfo> publishTaskInfoList = new ArrayList<TaskInfo>();
//        List<TaskInfo> checkTaskInfoList = new ArrayList<TaskInfo>();
//        List<TaskInfo> completeTaskInfoList = new ArrayList<TaskInfo>();
//        List<ProTaskDependance> proTaskDependanceList = proTaskDependanceService.getProTaskDependanceList(projectId);
//        for (int i = 0; i < proTaskDependanceList.size(); i++) {
//            ProTaskDependance proTaskDependance = proTaskDependanceList.get(i);
//            long taskId = proTaskDependance.getDdTaskId();
//            TaskInfo taskInfo = taskInfoService.getById(taskId);
//
//            taskInfoList.add(taskInfo);
//        }
//        for (TaskInfo taskInfo : taskInfoList) {
//            if (taskInfo.getDdTaskChildType().equals("publishpanel")) {
//                publishTaskInfoList.add(taskInfo);
//            }
//            if (taskInfo.getDdTaskChildType().equals("createpanel")) {
//                createTaskInfoList.add(taskInfo);
//            }
//            if (taskInfo.getDdTaskChildType().equals("checkpanel")) {
//                checkTaskInfoList.add(taskInfo);
//            }
//            if (taskInfo.getDdTaskChildType().equals("completepanel")) {
//                completeTaskInfoList.add(taskInfo);
//            }
//        }
        //根据用户ID获取当前用户拥有项目列表
        List<Project> projectListbyUser = projectService.queryProjectBasicInfoList(userId);
        return getAutoView().addObject("Project", project)
                .addObject("projectListbyUser", projectListbyUser);
//                .addObject("taskListbyUser", createTaskInfoList)
//                .addObject("publishtaskListbyUser", publishTaskInfoList)
//                .addObject("checkTaskInfoList", checkTaskInfoList)
//                .addObject("completeTaskInfoList", completeTaskInfoList);
    }

    /**
     * 进入项目控制台
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("showtask")
    @Action(description = "项目显示")
    public ModelAndView showtask(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long projectId = RequestUtil.getLong(request, "id");
        Project project = projectService.getById(projectId);
        Long userId = project.getDdProjectCreatorId();
        List<TaskInfo> taskInfoList = new ArrayList<TaskInfo>();
        List<TaskInfo> createTaskInfoList = new ArrayList<TaskInfo>();
        List<TaskInfo> publishTaskInfoList = new ArrayList<TaskInfo>();
        List<TaskInfo> checkTaskInfoList = new ArrayList<TaskInfo>();
        List<TaskInfo> completeTaskInfoList = new ArrayList<TaskInfo>();
        List<ProTaskDependance> proTaskDependanceList = proTaskDependanceService.getProTaskDependanceList(projectId);
        for (int i = 0; i < proTaskDependanceList.size(); i++) {
            ProTaskDependance proTaskDependance = proTaskDependanceList.get(i);
            long taskId = proTaskDependance.getDdTaskId();
            TaskInfo taskInfo = taskInfoService.getById(taskId);

            taskInfoList.add(taskInfo);
        }
        for (TaskInfo taskInfo : taskInfoList) {
            if (taskInfo.getDdTaskChildType().equals("publishpanel")) {
                publishTaskInfoList.add(taskInfo);
            }
            if (taskInfo.getDdTaskChildType().equals("createpanel")) {
                createTaskInfoList.add(taskInfo);
            }
            if (taskInfo.getDdTaskChildType().equals("checkpanel")) {
                checkTaskInfoList.add(taskInfo);
            }
            if (taskInfo.getDdTaskChildType().equals("completepanel")) {
                completeTaskInfoList.add(taskInfo);
            }
        }
        //根据用户ID获取当前用户拥有项目列表
        List<Project> projectListbyUser = projectService.queryProjectBasicInfoList(userId);
        return getAutoView().addObject("Project", project)
//                .addObject("projectListbyUser", projectListbyUser)
                .addObject("taskListbyUser", createTaskInfoList)
                .addObject("publishtaskListbyUser", publishTaskInfoList)
                .addObject("checkTaskInfoList", checkTaskInfoList)
                .addObject("completeTaskInfoList", completeTaskInfoList);
    }

    /**
     * 任务从新建拖拽到发布
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("movetask")
    @Action(description = "任务拖拽到发布")
    public void createtopublish(HttpServletRequest request, HttpServletResponse response) throws Exception {

        PrintWriter out = response.getWriter();

        long taskId = RequestUtil.getLong(request, "id");
        String parent = RequestUtil.getString(request, "parent");
        TaskStart taskStart = new TaskStart();
        TaskInfo taskInfo = taskInfoService.getById(taskId);

//        List<OrderDataRelation> publishRelationList = orderDataRelationService.getPublishDataRelationList(taskId);
//        List<PrivateData> publshListWithoutValue = new ArrayList<PrivateData>();
//        int valueLength=publishRelationList.size();

        //发布任务
        if (taskInfo.getDdTaskChildType().equals("createpanel") && parent.equals("publishpanel")) {
            taskStart.setDdTaskStartId(UniqueIdUtil.genId());
            taskStart.setDdTaskId(taskId);
            taskStart.setDdTaskStatus(TaskStart.publishpanel);

            taskInfo = taskInfoService.getById(taskId);
            //更新taskinfo
            taskInfo.setDdTaskChildType("publishpanel");
            taskInfo.setDdTaskState(taskInfo.publishpanel);
            taskInfoService.update(taskInfo);
            //添加taskstart
            long userId = taskInfo.getDdTaskResponsiblePerson();
            taskStart.setDdTaskResponcePerson(userId);

            Project project = projectService.getById(taskInfo.getDdTaskProjectId());
//            ProjectStart
            taskStartService.taskStart(taskStart, project);
        }
        //收回任务
        if (taskInfo.getDdTaskChildType().equals("publishpanel") && parent.equals("createpanel")) {
            //更新taskinfo?????createpanel属性是否应该放到taskstart里面
            taskInfo.setDdTaskChildType("createpanel");
            taskInfo.setDdTaskState(taskInfo.createpanel);
            taskInfoService.update(taskInfo);

            taskStartService.delByTaskId(taskInfo.getDdTaskId());
        } else {

            //提交任务
            if (taskInfo.getDdTaskChildType().equals("publishpanel") && parent.equals("checkpanel")) {
                //更新taskinfo?????createpanel属性是否应该放到taskstart里面
                taskInfo.setDdTaskChildType("checkpanel");
                taskInfoService.update(taskInfo);
                taskInfo.setDdTaskState(taskInfo.checkpanel);

                taskStart.setDdTaskStatus(TaskStart.checkpanel);
                taskStartService.update(taskStart);
            } else {
                //驳回任务
                if (taskInfo.getDdTaskChildType().equals("checkpanel") && parent.equals("publishpanel")) {
                    //更新taskinfo?????createpanel属性是否应该放到taskstart里面
                    taskInfo.setDdTaskChildType("publishpanel");
                    taskInfoService.update(taskInfo);
                    taskInfo.setDdTaskState(taskInfo.publishpanel);

                    taskStart.setDdTaskStatus(TaskStart.publishpanel);
                    taskStartService.update(taskStart);
                } else {
                    //审核通过
                    if (taskInfo.getDdTaskChildType().equals("checkpanel") && parent.equals("completepanel")) {
                        //更新taskinfo?????createpanel属性是否应该放到taskstart里面
                        taskInfo.setDdTaskChildType("completepanel");
                        taskInfoService.update(taskInfo);
                        taskInfo.setDdTaskState(taskInfo.completepanel);

                        taskStart.setDdTaskStatus(TaskStart.completepanel);
                        taskStartService.update(taskStart);


                    }

                }

            }

        }

    }

    /**
     * 一键发布
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("onepunchsend")
    @Action(description = "一键发布")
    public void onepunchsend(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String resultMsg = null;
            String json = request.getParameter("strJson");
            String projectId = RequestUtil.getString(request, "projectId");
            String parent = RequestUtil.getString(request, "parent");
            JSONArray jsonArray = JSONArray.fromObject(json);

            if (jsonArray.isEmpty()) {
                writeResultMessage(response.getWriter(), resultMsg, 2);
            } else {
                TaskStart taskStart = new TaskStart();

                for (int i = 0; i < jsonArray.size(); i++) {
                    Object ddTaskId = jsonArray.get(i);
                    Long taskId = Long.parseLong((String) ddTaskId);

                    TaskInfo taskInfo = taskInfoService.getById(taskId);

                    taskStart.setDdTaskStartId(UniqueIdUtil.genId());
                    taskStart.setDdTaskId(taskId);
                    taskStart.setDdTaskStatus(TaskStart.publishpanel);

                    //更新taskinfo
                    taskInfo.setDdTaskChildType("publishpanel");
                    taskInfo.setDdTaskState(taskInfo.publishpanel);
                    taskInfoService.update(taskInfo);
                    //添加taskstart
                    long userId = taskInfo.getDdTaskResponsiblePerson();
                    taskStart.setDdTaskResponcePerson(userId);

                    Project project = projectService.getById(taskInfo.getDdTaskProjectId());
                    taskStartService.taskStart(taskStart, project);
                    writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
                }
            }
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * 一键收回
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("onepunchback")
    @Action(description = "一键收回")
    public void onepunchback(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            String resultMsg = null;
            String strJsonBack = request.getParameter("strJsonBack");
            String projectId = RequestUtil.getString(request, "projectId");
            String parent = RequestUtil.getString(request, "parent");
            JSONArray jsonArrayBack = JSONArray.fromObject(strJsonBack);
            if (jsonArrayBack.isEmpty()) {
                writeResultMessage(response.getWriter(), "isEmpty", 2);
            } else {
                TaskStart taskStart = new TaskStart();

                for (int i = 0; i < jsonArrayBack.size(); i++) {
                    Object ddTaskId = jsonArrayBack.get(i);
                    Long taskId = Long.parseLong((String) ddTaskId);

                    TaskInfo taskInfo = taskInfoService.getById(taskId);
                    //更新taskinfo?????createpanel属性是否应该放到taskstart里面
                    taskInfo.setDdTaskChildType("createpanel");
                    taskInfo.setDdTaskState(taskInfo.createpanel);
                    taskInfoService.update(taskInfo);

                    taskStartService.delByTaskId(taskInfo.getDdTaskId());
                }
                writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
            }
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * 项目统计
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("statis")
    @Action(description = "统计")
    public ModelAndView statis(HttpServletRequest request, HttpServletResponse response) throws Exception {
        ProcessFlow processFlow = new ProcessFlow();
        ModelAndView mv = new ModelAndView();
        Long projectId = RequestUtil.getLong(request, "id");
        ProjectProcessAssocia projectProcessAssocia = projectProcessAssociaService.selectByProjectId(projectId);
        if (projectProcessAssocia != null) {
            Long processFlowId = projectProcessAssocia.getDdPrcessId();
            processFlow = processFlowService.getById(processFlowId);
            String tempXml = processFlow.getDdProcessXml();
            mv = this.getAutoView().addObject("projectId", projectId)
                    .addObject("processFlowXml", tempXml);
        } else {
            mv = this.getAutoView().addObject("projectId", projectId);
        }
        return mv;
    }

    /**
     * 项目统计
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("test")
    @Action(description = "测试")
    public void test(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long taskId = RequestUtil.getLong(request, "id");

    }

}
