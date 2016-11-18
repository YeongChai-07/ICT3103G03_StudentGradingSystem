package com.sgs.model;

public class Module {

	private String idMod;
	private String modName;
	private String modDesc;
	
	public String getModId() {
		return idMod;
	}
	public void setModId(String idMod) {
		this.idMod = idMod;
	}
	public String getModName() {
		return modName;
	}
	public void setModName(String modName) {
		this.modName = modName;
	}
	public String getModDesc() {
		return modDesc;
	}
	public void setModDesc(String modDesc) {
		this.modDesc = modDesc;
	}
	
	@Override
	public String toString() {
		return "Module [idMod=" + idMod + ", modName=" + modName
				+ ", modDesc=" + modDesc
				+"]";
	}
	
	
}
