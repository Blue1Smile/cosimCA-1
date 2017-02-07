package com.casic.datadriver.controller.project;


import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;
import java.io.IOException;
import java.io.InputStream;


import com.casic.datadriver.model.flow.ProcessFlow;
import com.casic.datadriver.model.flow.ProjectProcessAssocia;
import com.casic.datadriver.model.task.TaskStart;
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
 * ��Ŀ����Ŀ�����.
 *
 * @author ���� ʱ�䣺2016/11/14 0014.
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
                resultMsg = getText("record.added", "项目信息");
            } else {
                projectService.updateAll(project);
                resultMsg = getText("record.updated", "项目信息");
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
//        QueryFilter queryFilter = new QueryFilter(request, "ProjectItem");
        List<Project> projectList = this.projectService.queryProjectBasicInfoList(userId);

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
        ResultMessage message = null;
        try {
            Long[] lAryId = RequestUtil.getLongAryByStr(request, "id");
            projectService.delAll(lAryId);
            message = new ResultMessage(ResultMessage.Success, "删除成功!");
        } catch (Exception ex) {
            message = new ResultMessage(ResultMessage.Fail, "删除失败" + ex.getMessage());
        }
        addMessage(message, request);
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
     * 启动项目 dd_project_start
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping("start")
    @Action(description = "启动项目")
    public void start(HttpServletRequest request, HttpServletResponse response) throws Exception {

        PrintWriter out = response.getWriter();

        try {
//			if(!Token.isTokenStringValid(request.getParameter(Token.TOKEN_STRING_NAME), request.getSession())) {
//				ResultMessage resultMessage = new ResultMessage(
//						ResultMessage.Fail, "非法访问!");
//				out.print(resultMessage);
//			}
            Long id = RequestUtil.getLong(request, "id");

            ProcessCmd processCmd = BpmUtil.getProcessCmd(request);
            processCmd.setCurrentUserId(ContextUtil.getCurrentUserId().toString());

            ProjectStartCmd projectStartCmd = new ProjectStartCmd();
            projectStartCmd.setStartUser(ContextUtil.getCurrentUser());
            projectStartCmd.setCurrentUser(ContextUtil.getCurrentUser());

            projectStartCmd.setProcessCmd(processCmd);
            projectStartService.startProject(id, projectStartCmd);
            //更新项目状态
            Project project = projectService.getById(id);
            project.setDdProjectState(Project.STATUS_RUNNING);
            projectService.update(project);
            ResultMessage resultMessage = new ResultMessage(
                    ResultMessage.Success, "启动流程成功!");
            out.print(resultMessage);
        } catch (Exception ex) {
            ex.printStackTrace();
            String str = MessageUtil.getMessage();
            if (StringUtil.isNotEmpty(str)) {
                ResultMessage resultMessage = new ResultMessage(
                        ResultMessage.Fail, "创建业务实例失败:\r\n" + str);
                out.print(resultMessage);
            } else {
                String message = ExceptionUtil.getExceptionMessage(ex);
                ResultMessage resultMessage = new ResultMessage(
                        ResultMessage.Fail, message);
                out.print(resultMessage);
            }
        }
    }

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
        List<TaskInfo> taskInfoList = new ArrayList<TaskInfo>();
        List<TaskInfo> createTaskInfoList = new ArrayList<TaskInfo>();
        List<TaskInfo> publishTaskInfoList = new ArrayList<TaskInfo>();
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
        }
        //根据用户ID获取当前用户拥有项目列表
        List<Project> projectListbyUser = projectService.queryProjectBasicInfoList(userId);
        return getAutoView().addObject("Project", project)
                .addObject("projectListbyUser", projectListbyUser)
                .addObject("taskListbyUser", createTaskInfoList)
                .addObject("publishtaskListbyUser", publishTaskInfoList);
    }

    /**
     * 任务从新建拖拽到发布
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */


    @RequestMapping("createtopublish")
    @Action(description = "任务拖拽到发布")
    public void createtopublish(HttpServletRequest request, HttpServletResponse response) throws Exception {
        long taskId = RequestUtil.getLong(request, "id");
        String parent = RequestUtil.getString(request, "parent");

        TaskStart taskStart = new TaskStart();
        TaskInfo taskInfo = new TaskInfo();
        if (parent.equals("createpanel")) {
            taskInfo = taskInfoService.getUserIdbyTaskId(taskId);
            //更新taskinfo
            taskInfo.setDdTaskChildType("createpanel");
            taskInfoService.updateDDTask(taskInfo);
        }
        if (parent.equals("publishpanel")) {
            taskStart.setDdTaskStartId(UniqueIdUtil.genId());
//            taskStart.setDdProjectStartId();
            taskStart.setDdTaskId(taskId);
//            taskStart.setActInstId();
            taskStart.setDdTaskStatus((short) 1);
//            taskStart.setSortOrder();
            taskInfo = taskInfoService.getUserIdbyTaskId(taskId);
            //更新taskinfo
            taskInfo.setDdTaskChildType("publishpanel");
            taskInfoService.updateDDTask(taskInfo);
            //添加taskstart
            long userId = taskInfo.getDdTaskResponsiblePerson();
            taskStart.setDdTaskResponcePerson(userId);
            taskStartService.taskStart(taskStart);
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
        Long projectId = RequestUtil.getLong(request, "projectId");
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
}
