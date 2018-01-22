package com.empsystem.dao.impl;

import com.empsystem.dao.IUserDao;
import com.empsystem.entity.TbUser;
import com.empsystem.util.PageBean;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 处理用户数据操作的持久化类
 */
@Repository("userDao")
public class UserDaoImpl extends BaseDao implements IUserDao{

    //添加用户
    @Override
    public boolean addUser( TbUser user ) {
        return addObject(user);
    }

    //查询用户
    @Override
    public List findUserList( String hql ) {
        return findObjectList(hql);
    }

    //更新用户
    @Override
    public boolean updateUser( TbUser user ) {
        return updateObject(user);
    }

    //删除用户
    @Override
    public boolean delUser( TbUser user ) {
        return deleteObject(user);
    }

    //根据id查询用户
    @Override
    public TbUser getUserById( int id ) {
       return (TbUser) getObjectById(TbUser.class,id);
    }

    //分页查询用户
    @Override
    public List findUserList( PageBean bean, String hql ) {
        try {
            Query query = getSession().createQuery(hql);
            query.setFirstResult((bean.getCpage()-1)*bean.getShowNum()); //从哪里开始查询
            query.setMaxResults(bean.getShowNum()); //设置每页显示多少行
            List list = query.list();
            return list;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
