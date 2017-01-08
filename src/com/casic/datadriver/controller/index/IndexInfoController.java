package com.casic.datadriver.controller.index;

import com.casic.datadriver.model.index.IndexInfo;
import com.casic.datadriver.service.index.IndexService;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.controller.BaseController;
import com.hotent.core.web.util.RequestUtil;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2016/11/18 0018.
 */


@Controller
@RequestMapping("/datadriver/index/")
public class IndexInfoController extends BaseController {


    @Resource
    private IndexService indexService;

//    @Resource
//    private IndexVersionService indexVersionService;

    /**
     * 指标保存
     *
     * @return
     */
    @RequestMapping("save")
    @Action(description = "保存指标")
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;

        IndexInfo index = getFormObject(request);
        System.out.println(index.getDdIndexName() + ":" + index.getDdIndexId());
        try {
            if (index.getDdIndexId() == null || index.getDdIndexId() == 0) {
                index.setDdIndexId(UniqueIdUtil.genId());
                indexService.addDDIndex(index);

                resultMsg = getText("record.added", "指标信息");
            } else {
                indexService.update(index);
                resultMsg = getText("record.updated", "指标信息");
            }
            writeResultMessage(response.getWriter(), resultMsg, ResultMessage.Success);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }


    /**
     * @param request
     * @return
     * @throws Exception
     */
    protected IndexInfo getFormObject(HttpServletRequest request) throws Exception {

        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[]{"yyyy-MM-dd"})));

        String json = RequestUtil.getString(request, "json");
        JSONObject obj = JSONObject.fromObject(json);

        IndexInfo index = (IndexInfo) JSONObject.toBean(obj, IndexInfo.class);

        return index;
    }

    /**
     * 指标编辑、增加
     *
     * @return
     */
    @RequestMapping("indexedit")
    @Action(description = "指标编辑或者增加")
    public ModelAndView indexedit(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String resultMsg = null;
        try {
            IndexInfo indexInfo = new IndexInfo();
            String returnUrl = RequestUtil.getPrePage(request);
            Long projectId = RequestUtil.getLong(request, "id");
            List<IndexInfo> indexInfoList = new ArrayList<IndexInfo>();
            indexInfoList = indexService.getByProjectId(projectId);
            for (int i = 0; i > indexInfoList.size(); i++) {
                indexInfo = indexInfoList.get(i);
            }
            return getAutoView().addObject("projectId", projectId)
                    .addObject("indexInfo", indexInfo)
                    .addObject("returnUrl", returnUrl);
        } catch (Exception e) {
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
            return null;
        }
    }
}
