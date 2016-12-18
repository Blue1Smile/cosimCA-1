package com.casic.datadriver.controller.index;
import com.casic.datadriver.service.index.IndexService;
import com.casic.datadriver.dao.index.IndexDao;
import com.casic.datadriver.model.index.Index;

import com.hotent.core.annotion.Action;
import com.hotent.core.util.UniqueIdUtil;
import com.hotent.core.web.ResultMessage;
import com.hotent.core.web.util.RequestUtil;
import net.sf.ezmorph.object.DateMorpher;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.hotent.core.web.controller.BaseController;

/**
 * Created by Administrator on 2016/11/18 0018.
 */




public class IndexController extends BaseController {



    @Resource
    private IndexService indexService;

 //   @Resource
 //   private IndexVersionService indexVersionService;
    /**
     * ?????????
     * @return
     */
    @RequestMapping("save")
    @Action(description="添加或更新指标")
    public void save(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        String resultMsg=null;

        Index index=getFormObject(request);
        System.out.println(index.getDdIndexName()+":"+index.getDdIndexId());
        try{
            if(index.getDdIndexId()!=null||index.getDdIndexId()!=0){
                index.setDdIndexId((int) UniqueIdUtil.genId());
                indexService.addDDIndex(index);


                resultMsg=getText("record.added","cloud_account_info");
            }else{
                indexService.update(index);
                resultMsg=getText("record.updated","cloud_account_info");
            }
            writeResultMessage(response.getWriter(),resultMsg, ResultMessage.Success);
        }catch(Exception e){
            writeResultMessage(response.getWriter(),resultMsg+","+e.getMessage(),ResultMessage.Fail);
        }
    }


    /**
     * 取得 index 实体
     * @param request
     * @return
     * @throws Exception
     */
    protected Index getFormObject(HttpServletRequest request) throws Exception {

        JSONUtils.getMorpherRegistry().registerMorpher(new DateMorpher((new String[] { "yyyy-MM-dd" })));

        String json= RequestUtil.getString(request, "json");
        JSONObject obj = JSONObject.fromObject(json);

        Index index = (Index)JSONObject.toBean(obj, Index.class);

        return index;
    }






}
