package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.Role;
import com.mapper.RoleDao;

@Service
public class RoleServiceImpl implements RoleService{

	@Autowired
	private RoleDao roleDao;
	@Override
	public void save(Role role) {
		roleDao.save(role);
	}

	@Override
	public void delete(int rid) {
		roleDao.delete(rid);
	}

	@Override
	public void update(Role role) {
		roleDao.update(role);
	}

	@Override
	public List<Role> listAll() {
		List<Role> roles = roleDao.listAll();
		return roles;
	}

	@Override
	public Role getById(int rid) {
        Role role = roleDao.getById(rid);
		return role;
	}

	
	
}
