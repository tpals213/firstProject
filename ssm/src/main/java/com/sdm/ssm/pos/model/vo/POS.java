package com.sdm.ssm.pos.model.vo;

public class POS {
    private int posNo;
    private String posName;
    private int id; // 사용자의 고유한 ID 추가

    public POS() {
    }

    public POS(int posNo, String posName, int id) {
        this.posNo = posNo;
        this.posName = posName;
        this.id = id;
    }

    public int getPosNo() {
        return posNo;
    }

    public void setPosNo(int posNo) {
        this.posNo = posNo;
    }

    public String getPosName() {
        return posName;
    }

    public void setPosName(String posName) {
        this.posName = posName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "POS [posNo=" + posNo + ", posName=" + posName + ", id=" + id + "]";
    }
}
