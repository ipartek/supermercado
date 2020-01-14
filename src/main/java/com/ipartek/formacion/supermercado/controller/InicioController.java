package com.ipartek.formacion.supermercado.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.ipartek.formacion.supermercado.model.ConnectionManager;
import com.ipartek.formacion.supermercado.modelo.dao.CategoriaDAO;
import com.ipartek.formacion.supermercado.modelo.dao.ProductoDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Categoria;
import com.ipartek.formacion.supermercado.modelo.pojo.Producto;

/**
 * Servlet implementation class InicioController
 */
@WebServlet("/inicio")
public class InicioController extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	private final static Logger LOG = Logger.getLogger(ProductoDAO.class);
	
	private static ProductoDAO daoProducto;
	private static CategoriaDAO daoCategoria;
       
	
	@Override
	public void init(ServletConfig config) throws ServletException {	
		super.init(config);
		daoProducto = ProductoDAO.getInstance();
		daoCategoria = CategoriaDAO.getInstance();
		
	}
	
	
	@Override
	public void destroy() {	
		super.destroy();
		daoProducto = null;
		daoCategoria = null;
	}
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		Connection con = ConnectionManager.getConnection();
		
		if ( null == con ) {
			resp.sendRedirect( req.getContextPath() + "/error.jsp");
		}else {
			// llama a GET o POST
			super.service(req, resp);
			try {
				con.close();
			} catch (SQLException e) {
				LOG.error("Error en al cerrar la conexion " + e);
			}
		}	
	}
	
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//llamar al DAO capa modelo
		ArrayList<Producto> productos = (ArrayList<Producto>) daoProducto.getAll();
		ArrayList<Categoria> categorias = (ArrayList<Categoria>) daoCategoria.getAll();
		
		request.setAttribute("productos", productos );		
		request.setAttribute("categorias", categorias );	
		
		request.setAttribute("mensajeAlerta", new Alerta( Alerta.TIPO_PRIMARY , "Los últimos productos destacados.") );		
		
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
				
		//llamar al DAO capa modelo
		ArrayList<Producto> productos = (ArrayList<Producto>) daoProducto.getAll();
		ArrayList<Categoria> categorias = (ArrayList<Categoria>) daoCategoria.getAll();
		
		//filtro/buscador:  
		int cId = ( request.getParameter("id") != null ) ? Integer.parseInt(request.getParameter("id")) : 0;
		
		if(cId > 0 || cId == 0) {
			String pNombre = request.getParameter("nombre");
			productos = (ArrayList<Producto>) daoProducto.getAllBuscador(cId, pNombre);
			
			request.setAttribute("productos", productos );		
			request.setAttribute("categorias", categorias );
		}

		
		request.setAttribute("mensajeAlerta", new Alerta( Alerta.TIPO_PRIMARY , "Los últimos productos destacados.") );		
		
		request.getRequestDispatcher("index.jsp").forward(request, response);
		
		
	}

}
