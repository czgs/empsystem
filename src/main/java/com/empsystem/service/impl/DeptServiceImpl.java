package com.empsystem.service.impl;

import com.empsystem.dao.IDeptDao;
import com.empsystem.entity.TbDept;
import com.empsystem.service.IDeptService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 部门业务服务层操作
 */
@Service("deptService")
@Transactional(propagation = Propagation.REQUIRED)
public class DeptServiceImpl implements IDeptService{

    //声明数据层接口
    @Resource(name ="deptDao")
    private IDeptDao deptDao;

    //添加部门名称
    @Override
    public boolean addDept( TbDept dept ) {
        String hql = "from TbDept where d_name='"+dept.getD_name()+"'";
        List list = deptDao.findDeptList(hql);
        //如果不为空 ，证明已经有这个部门了，不需要再添加
        if(list!=null&&list.size()>0){
            return false;
        }else{
            //上面list集合为空，那么执行添加部门操作
            return deptDao.addDept(dept);
        }
    }

    @Override
    public boolean delDept( TbDept dept ) {
        return deptDao.delDept(dept);
    }

    @Override
    public TbDept getDeptById( int id ) {
        return deptDao.getDeptById(id);
    }

    @Override
    public List findDeptList() {
        String hql = "from TbDept";
        return deptDao.findDeptList(hql);
    }

    @Override
    public boolean updateDept(TbDept dept) {
        return deptDao.updateDept(dept);
    }

    public void setDeptDao( IDeptDao deptDao ) {
        this.deptDao = deptDao;
    }
}
