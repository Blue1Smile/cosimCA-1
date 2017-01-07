package com.casic.datadriver.controller.flow;

import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.flow.ProcessFlow;
import com.casic.datadriver.model.task.ProTaskDependance;
import com.casic.datadriver.model.task.TaskInfo;
import com.casic.datadriver.service.task.ProTaskDependanceService;
import com.casic.datadriver.service.task.TaskInfoService;
import com.casic.datadriver.service.flow.ProcessFlowService;
import com.hotent.core.annotion.Action;
import com.hotent.core.bpmn20.entity.Process;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.core.web.util.RequestUtil;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.jdom.output.Format;
import org.jdom.output.XMLOutputter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Reader;
import java.io.StringReader;
import java.net.URLDecoder;
import java.util.Iterator;

/**
 * Created by dodo on 2016/12/27.
 */
@Controller
@RequestMapping("/datadriver/designflow/")
public class ProcessFlowController extends AbstractController {

    @Resource
    private ProcessFlowService processFlowService;
    @Resource
    private TaskInfoService taskInfoService;
    @Resource
    private ProTaskDependanceService proTaskDependanceService;
    /**
     * 进入流程iframe.
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @return the list
     * @throws Exception
     *             the exception
     */
    @RequestMapping("flowframe")
    @Action(description = "根据项目进入流程设计iframe")
    public ModelAndView flowframe(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long projectId = RequestUtil.getLong(request, "id");
        ModelAndView mv = this.getAutoView().addObject("projectId", projectId);
//        ModelAndView mv = new ModelAndView("redirect:projectflow.ht?id="+projectId);
        return mv;
    }

    /**
     * 进入流程设计页面.
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @return the list
     * @throws Exception
     *             the exception
     */
    @RequestMapping("projectflow")
    @Action(description = "流程设计")
    public ModelAndView projectflow(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long projectId = RequestUtil.getLong(request, "id");

        ModelAndView mv = this.getAutoView().addObject("projectId", projectId);
        return mv;
    }


    @RequestMapping("DataSave_zx")
    @Action(description = "根据项目进入流程设计iframe")
    public void DataSave_zx(HttpServletRequest request, HttpServletResponse response) throws Exception {

        request.setCharacterEncoding("utf-8");
        //	String test = URLDecoder.decode(request.getParameter("xml"), "UTF-8").replaceAll("&#xa;", "");
        String test = URLDecoder.decode(request.getParameter("xml"), "UTF-8").replaceAll("\n", "");
        //String xml = (String) request.getParameter("xml");
        System.out.println(test);
        Reader in = new StringReader(test);
        Document doc = (new SAXBuilder()).build(in);

        Element mxGraphmodel =doc.getRootElement();
        Element root = mxGraphmodel.getChild("root");
        //String projectID = root.getChild("Layer").getAttributeValue("projectID");
        java.util.List task = root.getChildren("Task");
        String projectID = root.getChild("Layer").getAttributeValue("projectId");
        long projectId = Long.parseLong(projectID);
        for(Iterator i = task.iterator(); i.hasNext();)
        {
            TaskInfo taskInfo = new TaskInfo();


            Element el = (Element) i.next();
            String tasktype = el.getAttributeValue("任务类型");
            String taskdesp = el.getAttributeValue("任务描述");
            String taskid = el.getAttributeValue("oracleid");
            //考虑null的情况
            if(taskdesp!=null)
                taskInfo.setDdTaskDescription(taskdesp);
            if(tasktype!=null)
                taskInfo.setDdTaskType(tasktype);
            taskInfo.setDdTaskProjectId(projectId);
            taskInfo.setDdTaskName(el.getAttributeValue("label"));//任务名称

            if(taskid!=null) {
                taskInfo.setDdTaskId(Long.parseLong(taskid));
            }
            ProTaskDependance proTaskDependance = new ProTaskDependance();
            proTaskDependance.setDdProjectId(taskInfo.getDdTaskProjectId());
            try {
                if (taskInfo.getDdTaskId() == null || taskInfo.getDdTaskId() == 0) {
                    taskInfo.setDdTaskId(UniqueIdUtil.genId());
                    taskInfoService.addDDTask(taskInfo);
                    proTaskDependance.setDdTaskId(UniqueIdUtil.genId());
                    proTaskDependance.setDdTaskId(taskInfo.getDdTaskId());
                    proTaskDependanceService.addDDProTaskDependance(proTaskDependance);
                    //resultMsg = getText("record.added", "添加完成");
                } else {
                    taskInfoService.updateDDTask(taskInfo);
                    //resultMsg = getText("record.updated", "更新完成");
                }
            }
            catch (Exception e) {
                writeResultMessage(response.getWriter(),   e.getMessage(), ResultMessage.Fail);
            }

            el.setAttribute("oracleid",taskInfo.getDdTaskId().toString());
            System.out.println(taskInfo.getDdTaskId().toString());
        }
            //System.out.println(el.getAttribute("label"));
        Format format = Format.getCompactFormat();
        format.setEncoding("utf-8");
        format.setIndent(" ");
        XMLOutputter xmlOutputter = new XMLOutputter();
        java.io.StringWriter a =new java.io.StringWriter();
        xmlOutputter.output(doc,a);
        String str = a.toString();
//      需要保存xml 变量str就是xml
        ProcessFlow processflow = new ProcessFlow();
        processflow.setDdProcessId(UniqueIdUtil.genId());
        processflow.setDdProcessXml(str);


//        processFlowService.add(processflow);


        System.out.println(doc.toString());

        System.out.println(str);



    }

}
