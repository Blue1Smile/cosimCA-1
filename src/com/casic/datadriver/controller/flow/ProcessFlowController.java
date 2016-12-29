package com.casic.datadriver.controller.flow;

import com.casic.datadriver.controller.AbstractController;
import com.hotent.core.annotion.Action;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.core.web.util.RequestUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by dodo on 2016/12/27.
 */
@Controller
@RequestMapping("/datadriver/designflow/")
public class ProcessFlowController extends AbstractController {
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

}
