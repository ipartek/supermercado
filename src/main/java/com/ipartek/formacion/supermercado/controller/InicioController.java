package com.ipartek.formacion.supermercado.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.ipartek.formacion.supermercado.modelo.dao.CategoriaDAO;
import com.ipartek.formacion.supermercado.modelo.dao.ProductoDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Categoria;
import com.ipartek.formacion.supermercado.modelo.pojo.Producto;

/**
 * Servlet implementation class InicioController
 */
@WebServlet("/inicio")
public class InicioController extends HttpServlet {
	
	private final static Logger LOG = Logger.getLogger(InicioController.class);
	private static final long serialVersionUID = 1L;
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
		
			// llama a GET o POST
			super.service(req, resp);
	}
	
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pCategoria = request.getParameter("categoriaId");
		String pProducto = request.getParameter("producto");
		String pAccion = request.getParameter("accion");
		
		ArrayList<Producto> productos = (ArrayList<Producto>) daoProducto.getAllActivos();
		ArrayList<Categoria> categorias = (ArrayList<Categoria>) daoCategoria.getAll();
		
		Alerta alerta = new Alerta();
		
		alerta.setTexto("Los últimos productos destacados.");
		alerta.setTipo(Alerta.TIPO_PRIMARY);
		
		if(pAccion != null) {   			// Si la variable pAccion no es null llama al procedure de busqueda de la base de datos 
			
			try {
				
				int numCategoria = Integer.parseInt(pCategoria);
				
				productos = (ArrayList<Producto>) daoProducto.busqueda(numCategoria, pProducto);
								
				
			} catch (NumberFormatException e) {
				
				LOG.error(e);
				
				alerta.setTipo(Alerta.TIPO_DANGER);
				alerta.setTexto("Ha ocurrido una error a la hora de procesar su solicitud.");
				
			} catch (SQLException e) {
				LOG.error(e);
			}
			
		}

		request.setAttribute("productos", productos );		
		request.setAttribute("categorias", categorias );	
		request.setAttribute("mensajeAlerta", alerta);				
		request.getRequestDispatcher("index.jsp").forward(request, response);
		
		
	}

}
