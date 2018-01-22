package com.empsystem.service.impl;


import com.empsystem.dao.IEmpDao;
import com.empsystem.dao.IUserDao;
import com.empsystem.entity.TbEmp;
import com.empsystem.entity.TbEmpInfo;
import com.empsystem.entity.TbUser;
import com.empsystem.service.IEmpService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service("empService")
@Transactional(propagation = Propagation.REQUIRED)
public class EmpServiceImpl implements IEmpService{

    @Resource(name = "empDao")
    private IEmpDao empDao;

    @Resource(name = "userDao")
    private IUserDao userDao;

    //添加员工信息
    @Override
    public boolean addEmp( TbEmp emp, TbUser user) {
        return empDao.addEmp(emp,user);

    }

    @Override
    public List findEmpList() {
        String hql = "from TbEmp e left join TbEmpInfo ei on e.e_no = ei.emp.e_no";
        return empDao.findEmpList(hql);
    }

    @Override
    public boolean addEmpInfo( TbEmpInfo empInfo ) {
        return empDao.addEmpInfo(empInfo);
    }

    @Override
    public TbEmpInfo findEmpInfoById( int ei_no) {
        return empDao.findEmpInfoById(ei_no);
    }

    @Override
    public boolean updateEmpInfo( TbEmpInfo empInfo,TbEmp emp,TbUser user) {
       if(userDao.updateUser(user)){
            if(empDao.updateEmp(emp)){
                empInfo.setEmp(emp);
                empInfo.getEmp().setUser(user);
                return empDao.updateEmpInfo(empInfo);
            }
        }
        return false;
    }

    public void setEmpDao( IEmpDao empDao ) {
        this.empDao = empDao;
    }

    public void setUserDao( IUserDao userDao ) {
        this.userDao = userDao;
    }
}
