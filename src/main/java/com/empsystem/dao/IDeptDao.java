package com.empsystem.dao;


import com.empsystem.entity.TbDept;

import java.util.List;

public interface IDeptDao {

    //添加部门
    public boolean addDept(TbDept dept);

    //删除部门
    public boolean delDept(TbDept dept);

    //根据id获取部门对象
    public TbDept getDeptById(int id);

    //查询用户
    public List findDeptList(String hql);

    //修改用户
    public boolean updateDept(TbDept dept);
}
