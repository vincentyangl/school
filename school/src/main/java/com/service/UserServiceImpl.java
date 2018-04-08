package com.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bean.User;
import com.mapper.UserDao;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDao userDao;
	
	@Override
	public List<User> listAll(Map map) {
		List<User> users = userDao.listAll(map);
		return users;
	}

	@Override
	public void save(User user) {
		userDao.save(user);
	}

	@Override
	public void delete(int user_id) {
		userDao.delete(user_id);
	}

	@Override
	public void update(User user) {
		userDao.update(user);
	}

}
