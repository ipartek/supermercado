package com.ipartek.formacion.supermercado.controller.mipanel;

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
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

/**
 * Servlet implementation class ProductosController
 */
@WebServlet("/mipanel/usuarios/")
public class UsuariosController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final static Logger LOG = Logger.getLogger(UsuariosController.class);
	private static final String VIEW_DATOS =  "/mipanel/index.jsp";
	private static UsuarioDAO dao;
	private Usuario uLogeado;

	ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
	Validator validator = factory.getValidator();

	// Acciones

	private static final String ACCION_DATOS = "datos";
	private static final String ACCION_GUARDAR = "guardar"; // Crear y modificar

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
		
		uLogeado = (Usuario)request.getSession().getAttribute("usuarioLogeado");

		try {

			switch (pAccion) {
			case ACCION_DATOS:
				listar(request, response);
				break;
			case ACCION_GUARDAR:
				guardar(request, response);
				break;
			default:
				listar(request, response);
				break;
			}

		} catch (Exception e) {
			
			LOG.error("Ha ocurrido un error a la hora de proveer los datos necesarios: " + e);

		} finally {
			
			LOG.debug(getServletContext().toString() + VIEW_DATOS);

			request.getRequestDispatcher(getServletContext().toString() + VIEW_DATOS).forward(request, response);
		}

	}

	private void guardar(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String pPassword = request.getParameter("password");
		String pPasswordConfirm = request.getParameter("password-confirm");
		String pImagen = request.getParameter("imagen");

		Usuario user = uLogeado;

		Set<ConstraintViolation<Usuario>> validaciones = validator.validate(user);

		if (validaciones.size() > 0) {

			mensajeValidacion(request, validaciones);

			request.setAttribute("usuario", user);

		} else {

				try {
					
					dao.update(user.getId(), user);
					
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

	private void listar(HttpServletRequest request, HttpServletResponse response) {

		Usuario usuario = new Usuario();

		try {
			usuario = dao.getById(uLogeado.getId());
		} catch (Exception e) {
			LOG.error("No se ha podido recuperar el usuario para listar sus datos. ERROR -> " + e);
		}

		request.setAttribute("usuario", usuario);

	}

}
