package com.empsystem.web;

import com.empsystem.entity.TbEmp;
import com.empsystem.entity.TbEmpInfo;
import com.empsystem.entity.TbUser;
import com.empsystem.service.IEmpService;
import org.apache.struts2.ServletActionContext;
import org.aspectj.util.FileUtil;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.jsp.PageContext;
import java.io.File;
import java.io.IOException;
import java.util.List;

@Controller("empAction")
@Scope("prototype")
public class EmpAction {

    private TbEmp emp;
    private TbUser user;
    private int msg;
    private List empList;
    private TbEmpInfo empInfo;
    private String hiddenImage;

    private File empImage;
    private String empImageFileName;

    @Resource(name = "empService")
    private IEmpService empService;

    //处理添加员工
    public String addEmp(){
        uploadImge();
       if(empService.addEmp(emp,user)){
            msg=1;
        }else{
            msg=0;
        }
        return "msg";
    }

    //执行图像上传的操作
    private void uploadImge(){
        //如果不为空
        if(empImage!=null&&empImageFileName!=null){
            ServletContext ctx = ServletActionContext.getServletContext();
            String path = ctx.getRealPath("/images");
            String filePath = path+"/"+empImageFileName;//获取文件要上传的路径
            try {
                FileUtil.copyFile(empImage,new File(filePath));//执行上传
                //记录文件路径
                emp.setE_image(empImageFileName);//记录图片路径
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    //执行查询所有员工
    public String findEmpList(){
        empList = empService.findEmpList();
        return "toEmpList";
    }

    //添加员工详细信息
    public String addEmpInfo(){
        if(empService.addEmpInfo(empInfo)){
            msg = 1;
        }else{
            msg = 0;
        }
        return "msg";
    }

    //查询个人详细全部信息
    public String findEmpInfoById(){
        empInfo = empService.findEmpInfoById(empInfo.getEi_no());
        return "toEmpInfo";
    }

    //更新所有信息资料
    public String updateEmpInfo(){
        emp.setE_image(hiddenImage);
        uploadImge();
        if(empService.updateEmpInfo(empInfo,emp,user)){
            msg = 1;
        }else{
            msg = 0;
        }
        return "msg";
    }

    public TbEmp getEmp() {
        return emp;
    }

    public void setEmp( TbEmp emp ) {
        this.emp = emp;
    }

    public int getMsg() {
        return msg;
    }

    public void setMsg( int msg ) {
        this.msg = msg;
    }

    public List getEmpList() {
        return empList;
    }

    public void setEmpList( List empList ) {
        this.empList = empList;
    }

    public File getEmpImage() {
        return empImage;
    }

    public void setEmpImage( File empImage ) {
        this.empImage = empImage;
    }

    public String getEmpImageFileName() {
        return empImageFileName;
    }

    public void setEmpImageFileName( String empImageFileName ) {
        this.empImageFileName = empImageFileName;
    }

    public void setEmpService( IEmpService empService ) {
        this.empService = empService;
    }

    public TbUser getUser() {
        return user;
    }

    public void setUser( TbUser user ) {
        this.user = user;
    }

    public TbEmpInfo getEmpInfo() {
        return empInfo;
    }

    public void setEmpInfo( TbEmpInfo empInfo ) {
        this.empInfo = empInfo;
    }

    public String getHiddenImage() {
        return hiddenImage;
    }

    public void setHiddenImage( String hiddenImage ) {
        this.hiddenImage = hiddenImage;
    }

    public IEmpService getEmpService() {
        return empService;
    }
}
