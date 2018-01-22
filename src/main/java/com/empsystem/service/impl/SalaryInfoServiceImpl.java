package com.empsystem.service.impl;

import com.empsystem.dao.IEmpDao;
import com.empsystem.dao.IRealSalaryDao;
import com.empsystem.dao.ISalaryDao;
import com.empsystem.dao.ISalaryInfoDao;
import com.empsystem.entity.TbEmp;
import com.empsystem.entity.TbRealSalary;
import com.empsystem.entity.TbSalary;
import com.empsystem.entity.TbSalaryInfo;
import com.empsystem.service.ISalaryInfoService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 * 员工考勤 服务层
 */
@Service("salaryInfoService")
@Transactional(propagation = Propagation.REQUIRED)
public class SalaryInfoServiceImpl implements ISalaryInfoService{

    @Resource(name = "salaryInfoDao")
    private ISalaryInfoDao salaryInfoDao;

    @Resource(name = "realSalaryDao")
    private IRealSalaryDao realSalaryDao;

    @Resource(name = "empDao")
    private IEmpDao empDao;

    @Resource(name = "salaryDao")
    private ISalaryDao salaryDao;

    private TbRealSalary realSalary;

    //添加考勤记录
    @Override
    public boolean addSalaryInfo(TbSalaryInfo salaryInfo) {
        if(salaryInfoDao.addSalaryInfo(salaryInfo)){
            /*创建一个时间格式化转换,将【salaryInfo】创建考勤记录中的时间：年月日，截取年月
              为什么要这么做？ 因为我们需要根据这个月份，去查询 实际工资表【realSalary】中，根据员工编号查询，这个员工这个月有没有记录，
                                如果还没就创建，如果存在就修改
            */
            SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM");   // 需要转换成的格式
            String yearMonthDate = fmt.format(salaryInfo.getSi_time());       //将salaryInfo的年月日时间 传到fmt里面，转成 年月
            int eno = salaryInfo.getEmp().getE_no();       //取出员工的编号

            String hql = "from TbRealSalary rs where rs.r_yearMonth='"+yearMonthDate+"' and rs.r_eno="+eno;  //根据年月时间， 员工编号查询
            List realSalaryList = realSalaryDao.findRealSalaryList(hql);

            if(realSalaryList!=null&&realSalaryList.size()>0){  //如果有记录
                TbRealSalary realSalaryClass = (TbRealSalary) realSalaryList.get(0); //获取List里面的对象
                double salary = realSalaryClass.getR_realSalary()+(salaryInfo.getSi_variate());  //将修改实际工资表里面的 实际工资+(奖||罚)工资
                realSalaryClass.setR_realSalary(salary);     //将修改完的实际工资，重新赋值回去
                realSalaryDao.updateRealSalary(realSalaryClass); //最后执行保存
            }else{
                //如果realSalaryList为空，证明表中无数据，所以需要创建一个
                /*1、根据员工编号查询出  员工表，
                  2、再根据员工表里面的基本工资编号，查询出 基本工资表
                  3、将2个表的id赋值给realSalary表
                  4、将基本工资表的工 资取出来，加上奖罚工资，保存实际工资表中
                  5、将时间年月时间段保存
                */
                //获取员工、基本工资对象
                TbRealSalary  realSalary = new TbRealSalary();
                TbEmp empClass = empDao.getEmpById(eno);
                TbSalary salaryClass = salaryDao.getSalaryById(empClass.getSalary().getS_no());
                //将员工、基本工资表编号 赋值进去
                realSalary.setR_eno(empClass.getE_no());
                realSalary.setR_sno(salaryClass.getS_no());

                //将基本工资表的 工资 + 奖罚表中的 奖罚资金,得出真实工资，然后赋值到 真实工资表的 工资列
                double salary = salaryClass.getS_salary()+(salaryInfo.getSi_variate());
                realSalary.setR_realSalary(salary);

                //将年月时间段保存进去
                realSalary.setR_yearMonth(yearMonthDate);
                realSalaryDao.addRealSalary(realSalary);

                /*TbEmp empClass = empDao.getEmpById(eno);
                TbSalary salaryClass = salaryDao.getSalaryById(empClass.getSalary().getS_no());
                //将员工、基本工资表编号 赋值进去
                realSalary.setR_eno(empClass.getE_no());
                realSalary.setR_sno(salaryClass.getS_no());

                //将基本工资表的 工资 + 奖罚表中的 奖罚资金,得出真实工资，然后赋值到 真实工资表的 工资列
                double salary = salaryClass.getS_salary()+(salaryInfo.getSi_variate());
                realSalary.setR_realSalary(salary);

                //将年月时间段保存进去
                realSalary.setR_yearMonth(yearMonthDate);
                realSalaryDao.addRealSalary(realSalary);*/

            }
            return true;
        }
        return false;
    }



    //根据年月查询考勤记录列表
    /*
    select e.e_name,e.s_salary,ifnull(sum(sinfo.si_variate),0)  from (select * from tb_emp emp left join tb_salary salary on emp.e_sno = salary.s_no)e left join
    tb_salaryInfo sinfo on e.e_no = sinfo.si_eno
    and date_format(sinfo.si_time,'%Y-%m')='2018-01'
    group by e.e_no,e.s_salary;
    * */

    /**
     *select e.e_name,rs.r_yearmonth,s.s_salary,sum(sinfo.si_variate),rs.r_realsalary from tb_salary s
     inner join tb_realsalary rs on s.s_no = rs.r_sno
     right join tb_emp e on rs.r_eno = e.e_no
     left join tb_salaryinfo sinfo on e.e_no = sinfo.si_eno
     where date_format(sinfo.si_time,'%Y-%m')='2018-02'
     and rs.r_yearmonth='2018-02'
     group by e.e_no;
     */
    @Override
    public List findSalaryInfoList(String[] querys) {

        if(querys!=null&&querys.length>0){
            //按年月查询
            if(querys[1]!=null&&querys[1].length()>0){
                String hql = "SELECT e,i.si_time,sum(i.si_variate) FROM TbEmp e INNER JOIN TbSalary s"
                        + " ON e.salary.s_no=s.s_no LEFT JOIN TbSalaryInfo i"
                        + " ON  e.e_no=i.emp.e_no"
                        + " AND date_format(i.si_time,'%Y-%m')='"+querys[1]+"'"
                        + " GROUP BY e.e_no,e.salary.s_salary";
                return salaryInfoDao.findSalaryInfoList(hql);
            }
        }
       return null;
    }

    //查询指定员工，在指定时间内的考勤记录
    @Override
    public List findSalaryInfoByIdDateList( int eno, String yearMonth ) {
        String hql = "FROM TbSalaryInfo sinfo"
                + " WHERE sinfo.emp.e_no ="+eno
                + " AND date_format(sinfo.si_time,'%Y-%m')='"+yearMonth+"'"
                + " GROUP BY sinfo.si_time";
        return salaryInfoDao.findSalaryInfoList(hql);
    }

    //根据id查询出一个对象
    @Override
    public TbSalaryInfo getSalaryInfoById( int id ) {
        return salaryInfoDao.getSalaryInfoById(id);
    }

    //修改考勤信息
    @Override
    public boolean updateSalaryInfo( TbSalaryInfo salaryInfo ) {

        //return  salaryInfoDao.updateSalaryInfo(salaryInfo);
        //不要马上执行修改，要先查询出以前数据对象，销毁实际表中存在的这条记录之前存进去的数据
        TbSalaryInfo salaryInfoTest = salaryInfoDao.getSalaryInfoById(salaryInfo.getSi_no());

        SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM");   // 需要转换成的格式
        String yearMonthDate = fmt.format(salaryInfoTest.getSi_time());       //将salaryInfoTest的年月日时间 传到fmt里面，转成 年月
        int eno = salaryInfoTest.getEmp().getE_no();    //员工编号

        String hql = "from TbRealSalary rs where rs.r_yearMonth='"+yearMonthDate+"' and rs.r_eno="+eno;  //根据年月时间， 员工编号查询
        List realSalaryList = realSalaryDao.findRealSalaryList(hql);

        if(realSalaryList!=null&&realSalaryList.size()>0){
            realSalary = (TbRealSalary) realSalaryList.get(0); //将list的对象，取出来
            double salaryTest = realSalary.getR_realSalary()-(salaryInfoTest.getSi_variate());  //将实际工资列 减去 之前这条记录的奖罚资金
            realSalary.setR_realSalary(salaryTest);     //再将新的实际工资，保存回去

            if(realSalaryDao.updateRealSalary(realSalary)){     //再重新执行持久化修改
                salaryInfoTest.setSi_no(salaryInfo.getSi_no());
                salaryInfoTest.setSi_casetype(salaryInfo.getSi_casetype());
                salaryInfoTest.setSi_titel(salaryInfo.getSi_titel());
                salaryInfoTest.setSi_content(salaryInfo.getSi_content());
                salaryInfoTest.setSi_time(salaryInfo.getSi_time());
                salaryInfoTest.setSi_variate(salaryInfo.getSi_variate());
                salaryInfoTest.getEmp().setE_no(salaryInfo.getEmp().getE_no());
                if(salaryInfoDao.updateSalaryInfo(salaryInfoTest)){  //确保实际工资回到之前无加这条记录的奖罚的时候 可以执行修改这条记录的奖罚工资
                    double salary = realSalary.getR_realSalary()+(salaryInfoTest.getSi_variate());  //再将实际工资 加上 这条记录的新奖罚工资
                    realSalary.setR_realSalary(salary);    //再重新赋值回去

                    if(realSalaryDao.updateRealSalary(realSalary)){ //执行正确的修改
                        return true;
                    };
                }
            }
        }
        return false;
    }


    public void setSalaryInfoDao( ISalaryInfoDao salaryInfoDao ) {
        this.salaryInfoDao = salaryInfoDao;
    }

    public void setRealSalaryDao( IRealSalaryDao realSalaryDao ) {
        this.realSalaryDao = realSalaryDao;
    }

    public void setEmpDao( IEmpDao empDao ) {
        this.empDao = empDao;
    }

    public void setSalaryDao( ISalaryDao salaryDao ) {
        this.salaryDao = salaryDao;
    }

    public TbRealSalary getRealSalary() {
        return realSalary;
    }

    public void setRealSalary( TbRealSalary realSalary ) {
        this.realSalary = realSalary;
    }
}
