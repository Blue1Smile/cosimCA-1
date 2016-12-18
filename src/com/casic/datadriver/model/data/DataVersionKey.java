package com.casic.datadriver.model.data;

public class DataVersionKey {
    private Integer ddDataId;

    private Integer ddDataVersion;

    private Integer ddProjectPhaseId;

    public Integer getDdDataId() {
        return ddDataId;
    }

    public void setDdDataId(Integer ddDataId) {
        this.ddDataId = ddDataId;
    }

    public Integer getDdDataVersion() {
        return ddDataVersion;
    }

    public void setDdDataVersion(Integer ddDataVersion) {
        this.ddDataVersion = ddDataVersion;
    }

    public Integer getDdProjectPhaseId() {
        return ddProjectPhaseId;
    }

    public void setDdProjectPhaseId(Integer ddProjectPhaseId) {
        this.ddProjectPhaseId = ddProjectPhaseId;
    }
}