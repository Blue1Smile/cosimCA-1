package com.casic.datadriver.controller;

import com.casic.datadriver.controller.datacenter.PersonalTaskController;
import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.model.Model;
import com.casic.datadriver.model.modelcenter.ModelCenterModel;
import com.casic.datadriver.service.ModelCenterService;
import com.casic.datadriver.service.model.ModelService;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.util.RequestUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.io.*;

import static com.hotent.core.util.AppUtil.getServletContext;

/**
 * Created by 忠 on 2017/2/28.
 */
@Controller
@RequestMapping("/datadriver/modelcenter/")
public class ModelCenterController {

    @Resource
    private ModelCenterService modelcenterservice;

    @Resource
    private ModelService modelservice;

    @RequestMapping("showtree")
    @Action(description = "模型树形结构显示")
    @ResponseBody
    public String showtree(HttpServletRequest request, HttpServletResponse response) throws Exception {

        List<Model> root = modelservice.findByPid(0);  //获取根节点（获取的值存到list中）
        JSONArray jsonArray = JSONArray.fromObject(buildTree(root));
        //       net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(buildTree(root));
        System.out.println(jsonArray.toString());

        PersonalTaskController Tjson = new PersonalTaskController();
        String t = "";
        t=jsonArray.toString();
        Tjson.formatJson(t);
        return t;
    }

    public List<Model> buildTree(List<Model> root){
        for(int i=0;i<root.size();i++){
            List<Model> children = modelservice.findByPid(root.get(i).getDdModeltypeId()); //查询某节点的子节点（获取的是list）
            buildTree(children);
            root.get(i).setChildren(children);
        }
        return root;

    }

    @RequestMapping("save")
    @Action(description = "保存工具")
    public void  save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Long Modeltype= RequestUtil.getLong(request, "Modeltype");
        Long taskid= RequestUtil.getLong(request, "id");
        String ddModelName= RequestUtil.getString(request, "ddModelName");
        Long ddModelVersion= RequestUtil.getLong(request, "ddModelVersion");
        String ddModelBf= RequestUtil.getString(request, "ddModelBf");
        Long ddModelBf2= RequestUtil.getLong(request, "ddModelBf2");
        String DdModelExplain= RequestUtil.getString(request, "DdModelExplain");

        ModelCenterModel m = new ModelCenterModel();
//        ToolCenterModel ToolData = this.getFormObject(request, ToolCenterModel.class);
        m.setDdTaskId(taskid);
        m.setDdModelName(ddModelName);
        m.setDdModelExplain(DdModelExplain);
        m.setDdModelType(Modeltype);
        m.setDdModelVersion(ddModelVersion);
        m.setDdModelBf2(ddModelBf2);

        //创建一个通用的多部分解析器
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        //判断 request 是否有文件上传,即多部分请求
        if(multipartResolver.isMultipart(request)) {
            //转换成多部分request
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            //取得request中的所有文件名
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                //记录上传过程起始时的时间，用来计算上传时间
                //   int pre = (int) System.currentTimeMillis();
                //取得上传文件
                MultipartFile file1 = multiRequest.getFile(iter.next());

                if (file1 != null) {
                    //取得当前上传文件的文件名称
                    String myFileName = file1.getOriginalFilename();
                    //如果名称不为“”,说明该文件存在，否则说明该文件不存在
                    if (myFileName.trim() != "") {
                        System.out.println(myFileName);
                        //重命名上传后的文件名
                        String fileName = "demoUpload" + file1.getOriginalFilename();
                        //定义上传路径//
                        ////
                        //取得根目录路径
//                        String rootPath=getClass().getResource("/").getFile().toString();

                        ////
                        String realPath = getServletContext().getRealPath("/");
                        String path =realPath+ "/ModelCenter/" + ddModelName + "/" + ddModelVersion +"_"+myFileName;
//                        String path ="d:"+ "/major/" + major + "/" + ddToolVersion +"_"+myFileName;
                        m.setDdModelUrl("/ModelCenter/" + ddModelName + "/" + ddModelVersion +"_"+myFileName);
                        File file = new File(path);
                        //创建目录

                        if (!file.exists() && !file.isDirectory()) {
                            System.out.println("//不存在");
                            file.mkdirs();
                        } else {
                            System.out.println("//目录存在");
                        }
                        File localFile = new File(path);
                        file1.transferTo(localFile);

                    }
                    m.setDdMdoelId(UniqueIdUtil.genId());
//                    m.setDdToolName(myFileName);

                    modelcenterservice.add(m);

//                    response.sendRedirect("toollist1.ht?major="+major);//根据实际情况跳转w
                }
                else {

                }
                //记录上传该文件后的时间
                //    int finaltime = (int) System.currentTimeMillis();
                //     System.out.println(finaltime - pre);
            }
        }

    }


    @RequestMapping("showmodel")
    @Action(description = "模型列表")
    public void querysubmitpublish1(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        request.setCharacterEncoding("UTF-8");
        JSONObject json=new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        String search= new String(RequestUtil.getString(request, "searchText").getBytes("ISO-8859-1"),"UTF-8");


        Long pageSize =RequestUtil.getLong(request, "pageSize");
        Long  pageNumber = RequestUtil.getLong(request, "pageNumber");
        int son= RequestUtil.getInt(request, "son");
        response.setContentType("application/json");
        ModelCenterModel temp;

        PageInfo pageinfo = new PageInfo();

        pageinfo.setBf2(search);
        pageinfo.setPageSize((pageNumber-1)*pageSize);
        pageinfo.setPageNumber(pageSize);
        int Allnum = 0;
        try {
            List<ModelCenterModel> mylist =  new ArrayList<>();
            List<ModelCenterModel> toolList1 =  new ArrayList<>();
//            List<ModelCenterModel> mylist =  new ArrayList<>();
            JSONObject jsonObject = new JSONObject();
            if (son==1){
                long Modeltype= RequestUtil.getLong(request, "Modeltype");
                pageinfo.setId(Modeltype);
                Allnum = this.modelcenterservice.querytoolBymodeltype(Modeltype).size();
                //mylist = this.tservice.querytoolBymajor(major);
                mylist = this.modelcenterservice.querytoolBymodeltypeF(pageinfo);

            }
            else if(son==2){
                Long Modeltype= RequestUtil.getLong(request, "Modeltype");
//                String Modeltype= new String(RequestUtil.getString(request, "Modeltype").getBytes("ISO-8859-1"),"UTF-8");
//                String ModelName= RequestUtil.getString(request, "ModelName");
                String ModelName= new String(RequestUtil.getString(request, "ModelName").getBytes("ISO-8859-1"));
                pageinfo.setId(Modeltype);
                pageinfo.setName(ModelName);
                mylist = this.modelcenterservice.querytoolBymodelname(pageinfo);
            }
            else if(son==3)
            {
                Long id= RequestUtil.getLong(request, "id");
                pageinfo.setId(id);
                Allnum = this.modelcenterservice.querytoolBytaskid(pageinfo).size();
                //mylist = this.tservice.querytoolBymajor(major);
                mylist = this.modelcenterservice.querytoolBytaskidF(pageinfo);
//                Allnum = mylist.size();
            }
            for (int i = 0; i < mylist.size(); i++) {
                ModelCenterModel mymodel = mylist.get(i);
                jsonObject.put("ModelID", mymodel.getDdMdoelId());
                jsonObject.put("ModelName", mymodel.getDdModelName());
                jsonObject.put("ModelUrl", mymodel.getDdModelUrl());
                jsonObject.put("ModelVersion", mymodel.getDdModelVersion());
                jsonObject.put("Modelbz", mymodel.getDdModelExplain());
                jsonObject.put("ModelType", mymodel.getDdModelType());
                jsonMembers.add(jsonObject);
            }
            json.put("total", Allnum);
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
        }catch (Exception e) {
            String resultMsg = null;
//            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
//        return json;
    }


    @RequestMapping("remove")
    @Action(description = "删除模型")
    public void remove(HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        Long id= RequestUtil.getLong(request, "id");
        this.modelcenterservice.delmodel(id);
    }

    @RequestMapping("getmodel")
    @Action(description = "下载模型")
    public void gettool(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        //获取网站部署路径(通过ServletContext对象)，用于确定下载文件位置，从而实现下载
//        String path = servletContext.getRealPath("/");
//        String major= new String(RequestUtil.getString(request, "major").getBytes("ISO-8859-1"));
        String major= new String(RequestUtil.getString(request, "modelurl").getBytes("ISO-8859-1"),"UTF-8");
        String name= new String(RequestUtil.getString(request, "modelname").getBytes("ISO-8859-1"),"UTF-8");
        String path = getServletContext().getRealPath("/");
        try{
            // path是指欲下载的文件的路径。
            File file = new File(path+major);
            // 取得文件名。
            String filename = file.getName();
            // 取得文件的后缀名。
            String ext = filename.substring(filename.lastIndexOf(".") + 1).toUpperCase();

            // 以流的形式下载文件。
            InputStream fis = new BufferedInputStream(new FileInputStream(path+major));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            // 设置response的Header
            response.addHeader("Content-Disposition", "attachment;filename=" + new String(filename.getBytes()));
            response.addHeader("Content-Length", "" + file.length());
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            response.setContentType("application/octet-stream");
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
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
}
