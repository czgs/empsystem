package com.empsystem.service;


import com.empsystem.entity.TbNotice;
import com.empsystem.util.PageBean;

public interface INoticeService {

    public boolean addNotice( TbNotice notice);

    public boolean updateNotice(TbNotice notice);

    public boolean delNotice(TbNotice notice);

    public TbNotice getNoticeById(int id);

    public PageBean findNoticeList( PageBean bean,String[] querys);
}
