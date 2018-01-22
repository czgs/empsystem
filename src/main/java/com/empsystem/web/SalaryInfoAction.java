package com.empsystem.web;

import com.empsystem.entity.TbSalaryInfo;
import com.empsystem.service.ISalaryInfoService;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.List;

/**
 * 员工考勤 控制层
 */
@Controller("salaryInfoAction")
@Scope("prototype")
public class SalaryInfoAction {
    private TbSalaryInfo salaryInfo;
    private int msg;
    private int judgeSalaryRadio;

    private String  querys[];   //传递查询的条件
    private List salaryInfoList;
    private List salaryInfoByIdList;
    private String yearMonth;

    @Resource(name = "salaryInfoService")
    private ISalaryInfoService salaryInfoService;

    //添加奖罚工资
    public String addSalaryInfo(){
        //判断传进来的值是不是 需要减钱的，需要就要把值变为 负数
        if(judgeSalaryRadio==3){
            double value = -(salaryInfo.getSi_variate());
            salaryInfo.setSi_variate(value);
        }
       if(salaryInfoService.addSalaryInfo(salaryInfo)){
            msg = 1;
        }else{
            msg = 0;
        }
        return "msg";
    }

    //根据年月查询所有员工
    public String findSalaryInfoList(){
        salaryInfoList = salaryInfoService.findSalaryInfoList(querys);
        return "salaryInfoList";
    }

    //根据员工编号查询年、月列表
    public String findSalaryInfoByIdDateList(){
        salaryInfoByIdList = salaryInfoService.findSalaryInfoByIdDateList(salaryInfo.getEmp().getE_no(),yearMonth);
        return "salaryInfoByIdList";
    }

    //根据考勤表id 查询出一条具体信息
    public String toUpdateSalaryInfoById(){
        salaryInfo = salaryInfoService.getSalaryInfoById(salaryInfo.getSi_no());
        return "toUpdateSalaryInfo";
    }

    //执行修改考勤表数据
    public String doUpdateSalaryInfo(){
        //判断传进来的值是不是 需要减钱的，需要就要把值变为 负数
        if(judgeSalaryRadio==3){
            double value = -(salaryInfo.getSi_variate());
            salaryInfo.setSi_variate(value);
        }
        if(salaryInfoService.updateSalaryInfo(salaryInfo)){
            msg = 1;
        }else{
            msg = 0;
        }
        return "msg";
    }

    public TbSalaryInfo getSalaryInfo() {
        return salaryInfo;
    }

    public void setSalaryInfo( TbSalaryInfo salaryInfo ) {
        this.salaryInfo = salaryInfo;
    }

    public int getMsg() {
        return msg;
    }

    public void setMsg( int msg ) {
        this.msg = msg;
    }

    public void setSalaryInfoService( ISalaryInfoService salaryInfoService ) {
        this.salaryInfoService = salaryInfoService;
    }

    public List getSalaryInfoList() {
        return salaryInfoList;
    }

    public void setSalaryInfoList( List salaryInfoList ) {
        this.salaryInfoList = salaryInfoList;
    }

    public String[] getQuerys() {
        return querys;
    }

    public void setQuerys( String[] querys ) {
        this.querys = querys;
    }

    public int getJudgeSalaryRadio() {
        return judgeSalaryRadio;
    }

    public void setJudgeSalaryRadio( int judgeSalaryRadio ) {
        this.judgeSalaryRadio = judgeSalaryRadio;
    }

    public List getSalaryInfoByIdList() {
        return salaryInfoByIdList;
    }

    public void setSalaryInfoByIdList( List salaryInfoByIdList ) {
        this.salaryInfoByIdList = salaryInfoByIdList;
    }

    public String getYearMonth() {
        return yearMonth;
    }

    public void setYearMonth( String yearMonth ) {
        this.yearMonth = yearMonth;
    }
}
