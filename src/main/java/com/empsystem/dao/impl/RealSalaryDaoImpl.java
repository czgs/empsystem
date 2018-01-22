package com.empsystem.dao.impl;

import com.empsystem.dao.IRealSalaryDao;
import com.empsystem.entity.TbRealSalary;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 实际工资表 数据库操作 持久化
 */
@Repository("realSalaryDao")
public class RealSalaryDaoImpl extends BaseDao implements IRealSalaryDao{
    @Override
    public boolean addRealSalary( TbRealSalary realSalary ) {
        return addObject(realSalary);
    }

    @Override
    public boolean updateRealSalary( TbRealSalary realSalary ) {
        return updateObject(realSalary);
    }

    @Override
    public boolean delRealSalary( TbRealSalary realSalary ) {
        return deleteObject(realSalary);
    }

    @Override
    public List findRealSalaryList( String hql ) {
        return findObjectList(hql);
    }

    @Override
    public TbRealSalary getRealSalaryById( int id ) {
        return (TbRealSalary) getObjectById(TbRealSalary.class,id);
    }
}
