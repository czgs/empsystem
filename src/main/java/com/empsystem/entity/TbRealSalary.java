package com.empsystem.entity;

import javax.persistence.*;

/**
 * 实际工资表   （存储实际工资的表，把每个月的实际工资记录起来,到时候查询直接根据这个表查询）
 */
@Entity
@Table(name = "tb_realsalary")
public class TbRealSalary {

    private int r_no;   //实际工资 主键
    private int r_eno;  //员工表 主键
    private int r_sno;  //基本工资表 主键
    private double r_realSalary;   //实际工资表 实际工资（每个月实际发的工资）
    private String r_yearMonth;     //年月字段  （时间）

    public TbRealSalary() {
        super();
    }

    public TbRealSalary( int r_no, int r_eno, int r_sno, double r_realSalary, String r_yearMonth ) {
        this.r_no = r_no;
        this.r_eno = r_eno;
        this.r_sno = r_sno;
        this.r_realSalary = r_realSalary;
        this.r_yearMonth = r_yearMonth;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getR_no() {
        return r_no;
    }

    public void setR_no( int r_no ) {
        this.r_no = r_no;
    }

    public int getR_eno() {
        return r_eno;
    }

    public void setR_eno( int r_eno ) {
        this.r_eno = r_eno;
    }

    public int getR_sno() {
        return r_sno;
    }

    public void setR_sno( int r_sno ) {
        this.r_sno = r_sno;
    }

    public double getR_realSalary() {
        return r_realSalary;
    }

    public void setR_realSalary( double r_realSalary ) {
        this.r_realSalary = r_realSalary;
    }

    public String getR_yearMonth() {
        return r_yearMonth;
    }

    public void setR_yearMonth( String r_yearMonth ) {
        this.r_yearMonth = r_yearMonth;
    }
}
