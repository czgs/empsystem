package com.empsystem.dao;

import com.empsystem.entity.TbUser;
import com.empsystem.util.PageBean;

import java.util.List;

/**
 * 定义用户相关数据操作的接口
 */
public interface IUserDao {

   //添加用户
    public boolean addUser(TbUser user);

    //查询所有用户
    public List findUserList(String hql);

    //修改用户
    public boolean updateUser(TbUser user);

    //删除用户
    public boolean delUser(TbUser user);

    //根据Id查询用户
    public TbUser getUserById(int id);

    //分页查询用户
    public List findUserList(PageBean bean,String hql);
}
