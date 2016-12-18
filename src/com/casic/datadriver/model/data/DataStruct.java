package com.casic.datadriver.model.data;

public class DataStruct {
    private Integer ddStructId;

    private Integer ddDataId;

    private String ddStructName;

    private Integer ddStructMemberType;

    private Integer ddStructMemberId;

    public Integer getDdStructId() {
        return ddStructId;
    }

    public void setDdStructId(Integer ddStructId) {
        this.ddStructId = ddStructId;
    }

    public Integer getDdDataId() {
        return ddDataId;
    }

    public void setDdDataId(Integer ddDataId) {
        this.ddDataId = ddDataId;
    }

    public String getDdStructName() {
        return ddStructName;
    }

    public void setDdStructName(String ddStructName) {
        this.ddStructName = ddStructName;
    }

    public Integer getDdStructMemberType() {
        return ddStructMemberType;
    }

    public void setDdStructMemberType(Integer ddStructMemberType) {
        this.ddStructMemberType = ddStructMemberType;
    }

    public Integer getDdStructMemberId() {
        return ddStructMemberId;
    }

    public void setDdStructMemberId(Integer ddStructMemberId) {
        this.ddStructMemberId = ddStructMemberId;
    }
}