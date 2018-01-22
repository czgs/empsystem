package com.empsystem.entity;

import javax.persistence.*;

/**
 * 实体类 部分表
 */
@Entity
@Table(name = "tb_dept")
public class TbDept {

    private int d_no;   //部门编号
    private String d_name;  //部门名称

    public TbDept() {
        super();
    }

    public TbDept( int d_no, String d_name ) {
        this.d_no = d_no;
        this.d_name = d_name;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getD_no() {
        return d_no;
    }

    public void setD_no( int d_no ) {
        this.d_no = d_no;
    }

    public String getD_name() {
        return d_name;
    }

    public void setD_name( String d_name ) {
        this.d_name = d_name;
    }
}
