package com.ipartek.formacion.supermercado.controller.seguridad;

import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.ipartek.formacion.supermercado.controller.Alerta;
import com.ipartek.formacion.supermercado.modelo.dao.CategoriaDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Categoria;

/**
 * Servlet implementation class CategoriaController
 */
@WebServlet("/seguridad/categorias")
public class CategoriaController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static Logger LOG = LogManager.getLogger(SeguridadBackofficeFilter.class);

	private static final String VIEW_TABLA = "categorias/index.jsp";
	private static final String VIEW_FORM = "categorias/formulario.jsp";

	private static String vistaSeleccionda = VIEW_TABLA;
	private static CategoriaDAO dao;

	//acciones
	public static final String ACCION_LISTAR = "listar";
	public static final String ACCION_IR_FORMULARIO = "formulario";
	public static final String ACCION_GUARDAR = "guardar";   // crear y modificar
	public static final String ACCION_ELIMINAR = "eliminar";

	//Crear Factoria y Validador
	ValidatorFactory factory;
	Validator validator;

	String pAccion;
	String pId;
	String pNombre;

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
		dao = CategoriaDAO.getInstance();

		factory = Validation.buildDefaultValidatorFactory();
		validator = factory.getValidator();
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


	private void doAction(HttpServletRequest request, HttpServletResponse response) {
		pAccion = request.getParameter("accion");
		pId = request.getParameter("id");
		pNombre= request.getParameter("nombre");

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

		} catch(Exception e) {
			LOG.error(e);
			e.printStackTrace();
		}
	}


	private void irFormulario(HttpServletRequest request, HttpServletResponse response) {
		Categoria c = new Categoria();

		if( pId != null && pId.matches("\\d+")) {
			int id = Integer.parseInt(pId);
			c = dao.getById(id);
		}

		request.setAttribute("categoria", c);

		vistaSeleccionda = VIEW_FORM;
	}


	private void guardar(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(pId);

		Categoria c = new Categoria();
		c.setId(id);
		c.setNombre(pNombre);

		// TODO: validacion de categoria

		try {
			if(id > 0) {
				// Queremos modificar la categoria
				dao.update(id, c);
			} else {
				dao.create(c);
			}
		} catch(Exception e) {
			LOG.error(e);
			e.printStackTrace();
		}

		request.setAttribute("categorias", dao.getAll());

		vistaSeleccionda = VIEW_FORM;
	}


	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(pId);
		try {
			Categoria c = dao.delete(id);
			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Eliminado " + c.getNombre() ));
		} catch(Exception e) {
			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "No se puede Eliminar la categoria"));
			LOG.error(e);
			e.printStackTrace();
		}
	}


	private void listar(HttpServletRequest request, HttpServletResponse response) {
		LOG.trace("Listando todos las categorias");
		request.setAttribute("categorias", dao.getAll());

		vistaSeleccionda = VIEW_TABLA;
	}
}
