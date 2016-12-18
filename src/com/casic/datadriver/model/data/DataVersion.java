package com.casic.datadriver.model.data;

import java.util.Date;

public class DataVersion {
    private Integer ddDataVersionId;

    private Integer ddDataId;

    private Integer ddDataVersion;

    private String ddDataValue;

    private Date ddDataRecordTime;

    private Integer ddDataRecordPersonId;

    private Integer ddProjectPhaseId;

    private Integer ddProjectDataState;

    private String ddDataChangeReason;

    public Integer getDdDataVersionId() {
        return ddDataVersionId;
    }

    public void setDdDataVersionId(Integer ddDataVersionId) {
        this.ddDataVersionId = ddDataVersionId;
    }

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

    public String getDdDataValue() {
        return ddDataValue;
    }

    public void setDdDataValue(String ddDataValue) {
        this.ddDataValue = ddDataValue;
    }

    public Date getDdDataRecordTime() {
        return ddDataRecordTime;
    }

    public void setDdDataRecordTime(Date ddDataRecordTime) {
        this.ddDataRecordTime = ddDataRecordTime;
    }

    public Integer getDdDataRecordPersonId() {
        return ddDataRecordPersonId;
    }

    public void setDdDataRecordPersonId(Integer ddDataRecordPersonId) {
        this.ddDataRecordPersonId = ddDataRecordPersonId;
    }

    public Integer getDdProjectPhaseId() {
        return ddProjectPhaseId;
    }

    public void setDdProjectPhaseId(Integer ddProjectPhaseId) {
        this.ddProjectPhaseId = ddProjectPhaseId;
    }

    public Integer getDdProjectDataState() {
        return ddProjectDataState;
    }

    public void setDdProjectDataState(Integer ddProjectDataState) {
        this.ddProjectDataState = ddProjectDataState;
    }

    public String getDdDataChangeReason() {
        return ddDataChangeReason;
    }

    public void setDdDataChangeReason(String ddDataChangeReason) {
        this.ddDataChangeReason = ddDataChangeReason;
    }
}