package com.empsystem.service;

import com.empsystem.entity.TbUser;
import com.empsystem.util.PageBean;

/**
 * 定义用户相关业务的接口
 */
public interface IUserService {


    //用户登录
    public TbUser doLogin(TbUser user);

    //添加用户
    public boolean addUser(TbUser user);

    //修改用户
    public boolean updateUser(TbUser user);

    //删除用户
    public boolean delUser(TbUser user);

    //根据Id查询用户
    public TbUser getUserById(int id);

    //分页带条件查询所有用户
    public PageBean findUserList(PageBean bean,String[] querys);

    //根据账号查询出数据库有无此账号
    public boolean findUserName( String uname);

}
