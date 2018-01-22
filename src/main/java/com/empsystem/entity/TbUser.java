package com.empsystem.entity;

import javax.persistence.*;

/**
 * 实体类 用户表
 */
@Entity
@Table(name = "tb_user")
public class TbUser {

    private int u_no;      //用户编号
    private String u_name; //账号
    private String u_pwd;  //密码
    private int u_status=0; //身份  2：超级管理员    1：普通管理员   0：员工  默认为0

    public TbUser() {
        super();
    }

    public TbUser( int u_no, String u_name, String u_pwd, int u_status ) {
        this.u_no = u_no;
        this.u_name = u_name;
        this.u_pwd = u_pwd;
        this.u_status = u_status;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getU_no() {
        return u_no;
    }

    public void setU_no( int u_no ) {
        this.u_no = u_no;
    }

    //@Column(nullable=false,unique=true) //这个是标注为 不能为空 和 唯一
    public String getU_name() {
        return u_name;
    }

    public void setU_name( String u_name ) {
        this.u_name = u_name;
    }

    public String getU_pwd() {
        return u_pwd;
    }

    public void setU_pwd( String u_pwd ) {
        this.u_pwd = u_pwd;
    }

    public int getU_status() {
        return u_status;
    }

    public void setU_status( int u_status ) {
        this.u_status = u_status;
    }
}
