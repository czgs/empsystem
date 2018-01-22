package com.empsystem.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * 实体类 工资详细表
 */
@Entity
@Table(name = "tb_salaryinfo")
public class TbSalaryInfo {

    private int si_no;  //编号
    private String si_casetype; //请假类型
    private String si_titel;    //请假标题名
    private String si_content;  //请假详细内容
    private Date si_time;  //发表时间
    private double si_variate;  //奖金&罚扣


    //多条考勤工资详细记录对应一个员工
    private TbEmp emp;

    public TbSalaryInfo() {
        super();
    }

    public TbSalaryInfo( int si_no, String si_casetype, String si_titel, String si_content, Date si_time, double si_variate ) {
        this.si_no = si_no;
        this.si_casetype = si_casetype;
        this.si_titel = si_titel;
        this.si_content = si_content;
        this.si_time = si_time;
        this.si_variate = si_variate;

    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getSi_no() {
        return si_no;
    }

    public void setSi_no( int si_no ) {
        this.si_no = si_no;
    }

    public String getSi_casetype() {
        return si_casetype;
    }

    public void setSi_casetype( String si_casetype ) {
        this.si_casetype = si_casetype;
    }

    public String getSi_titel() {
        return si_titel;
    }

    public void setSi_titel( String si_titel ) {
        this.si_titel = si_titel;
    }

    public String getSi_content() {
        return si_content;
    }

    public void setSi_content( String si_content ) {
        this.si_content = si_content;
    }

    public Date getSi_time() {
        return si_time;
    }

    public void setSi_time( Date si_time ) {
        this.si_time = si_time;
    }

    public double getSi_variate() {
        return si_variate;
    }

    public void setSi_variate( double si_variate ) {
        this.si_variate = si_variate;
    }


    @ManyToOne
    @JoinColumn(name = "si_eno")
    public TbEmp getEmp() {
        return emp;
    }

    public void setEmp( TbEmp emp ) {
        this.emp = emp;
    }
}
