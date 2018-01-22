package com.empsystem.dao;

import com.empsystem.entity.TbNotice;
import com.empsystem.util.PageBean;

import java.util.List;

/**
 * Created by Chen on 2017/12/25.
 */
public interface INoticeDao {

    public boolean addNotice( TbNotice notice);

    public boolean updateNotice(TbNotice notice);

    public boolean delNotice(TbNotice notice);

    public TbNotice getNoticeById(int id);

    public List findNoticeList(String hql);

    public List findNoticeList( PageBean bean,String hql);
}
