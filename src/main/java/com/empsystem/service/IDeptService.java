package com.empsystem.service;

import com.empsystem.entity.TbDept;

import java.util.List;

/**
 * Created by Chen on 2017/12/22.
 */
public interface IDeptService {

    //添加部门
    public boolean addDept(TbDept dept);

    //删除部门
    public boolean delDept(TbDept dept);

    //根据id获取部门对象
    public TbDept getDeptById(int id);

    //查询部门
    public List findDeptList();

    //修改部门
    public boolean updateDept(TbDept dept);
}
