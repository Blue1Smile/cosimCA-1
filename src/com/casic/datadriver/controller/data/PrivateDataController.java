package com.casic.datadriver.controller.data;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.casic.datadriver.model.data.DataSnapShotId;
import com.casic.datadriver.model.data.DataVersion;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.model.task.TaskStart;
import com.casic.datadriver.service.data.DataSnapShotIdService;
import com.casic.datadriver.service.data.DataVersionService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.hotent.core.util.ContextUtil;
import com.hotent.platform.auth.ISysUser;
import net.sf.json.JSONObject;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.service.data.PrivateDataService;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.core.web.util.RequestUtil;

/**
 * ?????????????.
 *
 * @author ???? ???2016/11/14 0014.
 */
@Controller
@RequestMapping("/datadriver/privatedata/")
public class PrivateDataController extends AbstractController {

    /** The privateData service. */
    @Resource
    private PrivateDataService privateDataService;

    @Resource
    private TaskInfoService taskInfoService;

    @Resource
    private DataSnapShotIdService dataSnapShotIdService;


    @Resource
    private DataVersionService dataVersionService;
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
    @RequestMapping("save")
         @Action(description = "保存privateData")
         public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;
        PrivateData privateData = this.getFormObject(request, PrivateData.class);
        try {
            if (privateData.getDdDataId() == null || privateData.getDdDataId() == 0) {
                privateData.setDdDataId(UniqueIdUtil.genId());
                privateDataService.addDDPrivateData(privateData);
                resultMsg = getText("record.added", "私有数据");
//                resultMsg = new String(resultMsg.getBytes(),"utf-8");
            } else {
                privateDataService.updatedata(privateData);
                resultMsg = getText("record.updated", "私有数据");
//                resultMsg = new String(resultMsg.getBytes(),"utf-8");
            }
            writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * Query privateData basic info list.
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @return the list
     * @throws Exception
     *             the exception
     */

    @RequestMapping("list")
    @Action(description = "私有数据列表")
    public ModelAndView queryPrivateDataBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long id = RequestUtil.getLong(request, "id");
        List<PrivateData> privateDataInfoList=  new ArrayList<PrivateData>();
        TaskInfo taskInfo = taskInfoService.getById(id);
        if (id == null || id == 0) {
            privateDataInfoList = privateDataService.getAll();
        } else {
            privateDataInfoList = privateDataService.queryPrivateDataByddTaskID(id);
        }
        ModelAndView mv = this.getAutoView().addObject("privateDataList", privateDataInfoList)
                .addObject("taskInfo", taskInfo);
        return mv;

    }

//    /**
//     * 添加和编辑私有数据
//     *
//     * @param request
//     *            the request
//     * @param response
//     *            the response
//     * @return the list
//     * @throws Exception
//     *             the exception
//     */
//    @RequestMapping("edit")
//    @Action(description = "私有数据添加和编辑")
//    public ModelAndView edit(HttpServletRequest request, HttpServletResponse response)
//            throws Exception {
//        Long id = RequestUtil.getLong(request, "id");
//        if (id==null||id==0L) {
//            Long ddDataId = RequestUtil.getLong(request, "ddDataId");
//            PrivateData privateData = privateDataService.getById(ddDataId);
//            Long taskId = privateData.getDdDataTaskId();
//            ModelAndView mv = this.getAutoView().addObject("PrivateData", privateData).addObject("taskId", taskId);
//            return mv;
//        }else {
//            TaskInfo taskInfo = taskInfoService.getById(id);
//            ModelAndView mv = this.getAutoView().addObject("taskInfo", taskInfo).addObject("taskId", id);
//            return mv;
//        }
//    }

    /**
     * 编辑任务
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("edit")
    @Action(description = "数据编辑")
    public ModelAndView edit(HttpServletRequest request) throws Exception {

        String time = "2017年12月10日";
        Long id = RequestUtil.getLong(request, "id");
        String returnUrl = RequestUtil.getPrePage(request);
        PrivateData privateData = privateDataService.getById(id);
        List<DataVersion> dataVersionList = dataVersionService.queryDataVersionListByddDataId(id);
//        int lenth = dataVersionList.size();
        return getAutoView().addObject("privateData", privateData)
                .addObject("returnUrl", returnUrl).addObject("dataVersionList",dataVersionList);
    }

    /**
     * Del.
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @throws Exception
     *             the exception
     */
    @RequestMapping("del")
    public void del(HttpServletRequest request, HttpServletResponse response) throws Exception {
        super.del(request, response, this.privateDataService);
    }


    /**
     * ???????????.
     *
     * @param bin
     *            the bin
     */
    @InitBinder
    public void initBinder(ServletRequestDataBinder bin) {
        bin.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
    }

//    /**
//     * 2017/2/8/
//     *
//     * @param request  the request
//     * @param response the response
//     * @return the list
//     * @throws Exception the exception
//     */
//    @RequestMapping("onchangeprivatedata")
//    @Action(description = "更改数据详情")
//    private void onchangeprivatedata(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        try {
//            long dataId = RequestUtil.getLong(request, "dataId");
//            String json = request.getParameter("strJson");
//            JSONObject obj = JSONObject.fromObject(json);
//            Iterator<String> sIterator = obj.keys();
//            String key = sIterator.next();
//            TaskStart taskStart = taskStartService.getByTaskId(taskId);
//            TaskInfo taskInfo = taskInfoService.getById(taskId);
//            switch (Integer.parseInt(key)) {
//                case 0:
//                    long temp0 = obj.getLong("0");
//                    taskStart.setDdTaskResponcePerson(temp0);
//                    taskStartService.update(taskStart);
//                    taskInfo.setDdTaskResponsiblePerson(temp0);
//                    break;
//                case 1:
//                    long temp1 = obj.getLong("1");
//                    taskInfo.setDdTaskPriority(temp1);
//                    break;
//                case 2:
//                    String temp2 = obj.getString("2");
//                    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-DD",
//                            Locale.ENGLISH);
//                    Date parsedDate = sdf.parse(temp2);
//                    taskInfo.setDdTaskPlanEndTime(parsedDate);
//                    break;
//                case 3:
//                    String temp3 = obj.getString("3");
//                    taskInfo.setDdTaskDescription(temp3);
//                    break;
//            }
//
//            taskInfoService.updateDDTask(taskInfo);
//        } catch (Exception e) {
//            String resultMsg = null;
//            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
//        }
//    }


}
