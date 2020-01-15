package com.ipartek.formacion.supermercado.controller.seguridad;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

import com.ipartek.formacion.supermercado.controller.Alerta;
import com.ipartek.formacion.supermercado.modelo.dao.UsuarioDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Categoria;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;


@WebServlet("/seguridad/usuarios")
public class UsuariosController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final String VIEW_TABLA = "usuarios/index.jsp";
	private static final String VIEW_FORM = "usuarios/formulario.jsp";
	private static String vistaSeleccionda = VIEW_TABLA;
    //acciones
  	public static final String ACCION_LISTAR = "listar";
  	public static final String ACCION_IR_FORMULARIO = "formulario";
  	public static final String ACCION_GUARDAR = "guardar";   // crear y modificar
  	public static final String ACCION_ELIMINAR = "eliminar";
    private static UsuarioDAO usuarioDao;

    //Crear Factoria y Validador
  	ValidatorFactory factory;
  	Validator validator;
  	
    private String uId, uNombre, uContrasenia, uIdRol, uAccion;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doAction(request, response);
	}

	private void doAction(HttpServletRequest request, HttpServletResponse response) {
			
		
		//recoger parametros
		uAccion = request.getParameter("accion");
		uId = request.getParameter("id");
		uNombre = request.getParameter("nombre");
		uContrasenia = request.getParameter("precio");
		uIdRol = request.getParameter("imagen");
		
		
		try {
			
			switch (uAccion) {
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
			
			try {
				request.getRequestDispatcher(vistaSeleccionda).forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	
private void irFormulario(HttpServletRequest request, HttpServletResponse response) {
		
		Usuario uEditar = new Usuario();
		
		if ( uId != null ) {
			
			int id = Integer.parseInt(uId);
			uEditar = usuarioDao.getById(id);
			
		}
		request.setAttribute("categorias", usuarioDao.getAll());
		request.setAttribute("usuarios", usuarioDao.getAll() );
		request.setAttribute("producto", uEditar );
		vistaSeleccionda = VIEW_FORM;
		
	}

	private void guardar(HttpServletRequest request, HttpServletResponse response) {
		
		
		int id = Integer.parseInt(uId);
		Usuario uGuardar = new Usuario();		
		uGuardar.setId(id);
		uGuardar.setNombre(uNombre);
		
	
		Set<ConstraintViolation<Usuario>> validaciones = validator.validate(uGuardar);
		if( validaciones.size() > 0 ) {			
			mensajeValidacion(request, validaciones);
		}else {	
		
				try {
				
					if ( id > 0 ) {  // modificar
						
						usuarioDao.update(id, uGuardar);		
						request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Se ha actualizado el usuario " + uGuardar.getNombre() + " con éxito."));
					}else {            // crear
						usuarioDao.create(uGuardar);
						request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Se ha creado el usuario " + uGuardar.getNombre() + " con éxito."));
					}
					
				}catch (Exception e) {  // validacion a nivel de base datos
					
					request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "El nombre ya existe, selecciona otro"));
				}					
			
		}	
		
		request.setAttribute("usuarios", usuarioDao.getAll() );
		listar(request, response);
			
		
	}

	private void mensajeValidacion(HttpServletRequest request, Set<ConstraintViolation<Usuario>> validaciones ) {

		StringBuilder mensaje = new StringBuilder();
		for (ConstraintViolation<Usuario> cv : validaciones) {
			
			mensaje.append("<p>");
			mensaje.append(cv.getPropertyPath()).append(": ");
			mensaje.append(cv.getMessage());
			mensaje.append("</p>");
			
		}
		  
		request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, mensaje.toString() ));
		
	}

	private void eliminar(HttpServletRequest request, HttpServletResponse response) {
	
		int id = Integer.parseInt(uId);
		try {
			Usuario uEliminado = usuarioDao.delete(id);
			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Eliminado " + uEliminado.getNombre() ));
		} catch (Exception e) {
			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "No se puede Eliminar el usuario"));
			
		}
		
		listar(request, response);
		
	}

	private void listar(HttpServletRequest request, HttpServletResponse response) {
		
		ArrayList<Usuario> usuarios = (ArrayList<Usuario>) usuarioDao.getAll();
		request.setAttribute("productos", usuarios );
		vistaSeleccionda = VIEW_TABLA;
		
	}
	
	
	
	
	
}
