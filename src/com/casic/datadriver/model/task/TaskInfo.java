package com.casic.datadriver.model.task;

import com.casic.datadriver.model.data.PrivateData;
import com.hotent.core.model.BaseModel;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class TaskInfo extends BaseModel {


    public static final Short STATUS_RUNNING		=1;
    public static final Short STATUS_STOP			=2;
    public static final Short STATUS_EXCEPTION		=-1;
    public static final Short STATUS_COMPLETE		=-2;
    public static final Short STATUS_SUBMIT	        =0;
    private Long ddTaskId;

    private String ddTaskName;

    private String ddTaskDescription;

    private Long ddTaskCreatorId;

    private Long ddTaskResponsiblePerson;

    private Long ddTaskFixedPattern;

    private String ddTaskType;

    private String ddTaskChildType;

    private Long ddTaskPriority;

    private Long ddTaskMilestone;

    private String ddTaskEstimateTime;

    private Date ddTaskPlanStartTime;

    private Date ddTaskPlanEndTime;

    private Long ddTaskCompleteRate;

    private Long ddTaskCompleteState;

    private Long ddTaskResourceId;

    private String ddTaskActualTime;

    private String ddTaskPlanTime;

    private Date ddTaskActualStartTime;

    private Date ddTaskActualEndTime;

    private Long ddTaskPlanDuration;

    private Long ddTaskProjectId;

    private String ddTaskPerson;

    private String ddTaskProjectName;

    private Short ddTaskState;

    public Short getDdTaskState() {
        return ddTaskState;
    }

    public void setDdTaskState(Short ddTaskState) {
        this.ddTaskState = ddTaskState;
    }



    //任务管理中的私有数据管理
    protected List<PrivateData> privateDataList= new ArrayList<PrivateData>();

    public String getDdTaskPerson() {
        return ddTaskPerson;
    }

    public void setDdTaskPerson(String ddTaskPerson) {
        this.ddTaskPerson = ddTaskPerson;
    }

    public Long getDdTaskId() {
        return ddTaskId;
    }

    public void setDdTaskId(Long ddTaskId) {
        this.ddTaskId = ddTaskId;
    }

    public String getDdTaskName() {
        return ddTaskName;
    }

    public void setDdTaskName(String ddTaskName) {
        this.ddTaskName = ddTaskName;
    }

    public String getDdTaskDescription() {
        return ddTaskDescription;
    }

    public void setDdTaskDescription(String ddTaskDescription) {
        this.ddTaskDescription = ddTaskDescription;
    }

    public Long getDdTaskCreatorId() {
        return ddTaskCreatorId;
    }

    public void setDdTaskCreatorId(Long ddTaskCreatorId) {
        this.ddTaskCreatorId = ddTaskCreatorId;
    }

    public Long getDdTaskResponsiblePerson() {
        return ddTaskResponsiblePerson;
    }

    public void setDdTaskResponsiblePerson(Long ddTaskResponsiblePerson) {
        this.ddTaskResponsiblePerson = ddTaskResponsiblePerson;
    }

    public Long getDdTaskFixedPattern() {
        return ddTaskFixedPattern;
    }

    public void setDdTaskFixedPattern(Long ddTaskFixedPattern) {
        this.ddTaskFixedPattern = ddTaskFixedPattern;
    }

    public String getDdTaskType() {
        return ddTaskType;
    }

    public void setDdTaskType(String ddTaskType) {
        this.ddTaskType = ddTaskType;
    }

    public String getDdTaskChildType() {
        return ddTaskChildType;
    }

    public void setDdTaskChildType(String ddTaskChildType) {
        this.ddTaskChildType = ddTaskChildType;
    }

    public Long getDdTaskPriority() {
        return ddTaskPriority;
    }

    public void setDdTaskPriority(Long ddTaskPriority) {
        this.ddTaskPriority = ddTaskPriority;
    }

    public Long getDdTaskMilestone() {
        return ddTaskMilestone;
    }

    public void setDdTaskMilestone(Long ddTaskMilestone) {
        this.ddTaskMilestone = ddTaskMilestone;
    }

    public String getDdTaskEstimateTime() {
        return ddTaskEstimateTime;
    }

    public void setDdTaskEstimateTime(String ddTaskEstimateTime) {
        this.ddTaskEstimateTime = ddTaskEstimateTime;
    }

    public Date getDdTaskPlanStartTime() {
        return ddTaskPlanStartTime;
    }

    public void setDdTaskPlanStartTime(Date ddTaskPlanStartTime) {
        this.ddTaskPlanStartTime = ddTaskPlanStartTime;
    }

    public Date getDdTaskPlanEndTime() {
        return ddTaskPlanEndTime;
    }

    public void setDdTaskPlanEndTime(Date ddTaskPlanEndTime) {
        this.ddTaskPlanEndTime = ddTaskPlanEndTime;
    }

    public Long getDdTaskCompleteRate() {
        return ddTaskCompleteRate;
    }

    public void setDdTaskCompleteRate(Long ddTaskCompleteRate) {
        this.ddTaskCompleteRate = ddTaskCompleteRate;
    }

    public Long getDdTaskCompleteState() {
        return ddTaskCompleteState;
    }

    public void setDdTaskCompleteState(Long ddTaskCompleteState) {
        this.ddTaskCompleteState = ddTaskCompleteState;
    }

    public Long getDdTaskResourceId() {
        return ddTaskResourceId;
    }

    public void setDdTaskResourceId(Long ddTaskResourceId) {
        this.ddTaskResourceId = ddTaskResourceId;
    }

    public String getDdTaskActualTime() {
        return ddTaskActualTime;
    }

    public void setDdTaskActualTime(String ddTaskActualTime) {
        this.ddTaskActualTime = ddTaskActualTime;
    }

    public String getDdTaskPlanTime() {
        return ddTaskPlanTime;
    }

    public void setDdTaskPlanTime(String ddTaskPlanTime) {
        this.ddTaskPlanTime = ddTaskPlanTime;
    }

    public Date getDdTaskActualStartTime() {
        return ddTaskActualStartTime;
    }

    public void setDdTaskActualStartTime(Date ddTaskActualStartTime) {
        this.ddTaskActualStartTime = ddTaskActualStartTime;
    }

    public Date getDdTaskActualEndTime() {
        return ddTaskActualEndTime;
    }

    public void setDdTaskActualEndTime(Date ddTaskActualEndTime) {
        this.ddTaskActualEndTime = ddTaskActualEndTime;
    }

    public Long getDdTaskPlanDuration() {
        return ddTaskPlanDuration;
    }

    public void setDdTaskPlanDuration(Long ddTaskPlanDuration) {
        this.ddTaskPlanDuration = ddTaskPlanDuration;
    }

    public Long getDdTaskProjectId() {
        return ddTaskProjectId;
    }

    public void setDdTaskProjectId(Long ddTaskProjectId) {
        this.ddTaskProjectId = ddTaskProjectId;
    }

    public void setPrivateDataList(List<PrivateData> privateDataList)
    {
        this.privateDataList = privateDataList;
    }

    public List<PrivateData> getPrivateDataList()
    {
        return this.privateDataList;
    }

    public String getDdTaskProjectName() {
        return ddTaskProjectName;
    }

    public void setDdTaskProjectName(String ddTaskProjectName) {
        this.ddTaskProjectName = ddTaskProjectName;
    }
}