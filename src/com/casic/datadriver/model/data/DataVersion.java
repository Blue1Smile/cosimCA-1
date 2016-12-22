package com.casic.datadriver.model.data;

import java.util.Date;

public class DataVersion {



    private Long ddDataVersionId;

    private Long ddDataId;



    private Long ddDataVersion;

    private String ddDataValue;

    private String ddDataRecordTime;

    private Long ddDataRecordPersonId;

    private Long ddProjectPhaseId;

    private Long ddProjectDataState;

    private String ddDataChangeReason;


    public Long getDdDataVersionID() {
        return ddDataVersionId;
    }

    public void setDdDataVersionID(Long ddDataVersionID) {
        this.ddDataVersionId = ddDataVersionID;
    }

    public Long getDdDataId() {
        return ddDataId;
    }

    public void setDdDataId(Long ddDataId) {
        this.ddDataId = ddDataId;
    }


    public Long getDdDataVersion() {
        return ddDataVersion;
    }

    public void setDdDataVersion(Long ddDataVersion) {
        this.ddDataVersion = ddDataVersion;
    }


    public String getDdDataValue() {
        return ddDataValue;
    }

    public void setDdDataValue(String ddDataValue) {
        this.ddDataValue = ddDataValue;
    }

    public String getDdDataRecordTime() {
        return ddDataRecordTime;
    }

    public void setDdDataRecordTime(String ddDataRecordTime) {
        this.ddDataRecordTime = ddDataRecordTime;
    }

    public Long getDdDataRecordPersonId() {
        return ddDataRecordPersonId;
    }

    public void setDdDataRecordPersonId(Long ddDataRecordPersonId) {
        this.ddDataRecordPersonId = ddDataRecordPersonId;
    }

    public Long getDdProjectPhaseId() {
        return ddProjectPhaseId;
    }

    public void setDdProjectPhaseId(Long ddProjectPhaseId) {
        this.ddProjectPhaseId = ddProjectPhaseId;
    }

    public Long getDdProjectDataState() {
        return ddProjectDataState;
    }

    public void setDdProjectDataState(Long ddProjectDataState) {
        this.ddProjectDataState = ddProjectDataState;
    }

    public String getDdDataChangeReason() {
        return ddDataChangeReason;
    }

    public void setDdDataChangeReason(String ddDataChangeReason) {
        this.ddDataChangeReason = ddDataChangeReason;
    }







}