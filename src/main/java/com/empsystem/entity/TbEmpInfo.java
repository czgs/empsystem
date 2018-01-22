package com.empsystem.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * 实体类 员工详细表
 */
@Entity
@Table(name = "tb_empinfo")
public class TbEmpInfo {

    private int ei_no;          //员工详细表编号
    private String ei_natio;    //民族
    private String ei_province; //省份
    private String ei_city;     //城市
    private String ei_address;  //地址
    private String ei_tel;      //手机号
    private String ei_qq;       //QQ号
    private String ei_wechar;   //微信号
    private String ei_hobby;    //爱好
    private String ei_motto;    //座右铭
    private Date ei_date;       //入职时间
    private String ei_card;     //身份证号

    //每一条详细记录对应一个员工
    private TbEmp emp;

    public TbEmpInfo() {
        super();
    }

    public TbEmpInfo( int ei_no, String ei_natio, String ei_province, String ei_city, String ei_address, String ei_tel, String ei_qq, String ei_wechar, String ei_hobby, String ei_motto ,Date ei_date,String ei_card) {
        this.ei_no = ei_no;
        this.ei_natio = ei_natio;
        this.ei_province = ei_province;
        this.ei_city = ei_city;
        this.ei_address = ei_address;
        this.ei_tel = ei_tel;
        this.ei_qq = ei_qq;
        this.ei_wechar = ei_wechar;
        this.ei_hobby = ei_hobby;
        this.ei_motto = ei_motto;
        this.ei_date = ei_date;
        this.ei_card = ei_card;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getEi_no() {
        return ei_no;
    }

    public void setEi_no( int ei_no ) {
        this.ei_no = ei_no;
    }

    public String getEi_natio() {
        return ei_natio;
    }

    public void setEi_natio( String ei_natio ) {
        this.ei_natio = ei_natio;
    }

    public String getEi_province() {
        return ei_province;
    }

    public void setEi_province( String ei_province ) {
        this.ei_province = ei_province;
    }

    public String getEi_city() {
        return ei_city;
    }

    public void setEi_city( String ei_city ) {
        this.ei_city = ei_city;
    }

    public String getEi_address() {
        return ei_address;
    }

    public void setEi_address( String ei_address ) {
        this.ei_address = ei_address;
    }

    public String getEi_tel() {
        return ei_tel;
    }

    public void setEi_tel( String ei_tel ) {
        this.ei_tel = ei_tel;
    }

    public String getEi_qq() {
        return ei_qq;
    }

    public void setEi_qq( String ei_qq ) {
        this.ei_qq = ei_qq;
    }

    public String getEi_wechar() {
        return ei_wechar;
    }

    public void setEi_wechar( String ei_wechar ) {
        this.ei_wechar = ei_wechar;
    }

    public String getEi_hobby() {
        return ei_hobby;
    }

    public void setEi_hobby( String ei_hobby ) {
        this.ei_hobby = ei_hobby;
    }

    public String getEi_motto() {
        return ei_motto;
    }

    public void setEi_motto( String ei_motto ) {
        this.ei_motto = ei_motto;
    }

    public Date getEi_date() {
        return ei_date;
    }

    public void setEi_date( Date ei_date ) {
        this.ei_date = ei_date;
    }

    public String getEi_card() {
        return ei_card;
    }

    public void setEi_card( String ei_card ) {
        this.ei_card = ei_card;
    }

    @OneToOne(cascade = CascadeType.REFRESH)
    @JoinColumn(name = "ei_eno")
    public TbEmp getEmp() {
        return emp;
    }

    public void setEmp( TbEmp emp ) {
        this.emp = emp;
    }
}
