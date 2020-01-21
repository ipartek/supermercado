package com.ipartek.formacion.supermercado.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.management.ManagementFactory;
import java.sql.Connection;
import java.util.List;
import java.util.Set;
import javax.management.MBeanAttributeInfo;
import javax.management.MBeanInfo;
import javax.management.MBeanServer;
import javax.management.ObjectName;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ipartek.formacion.supermercado.modelo.ConnectionManager;
@WebServlet("/poolmonitor")
public class MonitorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        PrintWriter writer = resp.getWriter();
        writer.println("<!DOCTYPE html>");
        writer.println("<html>");
        writer.println("<body>");
        writer.println("<p><h1>Tomcat Pool</h1></p><p>");
        try {
            List<Connection> lista = ConnectionManager.conlist;
            int i = 0;
            for(Connection con : lista) {
            	if(!con.isClosed()) {
            		i++;
            	}
            	writer.println("<p>");
            	writer.println(con.toString());
            	writer.println("<br>");
            	writer.println("Esta cerrado? : " + con.isClosed());
            	writer.println("</p>");
            }
            writer.println("<br> Numero de procesos " + i);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        writer.println("</p></body>");
        writer.println("</html>");
    }
}