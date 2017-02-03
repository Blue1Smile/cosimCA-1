package com.casic.datadriver.model.data;
import com.hotent.core.model.BaseModel;
/**
 * Created by d on 2017/1/30.
 */
public class DataSnapshot extends BaseModel {

    private long ddDataId;
    private long ddDataSnapshotId;
    private String ddDataValue;
    private String ddDataRecordTime;
    private long ddSnapshotPersonId;
    private String ddSnapshotTime;
    private String ddDataTag;

    public long getDdDataId() {
        return ddDataId;
    }
    public void setDdDataId(long ddDataId) {
        this.ddDataId = ddDataId;
    }

    public long getDdDataSnapshotId() {
        return ddDataSnapshotId;
    }
    public void setDdDataSnapshotId(long ddDataSnapshotId) {
        this.ddDataSnapshotId = ddDataSnapshotId;
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

    public long getDdSnapshotPersonId() {
        return ddSnapshotPersonId;
    }
    public void setDdSnapshotPersonId(long ddSnapshotPersonId) {
        this.ddSnapshotPersonId = ddSnapshotPersonId;
    }

    public String getDdSnapshotTime() {
        return ddSnapshotTime;
    }
    public void setDdSnapshotTime(String ddSnapshotTime) {
        this.ddSnapshotTime = ddSnapshotTime;
    }

    public String getDdDataTag() {
        return ddDataTag;
    }
    public void setDdDataTag(String ddDataTag) {
        this.ddDataTag = ddDataTag;
    }
}
