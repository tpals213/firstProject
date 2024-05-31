package com.sdm.ssm.reserve.model.vo;

import java.sql.Date;

//vo(dto, do, entity, bean) 작성규칙
//1. 반드시 직렬화할 것
//2. 모든 필드는 private : 반드시 캡슐화할 것
//3. 기본생성자, 매개변수 있는 생성자 작성할 것
//4. 모든 필드에 대한 getters and setters 
//5. toString() overriding
//선택 : equals(), clone() 등 오버라이딩, 그 외의 메소드
public class ScheduleDto implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3227179235411338669L;
	
	private int schedule_idx;
	private int schedule_num;
	private String schedule_subject;
	private String schedule_desc;
	private Date schedule_date;
	
	//
	private String schedule_share; //공유할 일정인지 아닌지
	private String schedule_mycolor; //일정 색상 입출력
	
	public ScheduleDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ScheduleDto(int schedule_idx, int schedule_num, String schedule_subject, String schedule_desc,
			Date schedule_date, String schedule_share, String schedule_mycolor) {
		super();
		this.schedule_idx = schedule_idx;
		this.schedule_num = schedule_num;
		this.schedule_subject = schedule_subject;
		this.schedule_desc = schedule_desc;
		this.schedule_date = schedule_date;
		this.schedule_share = schedule_share;
		this.schedule_mycolor = schedule_mycolor;
	}

	public int getSchedule_idx() {
		return schedule_idx;
	}

	public void setSchedule_idx(int schedule_idx) {
		this.schedule_idx = schedule_idx;
	}

	public int getSchedule_num() {
		return schedule_num;
	}

	public void setSchedule_num(int schedule_num) {
		this.schedule_num = schedule_num;
	}

	public String getSchedule_subject() {
		return schedule_subject;
	}

	public void setSchedule_subject(String schedule_subject) {
		this.schedule_subject = schedule_subject;
	}

	public String getSchedule_desc() {
		return schedule_desc;
	}

	public void setSchedule_desc(String schedule_desc) {
		this.schedule_desc = schedule_desc;
	}

	public Date getSchedule_date() {
		return schedule_date;
	}

	public void setSchedule_date(Date schedule_date) {
		this.schedule_date = schedule_date;
	}

	public String getSchedule_share() {
		return schedule_share;
	}

	public void setSchedule_share(String schedule_share) {
		this.schedule_share = schedule_share;
	}

	public String getSchedule_mycolor() {
		return schedule_mycolor;
	}

	public void setSchedule_mycolor(String schedule_mycolor) {
		this.schedule_mycolor = schedule_mycolor;
	}

	@Override
	public String toString() {
		return "ReserveCal [schedule_idx=" + schedule_idx + ", schedule_num=" + schedule_num + ", schedule_subject="
				+ schedule_subject + ", schedule_desc=" + schedule_desc + ", schedule_date=" + schedule_date
				+ ", schedule_share=" + schedule_share + ", schedule_mycolor=" + schedule_mycolor + "]";
	}

	
}
