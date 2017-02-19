package com.casic.datadriver.controller.data;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.casic.datadriver.model.data.DataSnapShotId;
import com.casic.datadriver.model.data.DataVersion;
import com.casic.datadriver.model.project.Project;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.model.task.TaskStart;
import com.casic.datadriver.service.data.DataSnapShotIdService;
import com.casic.datadriver.service.data.DataVersionService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.hotent.core.util.ContextUtil;
import com.hotent.platform.auth.ISysUser;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
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

        PrivateData privateData = getFormObject(request);
        try {
            if (privateData.getDdDataId() == null || privateData.getDdDataId() == 0) {
                privateData.setDdDataId(UniqueIdUtil.genId());
                privateDataService.addDDPrivateData(privateData);

            } else {
                privateDataService.updatedata(privateData);

            }
        } catch (Exception e) {
        }
    }

    private PrivateData getFormObject(HttpServletRequest request) throws Exception {
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[]{"yyyy-MM-dd"})));

        String json = RequestUtil.getString(request, "json");
        JSONObject obj = JSONObject.fromObject(json);

        Map<String, Class> map = new HashMap<String, Class>();
//        map.put("privateDataList", PrivateData.class);
        PrivateData privateData = (PrivateData) JSONObject.toBean(obj, PrivateData.class);

        return privateData;
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
     * 添加私有数据
     *
     * @param request  the request
     * @param response the response
     * @return the add
     * @throws Exception the exception
     */
    @RequestMapping("addprivatedata")
    @Action(description = "添加任务")
    public ModelAndView addprivatedata(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        ResultMessage resultMessage = null;
        ModelAndView mv = new ModelAndView();
        try {
            Long id = RequestUtil.getLong(request, "id");
            TaskInfo taskInfo = taskInfoService.getById(id);

            ISysUser sysUser = ContextUtil.getCurrentUser();
            String sysName = sysUser.getFullname();
            Date currentTime = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dateString = formatter.format(currentTime);

            mv = this.getAutoView().addObject("taskInfo", taskInfo).addObject("currentTime", dateString).addObject("sysName",sysName);

        } catch (Exception ex) {
            resultMessage = new ResultMessage(ResultMessage.Fail, "创建失败" + ex.getMessage());
        }
        return mv;
    }

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
        PrivateData privateData = privateDataService.getById(id);
        long taskId = privateData.getDdDataTaskId();
        TaskInfo taskInfo = taskInfoService.getById(taskId);
        List<TaskInfo> taskInfoList = taskInfoService.queryTaskInfoByResponceId(taskInfo.getDdTaskResponsiblePerson());

        List<DataVersion> dataVersionList = dataVersionService.queryDataVersionListByddDataId(id);
//        int lenth = dataVersionList.size();
        return getAutoView().addObject("privateData", privateData)
                .addObject("taskInfoList", taskInfoList)
                .addObject("dataVersionList", dataVersionList);
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

    /**
     * 2017/2/16/
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("onchangeprivatedata")
    @Action(description = "更改数据详情")
    public void onchangeprivatedata(HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {
            long dataId = RequestUtil.getLong(request, "id");
            String json = request.getParameter("strJson");
            JSONObject obj = JSONObject.fromObject(json);
            Iterator<String> sIterator = obj.keys();
            String key = sIterator.next();
            PrivateData privateData = privateDataService.getDataById(dataId);

            switch (Integer.parseInt(key)) {
                case 0://更改数据类型
                    long temp0 = obj.getLong("0");
                    privateData.setDdDataType(temp0);
                    break;
                case 1://更改数据值
                    String temp1 = obj.getString("1");
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
                    DataVersion dataVersion1 = new DataVersion();
                    dataVersion1.setDdDataVersionId(UniqueIdUtil.genId());
                    dataVersion1.setDdDataId(privateData.getDdDataId());
                    dataVersion1.setDdDataChangeReason("非列表变更");
                    dataVersion1.setDdDataRecordPersonId(ContextUtil.getCurrentUserId());
                    dataVersion1.setDdDataRecordTime(df.format(new Date()));
                    dataVersion1.setDdDataValue(privateData.getDdDataLastestValue());

                    List<DataVersion> dataVersionList1 = dataVersionService.queryDataVersionListByddDataId(privateData.getDdDataId());
                    if (dataVersionList1!=null){
                        dataVersion1.setDdDataVersion((long) (dataVersionList1.size()+1));
                    }else {
                        dataVersion1.setDdDataVersion(0l);
                    }
                    dataVersionService.addDDDataVersion(dataVersion1);
                    privateData.setDdDataLastestValue(temp1);
                    break;
                case 2://更改数据所属任务
                    long temp2 = obj.getLong("2");
                    TaskInfo taskInfo = taskInfoService.getById(temp2);
                    privateData.setDdDataTaskId(temp2);
                    privateData.setDdDataTaskName(taskInfo.getDdTaskName());
                    break;
                case 3://更改数据描述
                    String temp3 = obj.getString("3");
                    privateData.setDdDataDescription(temp3);
                    break;
            }
            privateDataService.updatedata(privateData);
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }
}
