package com.ipartek.formacion.supermercado.controller;

import java.io.IOException;
import java.util.Set;

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

import com.ipartek.formacion.supermercado.modelo.dao.UsuarioDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

/**
 * Servlet implementation class RegistroController
 */
@WebServlet("/registro")
public class RegistroController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private final static Logger LOG = Logger.getLogger(LoginController.class);

	private static UsuarioDAO usuarioDao = UsuarioDAO.getInstance();	
	
	ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
	Validator validator = factory.getValidator();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("registro.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String vistaSeleccionda = "";
		
		String pNombre = request.getParameter("nombre");
		String pPassword = request.getParameter("password");
		String pImagen = request.getParameter("imagen");
		
		Usuario user = new Usuario();
		
		user.setNombre(pNombre);
		user.setContrasenia(pPassword);
		
		if(!pImagen.trim().equals("") && pImagen != null) {	
			
			user.setImagen(pImagen);	
			
		}

		Set<ConstraintViolation<Usuario>> validaciones = validator.validate(user);

		if (validaciones.size() > 0) {

			mensajeValidacion(request, validaciones);

			request.setAttribute("usuario", user);

		} else {

				try {
					
					usuarioDao.create(user);
					
				} catch (Exception e) {
					
					LOG.error("Error al crear el usuario. Datos usuario: " + user.toString() + "\n ERROR: " + e);
					
					request.setAttribute("mensajeAlerta", new Alerta("Ha ocurrido un error a la hora de procesar la solicitud. Contacte con el adminitrador.", Alerta.TIPO_DANGER));
					
					vistaSeleccionda = "registro.jsp";
				}

				request.setAttribute("mensajeAlerta", new Alerta("Usuario creado correctamente :)", Alerta.TIPO_PRIMARY));
				
				request.getRequestDispatcher("login.jsp").forward(request, response);

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

}
