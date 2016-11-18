package com.sgs.model;

import java.util.Date;

public class Log {

	private Date timestamp;
	private String action;
	private Integer fk_log_acc;
	
	public Date getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public Integer getLogacc() {
		return fk_log_acc;
	}
	public void setLogacc(Integer fk_log_acc) {
		this.fk_log_acc = fk_log_acc;
	}
	@Override
	public String toString() {
		return "Log [timestamp=" + timestamp + ", action=" + action
				+ ", fk_log_acc=" + fk_log_acc + "]";
	}
	
	
}
