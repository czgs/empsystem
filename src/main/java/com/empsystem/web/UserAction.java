package com.empsystem.web;

import com.empsystem.entity.TbUser;
import com.empsystem.service.IUserService;
import com.empsystem.util.PageBean;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

/**
 * 处理用户请求的Action
 */
@Controller("userAction")
@Scope("prototype")
public class UserAction extends ActionSupport{

    private TbUser user;
    private PageBean bean;
    private int msg;

    //声明服务层接口
    @Resource(name = "userService")
    private IUserService userService;

    public static void main( String[] args ) {
        String str1 = "1 2 3          4 54       5 6";
        String[] numbers = str1.split(" +");
        String i="";
        for (String temp : numbers) {
            i+=temp;

        }
        System.out.println(i);
    }

    //处理用户登录
    public String doLogin(){
        //调用服务层查询 是否有这个用户
        user = userService.doLogin(user);

        if(user==null){
            addActionError("用户名或密码有误");
            return "input";
        }else{
            System.out.println("当前用户是："+user.getU_name());
            ActionContext.getContext().getSession().put("loginUser",user);
        }
        return "main";
    }

    //根据账号判断是否有这个用户存在
    public String findUserName(){
        if(userService.findUserName(user.getU_name())==false){
            msg = 1;
        }
        return  "msg";
    }


    //分页查询所有用户
    public String findUserList(){
        //调用服务层
        bean = userService.findUserList(bean,null);
        return "userList";
    }

    //添加用户
    public String doAddUser(){
        if(userService.addUser(user)){
            msg=1;
        }else{
            msg=0;
        }
        return "msg";
    }

    //去到修改用户
    public String toUpdateUser(){
        user = userService.getUserById(user.getU_no());
        return "toUpdateUser";
    }

    //执行修改用户
    public String doUpdateUser(){
       if(userService.updateUser(user)){
            msg=1;
        }else{
            msg=0;
        }
        return "msg";
      /*  System.out.println(user.getU_name()+","+user.getU_pwd());
       return null;*/
    }


    public TbUser getUser() {
        return user;
    }

    public void setUser( TbUser user ) {
        this.user = user;
    }

    public PageBean getBean() {
        return bean;
    }

    public void setBean( PageBean bean ) {
        this.bean = bean;
    }

    public void setUserService( IUserService userService ) {
        this.userService = userService;
    }

    public int getMsg() {
        return msg;
    }

    public void setMsg( int msg ) {
        this.msg = msg;
    }
}
