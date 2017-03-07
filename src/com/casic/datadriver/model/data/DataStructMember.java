package com.casic.datadriver.model.data;

public class DataStructMember {
    private Long ddMemberId;

    private Long ddMemberType;

    private String ddItemKey;

    private String ddItemName;

    private String ddItemValue;

    private String ddDecsp;

    private Long ddSn;

    private String ddNodePath;

    private Long ddParentId;

    public Long getDdMemberId() {
        return ddMemberId;
    }

    public void setDdMemberId(Long ddMemberId) {
        this.ddMemberId = ddMemberId;
    }

    public Long getDdMemberType() {
        return ddMemberType;
    }

    public void setDdMemberType(Long ddMemberType) {
        this.ddMemberType = ddMemberType;
    }

    public String getDdItemKey() {
        return ddItemKey;
    }

    public void setDdItemKey(String ddItemKey) {
        this.ddItemKey = ddItemKey;
    }

    public String getDdItemName() {
        return ddItemName;
    }

    public void setDdItemName(String ddItemName) {
        this.ddItemName = ddItemName;
    }

    public String getDdItemValue() {
        return ddItemValue;
    }

    public void setDdItemValue(String ddItemValue) {
        this.ddItemValue = ddItemValue;
    }

    public String getDdDecsp() {
        return ddDecsp;
    }

    public void setDdDecsp(String ddDecsp) {
        this.ddDecsp = ddDecsp;
    }

    public Long getDdSn() {
        return ddSn;
    }

    public void setDdSn(Long ddSn) {
        this.ddSn = ddSn;
    }

    public String getDdNodePath() {
        return ddNodePath;
    }

    public void setDdNodePath(String ddNodePath) {
        this.ddNodePath = ddNodePath;
    }

    public Long getDdParentId() {
        return ddParentId;
    }

    public void setDdParentId(Long ddParentId) {
        this.ddParentId = ddParentId;
    }
}