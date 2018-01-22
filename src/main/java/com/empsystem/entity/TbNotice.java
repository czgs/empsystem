package com.empsystem.entity;

import javax.persistence.*;
import java.util.Date;

/**
 * 实体类 公告表
 */
@Entity
@Table(name = "tb_notice")
public class TbNotice {

    private int n_no;       //公告编号
    private String n_titel;  //公告标题名
    private String n_content;  //公告内容
    private Date n_date;    //公告创建时间

    //多条公告信息对应一个用户
    private TbUser user;

    public TbNotice() {
        super();
    }

    public TbNotice( int n_no, String n_titel, String n_content, Date n_date ) {
        this.n_no = n_no;
        this.n_titel = n_titel;
        this.n_content = n_content;
        this.n_date = n_date;
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getN_no() {
        return n_no;
    }

    public void setN_no( int n_no ) {
        this.n_no = n_no;
    }

    public String getN_titel() {
        return n_titel;
    }

    public void setN_titel( String n_titel ) {
        this.n_titel = n_titel;
    }

    public String getN_content() {
        return n_content;
    }

    public void setN_content( String n_content ) {
        this.n_content = n_content;
    }

    public Date getN_date() {
        return n_date;
    }

    public void setN_date( Date n_date ) {
        this.n_date = n_date;
    }

    @ManyToOne(cascade = CascadeType.REFRESH)
    @JoinColumn(name = "n_uno")
    public TbUser getUser() {
        return user;
    }

    public void setUser( TbUser user ) {
        this.user = user;
    }
}
