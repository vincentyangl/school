package com.realm;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.bean.Permissions;
import com.bean.User;
import com.service.PermissionsService;
import com.service.UserService;

public class MyRealm extends AuthorizingRealm{

	@Autowired
	private UserService userService;
	@Autowired
	private PermissionsService permissionsService;
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		//获取的登录后的用户名
		String user_name = (String) principals.getPrimaryPrincipal();
		User user = getUserByName(user_name).get(0);
		SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
		Set<String> set = new HashSet<>();
		set.add(user.getRole().getRole_name());
		//封装角色集合
		authorizationInfo.setRoles(set);
		//封装角色对应的权限集合
		authorizationInfo.setStringPermissions(getPermissionsName(user.getRole().getRole_id()));
		return authorizationInfo;
	}

	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
		//  AuthenticationToken 是从handler中传过来的 UsernamePasswordToken 他们的哈希码一致
		// 1.把 AuthenticationToken 转换为 UsernamePasswordToken
		UsernamePasswordToken upToken = (UsernamePasswordToken) token;
		// 2. 从UsernamePasswordToken中获取 username
		String username = upToken.getUsername();
		// 3.调用数据库的方法，从数据库中查询username对应的用户记录
		List<User> users = getUserByName(username);
		//4.若用户不存在，则可以抛出 UnknownAccountException 异常
		if (users.size()==0) {
			return null;
		}
		/*//5.根据用户情况，决定是否需要抛出其他 AuthenticationException 异常
			if ("monster".equals(username)) {
				throw new LockedAccountException("用户被锁定");
			}*/
		//6.根据用户情况，来构建 AuthenticationInfo 对象并返回,通常使用的实现类是  SimpleAuthenticationInfo
		//以下信息是从数据库中获取的

		//1）principal认证的实体信息，可以使username,也可以是数据表对应的用户的实体对象
		Object principal = username;
		//2)从数据库中获取的密码
		Object credentials = users.get(0).getUser_password();
		
		//3)realmName：当前realm对象的name,调用父类的getName() 方法即可
		String realmName = getName();
		//盐值
		ByteSource salt = ByteSource.Util.bytes(username);
		SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(principal, credentials,salt, realmName);
		return info;
	}
	
	public Set<String> getPermissionsName(int role_id) {
		Set<String> set = new HashSet<>();
		List<Permissions> permissions = permissionsService.getPermissionsByRoleId(role_id);
		for (Permissions permissions2 : permissions) {
			set.add(permissions2.getName());
		}
		return set;
	}

	public List<User> getUserByName(String user_name) {
		Map map = new HashMap<>();
		map.put("user_name", user_name);
		List<User> users = userService.listAll(map);
		return users;
	}
	

	public static void main(String[] args) {
		
		String hashAlgorithName="MD5";
		String pass="888888";
		Object salt=ByteSource.Util.bytes("jack");
		int count=1024;
		Object result=new SimpleHash(hashAlgorithName, pass,salt,count);
		System.out.println("result:"+result);
		
	}
	
}
