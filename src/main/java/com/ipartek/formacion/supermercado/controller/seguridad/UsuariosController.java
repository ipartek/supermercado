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
	private static final String VIEW_TABLA_ACTIVOS = "usuarios/index.jsp";
	private static final String VIEW_TABLA_SIN_VALIDAR = "usuarios/listasinvalidar.jsp";
	private static final String VIEW_TABLA_BAJA = "usuarios/listabaja.jsp";
	private static final String VIEW_FORM = "usuarios/formulario.jsp";
	private static String vistaSeleccionda = VIEW_TABLA_ACTIVOS;
	private static UsuarioDAO dao;

	ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
	Validator validator = factory.getValidator();

	// Acciones

	private static final String ACCION_LISTAR_ACTIVOS = "listar_activos";
	private static final String ACCION_LISTAR_SIN_VALIDAR = "listar_sinvalidar";
	private static final String ACCION_LISTAR_BAJA = "listar_baja";
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
			case ACCION_LISTAR_ACTIVOS:
				listarActivos(request, response);
				break;
			case ACCION_LISTAR_SIN_VALIDAR:
				listarSinValidar(request, response);
				break;
			case ACCION_LISTAR_BAJA:
				listarBaja(request, response);
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
				listarActivos(request, response);
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
				
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el adminitrador."));
				
			} catch (Exception e) {
				
				LOG.error("Error al convertir el string de pId en integer. ERROR: " + e);
				
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el adminitrador."));
			}

		}

		request.setAttribute("usuario", usuario);
		vistaSeleccionda = VIEW_FORM;

	}

	private void guardar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pId = request.getParameter("id");
		String pNombre = request.getParameter("nombre");
		//String pPassword = request.getParameter("password");
		String pPassMD5 = request.getParameter("contraseniaMD5");

		String pRol = request.getParameter("rolId");
		String pImagen = request.getParameter("imagen");
		String pValidado = request.getParameter("validadoId");

		Usuario user = new Usuario();
		user.setId(Integer.parseInt(pId));
		user.setNombre(pNombre);
		user.setContrasenia(pPassMD5);
		user.setImagen(pImagen);
		user.setValidado(Integer.parseInt(pValidado));
		
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

				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_SUCCESS, "Producto agregado correctamente :)"));
				this.listarActivos(request, response);

			} else {

				try {
					
					user.setId(Integer.parseInt(pId));
					
					dao.update(Integer.parseInt(pId), user);
					
				} catch (NumberFormatException e) {
					
					LOG.error("El ID pasado no es un numero. ERROR: " + e);
					
					request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el administrador."));
					
				} catch (Exception e) {
					
					LOG.error("Error al actualizar usuario. Datos usuario: " + user.toString() + "\n ERROR: " + e);
					
					request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el adminitrador."));
				}

				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_SUCCESS, "Usuario modificado correctamente :)"));

				this.listarActivos(request, response);

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

		request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, mensaje.toString()));

	}

	private void eliminar(HttpServletRequest request, HttpServletResponse response) {

		String pId = request.getParameter("id");

		Alerta alerta = new Alerta();

		if ((!"".equals(pId) && pId != null)) {

			Usuario user = null;
			try {
				
				user = dao.delete(Integer.parseInt(pId));
				
			} catch (MySQLIntegrityConstraintViolationException e1) {
				
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "No se puede eliminar un usuario con productos asociados >:("));
				
				this.listarActivos(request, response);
				
			} catch (Exception e) {
				
				LOG.error("El ID pasado no es un numero. ERROR: " + e);
				
				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el administrador."));
			} 
			alerta.setTexto("El usuario " + user.toString() + " ha sido eliminado con exito.");
			alerta.setTipo(Alerta.TIPO_SUCCESS);

		} else {

			alerta.setTexto("Ha ocurrido un error a la hora de eliminar el usuario :(");
			alerta.setTipo(Alerta.TIPO_DANGER);

		}

		request.setAttribute("mensajeAlerta", alerta);

		this.listarActivos(request, response);

	}

	private void listarActivos(HttpServletRequest request, HttpServletResponse response) {

		request.setAttribute("usuarios", dao.getAll());
		vistaSeleccionda = VIEW_TABLA_ACTIVOS;

	}
	
	private void listarSinValidar(HttpServletRequest request, HttpServletResponse response) {

		request.setAttribute("usuarios", dao.getAllInactivos());
		vistaSeleccionda = VIEW_TABLA_SIN_VALIDAR;

	}
	
	private void listarBaja(HttpServletRequest request, HttpServletResponse response) {

		request.setAttribute("usuarios", dao.getAllBaja());
		vistaSeleccionda = VIEW_TABLA_BAJA;

	}

}
