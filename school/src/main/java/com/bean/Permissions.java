package com.bean;

import java.util.List;

public class Permissions {
	
	//权限编号
	private int id;
	//权限名称
	private String name;
	//权限别名
	private String per_newName;
	//跳转路径
	private String per_url;
	//是否为菜单
	private int per_menu;
	//父元素Id
	private int pId;
	//子元素集合
	private List<Permissions> pers;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPer_newName() {
		return per_newName;
	}
	public void setPer_newName(String per_newName) {
		this.per_newName = per_newName;
	}
	public String getPer_url() {
		return per_url;
	}
	public void setPer_url(String per_url) {
		this.per_url = per_url;
	}
	public int getPer_menu() {
		return per_menu;
	}
	public void setPer_menu(int per_menu) {
		this.per_menu = per_menu;
	}
	public int getpId() {
		return pId;
	}
	public void setpId(int pId) {
		this.pId = pId;
	}
	public List<Permissions> getPers() {
		return pers;
	}
	public void setPers(List<Permissions> pers) {
		this.pers = pers;
	}


	
}
