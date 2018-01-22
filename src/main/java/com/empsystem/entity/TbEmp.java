package com.empsystem.entity;

import javax.persistence.*;

/**
 * 实体类 员工表
 */
@Entity
@Table(name = "tb_emp")
public class TbEmp {

    private int e_no; //员工编号
    private String e_name;  //员工姓名
    private String e_sex;   //员工性别
    private int e_age;  //员工年龄
    private String e_image;//员工头像

    //一个员工对应一个用户名
    private TbUser user;

    //多个员工对应一个部门
    private TbDept dept;

    //多个员工对应一份固定工资
    private TbSalary salary;

    public TbEmp() {
        super();
    }

    public TbEmp( int e_no, String e_name, String e_sex, int e_age, String e_image ) {
        this.e_no = e_no;
        this.e_name = e_name;
        this.e_sex = e_sex;
        this.e_age = e_age;
        this.e_image = e_image;
    }


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getE_no() {
        return e_no;
    }

    public void setE_no( int e_no ) {
        this.e_no = e_no;
    }

    public String getE_name() {
        return e_name;
    }

    public void setE_name( String e_name ) {
        this.e_name = e_name;
    }

    public String getE_sex() {
        return e_sex;
    }

    public void setE_sex( String e_sex ) {
        this.e_sex = e_sex;
    }

    public int getE_age() {
        return e_age;
    }

    public void setE_age( int e_age ) {
        this.e_age = e_age;
    }

    public String getE_image() {
        return e_image;
    }

    public void setE_image( String e_image ) {
        this.e_image = e_image;
    }

    @OneToOne(cascade = CascadeType.REFRESH)
    @JoinColumn(name = "e_uno")
    public TbUser getUser() {
        return user;
    }

    public void setUser( TbUser user ) {
        this.user = user;
    }

    @ManyToOne(cascade = CascadeType.REFRESH)
    @JoinColumn(name = "e_dno")
    public TbDept getDept() {
        return dept;
    }

    public void setDept( TbDept dept ) {
        this.dept = dept;
    }

    @ManyToOne(cascade = CascadeType.REFRESH)
    @JoinColumn(name = "e_sno")
    public TbSalary getSalary() {
        return salary;
    }

    public void setSalary( TbSalary salary ) {
        this.salary = salary;
    }
}
