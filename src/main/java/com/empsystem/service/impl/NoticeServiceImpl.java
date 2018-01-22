package com.empsystem.service.impl;

import com.empsystem.dao.INoticeDao;
import com.empsystem.dao.IUserDao;
import com.empsystem.entity.TbNotice;
import com.empsystem.service.INoticeService;
import com.empsystem.util.PageBean;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * 公告表 服务层操作
 */
@Service("noticeService")
@Transactional(propagation = Propagation.REQUIRED)
public class NoticeServiceImpl implements INoticeService{

    //声明公告表数据层接口
    @Resource(name = "noticeDao")
    private INoticeDao noticeDao;
    //声明用户表数据层接口
    @Resource(name = "userDao")
    private IUserDao userDao;

    @Override
    public boolean addNotice( TbNotice notice) {
        return noticeDao.addNotice(notice);
    }

    @Override
    public boolean updateNotice( TbNotice notice ) {
        return noticeDao.updateNotice(notice);
    }

    @Override
    public boolean delNotice( TbNotice notice ) {
        return noticeDao.delNotice(notice);
    }

    @Override
    public TbNotice getNoticeById( int id ) {
        return noticeDao.getNoticeById(id);
    }

    @Override
    public PageBean findNoticeList( PageBean bean, String[] querys) {
        String hql = "select n ,e from TbNotice n inner join TbUser u on n.user.u_no = u.u_no " +
                "left join TbEmp e on e.user.u_no = u.u_no order by n.n_date desc";
        bean.setResult(noticeDao.findNoticeList(bean,hql));
        bean.setAllNum(noticeDao.findNoticeList(hql).size());   //设置总条数
        return bean;
    }

    public void setNoticeDao( INoticeDao noticeDao ) {
        this.noticeDao = noticeDao;
    }

    public void setUserDao( IUserDao userDao ) {
        this.userDao = userDao;
    }
}
