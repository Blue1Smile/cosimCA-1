package com.casic.datadriver.controller.datacenter;


import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.data.OrderDataRelation;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.model.task.TaskStart;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.service.data.OrderDataRelationService;
import com.casic.datadriver.service.data.PrivateDataService;
import com.casic.datadriver.service.task.ProTaskDependanceService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.casic.datadriver.service.task.TaskStartService;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.core.web.util.RequestUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
public class DataCenterController extends AbstractController{

    @Resource
    private TaskInfoService taskInfoService;
    @Resource
    private PrivateDataService privateDataService;
    @Resource
    private OrderDataRelationService orderDataRelationService;
    @Resource
    private TaskStartService taskStartService;



    /**
     * 2016/12/4/修改
     * @param request
     *            the request
     * @param response
     *            the response
     * @return the list
     * @throws Exception
     *             the exception
     */
    @RequestMapping("list")
    @Action(description = "根据用户查看taskstart并返回用户任务列表")
    public ModelAndView queryProjectBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<TaskStart> taskStartList = taskStartService.queryTaskStartByResponceId(ContextUtil.getCurrentUserId());
        List<TaskInfo> taskInfo_list = new ArrayList<TaskInfo>();
        for (TaskStart taskStart:taskStartList){

            Long ddTaskId = taskStart.getDdTaskId();
            long ddTask_Id = ddTaskId;
            TaskInfo taskInfo =  taskInfoService.getById(ddTask_Id);
            taskInfo_list.add(taskInfo);
        }
        ModelAndView mv = this.getAutoView().addObject("taskList", taskInfo_list);
       return mv;
    }


    @RequestMapping("submitpublish")
    @Action(description="返回任务发布数据列表")
    public ModelAndView querysubmitpublish(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddTaskId= RequestUtil.getLong(request, "id");
        List<OrderDataRelation>  orderDataRelation_list =  this.orderDataRelationService.queryPublishDataRelationByddTaskID(ddTaskId);
        List<PrivateData> privateData = new ArrayList<PrivateData>();
        for (OrderDataRelation orderDataRelation:orderDataRelation_list){
            Long ddDataId=orderDataRelation.getDdDataId();
            List<PrivateData>  taskPrivateDatas =  this.privateDataService.getByddDataId(ddDataId);
            privateData.addAll(taskPrivateDatas);
        }
        ModelAndView mv = this.getAutoView().addObject("privateDataList",
                privateData);
        return mv;
    }

    @RequestMapping("showorder")
    @Action(description="返回任务订购数据列表")
    public ModelAndView queryshoworder(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddTaskId= RequestUtil.getLong(request, "id");
        List<OrderDataRelation>  orderDataRelation_list =  this.orderDataRelationService.queryOrderDataRelationByddTaskID(ddTaskId);
        List<PrivateData> privateData = new ArrayList<PrivateData>();
        for (OrderDataRelation orderDataRelation:orderDataRelation_list){

            Long ddDataId=orderDataRelation.getDdDataId();
            List<PrivateData>  taskPrivateDatas =  this.privateDataService.getByddDataId(ddDataId);
            privateData.addAll(taskPrivateDatas);
        }
        ModelAndView mv = this.getAutoView().addObject("privateDataList",
                privateData);
        return mv;
    }

    /**
     * 2016/12/5/修改
     * @param request
     *            the request
     * @param response
     *            the response
     * @return the list
     * @throws Exception
     *             the exception
     *             今天修改
     */
    @RequestMapping("submitdatavalue")
    @Action(description="")
    public void submitdatavalue(HttpServletRequest request, HttpServletResponse response) throws Exception {
       // String[] ddDataLastestValeu=(String[])request.getParameter("ddDataLastestValue");

        String[] ddDataLastestValues = RequestUtil.getStringAry(request, "ddDataLastestValue") ;
        Long[] ddDataIds = RequestUtil.getLongAry(request, "ddDataId") ;
    //    String ddDataLastestValue=RequestUtil.getString(request, "ddDataLastestValue");
        for(int i=0;i<ddDataIds.length;i++){
            PrivateData privateData =  this.privateDataService.getById(ddDataIds[i]);
            privateData.setDdDataLastestValue(ddDataLastestValues[i]);
            this.privateDataService.updatedata(privateData);

        }
  //      Long ddDataId=RequestUtil.getLong(request, "ddDataId");

    }


}
