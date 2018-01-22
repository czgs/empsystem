package com.empsystem.dao.impl;

import com.empsystem.dao.IDeptDao;
import com.empsystem.entity.TbDept;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 处理部门数据持久化操作
 */
@Repository("deptDao")
public class DeptDaoImpl extends BaseDao implements IDeptDao{
    @Override
    public boolean addDept( TbDept dept ) {
        return addObject(dept);
    }

    @Override
    public boolean delDept( TbDept dept ) {
        return deleteObject(dept);
    }

    @Override
    public TbDept getDeptById( int id ) {
        return (TbDept) getObjectById(TbDept.class,id);
    }

    @Override
    public List findDeptList( String hql ) {
        return findObjectList(hql);
    }

    @Override
    public boolean updateDept( TbDept dept ) {
        return updateObject(dept);
    }
}
