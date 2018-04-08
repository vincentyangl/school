package com.mapper;

import java.util.List;
import java.util.Map;

import com.bean.Permissions;

public interface PermissionsDao {

	public List<Permissions> listAll(Map map);
	public List<Permissions> getChildNode(int id);
	public void save(Permissions per);
	public void delete(int id);
	public void update(Permissions per);
	public List<Permissions> getPermissionsByRoleId(int role_id);
	public void updateName(Permissions per);
}
