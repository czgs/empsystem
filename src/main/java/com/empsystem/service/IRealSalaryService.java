package com.empsystem.service;


import com.empsystem.entity.TbRealSalary;

import java.util.List;

public interface IRealSalaryService {

    public boolean addRealSalary( TbRealSalary realSalary);

    public boolean updateRealSalary(TbRealSalary realSalary);

    public boolean delRealSalary(TbRealSalary realSalary);

    public List findRealSalaryList(String[] querys);

    public TbRealSalary getRealSalaryById(int id);

    public List findRealAndVariateSalaryList(int id,String year);
}
