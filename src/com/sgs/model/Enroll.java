package com.sgs.model;

public class Enroll {

	private int idEnroll;
	private int grade;
	private int fk_enroll_acc;
	private int fk_enroll_mod;
	
	public int getEnrollId() {
		return idEnroll;
	}
	public void setEnrollId(int idEnroll) {
		this.idEnroll = idEnroll;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public int getEnrollAcc() {
		return fk_enroll_acc;
	}
	public void setEnrollAcc(int fk_enroll_acc) {
		this.fk_enroll_acc = fk_enroll_acc;
	}
	public int getEnrollMod() {
		return fk_enroll_mod;
	}
	public void setEnrollMod(int fk_enroll_mod) {
		this.fk_enroll_mod = fk_enroll_mod;
	}
	@Override
	public String toString() {
		return "Enroll [idEnroll=" + idEnroll + ", grade=" + grade
				+ ", fk_enroll_acc=" + fk_enroll_acc + ", fk_enroll_mod=" + fk_enroll_mod
				+"]";
	}
	
	
}
