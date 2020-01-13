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
import com.ipartek.formacion.supermercado.modelo.dao.UsuarioDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Rol;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;

/**
 * Servlet implementation class ProductosController
 */
@WebServlet("/seguridad/usuarios")
public class UsuariosController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static Logger LOG = Logger.getLogger(UsuariosController.class);
	private static final String VIEW_TABLA = "usuarios/index.jsp";
	private static final String VIEW_FORM = "usuarios/formulario.jsp";
	private static String vistaSeleccionda = VIEW_TABLA;
	private static UsuarioDAO dao;

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

		dao = UsuarioDAO.getInstance();
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

		Usuario usuario = new Usuario();

		String pId = request.getParameter("id");

		if (!"".equals(pId) && pId != null) {

			try {

				usuario = dao.getById(Integer.parseInt(pId));

			} catch (NumberFormatException e) {

				LOG.error("El ID pasado no es un numero. ERROR: " + e);
				
				request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el adminitrador.", Alerta.TIPO_DANGER));
				
			} catch (Exception e) {
				
				LOG.error("Error al convertir el string de pId en integer. ERROR: " + e);
				
				request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el adminitrador.", Alerta.TIPO_DANGER));
			}

		}

		request.setAttribute("usuario", usuario);
		vistaSeleccionda = VIEW_FORM;

	}

	private void guardar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pId = request.getParameter("id");
		String pNombre = request.getParameter("nombre");
		String pPassword = request.getParameter("password");
		String pRol = request.getParameter("rolId");

		Usuario user = new Usuario();
		user.setId(Integer.parseInt(pId));
		user.setNombre(pNombre);
		user.setContrasenia(pPassword);
		
		Rol rol = new Rol();
		rol.setId(Integer.parseInt(pRol));
		
		if(Integer.parseInt(pRol) == Rol.ROL_ADMIN) {
			
			rol.setNombre("ADMIN");
			
		}

		Set<ConstraintViolation<Usuario>> validaciones = validator.validate(user);

		if (validaciones.size() > 0) {

			mensajeValidacion(request, validaciones);

			request.setAttribute("usuario", user);

			vistaSeleccionda = VIEW_FORM;

		} else {

			if ("0".equals(pId)) {

				try {

					dao.create(user);

				} catch (Exception e) {

					LOG.error("Error al crear un nuevo usuario. Datos del usuario: " + user.toString() + "\n ERROR: " + e);
				}

				request.setAttribute("mensajeAlerta", new Alerta("Producto agregado correctamente :)", Alerta.TIPO_SUCCESS));
				this.listar(request, response);

			} else {

				try {
					
					user.setId(Integer.parseInt(pId));
					
					dao.update(Integer.parseInt(pId), user);
					
				} catch (NumberFormatException e) {
					
					LOG.error("El ID pasado no es un numero. ERROR: " + e);
					
					request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el administrador.", Alerta.TIPO_DANGER));
					
				} catch (Exception e) {
					
					LOG.error("Error al actualizar usuario. Datos usuario: " + user.toString() + "\n ERROR: " + e);
					
					request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el adminitrador.", Alerta.TIPO_DANGER));
				}

				request.setAttribute("mensajeAlerta", new Alerta("Usuario modificado correctamente :)", Alerta.TIPO_SUCCESS));

				this.listar(request, response);

			}

		}

	}

	private void mensajeValidacion(HttpServletRequest request, Set<ConstraintViolation<Usuario>> validaciones) {

		StringBuilder mensaje = new StringBuilder();
		for (ConstraintViolation<Usuario> cv : validaciones) {

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

			Usuario user = null;
			try {
				
				user = dao.delete(Integer.parseInt(pId));
				
			} catch (MySQLIntegrityConstraintViolationException e1) {
				
				request.setAttribute("mensajeAlerta", new Alerta("No se puede eliminar un usuario con productos asociados >:(", Alerta.TIPO_DANGER));
				
				this.listar(request, response);
				
			} catch (Exception e) {
				
				LOG.error("El ID pasado no es un numero. ERROR: " + e);
				
				request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el administrador.", Alerta.TIPO_DANGER));
			} 
			alerta.setTexto("El usuario " + user.toString() + " ha sido eliminado con exito.");
			alerta.setTipo(Alerta.TIPO_SUCCESS);

		} else {

			alerta.setTexto("Ha ocurrido un error a la hora de eliminar el usuario :(");
			alerta.setTipo(Alerta.TIPO_DANGER);

		}

		request.setAttribute("mensajeAlerta", alerta);

		this.listar(request, response);

	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {

		request.setAttribute("usuarios", dao.getAll());
		vistaSeleccionda = VIEW_TABLA;

	}

}
