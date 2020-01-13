package com.ipartek.formacion.supermercado.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		if ( null == ConnectionManager.getConnection() ) {
			resp.sendRedirect( req.getContextPath() + "/error.jsp");
		}else {
		
			// llama a GET o POST
			super.service(req, resp);
		}	
	}
	
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		visualizarProductos(request, response);
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
		//llamar al DAO capa modelo
		ArrayList<Producto> productos = (ArrayList<Producto>) daoProducto.getAll();
		ArrayList<Categoria> categorias = (ArrayList<Categoria>) daoCategoria.getAll();
		
		
		
		request.setAttribute("productos", productos );		
		request.setAttribute("categorias", categorias );	
		
		
		request.setAttribute("mensajeAlerta", new Alerta( Alerta.TIPO_PRIMARY , "Los últimos productos destacados.") );		
		
		request.getRequestDispatcher("index.jsp").forward(request, response);
		
		
	}
	
	private void visualizarProductos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		
		String idCategoria = request.getParameter("");
		String nombreProducto= request.getParameter("");
		String accion = request.getParameter("");
		
		switch(accion) {
		
		case "":
			
			break;
			
		case "1":
			
			break;
			
		case "2":
			
			break;
			
			
		default: 
		
			break;
		}
		
		
		
	}
	//Usar metodos del DAO
	private void visualizarPorCategoria(int idCategoria) {
		CategoriaDAO catDao = CategoriaDAO.getInstance();
		
		catDao.getById(idCategoria);
		
	}
	
	
	
	private void visualizarPorNombreProducto(String nProducto) {
		ProductoDAO prodDao = ProductoDAO.getInstance();
		prodDao.get
		
	}
	
	
	private void visualizarPorCategoriayProducto(int idCategoria, String nProducto) {
		
		
	}
	

}
