
package com.Lizhiyu.dao.impl;

import com.Lizhiyu.dao.CanteeDao;
import com.Lizhiyu.pojo.Cantee;
import com.Lizhiyu.util.BaseDao;

import java.util.List;



public class CanteeDaoImpl extends BaseDao<Cantee> implements CanteeDao {
   private String sql;

   @Override
  public List<Cantee> query(){
      sql = "select people_count from head_count";
      return super.baseQuery(sql,Cantee.class);
  }
}


