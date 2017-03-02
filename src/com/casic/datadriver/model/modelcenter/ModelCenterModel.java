package com.casic.datadriver.model.modelcenter;

import com.hotent.core.model.BaseModel;

/**
 * Created by 忠 on 2017/2/28.
 */
public class ModelCenterModel extends BaseModel {
    private Long ddMdoelId;

    private String ddModelName;

    private String ddModelExplain;

    private Integer ddTaskId;

    private String ddModelUrl;

    private Long ddModelType;

    private Long ddModelVersion;

    private String ddModelBf1;

    private Long ddModelBf2;

    public Long getDdModelVersion() {
        return ddModelVersion;
    }

    public void setDdModelVersion(Long ddModelVersion) {
        this.ddModelVersion = ddModelVersion;
    }

    public Long getDdMdoelId() {
        return ddMdoelId;
    }

    public void setDdMdoelId(Long ddMdoelId) {
        this.ddMdoelId = ddMdoelId;
    }

    public String getDdModelName() {
        return ddModelName;
    }

    public void setDdModelName(String ddModelName) {
        this.ddModelName = ddModelName == null ? null : ddModelName.trim();
    }

    public String getDdModelExplain() {
        return ddModelExplain;
    }

    public void setDdModelExplain(String ddModelExplain) {
        this.ddModelExplain = ddModelExplain == null ? null : ddModelExplain.trim();
    }

    public Integer getDdTaskId() {
        return ddTaskId;
    }

    public void setDdTaskId(Integer ddTaskId) {
        this.ddTaskId = ddTaskId;
    }

    public String getDdModelUrl() {
        return ddModelUrl;
    }

    public void setDdModelUrl(String ddModelUrl) {
        this.ddModelUrl = ddModelUrl == null ? null : ddModelUrl.trim();
    }

    public Long getDdModelType() {
        return ddModelType;
    }

    public void setDdModelType(Long ddModelType) {
        this.ddModelType = ddModelType;
    }

    public String getDdModelBf1() {
        return ddModelBf1;
    }

    public void setDdModelBf1(String ddModelBf1) {
        this.ddModelBf1 = ddModelBf1 == null ? null : ddModelBf1.trim();
    }

    public Long getDdModelBf2() {
        return ddModelBf2;
    }

    public void setDdModelBf2(Long ddModelBf2) {
        this.ddModelBf2 = ddModelBf2;
    }
}
