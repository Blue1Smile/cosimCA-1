package com.casic.datadriver.controller.datacenter;


import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.data.OrderDataRelation;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.model.project.Project;
import com.casic.datadriver.model.task.TaskStart;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.service.data.OrderDataRelationService;
import com.casic.datadriver.service.data.PrivateDataService;
import com.casic.datadriver.service.project.ProjectService;
import com.casic.datadriver.service.task.ProTaskDependanceService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.casic.datadriver.service.task.TaskStartService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.core.web.util.RequestUtil;
import netscape.javascript.JSObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;


/**
 * @author ???? ???2016/11/14 0014.
 */
@Controller
@RequestMapping("/datadriver/datacenter/")
public class DataCenterController extends AbstractController {

    @Resource
    private TaskInfoService taskInfoService;
    @Resource
    private PrivateDataService privateDataService;
    @Resource
    private OrderDataRelationService orderDataRelationService;
    @Resource
    private TaskStartService taskStartService;
    @Resource
    private ProjectService projectService;



    /**
     * 2016/12/19/修改
     *取得项目树
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("list")
    public ModelAndView queryProjectBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Project> ProjectList = projectService.getAll();
        int ProjectLength = ProjectList.size();
        Long[] ProjectId = new Long[ProjectLength];
        String[] ProjectName = new String[ProjectLength];
        int allLength = 0;
        int[] TaskLength = new int[ProjectList.size()];
        List<TaskInfo> allTaskInfo = new ArrayList<TaskInfo>();
        for (int i = 0; i < ProjectList.size(); i++) {
            Project project = ProjectList.get(i);
            ProjectId[i] = project.getDdProjectId();
            ProjectName[i] = project.getDdProjectName();
            List<TaskInfo> now_Task = taskInfoService.queryTaskInfoByProjectId(ProjectId[i]);
            TaskLength[i] = now_Task.size();
            allLength = allLength + TaskLength[i];
            for (int j = 0; j < TaskLength[i]; j++) {
                TaskInfo taskInfo = now_Task.get(j);
                allTaskInfo.add(taskInfo);
            }
        }
        Long[] allTaskId = new Long[allLength];
        String[] allTaskName = new String[allLength];
        for (int i = 0; i < allLength; i++) {
            TaskInfo TaskInfo = allTaskInfo.get(i);
            allTaskId[i] = TaskInfo.getDdTaskId();
            allTaskName[i] = TaskInfo.getDdTaskName();
        }
        ModelAndView mv = this.getAutoView().addObject("ProjectId",
                ProjectId).addObject("ProjectName", ProjectName).addObject("ProjectLength", ProjectLength).addObject("allTaskInfoName", allTaskName)
                .addObject("allTaskInfoId", allTaskId).addObject("TaskLength", TaskLength);
        return mv;
    }

    /**
     * 2016/12/19/修改
     * 返回任务发布订购数据列表
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("publishOrderData")
    @Action(description = "返回任务发布订购数据列表")
    public ModelAndView querysubmitpublish(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddTaskId= RequestUtil.getLong(request, "id");
        //获得发布数据列表
        List<OrderDataRelation>  orderDataRelation_list =  this.orderDataRelationService.queryPublishDataRelationByddTaskID(ddTaskId);
        List<PrivateData> privateData = new ArrayList<PrivateData>();
        for (OrderDataRelation orderDataRelation:orderDataRelation_list){
            Long ddDataId=orderDataRelation.getDdDataId();
            List<PrivateData>  taskPrivateDatas =  this.privateDataService.getByddDataId(ddDataId);
            privateData.addAll(taskPrivateDatas);
        }

        //获得订购数据列表
        List<OrderDataRelation> orderDataRelation_list2 = this.orderDataRelationService.queryOrderDataRelationByddTaskID(ddTaskId);
        List<PrivateData> privateData2 = new ArrayList<PrivateData>();
        for (OrderDataRelation orderDataRelation : orderDataRelation_list2) {
            Long ddDataId=orderDataRelation.getDdDataId();
            List<PrivateData> taskPrivateDatas2 = this.privateDataService.getByddDataId(ddDataId);
            privateData2.addAll(taskPrivateDatas2);
        }
        ModelAndView mv = this.getAutoView().addObject("privateDataList_publish",
                privateData).addObject("privateDataList_order", privateData2);
        return mv;
    }




}
