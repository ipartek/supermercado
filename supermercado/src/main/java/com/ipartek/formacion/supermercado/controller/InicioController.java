package com.ipartek.formacion.supermercado.controller;

import java.io.IOException;
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
	private static ProductoDAO daoProducto;
	private static CategoriaDAO daoCategoria;
	
	private final static Logger LOG = Logger.getLogger(InicioController.class);

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

		if (null == ConnectionManager.getConnection()) {
			resp.sendRedirect(req.getContextPath() + "/error.jsp");
		} else {

			// llama a GET o POST
			super.service(req, resp);
		}
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		visualizarProductos(request, response);
		
		ArrayList<Categoria> categorias = (ArrayList<Categoria>) daoCategoria.getAll();

		request.setAttribute("categorias", categorias);

		request.getRequestDispatcher("/index.jsp").forward(request, response);
		LOG.debug("No falla");
	}

	private void visualizarProductos(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ArrayList<Producto> productos = (ArrayList<Producto>) daoProducto.getAll();
		
		String idCategoria = request.getParameter("categoria");
		String nombreProducto = request.getParameter("textoBuscado");
		if (idCategoria == null && nombreProducto == null) {
			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Los últimos productos destacados."));
		}else {
			try {
				
				int idParseado = (idCategoria==null)?0:Integer.parseInt(idCategoria);

				// En caso de que no haya ninguna categoría seleccionada y ningún producto en la
				// búsqueda, se devuelven todos.
				if ("".equalsIgnoreCase(idCategoria) && "".equalsIgnoreCase(nombreProducto)) {
					
					request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Los últimos productos destacados."));
				} else {
					if ("".equalsIgnoreCase(nombreProducto)) {
						productos = (ArrayList<Producto>) daoProducto.getByIdCategoria(idParseado);
						
						request.setAttribute("mensajeAlerta",new Alerta(Alerta.TIPO_PRIMARY, "Productos de la categoría " + daoCategoria.getById(idParseado).getNombre() + "."  ));
					} else {
						if ("".equalsIgnoreCase(idCategoria) || idParseado == 0) {
							productos = (ArrayList<Producto>) daoProducto.getByName(nombreProducto);
							request.setAttribute("mensajeAlerta",
									new Alerta(Alerta.TIPO_PRIMARY, "Estos son los productos que coinciden con su búsqueda:"));
						}else {
							productos = (ArrayList<Producto>) daoProducto.getByIdCategoriaAndProducto(idParseado, nombreProducto);
							request.setAttribute("mensajeAlerta",
									new Alerta(Alerta.TIPO_PRIMARY, "Estos son los productos que coinciden con su búsqueda:"));
						}
						
					}
				}
			} catch (Exception e) {
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "No se han encontrado productos"));
				LOG.error("Error en InicioController " + e);
			}
		}
		
		
		request.setAttribute("productos", productos);

	}

	

	
}
