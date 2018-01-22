package com.empsystem.dao;

import com.empsystem.entity.TbSalaryInfo;

import java.util.List;

/**
 * Created by Chen on 2018/1/4.
 */
public interface ISalaryInfoDao {

    public boolean addSalaryInfo( TbSalaryInfo salaryInfo);

    public List findSalaryInfoList(String hql);

    public TbSalaryInfo getSalaryInfoById(int id);

    public boolean updateSalaryInfo(TbSalaryInfo salaryInfo);
}
