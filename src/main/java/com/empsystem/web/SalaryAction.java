package com.empsystem.web;

import com.empsystem.entity.TbSalary;
import com.empsystem.service.ISalaryService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.List;

/**
 * 工资的控制层
 */
@Controller("salaryAction")
@Scope("prototype")
public class SalaryAction {

    private TbSalary salary;
    private int msg;
    private List salaryList;

    @Resource(name = "salaryService")
    private ISalaryService salaryService;

    //添加工资
    public String addSalary(){
        if(salaryService.addSalary(salary)){
            msg=1;
        }else{
            msg=0;
        }
        return "msg";
    }

    //查询工资列表
    public String findSalaryList(){
        salaryList = salaryService.findSalaryList();
        return "toSalaryList";
    }

    //去到修改页面，查出对象的信息
    public String toUpdateSalary(){
        salary = salaryService.getSalaryById(salary.getS_no());
        return "toUpdateSalary";
    }

    //确定修改对象信息
    public String doUpdateSalary(){
        if(salaryService.updateSalary(salary)){
            msg=1;
        }else{
            msg=0;
        }
        return "msg";
    }

    //删除工资
    public String delSalary(){
        if(salaryService.delSalary(salary)){
            msg=1;
        }else{
            msg=0;
        }
        return "msg";
    }


    public TbSalary getSalary() {
        return salary;
    }

    public void setSalary( TbSalary salary ) {
        this.salary = salary;
    }

    public int getMsg() {
        return msg;
    }

    public void setMsg( int msg ) {
        this.msg = msg;
    }

    public void setSalaryService( ISalaryService salaryService ) {
        this.salaryService = salaryService;
    }

    public List getSalaryList() {
        return salaryList;
    }

    public void setSalaryList( List salaryList ) {
        this.salaryList = salaryList;
    }
}
