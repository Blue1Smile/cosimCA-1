package com.casic.datadriver.model.data;

public class DataStruct {
    private Long ddStructId;

    private String ddStructName;

    private String ddNodePath;

    private Long ddDepthId;

    private Integer ddDepth;

    private Long ddParentId;

    private String ddCatkey;

    private String ddNodeKey;

    private Long ddTaskId;

    private Long ddSn;

    private Short ddIsLeaf;

    private String ddNodeCode;

    private Short ddNodeCodeType;

    public Long getDdStructId() {
        return ddStructId;
    }

    public void setDdStructId(Long ddStructId) {
        this.ddStructId = ddStructId;
    }

    public String getDdStructName() {
        return ddStructName;
    }

    public void setDdStructName(String ddStructName) {
        this.ddStructName = ddStructName;
    }

    public String getDdNodePath() {
        return ddNodePath;
    }

    public void setDdNodePath(String ddNodePath) {
        this.ddNodePath = ddNodePath;
    }

    public Long getDdDepthId() {
        return ddDepthId;
    }

    public void setDdDepthId(Long ddDepthId) {
        this.ddDepthId = ddDepthId;
    }

    public Integer getDdDepth() {
        return ddDepth;
    }

    public void setDdDepth(Integer ddDepth) {
        this.ddDepth = ddDepth;
    }

    public Long getDdParentId() {
        return ddParentId;
    }

    public void setDdParentId(Long ddParentId) {
        this.ddParentId = ddParentId;
    }

    public String getDdCatkey() {
        return ddCatkey;
    }

    public void setDdCatkey(String ddCatkey) {
        this.ddCatkey = ddCatkey;
    }

    public String getDdNodeKey() {
        return ddNodeKey;
    }

    public void setDdNodeKey(String ddNodeKey) {
        this.ddNodeKey = ddNodeKey;
    }

    public Long getDdTaskId() {
        return ddTaskId;
    }

    public void setDdTaskId(Long ddTaskId) {
        this.ddTaskId = ddTaskId;
    }

    public Long getDdSn() {
        return ddSn;
    }

    public void setDdSn(Long ddSn) {
        this.ddSn = ddSn;
    }

    public Short getDdIsLeaf() {
        return ddIsLeaf;
    }

    public void setDdIsLeaf(Short ddIsLeaf) {
        this.ddIsLeaf = ddIsLeaf;
    }

    public String getDdNodeCode() {
        return ddNodeCode;
    }

    public void setDdNodeCode(String ddNodeCode) {
        this.ddNodeCode = ddNodeCode;
    }

    public Short getDdNodeCodeType() {
        return ddNodeCodeType;
    }

    public void setDdNodeCodeType(Short ddNodeCodeType) {
        this.ddNodeCodeType = ddNodeCodeType;
    }
}