package com.empsystem.dao;

import com.empsystem.entity.TbSalary;

import java.util.List;

public interface ISalaryDao {

    public boolean addSalary(TbSalary salary);

    public boolean delSalary(TbSalary salary);

    public TbSalary getSalaryById(int id);

    public List findSalaryList(String hql);

    public boolean updateSalary(TbSalary salary);
}
