package com.casic.datadriver.controller.datacenter;


import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.data.DataVersion;
import com.casic.datadriver.model.data.OrderDataRelation;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.model.task.TaskStart;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.service.data.DataVersionService;
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
import com.hotent.platform.auth.ISysUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


/**
 * @author ???? ???2016/11/14 0014.
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


    /**
     * 2016/12/4/�޸�
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("list")
    @Action(description = "�����û��鿴taskstart�������û������б�")
    public ModelAndView queryProjectBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<TaskStart> taskStartList = taskStartService.queryTaskStartByResponceId(ContextUtil.getCurrentUserId());
        List<TaskInfo> taskInfo_list = new ArrayList<TaskInfo>();
        for (TaskStart taskStart : taskStartList) {

            Long ddTaskId = taskStart.getDdTaskId();
            long ddTask_Id = ddTaskId;
            TaskInfo taskInfo = taskInfoService.getById(ddTask_Id);
            taskInfo_list.add(taskInfo);
        }
        ModelAndView mv = this.getAutoView().addObject("taskList", taskInfo_list);
        return mv;
    }

    @RequestMapping("submitpublish")
    @Action(description = "�������񷢲������б�")
    public ModelAndView querysubmitpublish(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddTaskId = RequestUtil.getLong(request, "id");
        List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.queryPublishDataRelationByddTaskID(ddTaskId);
        List<PrivateData> privateData_list = new ArrayList<PrivateData>();
//        for (OrderDataRelation orderDataRelation : orderDataRelation_list) {
//            Long ddDataId = orderDataRelation.getDdDataId();
//            List<PrivateData> taskPrivateDatas = this.privateDataService.getByddDataId(ddDataId);
//            privateData.addAll(taskPrivateDatas);
//        }
        for (int i = 0; i < orderDataRelation_list.size(); i++) {
            OrderDataRelation orderDataRelation = orderDataRelation_list.get(i);
            PrivateData privateData = privateDataService.getById(orderDataRelation.getDdDataId());
            privateData_list.add(privateData);
        }
        ModelAndView mv = this.getAutoView().addObject("privateDataList",
                privateData_list);
        return mv;
    }



    @RequestMapping("showorder")
    @Action(description = "�������񶩹������б�")
    public ModelAndView queryshoworder(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddTaskId = RequestUtil.getLong(request, "id");
        List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.queryOrderDataRelationByddTaskID(ddTaskId);
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
     * 2016/12/22/�޸�
     *提交发布数据
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     *                   �����޸�
     */
    @RequestMapping("submitdatavalue")
    @Action(description = "")
    public void submitdatavalue(HttpServletRequest request, HttpServletResponse response) throws Exception {

        String[] ddDataValues = RequestUtil.getStringAry(request, "ddDataLastestValue");
        Long[] ddDataIds = RequestUtil.getLongAry(request, "ddDataId");
        DataVersion dataVersion = new DataVersion();
        for (int i = 0; i < ddDataIds.length; i++) {
            PrivateData privateData = this.privateDataService.getById(ddDataIds[i]);
            if (privateData.getDdDataLastestValue()!=null&&privateData.getDdDataLastestValue().equals(ddDataValues[i])){
            }
            else {

                privateData.setDdDataLastestValue(ddDataValues[i]);
                this.privateDataService.updatedata(privateData);
                dataVersion.setDdDataVersionID(UniqueIdUtil.genId());
                ISysUser sysUser = ContextUtil.getCurrentUser();
                dataVersion.setDdDataRecordPersonId(sysUser.getUserId());
                dataVersion.setDdDataId(ddDataIds[i]);
                dataVersion.setDdDataValue(ddDataValues[i]);
                Date nowTime = new Date(System.currentTimeMillis());
                SimpleDateFormat sdFormatter = new SimpleDateFormat("yyyy-MM-dd-hh-mm-ss");
                String retStrFormatNowDate = sdFormatter.format(nowTime);
                dataVersion.setDdDataRecordTime(retStrFormatNowDate);    //修改数据类型
                this.dataVersionService.add(dataVersion);
            }

        }
        //      Long ddDataId=RequestUtil.getLong(request, "ddDataId");

    }




}
