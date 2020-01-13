package com.ipartek.formacion.supermercado.controller.seguridad;

import java.io.IOException;
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

import org.apache.log4j.Logger;

import com.ipartek.formacion.supermercado.controller.Alerta;
import com.ipartek.formacion.supermercado.modelo.dao.CategoriaDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Categoria;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

/**
 * Servlet implementation class ProductosController
 */
@WebServlet("/seguridad/categorias")
public class CategoriasController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static Logger LOG = Logger.getLogger(CategoriasController.class);
	private static final String VIEW_TABLA = "categorias/index.jsp";
	private static final String VIEW_FORM = "categorias/formulario.jsp";
	private static String vistaSeleccionda = VIEW_TABLA;
	private static CategoriaDAO dao;

	ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
	Validator validator = factory.getValidator();

	// Acciones

	private static final String ACCION_LISTAR = "listar";
	private static final String ACCION_FORMULARIO = "formulario";
	private static final String ACCION_GUARDAR = "guardar"; // Crear y modificar
	private static final String ACCION_ELIMINAR = "eliminar";

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);

		dao = CategoriaDAO.getInstance();
		factory = Validation.buildDefaultValidatorFactory();
		validator = factory.getValidator();
	}

	@Override
	public void destroy() {
		super.destroy();

		dao = null;
		factory = null;
		validator = null;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doAction(request, response);
	}

	private void doAction(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pAccion = request.getParameter("accion");

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
			case ACCION_FORMULARIO:
				formulario(request, response);
				break;
			default:
				listar(request, response);
				break;
			}

		} catch (Exception e) {
			
			LOG.error("Ha ocurrido un error a la hora de proveer los datos necesarios: vistaSelecionada: " + vistaSeleccionda + ". ERROR: " + e);

		} finally {

			request.getRequestDispatcher(vistaSeleccionda).forward(request, response);
		}

	}

	private void formulario(HttpServletRequest request, HttpServletResponse response) {

		Categoria categoria = new Categoria();

		String pId = request.getParameter("id");

		if (!"".equals(pId) && pId != null) {

			try {

				categoria = dao.getById(Integer.parseInt(pId));

			} catch (NumberFormatException e) {

				LOG.error("El ID pasado no es un numero. ERROR: " + e);
				
				request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el adminitrador.", Alerta.TIPO_DANGER));
				
			} catch (Exception e) {
				
				LOG.error("Error al convertir el string de pId en integer. ERROR: " + e);
				
				request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el adminitrador.", Alerta.TIPO_DANGER));
			}

		}

		request.setAttribute("categoria", categoria);
		vistaSeleccionda = VIEW_FORM;

	}

	private void guardar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pId = request.getParameter("id");
		String pNombre = request.getParameter("nombre");

		Categoria categoria = new Categoria();
		categoria.setId(Integer.parseInt(pId));
		categoria.setNombre(pNombre);

		Set<ConstraintViolation<Categoria>> validaciones = validator.validate(categoria);

		if (validaciones.size() > 0) {

			mensajeValidacion(request, validaciones);

			request.setAttribute("categoria", categoria);

			vistaSeleccionda = VIEW_FORM;

		} else {

			if ("0".equals(pId)) {

				try {

					dao.create(categoria);

				} catch (Exception e) {

					LOG.error("Error al crear la nueva categoria. Datos de la categoria: " + categoria.toString() + "\n ERROR: " + e);
				}

				request.setAttribute("mensajeAlerta", new Alerta("Categoria agregada correctamente :)", Alerta.TIPO_SUCCESS));
				this.listar(request, response);

			} else {

				try {
					
					categoria.setId(Integer.parseInt(pId));
					
					dao.update(Integer.parseInt(pId), categoria);
					
				} catch (NumberFormatException e) {
					
					LOG.error("El ID pasado no es un numero. ERROR: " + e);
					
					request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el administrador.", Alerta.TIPO_DANGER));
					
				} catch (Exception e) {
					
					LOG.error("Error al actualizar la categoria. Datos usuario: " + categoria.toString() + "\n ERROR: " + e);
					
					request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el adminitrador.", Alerta.TIPO_DANGER));
				}

				request.setAttribute("mensajeAlerta", new Alerta("Categoria modificado correctamente :)", Alerta.TIPO_SUCCESS));

				this.listar(request, response);

			}

		}

	}

	private void mensajeValidacion(HttpServletRequest request, Set<ConstraintViolation<Categoria>> validaciones) {

		StringBuilder mensaje = new StringBuilder();
		for (ConstraintViolation<Categoria> cv : validaciones) {

			mensaje.append("<p>");
			mensaje.append(cv.getPropertyPath().toString().substring(0, 1).toUpperCase()
					+ (cv.getPropertyPath().toString().substring(1))).append(": ");
			mensaje.append(cv.getMessage());
			mensaje.append("</p>");

		}

		request.setAttribute("mensajeAlerta", new Alerta(mensaje.toString(), Alerta.TIPO_DANGER));

	}

	private void eliminar(HttpServletRequest request, HttpServletResponse response) {

		String pId = request.getParameter("id");

		Alerta alerta = new Alerta();

		if ((!"".equals(pId) && pId != null)) {

			Categoria categoria = null;
			try {
				
				categoria = dao.delete(Integer.parseInt(pId));
				
			} catch (MySQLIntegrityConstraintViolationException e1) {
				
				request.setAttribute("mensajeAlerta", new Alerta("No se puede eliminar una categoria con productos asociados >:(", Alerta.TIPO_DANGER));
				
				this.listar(request, response);
				
			} catch (Exception e) {
				
				LOG.error("El ID pasado no es un numero. ERROR: " + e);
				
				request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el administrador.", Alerta.TIPO_DANGER));
			} 
			alerta.setTexto("La categoria " + categoria.toString() + " ha sido eliminada con exito.");
			alerta.setTipo(Alerta.TIPO_SUCCESS);

		} else {

			alerta.setTexto("Ha ocurrido un error a la hora de eliminar la categoria :(");
			alerta.setTipo(Alerta.TIPO_DANGER);

		}

		request.setAttribute("mensajeAlerta", alerta);

		this.listar(request, response);

	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {

		request.setAttribute("categorias", dao.getAll());
		vistaSeleccionda = VIEW_TABLA;

	}

}
