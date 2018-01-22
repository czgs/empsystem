package com.empsystem.web;

import com.empsystem.entity.TbRealSalary;
import com.empsystem.service.IRealSalaryService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.List;

/**
 * 实际工资 控制层
 */
@Controller("realSalaryAction")
@Scope("prototype")
public class RealSalaryAction {

    private TbRealSalary realSalary;
    private int msg;
    private List realSalaryList;
    private String  querys[];   //传递查询的条件
    private String year;
    private List realAndvariateList;

    @Resource(name = "realSalaryService")
    private IRealSalaryService realSalaryService;

    public String findRealSalaryList(){
        realSalaryList = realSalaryService.findRealSalaryList(querys);
        return "realSalaryList";
    }

    public String findRealAndVariateSalaryList(){
        realAndvariateList = realSalaryService.findRealAndVariateSalaryList(realSalary.getR_eno(),year);
        return "realAndvariateList";
    }

    public TbRealSalary getRealSalary() {
        return realSalary;
    }

    public void setRealSalary( TbRealSalary realSalary ) {
        this.realSalary = realSalary;
    }

    public int getMsg() {
        return msg;
    }

    public void setMsg( int msg ) {
        this.msg = msg;
    }

    public void setRealSalaryService( IRealSalaryService realSalaryService ) {
        this.realSalaryService = realSalaryService;
    }

    public List getRealSalaryList() {
        return realSalaryList;
    }

    public void setRealSalaryList( List realSalaryList ) {
        this.realSalaryList = realSalaryList;
    }

    public String[] getQuerys() {
        return querys;
    }

    public void setQuerys( String[] querys ) {
        this.querys = querys;
    }

    public String getYear() {
        return year;
    }

    public void setYear( String year ) {
        this.year = year;
    }

    public List getRealAndvariateList() {
        return realAndvariateList;
    }

    public void setRealAndvariateList( List realAndvariateList ) {
        this.realAndvariateList = realAndvariateList;
    }
}
