package com.casic.datadriver.controller.datacenter;


import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.data.*;
import com.casic.datadriver.model.project.Project;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.service.data.*;
import com.casic.datadriver.service.project.ProjectService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.casic.datadriver.service.task.TaskStartService;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.util.RequestUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author 2016/11/14 0014.
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
    @Resource
    private DataSnapInfoIdService dataSnapInfoIdService;

    /**
     * 2016/12/19/修改
     * 取得项目树
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("list")
    public ModelAndView queryProjectBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        List<Project> AllProjectList = projectService.getAll();

        List<Project> tempProjectList = new ArrayList<>();
        for (int i = 0; i < AllProjectList.size(); i++) {
            if (AllProjectList.get(i).getDdProjectCreatorId().equals(ContextUtil.getCurrentUser().getUserId())) {


                tempProjectList.add(AllProjectList.get(i));
            } else {
                List<TaskInfo> taskInfoList = taskInfoService.queryTaskInfoByProjectId(AllProjectList.get(i).getDdProjectId());
                for (int j = 0; j < taskInfoList.size(); j++) {
                    if (taskInfoList.get(j).getDdTaskResponsiblePerson() == null) {

                    } else if (taskInfoList.get(j).getDdTaskResponsiblePerson().equals(ContextUtil.getCurrentUser().getUserId())) {
                        tempProjectList.add(AllProjectList.get(i));
                    }
                }
            }
        }
        List<Project> ProjectList = removeDuplicate(tempProjectList);

        int ProjectLength = ProjectList.size();
        Long[] ProjectId = new Long[ProjectLength];
        String[] ProjectName = new String[ProjectLength];
        int allLength = 0;
        int[] TaskLength = new int[ProjectList.size()];
        List<TaskInfo> allTaskInfo = new ArrayList<>();
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
            allTaskName[i] = replaceBlank(TaskInfo.getDdTaskName());
        }
        ModelAndView mv = this.getAutoView().addObject("ProjectId", ProjectId)
                .addObject("ProjectName", ProjectName).addObject("ProjectLength", ProjectLength)
                .addObject("allTaskInfoName", allTaskName)
                .addObject("allTaskInfoId", allTaskId)
                .addObject("TaskLength", TaskLength);
        return mv;
    }

    //过滤重复元素
    public static List<Project> removeDuplicate(List<Project> mList) {
        for (int i = 0; i < mList.size() - 1; i++) {
            for (int j = mList.size() - 1; j > i; j--) {
                if (mList.get(j).getDdProjectId().equals(mList.get(i).getDdProjectId())) {
                    mList.remove(j);
                }
            }
        }
        return mList;
    }
    public static String replaceBlank(String str) {
        String dest = "";
        if (str!=null) {
            Pattern p = Pattern.compile("\\s*|\t|\r|\n");
            Matcher m = p.matcher(str);
            dest = m.replaceAll("");
        }
        return dest;
    }
    /**
     * 2017/02/18/修改
     * 返回任务发布订购数据列表
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("publishorderdata")
    @Action(description = "返回到发布订阅页面")
    public ModelAndView publishorderdata(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long taskId = RequestUtil.getLong(request, "id");

//        List<OrderDataRelation> publishDataRelationList = orderDataRelationService.getPublishDataRelationList(taskId);
//        List<OrderDataRelation> orderDataRelationList = orderDataRelationService.getPublishDataRelationList(taskId);
        ModelAndView mv = this.getAutoView().addObject("taskId",
                taskId);
        return mv;
    }

    /**
     * 排序
     */

    class desc implements Comparator<OrderDataRelation> {
        @Override
        public int compare(OrderDataRelation u1, OrderDataRelation u2) {
            return -(u1.getDdDataName().compareTo(u2.getDdDataName()));
        }
    }

    class asc implements Comparator<OrderDataRelation> {
        @Override
        public int compare(OrderDataRelation u1, OrderDataRelation u2) {
            return u1.getDdDataName().compareTo(u2.getDdDataName());
        }
    }


    @RequestMapping("getReleasedatanew")
    @Action(description = "获得发布数据列表")
    public void getReleasedatanew(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String B = RequestUtil.getString(request, "DataType");
//        String  DataType= RequestUtil.getString(request, "DataType");
        String A = RequestUtil.getString(request, "sortOrder");
        Long ddTaskId = RequestUtil.getLong(request, "id");
        Long pageSize = RequestUtil.getLong(request, "pageSize");
        Long pageNumber = RequestUtil.getLong(request, "pageNumber");
        Long a = pageSize * (pageNumber - 1);
        Long b = pageSize * (pageNumber);

        int DataTypenum = RequestUtil.getInt(request, "DataTypenum");
        String search = new String(RequestUtil.getString(request, "searchText").getBytes("ISO-8859-1"), "UTF-8");
        String DataType = "";
        switch (DataTypenum) {
            case 1:
                DataType = "模型";
                break;
            case 2:
                DataType = "文件";
                break;
            case 3:
                DataType = "结构型数据";
                break;
            case 4:
                DataType = "";
                break;
        }


        PageInfo pageinfo = new PageInfo();
        pageinfo.setId(ddTaskId);
        pageinfo.setBf2(DataType);

        JSONObject jsonObject = new JSONObject();
        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();


        List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.getPublishDataRelationList(ddTaskId);

        List<PrivateData> taskPrivateDatas = null;
        int allnum = 0;

//        if (A.compareTo("desc")==0) {
//            //desc 降序
//            Comparator<OrderDataRelation> cmp = new desc();
//            Collections.sort(orderDataRelation_list, cmp);
//        }
//        else if(A.compareTo("asc")==0){ //asc 升序
//            Comparator<OrderDataRelation> cmp = new asc();
//            Collections.sort(orderDataRelation_list, cmp);
//            }


        if (DataType == null || DataType.length() <= 0) {
//            taskPrivateDatas = this.privateDataService.queryPrivateDataByddTaskID(ddTaskId);
            allnum = taskPrivateDatas.size();
        } else {
//            taskPrivateDatas = this.privateDataService.getBymodel(pageinfo);
            allnum = taskPrivateDatas.size();
        }
        if (b > taskPrivateDatas.size()) {
            b = Long.valueOf(taskPrivateDatas.size());
        }
//        for (int h = Math.toIntExact(a);h<b;h++){
//            Long ddDataId=orderDataRelation_list.get(h).getDdDataId();
//            pageinfo.setId(ddDataId);
//            if (DataType == null || DataType.length() <= 0) {
//                taskPrivateDatas = this.privateDataService.getByddDataId(ddDataId);
//                allnum=  this.orderDataRelationService.getPublishDataRelationList(ddTaskId).size();
//            }
//            else {
//                taskPrivateDatas = this.privateDataService.getBymodel(pageinfo);
//                allnum = taskPrivateDatas.size();
//            }

        for (int i = Math.toIntExact(a); i < b; i++) {
            PrivateData mymode = taskPrivateDatas.get(i);
            jsonObject.put("DdDataName", mymode.getDdDataName());
            jsonObject.put("DdDataLastestValue", mymode.getDdDataLastestValue());
            switch (mymode.getDdDataType()) {
                case 1:
                    DataType = "结构型数据";
                    break;
                case 2:
                    DataType = "文件";
                    break;
                case 3:
                    DataType = "模型";
                    break;
                case 4:
                    DataType = "";
                    break;
            }
            jsonObject.put("DdDataType",DataType);
            jsonObject.put("DdDataPath",mymode.getDdDataPath());
            jsonObject.put("DdDataCreateTime", mymode.getDdDataCreateTime());
            jsonObject.put("DdDataDescription", mymode.getDdDataDescription());
            jsonObject.put("DdDataId", mymode.getDdDataId());
            jsonMembers.add(jsonObject);
        }
//        }

        json.put("total", allnum);
        json.put("rows", jsonMembers);
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
//            system.out(json.toString());
        PrintWriter out = null;
        out = response.getWriter();
        out.append(jsonstring);
        out.flush();
        out.close();

    }

    /**
     * 分页函数
     * by 杜
     * 数据库分页
     */
    private PageInfo pagination(Long pageSize, Long pageNumber, Long id) {
        PageInfo pageInfo = new PageInfo();
        pageInfo.setPageSize((pageNumber - 1) * pageSize);
        pageInfo.setPageNumber(pageSize);
        pageInfo.setId(id);
        return pageInfo;
    }

    @RequestMapping("getReleasedata")
    @Action(description = "获得发布数据列表")
    public void getOrderdata(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String A = RequestUtil.getString(request, "sortName");
        Long ddTaskId = RequestUtil.getLong(request, "id");
        Long pageSize = RequestUtil.getLong(request, "pageSize");
        Long pageNumber = RequestUtil.getLong(request, "pageNumber");
//        PageInfo pageinfo = new PageInfo();
//        pageinfo.setPageSize((pageNumber - 1) * pageSize);
//        pageinfo.setPageNumber(pageSize);
//        pageinfo.setId(ddTaskId);

        PageInfo pageinfo = pagination(pageSize, pageNumber, ddTaskId);
//        var db = new QHC_IIMSContext();
        //获得发布数据列表
        List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.getPublishDataRelationListF(pageinfo);
//        List<OrderDataRelation>  orderDataRelation_list =  this.orderDataRelationService.getPublishDataRelationList(ddTaskId);
        List<PrivateData> privateData = new ArrayList<PrivateData>();
        int allnum = this.orderDataRelationService.getPublishDataRelationList(ddTaskId).size();
        JSONObject jsonObject = new JSONObject();
        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();

        for (OrderDataRelation orderDataRelation : orderDataRelation_list) {
            Long ddDataId = orderDataRelation.getDdDataId();
            List<PrivateData> taskPrivateDatas = null;
//            List<PrivateData> taskPrivateDatas = this.privateDataService.getByddDataId(ddDataId);

            for (int i = 0; i < taskPrivateDatas.size(); i++) {
                PrivateData mymode = taskPrivateDatas.get(i);
                jsonObject.put("DdDataName", mymode.getDdDataName());
                jsonObject.put("DdDataLastestValue", mymode.getDdDataLastestValue());
                jsonObject.put("DdDataType", mymode.getDdDataType());
                jsonObject.put("DdDataCreateTime", mymode.getDdDataCreateTime());
                jsonObject.put("DdDataDescription", mymode.getDdDataDescription());
                jsonObject.put("DdDataId", mymode.getDdDataId());
                jsonMembers.add(jsonObject);
            }
        }
        json.put("total", allnum);
        json.put("rows", jsonMembers);
//        String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
//            system.out(json.toString());
        PrintWriter out = null;
        out = response.getWriter();
        out.append(jsonstring);
        out.flush();
        out.close();
    }

    @RequestMapping("getOrderdata")
    @Action(description = "获得订购数据列表")
    public void getReleasedata(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddTaskId = RequestUtil.getLong(request, "id");
        //获得订购数据列表
        Long pageSize = RequestUtil.getLong(request, "pageSize");
        Long pageNumber = RequestUtil.getLong(request, "pageNumber");
        PageInfo pageinfo = new PageInfo();
        pageinfo.setPageSize((pageNumber - 1) * pageSize);
        pageinfo.setPageNumber((pageNumber - 1) * pageSize + pageSize);
        pageinfo.setId(ddTaskId);

        List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.getOrderDataRelationListF(pageinfo);
//        List<OrderDataRelation> orderDataRelation_list = this.orderDataRelationService.getOrderDataRelationList(ddTaskId);
        List<PrivateData> privateData = new ArrayList<PrivateData>();

        JSONObject jsonObject = new JSONObject();
        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();

        for (OrderDataRelation orderDataRelation : orderDataRelation_list) {
            Long ddDataId = orderDataRelation.getDdDataId();
//            List<PrivateData> taskPrivateDatas = this.privateDataService.getByddDataId(ddDataId);
            List<PrivateData> taskPrivateDatas = null;

            for (int i = 0; i < taskPrivateDatas.size(); i++) {
                PrivateData mymodel = taskPrivateDatas.get(i);
                jsonObject.put("DdDataName", mymodel.getDdDataName());
                jsonObject.put("DdDataLastestValue", mymodel.getDdDataLastestValue());
                jsonObject.put("DdDataType", mymodel.getDdDataType());
                jsonObject.put("DdDataCreateTime", mymodel.getDdDataCreateTime());
                jsonObject.put("DdDataDescription", mymodel.getDdDataDescription());
                jsonObject.put("DdDataId", mymodel.getDdDataId());
                jsonMembers.add(jsonObject);
            }
        }
        json.put("total", orderDataRelation_list.size());
        json.put("rows", jsonMembers);
//        String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
        String jsonstring = formatJson(json.toString());
        System.out.println(json.toString());
//            system.out(json.toString());
        PrintWriter out = null;
        out = response.getWriter();
        out.append(jsonstring);
        out.flush();
        out.close();
//            privateData.addAll(taskPrivateDatas);


//        ModelAndView mv = this.getAutoView().addObject("privateDataList_publish",
//                privateData).addObject("privateDataList_order", privateData2);
        //  return mv;
    }

    //格式化json
    public static String formatJson(String jsonStr) {
        if (null == jsonStr || "".equals(jsonStr)) return "";
        StringBuilder sb = new StringBuilder();
        char last = '\0';
        char current = '\0';
        int indent = 0;
        for (int i = 0; i < jsonStr.length(); i++) {
            last = current;
            current = jsonStr.charAt(i);
            switch (current) {
                case '{':
                case '[':
                    sb.append(current);
                    sb.append('\n');
                    indent++;
                    addIndentBlank(sb, indent);
                    break;
                case '}':
                case ']':
                    sb.append('\n');
                    indent--;
                    addIndentBlank(sb, indent);
                    sb.append(current);
                    break;
                case ',':
                    sb.append(current);
                    if (last != '\\') {
                        sb.append('\n');
                        addIndentBlank(sb, indent);
                    }
                    break;
                default:
                    sb.append(current);
            }
        }

        return sb.toString();
    }

    //添加空格
    private static void addIndentBlank(StringBuilder sb, int indent) {
        for (int i = 0; i < indent; i++) {
            sb.append('\t');
        }
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
//        Long ddDataId = RequestUtil.getLong(request, "id");
//
//        List<DataVersion> dataVersion_list = this.dataVersionService.queryDataVersionListByddDataId(ddDataId);
//        Integer DataType = privateDataService.getByddDataId(ddDataId).get(0).getDdDataType();
//        Long DataTaskId = privateDataService.getDataById(ddDataId).getDdDataTaskId();
//        JSONObject jsonObject = new JSONObject();
//        JSONObject json = new JSONObject();
//        JSONArray jsonMembers = new JSONArray();
//
//        for (int i = 0; i < dataVersion_list.size(); i++) {
//            DataVersion mymodel = dataVersion_list.get(i);
//            jsonObject.put("DdDataVersion", mymodel.getDdDataVersion());
//            jsonObject.put("ddDataRecordTime", mymodel.getDdDataRecordTime());
//            jsonObject.put("ddDataValue", mymodel.getDdDataValue());
//            jsonObject.put("DataType", DataType);
//            jsonMembers.add(jsonObject);
//        }
//
//        json.put("total", dataVersion_list.size());
//        json.put("rows", jsonMembers);
////        String jsonstring = "{\n\"total\":800,\n\"rows\":[\n{\n\"id\":0,\n\"name\":\"Item 0\",\n\"price\":\"$0\"\n},\n{\n\"id\":19,\n\"name\":\"Item 19\",\n\"price\":\"$19\"\n}\n]\n}";
//        String jsonstring = formatJson(json.toString());
//        System.out.println(json.toString());
////            system.out(json.toString());
//        PrintWriter out = null;
//        out = response.getWriter();
//        out.append(jsonstring);
//        out.flush();
//        out.close();
////        List<PrivateData> privateData = new ArrayList<PrivateData>();
//        ModelAndView mv = this.getAutoView().addObject("dataVersionList", dataVersion_list);
        return null;
    }


    /**
     * 项目快照
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("datasnapshot")
    @Action(description = "私有数据数据快照")
    public void datasnapshot(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String preUrl = RequestUtil.getPrePage(request);
        Long projectId = RequestUtil.getLong(request, "projectId");
//        String ddDataTag = RequestUtil.getString(request, "ddDataTag");
        DataSnapInfoId dataSnapInfoId = new DataSnapInfoId();

        dataSnapInfoId.setDdDataSnapShotId(UniqueIdUtil.genId());
        dataSnapInfoId.setDdSnapShotPersonId(ContextUtil.getCurrentUser().getUserId());

        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = formatter.format(currentTime);
        dataSnapInfoId.setDdSnapShotTime(dateString);

        dataSnapInfoId.setDdProjectId(projectId);

        dataSnapInfoIdService.add(dataSnapInfoId);
        List<TaskInfo> taskInfoList = taskInfoService.queryTaskInfoByProjectId(projectId);
        for (int i = 0; i < taskInfoList.size(); i++) {
//            List<PrivateData> privateDataList = privateDataService.queryPrivateDataByddTaskID(taskInfoList.get(i).getDdTaskId());
            List<PrivateData> privateDataList =null;
            for (int j = 0; j < privateDataList.size(); j++) {
                DataSnapshot dataSnapshot = new DataSnapshot();

                dataSnapshot.setDdDataSnapshotId(UniqueIdUtil.genId());
                dataSnapshot.setDdDataId(privateDataList.get(j).getDdDataId());
                dataSnapshot.setDdDataValue(privateDataList.get(j).getDdDataLastestValue());
                dataSnapshot.setDdSnapshotTime(dateString);

                dataSnapshotService.add(dataSnapshot);
            }
        }
        response.sendRedirect(preUrl);
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
        Long ddTaskId = RequestUtil.getLong(request, "ddTaskId");
        String ddSnapShotTime = RequestUtil.getString(request, "ddSnapShotTime");
//        List<PrivateData> privateDataList = this.privateDataService.queryPrivateDataByddTaskID(ddTaskId);
        List<PrivateData> privateDataList = null;
        List<DataSnapshot> dataSnapshotList = new ArrayList<DataSnapshot>();
        for (int i = 0; i < privateDataList.size(); i++) {
            List<DataSnapshot> privateDataSnapshotList = dataSnapshotService.getByddDataId(privateDataList.get(i).getDdDataId());
            for (int j = 0; j < privateDataSnapshotList.size(); j++) {
                String time = privateDataSnapshotList.get(j).getDdSnapshotTime();
                if (time.equals(ddSnapShotTime)) {
                    dataSnapshotList.add(privateDataSnapshotList.get(j));
                }
            }

        }
        ModelAndView mv = this.getAutoView().addObject("dataSnapshotList",
                dataSnapshotList);
        return mv;
    }


    /**
     * ?????????.
     *
     * @param request  the request
     * @param response the response
     * @throws Exception the exception
     */
    @RequestMapping("showdatashot")
    @Action(description = "查看数据快照")
    public ModelAndView showdatashot(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;


        Long ddDataSnapshotId = RequestUtil.getLong(request, "ddDataSnapshotId");
        DataSnapshot dataSnapshot = dataSnapshotService.getById(ddDataSnapshotId);
        Long ddDataId = dataSnapshot.getDdDataId();
        PrivateData privateData = privateDataService.getById(ddDataId);

        DataShot dataShot = new DataShot();
//        dataShot.setDdDataCreatePerson(privateData.getDdDataCreatePerson());
//        dataShot.setDdDataCreateTime(privateData.getDdDataCreateTime());
//        dataShot.setDdDataDescription(privateData.getDdDataDescription());
//        dataShot.setDdDataId(privateData.getDdDataId());
//        dataShot.setDdDataName(privateData.getDdDataName());
//        dataShot.setDdDataIsDelivery(privateData.getDdDataIsDelivery());
//        dataShot.setDdDataPublishType(privateData.getDdDataPublishType());
//        dataShot.setDdDataSensitiveness(privateData.getDdDataSensitiveness());
//        dataShot.setDdDataSnapShotId(dataSnapshot.getDdDataSnapshotId());
//        dataShot.setDdDataCreateTime(privateData.getDdDataCreateTime());
//        dataShot.setDdDataSubmiteState(privateData.getDdDataSubmiteState());
//        dataShot.setDdDataTaskName(privateData.getDdDataTaskName());
//        dataShot.setDdDataType(privateData.getDdDataType());
        dataShot.setDdSnapshotPersonId(dataSnapshot.getDdSnapshotPersonId());
        dataShot.setDdDataValue(dataSnapshot.getDdDataValue());
        dataShot.setDdDataTag(dataSnapshot.getDdDataTag());
        dataShot.setDdSnapshotTime(dataSnapshot.getDdSnapshotTime());

        ModelAndView mv = this.getAutoView().addObject("dataShot", dataShot);
        return mv;

    }

    /**
     * 数据快照列表.
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("snapshotlist")
    @Action(description = "返回所有快照列表")
    public ModelAndView snapshotlist(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
//        QueryFilter queryFilter = new QueryFilter(request, "ProjectItem");
        List<DataSnapInfoId> dataSnapInfoIdList = this.dataSnapInfoIdService.getAll();

        ModelAndView mv = this.getAutoView().addObject("snapshotList",
                dataSnapInfoIdList);
        return mv;
    }

    /**
     * 数据快照列表.
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("snapshottasklist")
    @Action(description = "返回查看项目的任务列表")
    public ModelAndView snapshottasklist(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long ddDataSnapShotId = RequestUtil.getLong(request, "ddDataSnapShotId");

        DataSnapInfoId dataSnapInfoId = dataSnapInfoIdService.getById(ddDataSnapShotId);

        List<TaskInfo> taskInfoList = taskInfoService.queryTaskInfoByProjectId(dataSnapInfoId.getDdProjectId());
        ModelAndView mv = this.getAutoView().addObject("snapshotTaskList",
                taskInfoList).addObject("ddSnapShotTime", dataSnapInfoId.getDdSnapShotTime());
        return mv;
    }

    /**
     * 项目数据订阅关系.
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("proorderrelation")
    @Action(description = "返回查看项目的任务列表")
    public ModelAndView proorderrelation(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long projectId = RequestUtil.getLong(request, "id");
        ModelAndView mv = this.getAutoView().addObject("projectId", projectId);
        return mv;
    }


}
