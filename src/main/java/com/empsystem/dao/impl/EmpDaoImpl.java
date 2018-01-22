package com.empsystem.dao.impl;

import com.empsystem.dao.IEmpDao;
import com.empsystem.entity.TbEmp;
import com.empsystem.entity.TbEmpInfo;
import com.empsystem.entity.TbUser;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 员工数据 持久层
 */
@Repository("empDao")
public class EmpDaoImpl extends BaseDao implements IEmpDao{

    //添加员工
    @Override
    public boolean addEmp( TbEmp emp, TbUser user ) {
        try {
            //先将用户账号密码 返回的id接受起来
            Integer uno = (Integer)getSession().save(user);
            //再执行持久化，把返回的id 赋值给传进来的user
            user.setU_no(uno);
            //将这个有id的user 赋值给 这个员工
            emp.setUser(user);
            getSession().save(emp);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //查询所有员工
    @Override
    public List findEmpList( String hql ) {
       return findObjectList(hql);
    }

    @Override
    public boolean addEmpInfo( TbEmpInfo empInfo ) {
        return addObject(empInfo);
    }

    @Override
    public TbEmpInfo findEmpInfoById( int ei_no ) {
        return (TbEmpInfo) getObjectById(TbEmpInfo.class,ei_no);
    }

    @Override
    public boolean updateEmpInfo( TbEmpInfo empInfo ) {
        return updateObject(empInfo);
    }

    @Override
    public boolean updateEmp( TbEmp emp ) {
        return updateObject(emp);
    }

    @Override
    public TbEmp getEmpById( int id ) {
        return (TbEmp) getObjectById(TbEmp.class,id);
    }


}
