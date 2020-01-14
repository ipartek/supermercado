package com.ipartek.formacion.supermercado.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import com.ipartek.formacion.supermercado.modelo.dao.UsuarioDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Alerta;
import com.ipartek.formacion.supermercado.modelo.pojo.Rol;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/login")
public class LoginController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private final static Logger LOG = Logger.getLogger(LoginController.class);

	private static UsuarioDAO usuarioDao = UsuarioDAO.getInstance();

	private static boolean isRedirect = false;

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

		String view = "login.jsp";

		String nombre = request.getParameter("nombre");
		String pass = request.getParameter("contrasenya");

		Usuario usuario = new Usuario();

		try {

			usuario = usuarioDao.exist(nombre, pass);

			if (usuario != null) {

				LOG.info("login correcto " + usuario);
				HttpSession session = request.getSession();
				session.setAttribute("usuarioLogeado", usuario);
				session.setMaxInactiveInterval(60 * 10); // 10min

				if (usuario.getRol().getId() == Rol.ROL_ADMIN) {
					isRedirect = false;

					view = "seguridad/index.jsp"; // accedemos la BACK-OFFICE

				} else {

					Usuario u = (Usuario) request.getSession().getAttribute("usuarioLogeado");
					usuarioDao.getById(u.getId());
					request.setAttribute("miUsuario", u);
					isRedirect = true;
					view = "mipanel/index.jsp"; // accedemos la FRONT-OFFICE

				}

			} else {

				request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "Debe logearse, prueba de nuevo"));

			}
		} catch (Exception e) {
			LOG.error(e);
		} finally {

			request.getRequestDispatcher(view).forward(request, response);

		}

	}

}
