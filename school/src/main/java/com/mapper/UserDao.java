package com.mapper;

import java.util.List;
import java.util.Map;

import com.bean.Role;
import com.bean.User;

public interface UserDao {

	public List<User> listAll(Map map);
	public void save(User user);
	public void delete(int user_id);
	public void update(User user);
	
}
