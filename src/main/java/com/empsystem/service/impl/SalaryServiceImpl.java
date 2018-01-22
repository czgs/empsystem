package com.empsystem.service.impl;
import com.empsystem.dao.ISalaryDao;
import com.empsystem.entity.TbSalary;
import com.empsystem.service.ISalaryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 处理工资业务层操作类
 */
@Service("salaryService")
@Transactional(propagation = Propagation.REQUIRED)
public class SalaryServiceImpl implements ISalaryService{

    //声明数据层接口
    @Resource(name = "salaryDao")
    private ISalaryDao salaryDao;

    @Override
    public boolean addSalary( TbSalary salary ) {
        return salaryDao.addSalary(salary);
    }

    @Override
    public boolean delSalary( TbSalary salary ) {
        return salaryDao.delSalary(salary);
    }

    @Override
    public TbSalary getSalaryById(int id) {
        return salaryDao.getSalaryById(id);
    }

    @Override
    public List findSalaryList() {
        String hql= "from TbSalary";
        return salaryDao.findSalaryList(hql);
    }

    @Override
    public boolean updateSalary( TbSalary salary ) {
        return salaryDao.updateSalary(salary);
    }

    public void setSalaryDao( ISalaryDao salaryDao ) {
        this.salaryDao = salaryDao;
    }
}
