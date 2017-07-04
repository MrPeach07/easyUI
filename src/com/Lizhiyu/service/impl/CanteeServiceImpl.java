package com.Lizhiyu.service.impl;

import com.Lizhiyu.dao.CanteeDao;
import com.Lizhiyu.dao.impl.CanteeDaoImpl;
import com.Lizhiyu.pojo.Cantee;
import com.Lizhiyu.service.CanteeService;

import java.util.List;



public class CanteeServiceImpl  implements CanteeService{

    CanteeDao canteeDao = (CanteeDao) new CanteeDaoImpl();
    @Override
    public List<Cantee> query(){
        return canteeDao.query();
    }
}
