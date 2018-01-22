package com.empsystem.service.impl;


import com.empsystem.dao.IRealSalaryDao;
import com.empsystem.dao.ISalaryInfoDao;
import com.empsystem.entity.TbRealSalary;
import com.empsystem.service.IRealSalaryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 实际工资 服务层操作
 */
@Service("realSalaryService")
@Transactional(propagation = Propagation.REQUIRED)
public class RealSalaryServiceImpl implements IRealSalaryService{

    @Resource(name = "realSalaryDao")
    private IRealSalaryDao realSalaryDao;

    @Resource(name = "salaryInfoDao")
    private ISalaryInfoDao salaryInfoDao;

    /*
     select e.e_name,rs.r_yearmonth,s.s_salary,sum(sinfo.si_variate),rs.r_realsalary from tb_salary s
     inner join tb_realsalary rs on s.s_no = rs.r_sno
     right join tb_emp e on rs.r_eno = e.e_no
     left join tb_salaryinfo sinfo on e.e_no = sinfo.si_eno
     where date_format(sinfo.si_time,'%Y-%m')='2018-02'
     and rs.r_yearmonth='2018-02'
     group by e.e_no;
    * */
    @Override
    public List findRealSalaryList(String[] querys) {

        /*
        * select e.e_name,sum(sinfo.si_variate),s.s_salary,rs.* from tb_salary s
            inner join  tb_realSalary rs on rs.r_sno = s.s_no
            inner join tb_emp e on e.e_no = rs.r_eno
            inner join tb_salaryInfo sinfo on sinfo.si_eno = e.e_no
            where rs.r_yearMonth like '2017%'
            and date_format(sinfo.si_time,'%Y')='2017'
            group by e.e_no
        * */

        /*select e.e_name,sum(s.s_salary) 总基本工资,sum(rs.r_realsalary) 总实际工资 from tb_realsalary rs
        inner join tb_salary s on rs.r_sno = s.s_no
        inner join tb_emp e on e.e_no = rs. r_eno
        where rs.r_yearMonth like "2018%"
        group by rs.r_eno
        order by rs.r_eno asc;

        select sum(sinfo.si_variate) from tb_emp e inner join tb_salaryinfo sinfo
        on e.e_no = sinfo.si_eno
        where sinfo.si_time like '2018%'
        group by e.e_no
        order by e.e_no asc;*/
        if(querys!=null&&querys.length>0){
            //按年月查询
            if(querys[0]!=null&&querys[0].length()>0){

                String hql = "select rs,s,e,sum(s.s_salary),sum(rs.r_realSalary) from TbRealSalary rs inner join TbSalary s on rs.r_sno = s.s_no "
                        + " inner join TbEmp e on e.e_no = rs.r_eno"
                        + " where rs.r_yearMonth like '"+querys[0]+"%'"
                        + " group by e.e_no"
                        + " order by e.e_no asc";
                List list = realSalaryDao.findRealSalaryList(hql);     //查询实际工资，基本工资总和

                String hql2 = "select sum(sinfo.si_variate) from TbEmp e inner join TbSalaryInfo sinfo on e.e_no = sinfo.emp.e_no"
                        + " where sinfo.si_time like '"+querys[0]+"%'"
                        + " group by e.e_no"
                        + " order by e.e_no asc";
                List list2 = salaryInfoDao.findSalaryInfoList(hql2);    //查询奖罚资金变动总和
                List l = new ArrayList();
                l.add(list);
                l.add(list2);
                return l;
            }else if(querys[1]!=null&&querys[1].length()>0){
                String hql="select e,s,rs,sum(sinfo.si_variate) from TbSalary s " +
                        " inner join TbRealSalary rs with s.s_no = rs.r_sno " +
                        " right join TbEmp e with rs.r_eno = e.e_no " +
                        " left join TbSalaryInfo sinfo with e.e_no = sinfo.emp.e_no " +
                        " where date_format(sinfo.si_time,'%Y-%m')='"+querys[1]+"' " +
                        " and rs.r_yearMonth='"+querys[1]+"' " +
                        " group by e.e_no";
                return realSalaryDao.findRealSalaryList(hql);
            }
        }
        return null;
    }
    /*
    select e.e_name,rs.* from tb_salary s inner join
    tb_realsalary rs on s.s_no = rs.r_sno inner join
    tb_emp e on rs.r_eno = e.e_no
    where rs.r_yearMonth like '2017%'
    and e.e_no=2
    order by rs.r_yearMonth desc;

    select count(sinfo.si_no),sum(sinfo.si_variate),sinfo.* from tb_emp e inner join
    tb_salaryinfo sinfo on e.e_no = sinfo.si_eno
    where sinfo.si_time like '2017%'
    and e.e_no=2
    group by date_format(sinfo.si_time,'%Y-%m')
    order by date_format(sinfo.si_time,'%Y-%m') desc;
    * */
    @Override
    public List findRealAndVariateSalaryList( int id, String year ) {

        String hql = "from TbSalary s inner join"
                + " TbRealSalary rs on s.s_no = rs.r_sno inner join"
                + " TbEmp e on e.e_no = rs.r_eno"
                + " where rs.r_yearMonth like '"+year+"%'"
                + " and e.e_no="+id+""
                + " order by rs.r_yearMonth desc";

        List list1 = realSalaryDao.findRealSalaryList(hql);

        String hql2 = "select sum(sinfo.si_variate) from TbEmp e inner join"
                + " TbSalaryInfo sinfo on e.e_no = sinfo.emp.e_no"
                + " where sinfo.si_time like '"+year+"%'"
                + " and e.e_no ="+id+""
                + " group by date_format(sinfo.si_time,'%Y-%m')"
                + " order by date_format(sinfo.si_time,'%Y-%m') desc";
        List list2 = salaryInfoDao.findSalaryInfoList(hql2);
        List l = new ArrayList();
        l.add(list1);
        l.add(list2);
        return l;
    }


    @Override
    public boolean addRealSalary( TbRealSalary realSalary ) {
        return false;
    }

    @Override
    public boolean updateRealSalary( TbRealSalary realSalary ) {
        return false;
    }

    @Override
    public boolean delRealSalary( TbRealSalary realSalary ) {
        return false;
    }

    @Override
    public TbRealSalary getRealSalaryById( int id ) {
        return null;
    }

    public void setRealSalaryDao( IRealSalaryDao realSalaryDao ) {
        this.realSalaryDao = realSalaryDao;
    }

    public void setSalaryInfoDao( ISalaryInfoDao salaryInfoDao ) {
        this.salaryInfoDao = salaryInfoDao;
    }
}
