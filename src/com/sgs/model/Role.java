package com.sgs.model;

public class Role {

	private int idRole;
	private String name;
	private String desc;
	
	public int getRoleId() {
		return idRole;
	}
	public void setRoleId(int idRole) {
		this.idRole = idRole;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	
	@Override
	public String toString() {
		return "Role [idRole=" + idRole + ", name=" + name
				+ ", desc=" + desc
				+"]";
	}
	
	
}
