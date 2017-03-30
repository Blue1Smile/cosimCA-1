package com.casic.datadriver.controller.data;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.casic.datadriver.model.data.PrivateData;
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
import com.casic.datadriver.model.data.DataStruct;
import com.casic.datadriver.service.data.DataStructService;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.query.QueryFilter;
import com.hotent.core.web.util.RequestUtil;

/**
 *
 * @author 2016/11/14 0014.
 */
@Controller
@RequestMapping("/datadriver/data/")
public class DataStructController extends AbstractController {

    /** The dataStruct service. */
    @Resource
    private DataStructService dataStructService;

    /**
     * 添加结构化数据、文件、模型.
     *
     * @param request
     *            the request
     * @param response
     *            the response
     * @throws Exception
     *             the exception
     */
    @RequestMapping("save")
    @Action(description = "添加dataStruct")
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;
        DataStruct dataStruct = getFormObject(request);
//        try {
//            if (dataStruct.getDdStructId() != null || dataStruct.getDdStructId() != 0) {
//                dataStruct.setDdStructId((int) UniqueIdUtil.genId());
//                dataStructService.addDDDataStruct(dataStruct);
//                resultMsg = getText("record.added", "cloud_account_info");
//            } else {
//                dataStructService.update(dataStruct);
//                resultMsg = getText("record.updated", "cloud_account_info");
//            }
//            writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
//        } catch (Exception e) {
//            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
//        }
    }

    private DataStruct getFormObject(HttpServletRequest request) throws Exception {
        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[]{"yyyy-MM-dd"})));

        String json = RequestUtil.getString(request, "json");
        JSONObject obj = JSONObject.fromObject(json);

        Map<String, Class> map = new HashMap<String, Class>();
        map.put("privateDataList", PrivateData.class);
        DataStruct dataStruct = (DataStruct) JSONObject.toBean(obj, DataStruct.class, map);

        return dataStruct;
    }
    /**
     * Query dataStruct basic info list.
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
    @Action(description = "����������ѯ��Ŀ������Ϣ�б�")
    public ModelAndView queryDataStructBasicInfoList(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        QueryFilter queryFilter = new QueryFilter(request, "DataStructItem");
        ModelAndView mv = this.getAutoView().addObject("dataStructList",
                this.dataStructService.queryDataStructBasicInfoList(queryFilter));
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
        super.del(request, response, this.dataStructService);
    }

    /**
     *
     * @param bin
     *            the bin
     */
    @InitBinder
    public void initBinder(ServletRequestDataBinder bin) {
        bin.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
    }
}
