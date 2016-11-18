package com.sgs.model;

public class Particulars {

	private int fk_part_acc;
	private String name;
	private String contact;
	private String email;
	
	public int getPartAcc() {
		return fk_part_acc;
	}
	public void setPartAcc(int fk_part_acc) {
		this.fk_part_acc = fk_part_acc;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	@Override
	public String toString() {
		return "Particulars [fk_part_acc=" + fk_part_acc + ", name=" + name
				+ ", contact=" + contact + ", email=" + email
				+"]";
	}
	
	
}
