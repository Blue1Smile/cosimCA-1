package com.casic.datadriver.controller.data;

import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.data.DataVersion;
import com.casic.datadriver.model.data.PrivateData;
import com.casic.datadriver.model.modelcenter.ModelCenterModel;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.service.ModelCenterService;
import com.casic.datadriver.service.data.DataSnapShotIdService;
import com.casic.datadriver.service.data.DataVersionService;
import com.casic.datadriver.service.data.PrivateDataService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.util.RequestUtil;
import com.hotent.platform.auth.ISysUser;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import org.apache.commons.fileupload.DiskFileUpload;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * ?????????????.
 *
 * @author ???? ???2016/11/14 0014.
 */
@Controller
@RequestMapping("/datadriver/privatedata/")
public class PrivateDataController extends AbstractController {

    /**
     * The privateData service.
     */
    @Resource
    private PrivateDataService privateDataService;

    @Resource
    private TaskInfoService taskInfoService;

    @Resource
    private DataSnapShotIdService dataSnapShotIdService;


    @Resource
    private DataVersionService dataVersionService;

    @Resource
    private ModelCenterService modelCenterService;

    /**
     * ?????????.
     *
     * @param request  the request
     * @param response the response
     * @throws Exception the exception
     */
    @RequestMapping("save")
    @Action(description = "保存privateData")
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;
        PrivateData privateData = getFormObject(request);
        try {
            if (privateData.getDdDataId() == null || privateData.getDdDataId() == 0) {
                privateData.setDdDataId(UniqueIdUtil.genId());
                privateData.setDdDataPublishType(0l);
                privateDataService.addDDPrivateData(privateData);
                resultMsg = getText("record.added", "数据信息");
            } else {
                privateDataService.updatedata(privateData);
                resultMsg = getText("record.updated", "数据信息");
            }
            writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
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
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */

    @RequestMapping("list")
    @Action(description = "私有数据列表")
    public ModelAndView queryPrivateDataBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long id = RequestUtil.getLong(request, "id");
        List<PrivateData> privateDataInfoList = new ArrayList<PrivateData>();
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
    @Action(description = "添加私有")
    public ModelAndView addprivatedata(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String resultMessage = "私有数据添加";
        ModelAndView mv = new ModelAndView();
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            Long id = RequestUtil.getLong(request, "id");
            TaskInfo taskInfo = taskInfoService.getById(id);

            ISysUser sysUser = ContextUtil.getCurrentUser();
            String sysName = sysUser.getFullname();

            String dateString = formatter.format(currentTime);
            List<ModelCenterModel> modelCenterModelList = modelCenterService.getByTaskId(id);
            mv = this.getAutoView().addObject("taskInfo", taskInfo)
                    .addObject("currentTime", dateString)
                    .addObject("sysName", sysName)
                    .addObject("modelCenterModelList", modelCenterModelList);
            writeResultMessage(response.getWriter(), resultMessage, ResultMessage.Success);
        } catch (Exception ex) {
            writeResultMessage(response.getWriter(), resultMessage + "," + ex.getMessage(), ResultMessage.Fail);
        }
        return mv;
    }
    /**
     * 上传私有数据文件
     *
     * @param request  the request
     * @param response the response
     * @return the add
     * @throws Exception the exception
     */
    @RequestMapping("uploadPrivateFile")
    @Action(description = "上传文件")
    public ModelAndView uploadPrivateFile(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long dataId = RequestUtil.getLong(request, "id");
        ModelAndView mv = this.getAutoView().addObject("dataStructId", dataId);
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
        List<ModelCenterModel> modelCenterModelList = modelCenterService.getByTaskId(taskId);
//        int lenth = dataVersionList.size();
        return getAutoView().addObject("privateData", privateData)
                .addObject("taskInfoList", taskInfoList)
                .addObject("dataVersionList", dataVersionList)
                .addObject("modelCenterModelList", modelCenterModelList);
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
        super.del(request, response, this.privateDataService);
    }


    /**
     * ???????????.
     *
     * @param bin the bin
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
//                    String temp0 = obj.getString("0");
                    privateData.setDdDataType(0);
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
                    if (dataVersionList1 != null) {
                        dataVersion1.setDdDataVersion((long) (dataVersionList1.size() + 1));
                    } else {
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

    @RequestMapping("importBrandSort")
    @Action(description = "导入EXCEL文件")
    public void importBrandSort(@RequestParam("filename") MultipartFile file,
                                HttpServletRequest request, HttpServletResponse response) throws Exception {
        ResultMessage message = null;
        Long taskId = RequestUtil.getLong(request, "id");
        Long projectId = RequestUtil.getLong(request, "projectId");
        String preUrl = RequestUtil.getPrePage(request);
        try {
            String temp = request.getSession().getServletContext()
                    .getRealPath(File.separator)
                    + "temp"; // 临时目录
            File tempFile = new File(temp);
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            DiskFileUpload fu = new DiskFileUpload();
            fu.setSizeMax(10 * 1024 * 1024); // 设置允许用户上传文件大小,单位:位
            fu.setSizeThreshold(4096); // 设置最多只允许在内存中存储的数据,单位:位
            fu.setRepositoryPath(temp); // 设置一旦文件大小超过getSizeThreshold()的值时数据存放在硬盘的目录
            // 开始读取上传信息

            if (file == null)
                return;
            logger.info(file.getOriginalFilename());

            String name = file.getOriginalFilename();// 获取上传文件名,包括路径
            //name = name.substring(name.lastIndexOf("\\") + 1);// 从全路径中提取文件名
            long size = file.getSize();
            if ((name == null || name.equals("")) && size == 0)
                return;
            InputStream in = file.getInputStream();
            int count = privateDataService
                    .importBrandPeriodSort(in, taskId, projectId);
//            int count = BrandMobileInfos.size();

            message = new ResultMessage(ResultMessage.Success, "成功导入" + count + "条");
        } catch (Exception ex) {
            // 改为人工刷新缓存KeyContextManager.clearPeriodCacheData(new
            // PeriodDimensions());// 清理所有缓存
            message = new ResultMessage(ResultMessage.Fail, "导入失败" + ex.getMessage());
        }

        addMessage(message, request);
        response.sendRedirect(preUrl);
    }

    /**
     * 指标编辑、增加
     *
     * @return
     */
    @RequestMapping("lastvalue")
    @Action(description = "指标值刷新")
    public void refreshlastvalue(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            String json = request.getParameter("strJson");
            JSONObject obj = JSONObject.fromObject(json);
            PrivateData privateData = privateDataService.getById(obj.getLong("ddDataId"));
            privateData.setDdDataLastestValue(obj.getString("ddDataLastestValue"));
            privateDataService.update(privateData);
            //更新数据版本
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
            DataVersion dataVersion = new DataVersion();
            dataVersion.setDdDataVersionId(UniqueIdUtil.genId());
            dataVersion.setDdDataId(privateData.getDdDataId());
            dataVersion.setDdDataChangeReason("发布人变更");
            dataVersion.setDdDataRecordPersonId(ContextUtil.getCurrentUserId());
            dataVersion.setDdDataRecordTime(df.format(new Date()));
            dataVersion.setDdDataValue(privateData.getDdDataLastestValue());

            List<DataVersion> dataVersionList1 = dataVersionService.queryDataVersionListByddDataId(privateData.getDdDataId());
            dataVersion.setDdDataVersion((long) (dataVersionList1.size()));

            dataVersionService.addDDDataVersion(dataVersion);
            privateData.setDdDataLastestValue(obj.getString("ddDataLastestValue"));
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }
}
