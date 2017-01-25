package com.casic.datadriver.model.data;

import java.util.Date;



public class DataSnapInfoId {
    private Long ddDataSnapShotId;

    private Integer ddSnapShotPersonId;

    private Date ddSnapShotTime;

    private String ddSnapShotReasonId;

    private Integer ddProjectId;

    public Long getDdDataSnapShotId() {
        return ddDataSnapShotId;
    }

    public void setDdDataSnapShotId(Long ddDataSnapShotId) {
        this.ddDataSnapShotId = ddDataSnapShotId;
    }

    public Integer getDdSnapShotPersonId() {
        return ddSnapShotPersonId;
    }

    public void setDdSnapShotPersonId(Integer ddSnapShotPersonId) {
        this.ddSnapShotPersonId = ddSnapShotPersonId;
    }

    public Date getDdSnapShotTime() {
        return ddSnapShotTime;
    }

    public void setDdSnapShotTime(Date ddSnapShotTime) {
        this.ddSnapShotTime = ddSnapShotTime;
    }

    public String getDdSnapShotReasonId() {
        return ddSnapShotReasonId;
    }

    public void setDdSnapShotReasonId(String ddSnapShotReasonId) {
        this.ddSnapShotReasonId = ddSnapShotReasonId;
    }

    public Integer getDdProjectId() {
        return ddProjectId;
    }

    public void setDdProjectId(Integer ddProjectId) {
        this.ddProjectId = ddProjectId;
    }

}