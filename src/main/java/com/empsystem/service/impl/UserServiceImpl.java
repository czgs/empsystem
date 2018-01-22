package com.empsystem.service.impl;

import com.empsystem.dao.IUserDao;
import com.empsystem.entity.TbUser;
import com.empsystem.service.IUserService;
import com.empsystem.util.PageBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 用户服务层业务操作
 */
@Service("userService")
@Transactional(propagation = Propagation.REQUIRED)
public class UserServiceImpl implements IUserService{

    //声明数据层接口
    @Resource(name = "userDao")
    private IUserDao userDao;

    @Override
    public TbUser doLogin(TbUser user) {
        //1.查询用户  先根据传进来的用户对象里面的 账号（u_name）查询所有相同账号
        String hql = "from TbUser where u_name='"+user.getU_name()+"'";
        List<TbUser> list = userDao.findUserList(hql);

        //2.判断查询的集合是否为空，是否有这个账号
        if(list!=null&&list.size()>0){
            //3,遍历集合并进行判断
            for (TbUser users : list) {
                if(users.getU_name().equals(user.getU_name())&&users.getU_pwd().equals(user.getU_pwd())){
                    return users;
                }
            }
        }
        return null;
    }

    @Override
    public boolean addUser( TbUser user ) {
       //1查询出数据库有没有与之相匹配的用户名
       String hql = "from TbUser where u_name='"+user.getU_name()+"'";
       //2查出来数据保存到到list
       List<TbUser> list = userDao.findUserList(hql);
       //3不为空的话，证明数据库已经有存在了，所以不能再添加了
        if(list!=null&&list.size()>0){
            return false;
        }else {
            //数据库没有此用户名，可以执行添加
            userDao.addUser(user);
            return true;
        }
    }


    @Override
    public boolean updateUser( TbUser user ) {
        return userDao.updateUser(user);
    }

    @Override
    public boolean delUser( TbUser user ) {
        return false;
    }

    @Override
    public TbUser getUserById( int id ) {
        return userDao.getUserById(id);
    }

    //分页查询用户
    @Override
    public PageBean findUserList( PageBean bean, String[] querys ) {
        String hql="from TbUser u";
       /* if(querys!=null&&querys.length>0){

        }*/
        hql+=" order by u.u_status desc";
        bean.setResult(userDao.findUserList(bean,hql)); //执行查询，并保存到bean的List中
        bean.setAllNum(userDao.findUserList(hql).size());
        return bean;
    }

    @Override
    public boolean findUserName( String uname ) {
        String hql = "from TbUser where u_name = '"+uname+"'";
        List list = userDao.findUserList(hql);
        //如果存在那么就返回假
        if(list!=null&&list.size()>0){
            return false;
        }else {
            return true;
        }
    }


    public void setUserDao( IUserDao userDao ) {
        this.userDao = userDao;
    }
}
