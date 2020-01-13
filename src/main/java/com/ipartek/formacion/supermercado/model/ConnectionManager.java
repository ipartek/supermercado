package com.ipartek.formacion.supermercado.model;

import java.sql.Connection;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.ipartek.formacion.supermercado.controller.LoginController;

public class ConnectionManager {

	private final static Logger LOG = Logger.getLogger(ConnectionManager.class);
	private static Connection conn;

	public static Connection getConnection() {

		conn = null;

		try {
			InitialContext ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mydb");
			if (ds == null) {
				throw new Exception("Data source no encontrado!");
			}

			conn = ds.getConnection();

		} catch (Exception e) {

			LOG.fatal(e);
		}

		return conn;

	}

}
