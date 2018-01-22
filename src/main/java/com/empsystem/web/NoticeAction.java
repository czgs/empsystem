package com.empsystem.web;

import com.empsystem.entity.TbNotice;
import com.empsystem.entity.TbUser;
import com.empsystem.service.INoticeService;
import com.empsystem.util.PageBean;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import java.util.List;

/**
 * 公告表 控制层操作类
 */
@Controller("noticeAction")
@Scope("prototype")
public class NoticeAction {

    private TbUser user;
    private TbNotice notice;
    private int msg;
    private List noticeList;
    private PageBean bean;

    @Resource(name = "noticeService")
    private INoticeService noticeService;

    //发布公告
    public String addNotice(){

        if(noticeService.addNotice(notice)){
            msg=1;
        }else{
            msg=0;
        }
        return "msg";
    }

    //查询所有公告信息
    public String findNoticeList(){
        bean = noticeService.findNoticeList( bean,null);
        return "noticeList";
    }

    //查询出公告读条信息
    public String toUpdateNotice(){
       notice = noticeService.getNoticeById(notice.getN_no());
       return "notice";
    }

    //修改公告信息
    public String doUpdateNotice(){
        if(noticeService.updateNotice(notice)){
            msg = 1;
        }else{
            msg =0;
        }
        return "msg";
    }

    //删除公告信息
    public String delNotice(){
        if(noticeService.delNotice(notice)){
            msg = 1;
        }else{
            msg = 0;
        }
        return "msg";
    }

    public TbUser getUser() {
        return user;
    }

    public void setUser( TbUser user ) {
        this.user = user;
    }

    public TbNotice getNotice() {
        return notice;
    }

    public void setNotice( TbNotice notice ) {
        this.notice = notice;
    }

    public int getMsg() {
        return msg;
    }

    public void setMsg( int msg ) {
        this.msg = msg;
    }

    public void setNoticeService( INoticeService noticeService ) {
        this.noticeService = noticeService;
    }

    public List getNoticeList() {
        return noticeList;
    }

    public void setNoticeList( List noticeList ) {
        this.noticeList = noticeList;
    }

    public PageBean getBean() {
        return bean;
    }

    public void setBean( PageBean bean ) {
        this.bean = bean;
    }
}
