package com.ipartek.formacion.supermercado.modelo.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.ipartek.formacion.supermercado.model.ConnectionManager;
import com.ipartek.formacion.supermercado.modelo.pojo.Categoria;
import com.ipartek.formacion.supermercado.modelo.pojo.Producto;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

public class ProductoDAO implements IProductoDAO {

	private final static Logger LOG = Logger.getLogger(ProductoDAO.class);
	
	private static UsuarioDAO usuarioDao;
	private static CategoriaDAO categoriaDao;

	private static ProductoDAO INSTANCE;

	
	private static final String SQL_GET_ALL = "{CALL `pa_producto_getall`()}";

	//Obtener todos los productos de un usuario
	private static final String SQL_GET_ALL_BY_USER = "{CALL `pa_producto_get_by_user`(?)}";

	//Obtener un producto por su id
	private static final String SQL_GET_BY_ID = "{CALL `pa_producto_get_by_id`(?)}";
	
	//Obtener un producto por su id y su id de usuario
	private static final String SQL_GET_BY_ID_BY_USER = "{CALL `pa_producto_get_by_user`}";
	
	//Búsqueda personalizada
	private static final String SQL_BUSQUEDA_PERSONALIZADA = "{CALL `pa_producto_busqueda_personalizada`(?,?)}";
	
	
	//Crear un nuevo producto
	private static final String SQL_GET_INSERT = "{CALL `pa_producto_insert`(?, ?, ?, ?, ?, ?, ?)}";
	
	//Actualizar un producto por id y usuario
	private static final String SQL_GET_UPDATE = "{CALL `pa_producto_update`(?,?,?,?,?,?,?,?)}";
	private static final String SQL_GET_UPDATE_BY_USER = "{CALL `pa_producto_updatebyuser`(?,?,?,?,?,?,?,?)}";
	
	//Eliminar un producto de forma lógica
	private static final String SQL_DELETE_LOGICO = "{CALL `pa_producto_delete_logico`(?)}";
	
	
	private static final String SQL_DELETE_BY_USER = "{}";
	

	private ProductoDAO() {
		super();
	}

	public static synchronized ProductoDAO getInstance() {

		if (INSTANCE == null) {
			INSTANCE = new ProductoDAO();
		}

		return INSTANCE;
	}

	@Override
	public List<Producto> getAll() {

		ArrayList<Producto> lista = new ArrayList<Producto>();

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs =  con.prepareCall(SQL_GET_ALL);
				ResultSet rs = cs.executeQuery()) {
				LOG.debug(cs);
			while (rs.next()) {

				lista.add(mapper(rs));

			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return lista;
	}

	public List<Producto> getAllByUser(int idUsuario) {

		ArrayList<Producto> lista = new ArrayList<Producto>();

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_GET_ALL_BY_USER)) {

			cs.setInt(1, idUsuario);
			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
				while (rs.next()) {
					lista.add(mapper(rs));
				}
			} // executeQuery

		} catch (SQLException e) {
			LOG.error(e);
		}

		return lista;
	}

	@Override
	public Producto getById(int id) {

		Producto p = null;

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_GET_BY_ID);) {

			// sustituyo parametros en la SQL, en este caso 1º ? por id
			cs.setInt(1, id);
			LOG.debug(cs);
			// ejecuto la consulta
			try (ResultSet rs = cs.executeQuery()) {

				while (rs.next()) {
					p = mapper(rs);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return p;
	}
	
	
	@Override
	public Producto getByIdByUser(int idProducto, int idUsuario) throws ProductoException {
		Producto p = null;

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_GET_BY_ID_BY_USER);) {

			// sustituyo parametros en la SQL, en este caso 1º ? por id
			cs.setInt(1, idProducto);
			cs.setInt(2, idUsuario);

			LOG.debug(cs);
			// ejecuto la consulta
			try (ResultSet rs = cs.executeQuery()) {

				if (rs.next()) {
					p = mapper(rs);
				}else {
					LOG.warn("No se encuentra producto");
					throw new ProductoException(ProductoException.EXCEPTION_UNAUTORIZED);
				}
			}

		}catch (SQLException e) {
			throw new ProductoException(ProductoException.EXCEPTION_UNAUTORIZED);
		}	

		return p;
	}
	

	@Override
	public Producto delete(int id) throws Exception {

		Producto registro = null;
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_DELETE_LOGICO)) {

			cs.setInt(1, id);

			registro = this.getById(id); // recuperar

			int affectedRows = cs.executeUpdate(); // eliminar
			if (affectedRows != 1) {
				registro = null;
				throw new Exception("No se puede eliminar " + registro);
			}

		}
		return registro;
	}
	
	@Override
	public Producto deleteByUser(int idProducto, int idUsuario) throws ProductoException {

		Producto registro = null;
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_DELETE_BY_USER)) {

			cs.setInt(1, idProducto);
			cs.setInt(2, idUsuario);

			registro = this.getById(idProducto); // recuperar

			LOG.debug(cs);
			
			int affectedRows = cs.executeUpdate();
			 
			
			if (affectedRows == 1) {
				LOG.debug("registro eliminado");
				
			}else {
				
				LOG.warn("No te pertenece producto al usuario");
				throw new ProductoException(ProductoException.EXCEPTION_UNAUTORIZED);
				
			}

		} catch (SQLException e) {
			throw new ProductoException(ProductoException.EXCEPTION_UNAUTORIZED);
		}
		return registro;
	}
	
	

	@Override
	public Producto update(int id, Producto pojo) throws Exception {

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_GET_UPDATE)) {

			cs.setString(1, pojo.getNombre());
			cs.setInt(2, pojo.getUsuario().getId());
			cs.setInt(3, id);

			int affectedRows = cs.executeUpdate(); // lanza una excepcion si nombre repetido
			if (affectedRows == 1) {
				pojo.setId(id);
			} else {
				throw new Exception("No se encontro registro para id=" + id);
			}

		}
		return pojo;
	}
	
	
	@Override
	public Producto updateByUser(int idProducto, int idUsuario, Producto pojo) throws SQLException,ProductoException {
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs =  con.prepareCall(SQL_GET_UPDATE_BY_USER)) {

			cs.setString(1, pojo.getNombre());
			cs.setInt(2, pojo.getUsuario().getId());			
			cs.setInt(3, idProducto);
			cs.setInt(4, idUsuario);
			
			LOG.debug(cs);

			int affectedRows = cs.executeUpdate(); // lanza una excepcion si nombre repetido
			if (affectedRows == 1) {
				LOG.debug("producto modificado");
				pojo.setId(idProducto);
			} else {
				LOG.warn("No le pertence el producto");
				throw new ProductoException(ProductoException.EXCEPTION_UNAUTORIZED);
			}
		}catch ( SQLException e) {
			
			LOG.debug(e + " ya existe el nombre del producto");
			throw e;
		}
		return pojo;
	}
	

	@Override
	public Producto create(Producto pojo) throws Exception {

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_GET_INSERT)) {
			
			int categoria = pojo.getCategoria().getId();

			cs.setString(1, pojo.getNombre());
			cs.setFloat(2, pojo.getPrecio());
			cs.setString(3, pojo.getImagen());
			cs.setString(4, pojo.getDescripcion());
			cs.setInt(5, pojo.getDescuento());
			cs.setInt(6, categoria);
			cs.setInt(7, pojo.getUsuario().getId());
						
			LOG.debug(cs);
			int affectedRows = cs.executeUpdate();
			if (affectedRows == 1) {
				// conseguimos el ID que acabamos de crear
				ResultSet rs = cs.getGeneratedKeys();
				if (rs.next()) {
					pojo.setId(rs.getInt(1));
				}

			}

		}

		return pojo;
	}

	
	public List<Producto> busquedaPersonalizada(int idCategoria, String nProducto) {
		ArrayList<Producto> listaProductos = new ArrayList<Producto>();
		Producto p = null;
		
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_BUSQUEDA_PERSONALIZADA) ) {

			// sustituyo parametros en la SQL, en este caso 1º ? por id
			cs.setInt(1, idCategoria);
			cs.setString(2, nProducto);
			
			LOG.debug(cs);
			// ejecuto la consulta
			try (ResultSet rs = cs.executeQuery()) {

				while (rs.next()) {
					p = mapper(rs);
					listaProductos.add(p);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return listaProductos;
	}
	
	/**
	 * Utilidad para mapear un ResultSet a un Producto
	 * 
	 * @param rs
	 * @return
	 * @throws SQLException
	 */
	private Producto mapper(ResultSet rs) throws SQLException {

		usuarioDao = UsuarioDAO.getInstance();
		
		categoriaDao = CategoriaDAO.getInstance();
		
		Producto p = new Producto();
		p.setId(rs.getInt("id_producto"));
		p.setNombre(rs.getString("nombre_producto"));
		p.setPrecio(rs.getFloat("precio"));
		p.setImagen(rs.getString("imagen"));
		p.setDescripcion(rs.getString("descripcion"));
		p.setDescuento(rs.getInt("descuento"));
		
		
		
		p.setCategoria(categoriaDao.getById(rs.getInt("id_categoria")));
		
		p.setUsuario(usuarioDao.getById(rs.getInt("id_usuario")));
		
		return p;
	}

}
