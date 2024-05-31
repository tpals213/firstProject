package com.sdm.ssm.pos.model.vo;

public class Table implements java.io.Serializable {

	private static final long serialVersionUID = 1528602481044012270L;
	
	private int id;
	private int tableNo;
	private String tableName;
	private Double tableX;
	private Double tableY;
	public Table(int id, int tableNo, String tableName, Double tableX, Double tableY) {
		super();
		this.id = id;
		this.tableNo = tableNo;
		this.tableName = tableName;
		this.tableX = tableX;
		this.tableY = tableY;
	}
	public Table() {
		super();
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getTableNo() {
		return tableNo;
	}
	public void setTableNo(int tableNo) {
		this.tableNo = tableNo;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public Double getTableX() {
		return tableX;
	}
	public void setTableX(Double tableX) {
		this.tableX = tableX;
	}
	public Double getTableY() {
		return tableY;
	}
	public void setTableY(Double tableY) {
		this.tableY = tableY;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "Table [id=" + id + ", tableNo=" + tableNo + ", tableName=" + tableName + ", tableX=" + tableX
				+ ", tableY=" + tableY + "]";
	}
	
}
