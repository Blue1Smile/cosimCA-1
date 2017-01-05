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

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2016/11/18 0018.
 */



@Controller
@RequestMapping("/datadriver/index/")
public class IndexInfoController extends BaseController {



    @Resource
    private IndexService indexService;

 //   @Resource
 //   private IndexVersionService indexVersionService;
    /**
     * 指标保存
     * @return
     */
    @RequestMapping("save")
    @Action(description="保存指标")
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        String resultMsg=null;

        IndexInfo index=getFormObject(request);
        System.out.println(index.getDdIndexName()+":"+index.getDdIndexId());
        try{
            if(index.getDdIndexId()!=null||index.getDdIndexId()!=0){
                index.setDdIndexId(UniqueIdUtil.genId());
                indexService.addDDIndex(index);


                resultMsg=getText("record.added","指标信息");
            }else{
                indexService.update(index);
                resultMsg=getText("record.updated","指标信息");
            }
            writeResultMessage(response.getWriter(),resultMsg, ResultMessage.Success);
        }catch(Exception e){
            writeResultMessage(response.getWriter(),resultMsg+","+e.getMessage(),ResultMessage.Fail);
        }
    }


    /**
     *
     * @param request
     * @return
     * @throws Exception
     */
    protected IndexInfo getFormObject(HttpServletRequest request) throws Exception {

        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[] { "yyyy-MM-dd" })));

        String json= RequestUtil.getString(request, "json");
        JSONObject obj = JSONObject.fromObject(json);

        IndexInfo index = (IndexInfo)JSONObject.toBean(obj, IndexInfo.class);

        return index;
    }






}
