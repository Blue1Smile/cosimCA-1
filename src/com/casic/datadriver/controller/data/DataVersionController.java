package com.casic.datadriver.controller.data;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.casic.datadriver.controller.AbstractController;
import com.casic.datadriver.model.data.DataVersion;
import com.casic.datadriver.service.data.DataVersionService;
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
@RequestMapping("/datadriver/dataVersion/")
public class DataVersionController extends AbstractController {

    /** The dataVersion service. */
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
    @Action(description = "添加或更新dataVersion")
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;
        DataVersion dataVersion = this.getFormObject(request, DataVersion.class);
        try {
            if (dataVersion.getDdDataVersionId() != null || dataVersion.getDdDataVersionId() != 0) {
                dataVersion.setDdDataVersionId((int) UniqueIdUtil.genId());
                dataVersionService.addDDDataVersion(dataVersion);
                resultMsg = getText("record.added", "cloud_account_info");
            } else {
                dataVersionService.update(dataVersion);
                resultMsg = getText("record.updated", "cloud_account_info");
            }
            writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * Query dataVersion basic info list.
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
    @Action(description = "根据条件查询项目基本信息列表")
    public ModelAndView queryDataVersionBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        QueryFilter queryFilter = new QueryFilter(request, "DataVersionItem");
        ModelAndView mv = this.getAutoView().addObject("dataVersionList",
                this.dataVersionService.queryDataVersionBasicInfoList(queryFilter));
        return mv;
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
        super.del(request, response, this.dataVersionService);
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
