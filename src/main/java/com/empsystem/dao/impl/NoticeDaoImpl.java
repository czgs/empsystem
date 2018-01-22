package com.empsystem.dao.impl;

import com.empsystem.dao.INoticeDao;
import com.empsystem.entity.TbNotice;
import com.empsystem.util.PageBean;
import org.hibernate.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 公告表 持久化数据库操作类
 */
@Repository("noticeDao")
public class NoticeDaoImpl extends BaseDao implements INoticeDao{
    @Override
    public boolean addNotice( TbNotice notice ) {
        return addObject(notice);
    }

    @Override
    public boolean updateNotice( TbNotice notice ) {
       return updateObject(notice);
    }

    @Override
    public boolean delNotice( TbNotice notice ) {
        return deleteObject(notice);
    }

    @Override
    public TbNotice getNoticeById( int id ) {
        return (TbNotice) getObjectById(TbNotice.class,id);
    }

    @Override
    public List findNoticeList( String hql ) {
        return findObjectList(hql);
    }

    @Override
    public List findNoticeList( PageBean bean, String hql ) {
        try{
            Query query = getSession().createQuery(hql);
            query.setFirstResult((bean.getCpage()-1)*bean.getShowNum());    //从哪里开始查询
            query.setMaxResults(bean.getShowNum());
            List list = query.list();
            return list;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
