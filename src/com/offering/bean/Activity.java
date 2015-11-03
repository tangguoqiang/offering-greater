package com.offering.bean;

import com.offering.common.Column;

/**
 * 活动
 * @author surfacepro3
 *
 */
public class Activity {

	@Column
	private String id;
	@Column
	private String title;
	@Column
	private String startTime;
	@Column
	private String endTime;
	@Column
	private String type;
	@Column
	private String status;
	@Column
	private String url;
	@Column
	private String summary;
	@Column
	private String share_activity_image;
	@Column
	private String createrId;
	@Column
	private String address;
	@Column
	private String remark;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}	
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getShare_activity_image() {
		return share_activity_image;
	}
	public void setShare_activity_image(String share_activity_image) {
		this.share_activity_image = share_activity_image;
	}
	public String getCreaterId() {
		return createrId;
	}
	public void setCreaterId(String createrId) {
		this.createrId = createrId;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
}
