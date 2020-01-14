package com.ipartek.formacion.supermercado.controller.seguridad;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
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
import com.ipartek.formacion.supermercado.modelo.dao.ProductoDAO;
import com.ipartek.formacion.supermercado.modelo.dao.UsuarioDAO;
import com.ipartek.formacion.supermercado.modelo.pojo.Producto;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

/**
 * Servlet implementation class ProductosController
 */
@WebServlet("/seguridad/productos")
public class ProductosController extends HttpServlet {
	
	private final static Logger LOG = Logger.getLogger(ProductosController.class);
	
	private static final long serialVersionUID = 1L;
	private static final String VIEW_TABLA_ACTIVOS = "productos/index.jsp";
	private static final String VIEW_TABLA_BAJA = "productos/listabaja.jsp";
	private static final String VIEW_TABLA_INACTIVOS = "productos/listainactivos.jsp";
	private static final String VIEW_FORM = "productos/formulario.jsp";
	private static String vistaSeleccionda = VIEW_TABLA_ACTIVOS;
	private static ProductoDAO daoProducto;
	private static UsuarioDAO daoUsuario;
	private static CategoriaDAO daoCategoria;
	
	//acciones
	public static final String ACCION_LISTAR_ACTIVOS = "listar";
	public static final String ACCION_LISTAR_BAJA = "listar_baja";
	public static final String ACCION_LISTAR_INACTIVOS = "listar_inactivos";
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
	String pCategoria;
	String pValidado;
	
	
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
		daoCategoria = null;
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
			pCategoria = request.getParameter("categoriaId");
			pValidado = request.getParameter("validadoId");
			
			
			try {
				
				switch (pAccion) {
				case ACCION_LISTAR_ACTIVOS:
					listarActivos(request, response);
					break;
				case ACCION_LISTAR_BAJA:
					listarBaja(request, response);
					break;
				case ACCION_LISTAR_INACTIVOS:
					listarInactivos(request, response);
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
					listarActivos(request, response);
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
		
		request.setAttribute("categorias", daoCategoria.getAll());
		request.setAttribute("usuarios", daoUsuario.getAll() );
		request.setAttribute("producto", pEditar );
		vistaSeleccionda = VIEW_FORM;
		
	}

	private void guardar(HttpServletRequest request, HttpServletResponse response) {
		
		
		int id = Integer.parseInt(pId);
		Producto pGuardar = new Producto();		
		pGuardar.setId(id);
		pGuardar.setNombre(pNombre);
		pGuardar.setDescripcion(pDescripcion);
		pGuardar.setImagen(pImagen);
		pGuardar.setDescuento( Integer.parseInt(pDescuento));
		pGuardar.setPrecio(Float.parseFloat(pPrecio));
		pGuardar.setCategoria(daoCategoria.getById(Integer.parseInt(pCategoria)));
		pGuardar.setValidado(Integer.parseInt(pValidado));
		
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
						
						request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_SUCCESS, "Producto modificado correctamente :)"));
						
					} else {            // crear
						
					
						daoProducto.create(pGuardar);
						
						request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_SUCCESS, "Producto creado correctamente :)"));
					}
					
				}catch (Exception e) {  // validacion a nivel de base datos
					
					request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "El nombre ya existe, selecciona otro"));
				}
				
				this.listarActivos(request, response);
			
		}		
		
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
			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_PRIMARY, "Producto eliminado " + pEliminado.getNombre() ));
		} catch (Exception e) {
			request.setAttribute("mensajeAlerta", new Alerta(Alerta.TIPO_DANGER, "No se puede Eliminar el producto"));
			
		}
		
		listarActivos(request, response);
		
	}

	private void listarActivos(HttpServletRequest request, HttpServletResponse response) {
		
		ArrayList<Producto> productos = (ArrayList<Producto>) daoProducto.getAllActivos();
		request.setAttribute("productos", productos );
		vistaSeleccionda = VIEW_TABLA_ACTIVOS;
		
	}
	
	private void listarInactivos(HttpServletRequest request, HttpServletResponse response) {
		
		ArrayList<Producto> productos = (ArrayList<Producto>) daoProducto.getAllInactivos();
		request.setAttribute("productos", productos );
		vistaSeleccionda = VIEW_TABLA_INACTIVOS;
		
	}
	
	private void listarBaja(HttpServletRequest request, HttpServletResponse response) {
		
		ArrayList<Producto> productos = (ArrayList<Producto>) daoProducto.getAllBaja();
		request.setAttribute("productos", productos );
		vistaSeleccionda = VIEW_TABLA_BAJA;
		
	}

}
