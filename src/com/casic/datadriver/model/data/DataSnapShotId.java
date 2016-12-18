package com.casic.datadriver.model.data;

public class DataSnapShotId {
    private Integer ddDataId;

    private Integer ddDataSnapShotId;

    private String ddDataValue;

    private Integer ddDataVersion;

    public Integer getDdDataId() {
        return ddDataId;
    }

    public void setDdDataId(Integer ddDataId) {
        this.ddDataId = ddDataId;
    }

    public Integer getDdDataSnapShotId() {
        return ddDataSnapShotId;
    }

    public void setDdDataSnapShotId(Integer ddDataSnapShotId) {
        this.ddDataSnapShotId = ddDataSnapShotId;
    }

    public String getDdDataValue() {
        return ddDataValue;
    }

    public void setDdDataValue(String ddDataValue) {
        this.ddDataValue = ddDataValue;
    }

    public Integer getDdDataVersion() {
        return ddDataVersion;
    }

    public void setDdDataVersion(Integer ddDataVersion) {
        this.ddDataVersion = ddDataVersion;
    }
}