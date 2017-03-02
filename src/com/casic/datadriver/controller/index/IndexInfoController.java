package com.casic.datadriver.controller.index;

import com.casic.datadriver.model.PageInfo;
import com.casic.datadriver.model.index.IndexInfo;
import com.casic.datadriver.service.index.IndexService;
import com.hotent.core.annotion.Action;
import com.hotent.core.util.ContextUtil;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.controller.BaseController;
import com.hotent.core.web.util.RequestUtil;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
     * 查询index列表
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("indexlist")
    @Action(description = "根据条件查询指标基本信息列表")
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Long projectId = RequestUtil.getLong(request, "id");
//        List<IndexInfo> indexInfoList = indexService.getByProjectId(projectId);

        ModelAndView mv = this.getAutoView().addObject("projectId",
                projectId);
        return mv;
    }

    /**
     * 查询index列表
     *
     * @param request  the request
     * @param response the response
     * @return the list
     * @throws Exception the exception
     */
    @RequestMapping("indexjson")
    @Action(description = "指标table")
    public void indexjson(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        JSONObject json = new JSONObject();
        JSONArray jsonMembers = new JSONArray();
        Long pageSize = RequestUtil.getLong(request, "pageSize");
        Long pageNumber = RequestUtil.getLong(request, "pageNumber");

        PageInfo pageinfo = new PageInfo();

        pageinfo.setPageSize((pageNumber - 1) * pageSize);
        pageinfo.setPageNumber(pageSize);

        response.setContentType("application/json");

        try {
            Long projectId = RequestUtil.getLong(request, "id");
            pageinfo.setId(projectId);
            int allnum = this.indexService.getByProjectId(projectId).size();
            List<IndexInfo> indexInfoList = this.indexService.getByProjectIdF(pageinfo);
            JSONObject jsonObject = new JSONObject();
            for (int i = 0; i < indexInfoList.size(); i++) {
                IndexInfo orderDataRelation = indexInfoList.get(i);

                jsonObject.put("ddIndexLastestValue", orderDataRelation.getDdIndexLastestValue());
                jsonObject.put("ddIndexId", orderDataRelation.getDdIndexId());
                jsonObject.put("ddIndexName", orderDataRelation.getDdIndexName());
                jsonObject.put("ddIndexOptimum", orderDataRelation.getDdIndexOptimum());
                jsonObject.put("ddIndexProjectId", orderDataRelation.getDdIndexProjectId());
                jsonObject.put("ddIndexProperty", orderDataRelation.getDdIndexProperty());
                jsonObject.put("ddIndexResponsiblePersonId", orderDataRelation.getDdIndexResponsiblePersonId());
                jsonObject.put("ddIndexSensitiveness", orderDataRelation.getDdIndexSensitiveness());
                jsonObject.put("ddIndexTypeId", orderDataRelation.getDdIndexTypeId());
                jsonMembers.add(jsonObject);
            }
            json.put("total", allnum);
            json.put("rows", jsonMembers);
            String jsonstring = formatJson(json.toString());
            PrintWriter out = null;
            out = response.getWriter();
            out.append(jsonstring);
            out.flush();
            out.close();
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
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

            Map<String, Class> map = new HashMap<String, Class>();
            map.put("indexinfo", IndexInfo.class);
            IndexInfo indexinfo = (IndexInfo) JSONObject.toBean(obj, IndexInfo.class, map);
            indexService.update(indexinfo);
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }

    /**
     * 指标删除
     *
     * @return
     */
    @RequestMapping("delindex")
    @Action(description = "指标删除")
    public void delindex(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        try {
            Long indexId = RequestUtil.getLong(request, "id");
            indexService.delById(indexId);
        } catch (Exception e) {
            String resultMsg = null;
            writeResultMessage(response.getWriter(), resultMsg + "," + e.getMessage(), ResultMessage.Fail);
        }
    }
}
