package com.casic.datadriver.controller.datacenter;


import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.data.*;
import com.casic.datadriver.model.project.Project;
import com.casic.datadriver.model.task.TaskStart;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.service.data.*;
import com.casic.datadriver.service.data.DataSnapShotIdService;

import com.casic.datadriver.service.project.ProjectService;
import com.casic.datadriver.service.task.ProTaskDependanceService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.casic.datadriver.service.task.TaskStartService;
import com.hotent.core.web.ResultMessage;
import com.hotent.platform.auth.ISysUser;
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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
    @Resource
    private DataVersionService dataVersionService;
    @Resource
    private DataSnapshotService dataSnapshotService;


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
    @RequestMapping("publishorderdata")
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

    /**
     * 2016/12/22/修改
     * 查看任务数据版本变化
     *
     * @param request  the request
     * @param response the response
     * @return the dataVersionlist
     * @throws Exception the exception
     */
    @RequestMapping("dataversion")
    @Action(description = "返回任务发布订购数据列表")
    public ModelAndView showDataVersion(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddDataId= RequestUtil.getLong(request, "id");
        //获得发布数据列表
        List<DataVersion>  dataVersion_list =  this.dataVersionService.queryDataVersionListByddDataId(ddDataId);
//        List<PrivateData> privateData = new ArrayList<PrivateData>();
        ModelAndView mv = this.getAutoView().addObject("dataVersionList", dataVersion_list);
        return mv;
    }



    /**
     * 私有数据数据快照
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @return the list
     * @throws Exception
     *             the exception
     */
    @RequestMapping("datasnapshot")
    @Action(description = "私有数据数据快照")
    public void datasnapshot(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Long ddDataVersionId = RequestUtil.getLong(request, "ddDataVersionId");
//        String ddDataTag = RequestUtil.getString(request, "ddDataTag");
        DataVersion dataVersion = dataVersionService.getById(ddDataVersionId);

        DataSnapshot dataSnapshot = new DataSnapshot();

        int size = dataSnapshotService.getByddDataId(dataVersion.getDdDataId()).size();
        if (size==0){
            dataSnapshot.setDdDataSnapshotId(UniqueIdUtil.genId());
            dataSnapshot.setDdDataId(dataVersion.getDdDataId());
            dataSnapshot.setDdDataValue(dataVersion.getDdDataValue());
            dataSnapshot.setDdDataRecordTime(dataVersion.getDdDataRecordTime());

            ISysUser sysUser = ContextUtil.getCurrentUser();
            dataSnapshot.setDdSnapshotPersonId(sysUser.getUserId());

            Date currentTime = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dateString = formatter.format(currentTime);
            dataSnapshot.setDdSnapshotTime(dateString);

//        dataSnapshot.setDdDataTag(ddDataTag);
            this.dataSnapshotService.add(dataSnapshot);
        }
        else
        {
            dataSnapshot.setDdDataSnapshotId(UniqueIdUtil.genId());
            dataSnapshot.setDdDataId(dataVersion.getDdDataId());
            dataSnapshot.setDdDataValue(dataVersion.getDdDataValue());
            dataSnapshot.setDdDataRecordTime(dataVersion.getDdDataRecordTime());

            ISysUser sysUser = ContextUtil.getCurrentUser();
            dataSnapshot.setDdSnapshotPersonId(sysUser.getUserId());

            Date currentTime = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dateString = formatter.format(currentTime);
            dataSnapshot.setDdSnapshotTime(dateString);

            //        dataSnapshot.setDdDataTag(ddDataTag);
            this.dataSnapshotService.update(dataSnapshot);
        }


    }




/**
 * 数据快照列表.
 *
 * @param request  the request
 * @param response the response
 * @return the list
 * @throws Exception the exception
 */
    @RequestMapping("datasnapshotlist")
    @Action(description = "根据条件查询项目基本信息列表")
    public ModelAndView datasnapshotlist(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
//        QueryFilter queryFilter = new QueryFilter(request, "ProjectItem");
        List<DataSnapshot> dataSnapshots = this.dataSnapshotService.getAll();
        int i =0;
        ModelAndView mv = this.getAutoView().addObject("datasnapshotlist",
                dataSnapshots);
        return mv;
    }





    /**
     * ?????????.
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @throws Exception
     *             the exception
     */
    @RequestMapping("showdatashot")
    @Action(description = "查看数据快照")
    public ModelAndView showdatashot(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;


        Long ddDataSnapshotId = RequestUtil.getLong(request, "ddDataSnapshotId");
        DataSnapshot dataSnapshot = dataSnapshotService.getById(ddDataSnapshotId);
        Long ddDataId= dataSnapshot.getDdDataId();
        PrivateData privateData = privateDataService.getById(ddDataId);

        DataShot dataShot = new DataShot();
        dataShot.setDdDataCreatePerson(privateData.getDdDataCreatePerson());
        dataShot.setDdDataCreateTime(privateData.getDdDataCreateTime());
        dataShot.setDdDataDescription(privateData.getDdDataDescription());
        dataShot.setDdDataId(privateData.getDdDataId());
        dataShot.setDdDataName(privateData.getDdDataName());
        dataShot.setDdDataIsDelivery(privateData.getDdDataIsDelivery());
        dataShot.setDdDataPublishType(privateData.getDdDataPublishType());
        dataShot.setDdDataSensitiveness(privateData.getDdDataSensitiveness());
        dataShot.setDdDataSnapShotId(dataSnapshot.getDdDataSnapshotId());
        dataShot.setDdDataCreateTime(privateData.getDdDataCreateTime());
        dataShot.setDdDataSubmiteState(privateData.getDdDataSubmiteState());
        dataShot.setDdDataTaskName(privateData.getDdDataTaskName());
        dataShot.setDdDataType(privateData.getDdDataType());
        dataShot.setDdSnapshotPersonId(dataSnapshot.getDdSnapshotPersonId());
        dataShot.setDdDataValue(dataSnapshot.getDdDataValue());
        dataShot.setDdDataTag(dataSnapshot.getDdDataTag());
        dataShot.setDdSnapshotTime(dataSnapshot.getDdSnapshotTime());

        ModelAndView mv = this.getAutoView().addObject("dataShot", dataShot);
        return mv;

    }


}
