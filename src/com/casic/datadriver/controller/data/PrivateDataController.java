package com.casic.datadriver.controller.data;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.casic.datadriver.model.data.DataSnapShotId;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.service.data.DataSnapShotIdService;
import com.casic.datadriver.service.task.TaskInfoService;
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

    /**
     * 添加和编辑私有数据
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @return the list
     * @throws Exception
     *             the exception
     */
    @RequestMapping("edit")
    @Action(description = "私有数据添加和编辑")
    public ModelAndView edit(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long id = RequestUtil.getLong(request, "id");
        if (id==null||id==0L) {
            Long ddDataId = RequestUtil.getLong(request, "ddDataId");
            PrivateData privateData = privateDataService.getById(ddDataId);
            Long taskId = privateData.getDdDataTaskId();
            ModelAndView mv = this.getAutoView().addObject("PrivateData", privateData).addObject("taskId", taskId);
            return mv;
        }else {
            TaskInfo taskInfo = taskInfoService.getById(id);
            ModelAndView mv = this.getAutoView().addObject("taskInfo", taskInfo).addObject("taskId", id);
            return mv;
        }
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




}
