package com.ipartek.formacion.supermercado.modelo;

import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class ConnectionManager {

	private final static Logger LOG = LogManager.getLogger(ConnectionManager.class);
	private static DataSource ds = null;
	private static InitialContext ctx = null;
	public static List<Connection> conlist = new ArrayList<Connection>();

	public static Connection getConnection() {

		Connection conn;
		conn = null;
		try {
			if(ctx == null) {
				ctx = (InitialContext) new InitialContext();
			}

			if(ds == null) {
				ds = (DataSource) ctx.lookup("java:comp/env/jdbc/mydb");
				LOG.trace("Creando datasource");
			}

			if (ds == null) {
				throw new Exception("Data source no encontrado!");
			}



			conn = ds.getConnection();
			conlist.add(conn);
		} catch (Exception e) {

			LOG.fatal(e);
		}

		return conn;

	}

}
