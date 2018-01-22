package com.empsystem.dao;

import com.empsystem.entity.TbRealSalary;

import java.util.List;

public interface IRealSalaryDao {
    public boolean addRealSalary( TbRealSalary realSalary);

    public boolean updateRealSalary(TbRealSalary realSalary);

    public boolean delRealSalary(TbRealSalary realSalary);

    public List findRealSalaryList(String hql);

    public TbRealSalary getRealSalaryById(int id);
}
