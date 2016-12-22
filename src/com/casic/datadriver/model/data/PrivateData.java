package com.casic.datadriver.model.data;

import com.hotent.core.model.BaseModel;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class PrivateData extends BaseModel {
    private Long ddDataId;

    private String ddDataName;

    private Long ddDataType;

    private String ddDataDescription;

    private Long ddDataTaskId;

    private Long ddDataPublishType;

    private String ddDataLastestValue;

    private Long ddDataSubmiteState;

    private Long ddDataCreatePerson;

    private Date ddDataCreateTime;

    private Long ddDataIsDelivery;

    private Long ddDataSensitiveness;

    private String ddDataTaskName;


    public String getDdDataTaskName() {
        return ddDataTaskName;
    }

    public void setDdDataTaskName(String ddDataTaskName) {
        this.ddDataTaskName = ddDataTaskName;
    }

    public Long getDdDataId() {
        return ddDataId;
    }

    public void setDdDataId(Long ddDataId) {
        this.ddDataId = ddDataId;
    }

    public String getDdDataName() {
        return ddDataName;
    }

    public void setDdDataName(String ddDataName) {
        this.ddDataName = ddDataName;
    }

    public Long getDdDataType() {
        return ddDataType;
    }

    public void setDdDataType(Long ddDataType) {
        this.ddDataType = ddDataType;
    }

    public String getDdDataDescription() {
        return ddDataDescription;
    }

    public void setDdDataDescription(String ddDataDescription) {
        this.ddDataDescription = ddDataDescription;
    }

    public Long getDdDataTaskId() {
        return ddDataTaskId;
    }

    public void setDdDataTaskId(Long ddDataTaskId) {
        this.ddDataTaskId = ddDataTaskId;
    }

    public Long getDdDataPublishType() {
        return ddDataPublishType;
    }

    public void setDdDataPublishType(Long ddDataPublishType) {
        this.ddDataPublishType = ddDataPublishType;
    }

    public String getDdDataLastestValue() {
        return ddDataLastestValue;
    }

    public void setDdDataLastestValue(String ddDataLastestValue) {
        this.ddDataLastestValue = ddDataLastestValue;
    }

    public Long getDdDataSubmiteState() {
        return ddDataSubmiteState;
    }

    public void setDdDataSubmiteState(Long ddDataSubmiteState) {
        this.ddDataSubmiteState = ddDataSubmiteState;
    }

    public Long getDdDataCreatePerson() {
        return ddDataCreatePerson;
    }

    public void setDdDataCreatePerson(Long ddDataCreatePerson) {
        this.ddDataCreatePerson = ddDataCreatePerson;
    }

    public Date getDdDataCreateTime() {
        return ddDataCreateTime;
    }

    public void setDdDataCreateTime(Date ddDataCreateTime) {
        this.ddDataCreateTime = ddDataCreateTime;
    }

    public Long getDdDataIsDelivery() {
        return ddDataIsDelivery;
    }

    public void setDdDataIsDelivery(Long ddDataIsDelivery) {
        this.ddDataIsDelivery = ddDataIsDelivery;
    }

    public Long getDdDataSensitiveness() {
        return ddDataSensitiveness;
    }

    public void setDdDataSensitiveness(Long ddDataSensitiveness) {
        this.ddDataSensitiveness = ddDataSensitiveness;
    }
}