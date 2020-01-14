package com.ipartek.formacion.supermercado.controller;

import java.io.IOException;
import java.sql.Connection;
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
import com.ipartek.formacion.supermercado.modelo.pojo.Alerta;
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

		try (Connection con = ConnectionManager.getConnection();) {
			if (null == con) {
				resp.sendRedirect(req.getContextPath() + "/error.jsp");
			} else {

				// llama a GET o POST
				super.service(req, resp);

			}
		} catch (Exception e) {
			LOG.fatal(e);
			resp.sendRedirect(req.getContextPath() + "/error.jsp");
		}

	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// llamar al DAO capa modelo
		ArrayList<Producto> productos = (ArrayList<Producto>) daoProducto.getAll();
		ArrayList<Categoria> categorias = (ArrayList<Categoria>) daoCategoria.getAll();

		request.setAttribute("productos", productos);
		request.setAttribute("categorias", categorias);

		request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Los últimos productos destacados."));

		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pCategoriaId = request.getParameter("categoriaElegida");
		String pNombreProducto = request.getParameter("productoElegido");
		int productosPorCat;

		ArrayList<Categoria> categorias = new ArrayList<Categoria>();
		ArrayList<Producto> productos = new ArrayList<Producto>();

		try {
			int pIdCategoria = Integer.parseInt(pCategoriaId);

			categorias = (ArrayList<Categoria>) daoCategoria.getAll();
			productos = (ArrayList<Producto>) daoProducto.buscarPorNombreCategoria(pIdCategoria, pNombreProducto);

			productosPorCat = productos != null ? productos.size() : 0;

			request.setAttribute("productos", productos);
			request.setAttribute("categorias", categorias);

			request.setAttribute("catElegida", pIdCategoria);
			request.setAttribute("prodElegido", pNombreProducto);

			if (productosPorCat == 0) {
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER,
						"No se han encontrado productos para los términos de búsqueda especificados. "));
			} else {

				// Para todas las categorias los productos que se corresponden con el terminos
				// de busqueda
				if (pIdCategoria == 0 && pNombreProducto != "") {

					request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "<b>" + productosPorCat
							+ "</b> producto(s) para el término de búsqueda <b>" + pNombreProducto + "</b>"));
				}
				// Para una catrgoria todos los productos
				else if (pIdCategoria != 0 && pNombreProducto == "") {

					request.setAttribute("mensajeAlerta",
							new Alerta(Alerta.TIPO_PRIMARY,
									"<b>" + productosPorCat + "</b>" + " producto(s) en  la categoría <b>"
											+ daoCategoria.getById(pIdCategoria).getNombre() + "</b>"));

				}
				// para una categoria productos que se llaman como pNombreProducto
				else if (pIdCategoria != 0 && pNombreProducto != "") {

					request.setAttribute("mensajeAlerta",
							new Alerta(Alerta.TIPO_PRIMARY,
									"<b>" + productosPorCat + " </b> producto(s)  en la categoría <b>"
											+ daoCategoria.getById(pIdCategoria).getNombre()
											+ "</b> para el término de búsqueda <b>" + pNombreProducto + "</b>"));

				} else {
					request.setAttribute("mensajeAlerta",
							new Alerta(Alerta.TIPO_PRIMARY, "Los últimos productos destacados."));
				}

			}

		} catch (NumberFormatException e) {
			LOG.error("Problema al parsear el string a entero");
		} catch (Exception e) {
			LOG.error(e);
		} finally {

			request.getRequestDispatcher("index.jsp").forward(request, response);
		}

	}

}
