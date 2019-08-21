package com.exam.vo;

import java.sql.Timestamp;

//Value Object(VO) = Java Bean class
public class MemberVO {
	private String id;
	private String passwd;
	private String name;
	private Integer age;
	private String gender;
	private String email;
	private Timestamp regDate;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "MemberVO [id=" + id + ", passwd=" + passwd + ", name=" + name + ", age=" + age + ", gender=" + gender
				+ ", email=" + email + ", regDate=" + regDate + "]";
	}

}
