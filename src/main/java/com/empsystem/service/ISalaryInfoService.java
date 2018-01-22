package com.empsystem.service;

import com.empsystem.entity.TbSalaryInfo;

import java.util.List;

public interface ISalaryInfoService {

    public boolean addSalaryInfo( TbSalaryInfo salaryInfo);

    public List findSalaryInfoList(String[] querys);

    public List findSalaryInfoByIdDateList(int eno,String yearMonth);

    public TbSalaryInfo getSalaryInfoById(int id);

    public boolean updateSalaryInfo(TbSalaryInfo salaryInfo);
}
