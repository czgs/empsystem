package com.empsystem.dao.impl;

import com.empsystem.dao.ISalaryInfoDao;
import com.empsystem.entity.TbSalaryInfo;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("salaryInfoDao")
public class SalaryInfoDaoImpl extends BaseDao implements ISalaryInfoDao{

    @Override
    public boolean addSalaryInfo( TbSalaryInfo salaryInfo ) {
        return addObject(salaryInfo);
    }

    @Override
    public List findSalaryInfoList( String hql ) {
        return findObjectList(hql);
    }

    @Override
    public TbSalaryInfo getSalaryInfoById( int id ) {
        return (TbSalaryInfo) getObjectById(TbSalaryInfo.class,id);
    }

    @Override
    public boolean updateSalaryInfo( TbSalaryInfo salaryInfo ) {
        return updateObject(salaryInfo);
    }


}
