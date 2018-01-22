package com.empsystem.dao.impl;


import com.empsystem.dao.ISalaryDao;
import com.empsystem.entity.TbSalary;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 工资持久化数据库操作类
 */
@Repository("salaryDao")
public class SalaryDaoImpl extends BaseDao implements ISalaryDao{
    @Override
    public boolean addSalary( TbSalary salary ) {
        return addObject(salary);
    }

    @Override
    public boolean delSalary( TbSalary salary ) {
        return deleteObject(salary);
    }

    @Override
    public TbSalary getSalaryById( int id ) {
        return (TbSalary)getObjectById(TbSalary.class,id);
    }

    @Override
    public List findSalaryList( String hql ) {
        return findObjectList(hql);
    }

    @Override
    public boolean updateSalary( TbSalary salary ) {
         return updateObject(salary);
    }
}
