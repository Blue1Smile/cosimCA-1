package com.casic.datadriver.model.data;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.apache.commons.lang.builder.ToStringBuilder;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DataStruct {
    private Long ddStructId;

    private String ddStructName;

    private String ddNodePath;

    private Short ddDepth;

    private Long ddParentId;

    private String ddCatkey;

    private Long ddTaskId;

    private Short ddIsLeaf;

    private Short ddType;

    private String ddDescription;


    private Short ddPublishState;

    private Short ddOrderState;

    private Short ddSubmitState;

    private String ddTaskName;

    private String ddCreator;

    private Date ddCreateTime;


    private String ddEngName;

    private Long ddProjectId;

    protected List<PrivateData> privateDataList= new ArrayList<PrivateData>();

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

    public Short getDdDepth() {
        return ddDepth;
    }

    public void setDdDepth(Short ddDepth) {
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

    public Long getDdTaskId() {
        return ddTaskId;
    }

    public void setDdTaskId(Long ddTaskId) {
        this.ddTaskId = ddTaskId;
    }

    public Short getDdIsLeaf() {
        return ddIsLeaf;
    }

    public void setDdIsLeaf(Short ddIsLeaf) {
        this.ddIsLeaf = ddIsLeaf;
    }

    public Short getDdType() {
        return ddType;
    }

    public void setDdType(Short ddType) {
        this.ddType = ddType;
    }

    public String getDdDescription() {
        return ddDescription;
    }

    public void setDdDescription(String ddDescription) {
        this.ddDescription = ddDescription;
    }

    public Short getDdPublishState() {
        return ddPublishState;
    }

    public void setDdPublishState(Short ddPublishState) {
        this.ddPublishState = ddPublishState;
    }

    public Short getDdOrderState() {
        return ddOrderState;
    }

    public void setDdOrderState(Short ddOrderState) {
        this.ddOrderState = ddOrderState;
    }

    public Short getDdSubmitState() {
        return ddSubmitState;
    }

    public void setDdSubmitState(Short ddSubmitState) {
        this.ddSubmitState = ddSubmitState;
    }

    public String getDdTaskName() {
        return ddTaskName;
    }

    public void setDdTaskName(String ddTaskName) {
        this.ddTaskName = ddTaskName;
    }

    public String getDdCreator() {
        return ddCreator;
    }

    public void setDdCreator(String ddCreator) {
        this.ddCreator = ddCreator;
    }

    public Date getDdCreateTime() {
        return ddCreateTime;
    }

    public void setDdCreateTime(Date ddCreateTime) {
        this.ddCreateTime = ddCreateTime;
    }

    public String getDdEngName() {
        return ddEngName;
    }

    public void setDdEngName(String ddEngName) {
        this.ddEngName = ddEngName;
    }

    public Long getDdProjectId() {
        return ddProjectId;
    }

    public void setDdProjectId(Long ddProjectId) {
        this.ddProjectId = ddProjectId;
    }

    public void setPrivateDataList(List<PrivateData> privateDataList)
    {
        this.privateDataList = privateDataList;
    }

    public List<PrivateData> getPrivateDataList()
    {
        return this.privateDataList;
    }
    /**
     * @see Object#equals(Object)
     */
    public boolean equals(Object object)
    {
        if (!(object instanceof DataStruct))
        {
            return false;
        }
        DataStruct ti = (DataStruct) object;
        return new EqualsBuilder()
                .append(this.ddCatkey, ti.ddCatkey)
                .append(this.ddCreateTime, ti.ddCreateTime)
                .append(this.ddCreator, ti.ddCreator)
                .append(this.ddDepth, ti.ddDepth)
                .append(this.ddDescription, ti.ddDescription)
                .append(this.ddEngName, ti.ddEngName)
                .append(this.ddIsLeaf, ti.ddIsLeaf)
                .append(this.ddNodePath, ti.ddNodePath)
                .append(this.ddOrderState, ti.ddOrderState)
                .append(this.ddParentId, ti.ddParentId)
                .append(this.ddTaskId, ti.ddTaskId)
                .append(this.ddPublishState, ti.ddPublishState)
                .append(this.ddTaskName, ti.ddTaskName)
                .append(this.ddStructId, ti.ddStructId)
                .append(this.ddStructName, ti.ddStructName)
                .append(this.ddSubmitState, ti.ddSubmitState)
                .append(this.ddType, ti.ddType)
                .append(this.ddProjectId, ti.ddProjectId)
                .isEquals();
    }

    /**
     * @see Object#hashCode()
     */
    public int hashCode()
    {
        return new HashCodeBuilder(-82280557, -700257973)
                .append(this.ddCatkey)
                .append(this.ddCreateTime)
                .append(this.ddCreator)
                .append(this.ddDepth)
                .append(this.ddDescription)
                .append(this.ddEngName)
                .append(this.ddIsLeaf)
                .append(this.ddNodePath)
                .append(this.ddOrderState)
                .append(this.ddParentId)
                .append(this.ddTaskId)
                .append(this.ddPublishState)
                .append(this.ddTaskName)
                .append(this.ddStructId)
                .append(this.ddStructName)
                .append(this.ddSubmitState)
                .append(this.ddType)
                .append(this.ddProjectId)
                .toHashCode();
    }

    /**
     * @see Object#toString()
     */
    public String toString()
    {
        return new ToStringBuilder(this)
                .append(this.ddCatkey)
                .append(this.ddCreateTime)
                .append(this.ddCreator)
                .append(this.ddDepth)
                .append(this.ddDescription)
                .append(this.ddEngName)
                .append(this.ddIsLeaf)
                .append(this.ddNodePath)
                .append(this.ddOrderState)
                .append(this.ddParentId)
                .append(this.ddTaskId)
                .append(this.ddPublishState)
                .append(this.ddTaskName)
                .append(this.ddStructId)
                .append(this.ddStructName)
                .append(this.ddSubmitState)
                .append(this.ddType)
                .append(this.ddProjectId)
                .toString();
    }
}