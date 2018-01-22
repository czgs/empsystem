package com.empsystem.entity;

import javax.persistence.*;

/**
 * 实体类 基本工资表
 */
@Entity
@Table(name = "tb_salary")
public class TbSalary {

    private int s_no;
    private double s_salary;

    public TbSalary() {
        super();
    }

    public TbSalary( int s_no, double s_salary ) {
        this.s_no = s_no;
        this.s_salary = s_salary;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getS_no() {
        return s_no;
    }

    public void setS_no( int s_no ) {
        this.s_no = s_no;
    }

    public double getS_salary() {
        return s_salary;
    }

    public void setS_salary( double s_salary ) {
        this.s_salary = s_salary;
    }
}
