package com.ipartek.formacion.supermercado.controller.seguridad;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

import com.ipartek.formacion.supermercado.controller.Alerta;
import com.ipartek.formacion.supermercado.modelo.dao.CategoriaDAO;
import com.ipartek.formacion.supermercado.modelo.dao.ProductoDAO;
import com.ipartek.formacion.supermercado.modelo.dao.UsuarioDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Producto;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

/**
 * Servlet implementation class ProductosController
 */
@WebServlet("/seguridad/productos")
public class ProductosController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final String VIEW_TABLA = "productos/index.jsp";
	private static final String VIEW_FORM = "productos/formulario.jsp";
	private static String vistaSeleccionda = VIEW_TABLA;
	private static ProductoDAO daoProducto;
	private static UsuarioDAO daoUsuario;
	private static CategoriaDAO daoCategoria;

	//acciones
	public static final String ACCION_LISTAR = "listar";
	public static final String ACCION_IR_FORMULARIO = "formulario";
	public static final String ACCION_GUARDAR = "guardar";   // crear y modificar
	public static final String ACCION_ELIMINAR = "eliminar";

	//Crear Factoria y Validador
	ValidatorFactory factory;
	Validator validator;


	//parametros
	String pAccion;
	String pId;
	String pNombre;
	String pPrecio;
	String pImagen;
	String pDescripcion;
	String pDescuento;
	String pUsuarioId;
	String pCategoriaId;


	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		daoProducto = ProductoDAO.getInstance();
		daoUsuario = UsuarioDAO.getInstance();
		daoCategoria = CategoriaDAO.getInstance();
		factory = Validation.buildDefaultValidatorFactory();
		validator = factory.getValidator();
	}

	@Override
	public void destroy() {
		super.destroy();
		daoProducto = null;
		daoUsuario = null;
		factory = null;
		validator = null;
	}


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	private void doAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


			//recoger parametros
			pAccion = request.getParameter("accion");
			pId = request.getParameter("id");
			pNombre = request.getParameter("nombre");
			pPrecio = request.getParameter("precio");
			pImagen = request.getParameter("imagen");
			pDescripcion = request.getParameter("descripcion");
			pDescuento = request.getParameter("descuento");
			pUsuarioId = request.getParameter("usuarioId");
			pCategoriaId = request.getParameter("categoriaId");

			try {

				switch (pAccion) {
				case ACCION_LISTAR:
					listar(request, response);
					break;
				case ACCION_ELIMINAR:
					eliminar(request, response);
					break;
				case ACCION_GUARDAR:
					guardar(request, response);
					break;
				case ACCION_IR_FORMULARIO:
					irFormulario(request, response);
					break;
				default:
					listar(request, response);
					break;
				}




			}catch (Exception e) {
				// TODO log
				e.printStackTrace();

			}finally {

				request.getRequestDispatcher(vistaSeleccionda).forward(request, response);
			}




	}


	private void irFormulario(HttpServletRequest request, HttpServletResponse response) {

		Producto pEditar = new Producto();

		if ( pId != null ) {

			int id = Integer.parseInt(pId);
			pEditar = daoProducto.getById(id);

		}

		request.setAttribute("usuarios", daoUsuario.getAll() );
		request.setAttribute("categorias", daoCategoria.getAll());
		request.setAttribute("producto", pEditar );
		vistaSeleccionda = VIEW_FORM;

	}

	private void guardar(HttpServletRequest request, HttpServletResponse response) {


		int id = Integer.parseInt(pId);
		Producto pGuardar = new Producto();
		pGuardar.setId(id);
		pGuardar.setNombre(pNombre);
		pGuardar.setDescuento( Integer.parseInt(pDescuento));
		pGuardar.setPrecio(Float.parseFloat(pPrecio));
		pGuardar.setImagen(pImagen);
		pGuardar.setDescripcion(pDescripcion);
		pGuardar.setDescuento(Integer.parseInt(pDescuento));


		Usuario u = new Usuario();
		u.setId(Integer.parseInt(pUsuarioId));
		pGuardar.setUsuario(u);


		Set<ConstraintViolation<Producto>> validaciones = validator.validate(pGuardar);
		if( validaciones.size() > 0 ) {
			mensajeValidacion(request, validaciones);
		}else {

				try {

					if ( id > 0 ) {  // modificar

						daoProducto.update(id, pGuardar);

					}else {            // crear
						daoProducto.create(pGuardar);
					}

				}catch (Exception e) {  // validacion a nivel de base datos

					request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "El nombre ya existe, selecciona otro"));
				}

		}

		request.setAttribute("usuarios", daoUsuario.getAll() );
		request.setAttribute("producto", pGuardar);
		vistaSeleccionda = VIEW_FORM;


	}

	private void mensajeValidacion(HttpServletRequest request, Set<ConstraintViolation<Producto>> validaciones ) {

		StringBuilder mensaje = new StringBuilder();
		for (ConstraintViolation<Producto> cv : validaciones) {

			mensaje.append("<p>");
			mensaje.append(cv.getPropertyPath()).append(": ");
			mensaje.append(cv.getMessage());
			mensaje.append("</p>");

		}

		request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, mensaje.toString() ));

	}

	private void eliminar(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(pId);
		try {
			Producto pEliminado = daoProducto.delete(id);
			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Eliminado " + pEliminado.getNombre() ));
		} catch (Exception e) {
			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "No se puede Eliminar el producto"));

		}

		listar(request, response);

	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {

		List<Producto> listaProductos = new ArrayList<Producto>();

		String pNombre = request.getParameter("nombre");
		String pCategoriaId = request.getParameter("categoriaId");

		int categoriaId = 0;

		if(pCategoriaId != null && pCategoriaId.length() > 0 && pCategoriaId.matches("\\d+") ) {
			categoriaId = Integer.parseInt(pCategoriaId);
		}

		if(pNombre == null) {
			pNombre = "";
		}


		ArrayList<Producto> productos = (ArrayList<Producto>) daoProducto.getAllFiltered(categoriaId, pNombre);
		request.setAttribute("productos", productos );
		vistaSeleccionda = VIEW_TABLA;

	}



}
