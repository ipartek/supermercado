package com.ipartek.formacion.supermercado.modelo.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.ipartek.formacion.supermercado.model.ConnectionManager;
import com.ipartek.formacion.supermercado.modelo.pojo.Categoria;
import com.ipartek.formacion.supermercado.modelo.pojo.Producto;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

public class ProductoDAO implements IProductoDAO {

	private final static Logger LOG = Logger.getLogger(ProductoDAO.class);

	private static ProductoDAO INSTANCE;
	

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
		return null;
	}
	
	public List<Producto> getAllActivos(){
		LOG.trace("Recuperar todos los Productos que estan Activos");
		ArrayList<Producto> lista = new ArrayList<Producto>();
		
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_producto_getallactivos()}");) {

			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
				while (rs.next()) {
					
					lista.add(mapper(rs));
				}
			}
			
		} catch (Exception e) {
			LOG.error(e);
		}
		
		return lista;
	}
	
	public List<Producto> getAllBaja(){
		LOG.trace("Recuperar todos los Productos que estan de Baja");
		ArrayList<Producto> lista = new ArrayList<Producto>();
		
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_producto_getallbaja()}");) {

			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
				while (rs.next()) {
					lista.add(mapper(rs));
				}
			}
			
		} catch (Exception e) {
			LOG.error(e);
		}
		
		return lista;
	}
	
	public List<Producto> getAllInactivos(){
		LOG.trace("Recuperar todos los Productos que estan Inactivos");
		ArrayList<Producto> lista = new ArrayList<Producto>();
		
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_producto_getallinactivos()}");) {
			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
				while (rs.next()) {
					lista.add(mapper(rs));
				}
			}
			
		} catch (Exception e) {
			LOG.error(e);
		}
		
		return lista;
	}

	public List<Producto> getAllByUser(int idUsuario) {
		ArrayList<Producto> lista = new ArrayList<Producto>();

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_producto_getallbyuser(?)}");) {

			cs.setInt(1, idUsuario);
			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
				while (rs.next()) {
					lista.add(mapper(rs));
				}
			}
		} catch (SQLException e) {
			LOG.error(e);
		}
		return lista;
	}

	@Override
	public Producto getById(int id) {
		LOG.trace("Recuperar Producto por id " + id);
		Producto registro = new Producto();

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_producto_getbyid(?)}");) {

			cs.setInt(1, id);
			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
				if (rs.next()) {
					registro = mapper(rs);
				} else {
					registro = null;
				}
			}
		} catch (Exception e) {
			LOG.error(e);
		}
		return registro;
	}
	
	@Override
	public Producto getByIdByUser(int idProducto, int idUsuario) throws ProductoException {
		Producto p = null;
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_producto_getbyidbyuser(?,?)}");) {

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
		} catch (SQLException e) {
			throw new ProductoException(ProductoException.EXCEPTION_UNAUTORIZED);
		}	
		return p;
	}
	
	@Override
	public Producto delete(int id) throws Exception {
		Producto registro = null;
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_producto_deletelogico(?)}");) {

			cs.setInt(1, id);

			registro = this.getById(id); // Recuperar

			int affectedRows = cs.executeUpdate(); // Eliminar
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
				CallableStatement cs = con.prepareCall("{CALL pa_producto_deletebyuserlogico(?,?)}");) {

			cs.setInt(1, idProducto);
			cs.setInt(2, idUsuario);

			registro = this.getById(idProducto); // recuperar

			LOG.debug(cs);
			
			int affectedRows = cs.executeUpdate();
			 
			if (affectedRows == 1) {
				LOG.debug("Registro Eliminado");
				
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
				CallableStatement cs = con.prepareCall("{CALL pa_producto_update(?,?,?,?,?,?,?,?,?)}");) {
			
			cs.setInt(1, id);
			cs.setInt(2, pojo.getUsuario().getId());
			cs.setInt(3, pojo.getCategoria().getId());
			cs.setString(4, pojo.getNombre());
			cs.setString(5, pojo.getDescripcion());
			cs.setFloat(6, pojo.getPrecio());
			cs.setInt(7, pojo.getDescuento());
			cs.setString(8, pojo.getImagen());
			cs.setInt(9, pojo.getValidado());
			
			LOG.debug(cs);

			int affectedRows = cs.executeUpdate(); // lanza una excepcion si nombre repetido
			if (affectedRows == 1) {
				pojo.setId(id);
			} else {
				throw new Exception("No se encontro registro para id =" + id);
			}

		}
		return pojo;
	}
	
	
	@Override
	public Producto updateByUser(int idProducto, int idUsuario, Producto pojo) throws SQLException,ProductoException { //TODO Por hacer de momento
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_producto_updatebyuser(?,?,?,?,?,?,?,?,?)}");) {
			
			cs.setInt(1, idProducto);
			cs.setInt(2, idUsuario);
			cs.setString(3, pojo.getNombre());
			cs.setInt(4, pojo.getCategoria().getId());
			cs.setString(5, pojo.getDescripcion());
			cs.setFloat(6, pojo.getPrecio());
			cs.setInt(7, pojo.getDescuento());
			cs.setString(8, pojo.getImagen());
			cs.setInt(9, pojo.getValidado());
		
			
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
				CallableStatement cs = con.prepareCall("{CALL pa_producto_insert(?,?,?,?,?,?,?)}");) {

			cs.setString(1, pojo.getNombre());
			cs.setInt(2, pojo.getUsuario().getId());
			cs.setInt(3, pojo.getCategoria().getId());
			cs.setString(4, pojo.getDescripcion());
			cs.setFloat(5, pojo.getPrecio());
			cs.setInt(6, pojo.getDescuento());
			cs.setInt(7, pojo.getValidado());

			
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
	
	/**
	 * Utilidad para mapear un ResultSet a un Producto
	 * 
	 * @param rs
	 * @return
	 * @throws SQLException
	 */
	private Producto mapper(ResultSet rs) throws SQLException {

		Producto p = new Producto();
		p.setId(rs.getInt("id_producto"));
		p.setNombre(rs.getString("nombre_producto"));
		p.setPrecio(rs.getFloat("precio"));
		p.setImagen(rs.getString("imagen"));
		p.setDescripcion(rs.getString("descripcion"));
		p.setDescuento(rs.getInt("descuento"));
		p.setFechaAlta(rs.getTimestamp("fecha_alta").toString());
		
		if(rs.getTimestamp("fecha_baja") != null) {
			
			p.setFechaBaja(rs.getTimestamp("fecha_baja").toString());
			
		} else {
			
			p.setFechaBaja("");
			
		}
		
		p.setValidado(rs.getInt("validado"));

		Usuario u = new Usuario();
		u.setId(rs.getInt("id_usuario"));
		u.setNombre(rs.getString("nombre_usuario"));
		p.setUsuario(u);
		
		Categoria c = new Categoria();
		c.setId(rs.getInt("id_categoria"));
		c.setNombre(rs.getString("nombre_categoria"));
		p.setCategoria(c);
		
		LOG.debug(p.toString());

		return p;
	}

	@Override
	public List<Producto> busqueda(int idCategoria, String searchParam) throws SQLException {
		LOG.trace("Recuperar todos los Productos que estan Activos");
		ArrayList<Producto> lista = new ArrayList<Producto>();
		
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_producto_busqueda(?,?)}");) {

			LOG.debug(cs);
			
			cs.setInt(1, idCategoria);
			cs.setString(2, searchParam);

			try (ResultSet rs = cs.executeQuery()) {
				while (rs.next()) {
					lista.add(mapper(rs));
				}
			}
			
		} catch (Exception e) {
			LOG.error(e);
		}
		
		return lista;
	}

}
