package com.Lizhiyu.servlet;

import com.Lizhiyu.pojo.Cantee;
import com.Lizhiyu.service.CanteeService;
import com.Lizhiyu.service.impl.CanteeServiceImpl;
import com.google.gson.Gson;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;




@WebServlet("/CanteeServlet")
public class CanteeServlet extends HttpServlet{
    private static final long  serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws
            ServletException,IOException {
        CanteeService canteeService = new CanteeServiceImpl();
        List<Cantee> list = canteeService.query();
        response.setCharacterEncoding("utf-8");
        //利用工具将list对象转换为json数据
        Gson gson = new Gson();
        String json = gson.toJson(list);
        System.out.println(json);
        response.getWriter().write(json);

    }
}
