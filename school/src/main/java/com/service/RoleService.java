package com.service;

import java.util.List;

import com.bean.Role;

public interface RoleService {

	public void save(Role role);
	public void delete(int rid);
	public void update(Role role);
	public List<Role> listAll();
	public Role getById(int rid);
	
}
