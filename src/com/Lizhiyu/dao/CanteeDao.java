package com.Lizhiyu.dao;

import com.Lizhiyu.pojo.Cantee;

import java.util.List;

/**
 * Created by Administrator on 2017/7/4.
 */
public interface CanteeDao {

    /**查询食堂人口流量信息
     * @return
     */
    public List<Cantee> query();
}
