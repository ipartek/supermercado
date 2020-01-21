package com.ipartek.formacion.supermercado.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.ipartek.formacion.supermercado.modelo.ConnectionManager;
import com.ipartek.formacion.supermercado.modelo.dao.CategoriaDAO;
import com.ipartek.formacion.supermercado.modelo.dao.ProductoDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Producto;

/**
 * Servlet implementation class InicioController
 */
@WebServlet("/inicio")
public class InicioController extends HttpServlet {

	private final static Logger LOG = LogManager.getLogger(InicioController.class);

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


		Connection con = ConnectionManager.getConnection();

		if (null == con) {
			resp.sendRedirect(req.getContextPath() + "/error.jsp");
		} else {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
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


//		for (int i = 0; i < 100; i++) {
//			try{
//			Connection con = ConnectionManager.getConnection();
//			con.close();
//			LOG.trace(i);
//			} catch(Exception e) {
//				LOG.error(e);
//			}
//
//		}

		// llamar al DAO capa modelo

		// filtro productos
		LOG.trace("Empezando parte de filtro...");
		String pNombre = request.getParameter("nombre");
		String pCategoriaId = request.getParameter("categoriaId");

		int categoriaId = 0;

		if (pCategoriaId != null && pCategoriaId.length() > 0 && pCategoriaId.matches("\\d+")) {
			categoriaId = Integer.parseInt(pCategoriaId);
		}

		if (pNombre == null) {
			pNombre = "";
		}

		LOG.trace("Limpiados los parametros de filtrado...");

		List<Producto> productos = daoProducto.getActivesFiltered(categoriaId, pNombre);

		LOG.trace("Obtenidos los productos filtrados");
		int contProductos = 0;
		for (Producto p : productos) {
			LOG.trace(p);
			contProductos++;
		}

		request.setAttribute("categorias", daoCategoria.getAll() );
		request.setAttribute("productos", productos);
		request.setAttribute("idcategoria", pCategoriaId);
		request.setAttribute("nombreProducto", pNombre);

		if(0 == categoriaId && "".equalsIgnoreCase(pNombre)) {
			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Los últimos productos destacados."));
		}
		else {
			String mensaje = contProductos + " producto" + (contProductos == 1?"":"s") +" encontrado" + (contProductos == 1?"":"s");

			if(categoriaId > 0) {
				mensaje += " de la categoria <b>" + daoCategoria.getById(categoriaId).getNombre() + "</b>";
			}

			if(pNombre != null && !pNombre.equals("")) {
				mensaje += (categoriaId > 0 ? " y": "") + " con nombre similar a <b>" + pNombre + "</b>";
			}

			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, mensaje));
		}

		request.getRequestDispatcher("index.jsp").forward(request, response);

	}

}
