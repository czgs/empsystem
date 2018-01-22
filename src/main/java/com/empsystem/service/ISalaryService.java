package com.empsystem.service;


import com.empsystem.entity.TbSalary;

import java.util.List;

public interface ISalaryService {

    public boolean addSalary(TbSalary salary);

    public boolean delSalary(TbSalary salary);

    public TbSalary getSalaryById(int id);

    public List findSalaryList();

    public boolean updateSalary(TbSalary salary);
}
