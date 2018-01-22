package com.empsystem.service;


import com.empsystem.entity.TbEmp;
import com.empsystem.entity.TbEmpInfo;
import com.empsystem.entity.TbUser;

import java.util.List;

public interface IEmpService {
        public boolean addEmp( TbEmp emp, TbUser user);

        public List findEmpList();

        public boolean addEmpInfo( TbEmpInfo empInfo);

        public TbEmpInfo findEmpInfoById(int ei_no);

        public boolean updateEmpInfo(TbEmpInfo empInfo,TbEmp emp,TbUser user);
}
