package com.sgs.model;

public class Account {

	private int idAcc;
	private String username;
	private String security;
	private String password;
	private Integer fk_acc_role;
	private Integer fk_part_acc;
	
	public int getAccountId() {
		return idAcc;
	}
	public void setAccountId(int idAcc) {
		this.idAcc = idAcc;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getSecurityCode() {
		return security;
	}
	public void setSecurityCode(String security) {
		this.security = security;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Integer getfk_acc_role() {
		return fk_acc_role;
	}
	public void setfk_acc_role(Integer fk_acc_role) {
		this.fk_acc_role = fk_acc_role;
	}

	public Integer getfk_part_acc() {
		return fk_part_acc;
	}
	public void setfk_part_acc(Integer fk_part_acc) {
		this.fk_part_acc = fk_part_acc;
	}
	@Override
	public String toString() {
		return "Account [idAcc=" + idAcc + ", username=" + username
				+ ", security=" + security + ", password=" + password + ", fk_acc_role="
				+ fk_acc_role + ", fk_part_acc=" + fk_part_acc
				+"]";
	}
	
	
}
