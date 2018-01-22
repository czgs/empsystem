package com.empsystem.web;

import com.empsystem.entity.TbDept;
import com.empsystem.service.IDeptService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.List;

/**
 * 处理部门的Action
 */
@Controller("deptAction")
@Scope("prototype")
public class DeptAction {

    private TbDept dept;
    private int msg;
    private List deptList;

    @Resource(name = "deptService")
    private IDeptService deptService;

    public String addDept(){
        if(deptService.addDept(dept)){
            msg=1;
        }else{
            msg=0;
        }
        return "msg";
    }

    public String findDeptList(){
        deptList = deptService.findDeptList();
        return "toDeptList";
    }

    public String toUpdateDept(){
        dept = deptService.getDeptById(dept.getD_no());
        return "toUpdateDept";
    }

    public String doUpdateDept(){
        if(deptService.updateDept(dept)){
            msg=1;
        }else {
            msg=0;
        }
        return "msg";
    }

    public String delDept(){
        if(deptService.delDept(dept)){
            msg=1;
        }else{
            msg=0;
        }
        return "msg";
    }

    public TbDept getDept() {
        return dept;
    }

    public void setDept( TbDept dept ) {
        this.dept = dept;
    }

    public int getMsg() {
        return msg;
    }

    public void setMsg( int msg ) {
        this.msg = msg;
    }

    public List getDeptList() {

        return deptList;
    }

    public void setDeptList( List deptList ) {
        this.deptList = deptList;
    }
}
