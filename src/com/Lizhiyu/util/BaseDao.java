package com.Lizhiyu.util;

/**
 * Created by Administrator on 2017/7/4.
 */

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**数据库操作的工具类
 * @author lzy
 * @param <T>
 */
public class BaseDao<T> {

    private static Connection conn;
    private static PreparedStatement ps;
    private static ResultSet rs;

    /**
     * 数据库添加，修改，删除的公共方法
     * @param sql 需要执行的sql语句
     * @param objs 可变的参数列表(数组)
     * 			        该参数只能放置在形参的最后一个
     * 			   sql中的占位符对应的参数
     * @return
     * 		-1 表示执行出错
     * 		其他值 表示影响的行数
     */
    public static int baseUpdate(String sql,Object ... objs){
        // 获取数据库的连接通道
        conn = DBUtils.getConnection();
        // 构建sql语句
        // 执行sql 语句
        try {
            ps = conn.prepareStatement(sql);
            // 对sql语句中的占位符进行赋值
            if(objs != null){
                // 遍历参数列表对占位符进行赋值
                for(int i = 0 ; i < objs.length ; i++){
                    ps.setObject(i+1, objs[i]);
                }
            }
            // 执行sql语句返回影响的行数
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            // 关闭资源
            DBUtils.close(conn, ps,rs);
        }
        return -1;
    }

    /**
     * 查询表结构中满足条件的记录数
     * @param sql 需要执行的sql语句
     * @param objs sql语句中对应的占位符对应的参数
     * @return
     * 		  -1 表示执行出错
     *        其他值 表示记录的条数
     */
    public static int baseQueryForCount(String sql,Object ... objs){
        conn = DBUtils.getConnection();
        try {
            ps = conn.prepareStatement(sql);
            // 对占位符进行赋值
            if(objs != null){
                for(int i = 0 ; i < objs.length ; i++){
                    ps.setObject(i+1, objs[i]);
                }
            }
            // 显示的执行sql语句
            rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally{
            // 关闭资源
            DBUtils.close(conn, ps, rs);
        }
        return -1;
    }

    /**
     * 查询单条记录，并返回对应的对象
     * @param sql 需要执行的sql语句
     * @param cls 返回对象对应的类对象
     * @param objs sql语句中对应的占位符的参数
     * @return
     * 		返回封装有查询记录的对象
     */
    public static <T> T baseQueryById(String sql,Class cls,Object ... objs){
        // 获取数据库的连接通道
        conn = DBUtils.getConnection();
        try {
            ps = conn.prepareStatement(sql);
            // 对占位符进行赋值
            if(objs != null){
                for (int i = 0; i < objs.length; i++) {
                    ps.setObject(i+1, objs[i]);
                }
            }
            // 执行sql语句
            rs = ps.executeQuery();
            // 元数据
            ResultSetMetaData md = rs.getMetaData();
            int rowCount = md.getColumnCount();
            //System.out.println("总共有多少列："+rowCount);
            if(rs.next()){
                // 2. 获取封装数据的对应的对象
                Object obj = cls.newInstance();
                //System.out.println(obj.getClass());
                // 1. 将该行记录中的每一个字段及对应的值取出来，
                for (int i = 0; i < rowCount; i++) {
                    String name = md.getColumnLabel(i+1).toLowerCase();//id name sex
                    Object value = rs.getObject(name);//1  张三  男    id=1   name=张三
                    // 如果查询的字段的值为空，那么就没有必要将空赋值给对象的属性了
                    if(value == null){
                        continue;
                    }
                    //System.out.println(name+":"+value+"类型："+value.getClass());
                    // System.out.println(name+":"+value);
                    // 3. 将查询的字段的值保存到对应的对象的成员变量(属性)中
                    // 判断类对象中是否存在表结果中的字段对应的成员变量
                    if(hasField(cls, name)){
                        // 根据查询的字段的名称获取类对象中对应的成员变量
                        Field field = cls.getDeclaredField(name);
                        //System.out.println(field.getName());
                        // 允许给私有成员变量赋值
                        field.setAccessible(true);
                        if(value instanceof BigDecimal){
                            // value 可能是整数也可能是小数
                            BigDecimal bigValue = (BigDecimal) value;
                            // 判断成员变量是什么类型的
                            if(field.getType().getName().equals("int")){
                                // 将值赋给对象的对象的成员变量   setsid()
                                field.set(obj, bigValue.intValue());
                            }else{
                                field.set(obj, bigValue.doubleValue());
                            }
                        }else{
                            // 将值赋给对象的对象的成员变量
                            field.set(obj, value);
                        }
                    }
                }
                // 4. 返回对应的对象
                return (T) obj;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (SecurityException e) {
            e.printStackTrace();
        } finally{
            DBUtils.close(conn, ps, rs);
        }
        return null;
    }
    /**
     * 查询多条数据
     * @param sql 需要执行的sql语句
     * @param cls 返回对象对应的类对象
     * @param objs sql语句中对应的占位符的参数
     * @return
     * 		查询的数据
     */
    public static <T> List<T> baseQuery(String sql, Class cls, Object ... objs){
        List<T> list = new ArrayList<>();
        // 获取数据库的连接通道
        conn = DBUtils.getConnection();
        try {
            ps = conn.prepareStatement(sql);
            // 对占位符进行赋值
            if(objs != null){
                for (int i = 0; i < objs.length; i++) {
                    ps.setObject(i+1, objs[i]);
                }
            }
            // 执行sql语句
            rs = ps.executeQuery();
            // 元数据
            ResultSetMetaData md = rs.getMetaData();
            int rowCount = md.getColumnCount();
            System.out.println("总共有多少列："+rowCount);
            while(rs.next()){
                // 2. 获取封装数据的对应的对象
                Object obj = cls.newInstance();
                //System.out.println(obj.getClass());
                // 1. 将该行记录中的每一个字段及对应的值取出来，
                for (int i = 0; i < rowCount; i++) {
                    String name = md.getColumnLabel(i+1).toLowerCase();
                    Object value = rs.getObject(name);
                    // 如果查询的字段的值为空，那么就没有必要将空赋值给对象的属性了
                    if(value == null){
                        continue;
                    }
                    // System.out.println(name+":"+value+"类型："+value.getClass());
                    // System.out.println(name+":"+value);
                    // 3. 将查询的字段的值保存到对应的对象的成员变量(属性)中
                    // 判断类对象中是否存在表结果中的字段对应的成员变量
                    if(hasField(cls, name)){
                        // 根据查询的字段的名称获取类对象中对应的成员变量
                        Field field = cls.getDeclaredField(name);
                        //System.out.println(field.getName());
                        // 允许给私有成员变量赋值
                        field.setAccessible(true);
                        if(value instanceof BigDecimal){
                            // value 可能是整数也可能是小数
                            BigDecimal bigValue = (BigDecimal) value;
                            // 判断成员变量是什么类型的
                            if(field.getType().getName().equals("int")){
                                // 将值赋给对象的对象的成员变量
                                field.set(obj, bigValue.intValue());
                            }else{
                                field.set(obj, bigValue.doubleValue());
                            }
                        }else{
                            // 将值赋给对象的对象的成员变量
                            field.set(obj, value);
                        }
                    }
                }
                // 4. 将遍历的记录保存到集合中
                list.add((T) obj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        } catch (SecurityException e) {
            e.printStackTrace();
        } finally{
            DBUtils.close(conn, ps, rs);
        }
        return list;
    }

    /**
     * 判断类对象中是否存在name属性
     * @param cls
     * @param name
     * @return
     * 		true 存在
     * 		false 不存在
     */
    public static boolean hasField(Class cls,String name){
        // 取出类对象中的所有的属性
        Field[] fls = cls.getDeclaredFields();
        for (Field field : fls) {
            //System.out.println(field.getName());
            if(field.getName().equals(name.trim())){
                return true;
            }
        }
        return false;
    }

    private final String QUERY_BEGIN = " select t2.*,rownum from (select t1.*,rownum num from  ( ";
    private final String QUERY_END = " ) t1 where rownum <= ?) t2 where t2.num >= ? ";



}
