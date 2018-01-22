package com.empsystem.dao;

import com.empsystem.entity.TbEmp;
import com.empsystem.entity.TbEmpInfo;
import com.empsystem.entity.TbUser;

import java.util.List;

/**
 * Created by Chen on 2017/12/29.
 */
public interface IEmpDao {

    public boolean addEmp( TbEmp emp, TbUser user);

    public List findEmpList( String hql);

    public boolean addEmpInfo( TbEmpInfo empInfo);

    public TbEmpInfo findEmpInfoById(int ei_no);

    public boolean updateEmpInfo(TbEmpInfo empInfo);

    public boolean updateEmp(TbEmp emp);

    public TbEmp getEmpById(int id);
}
