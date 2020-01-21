package com.ipartek.formacion.supermercado.modelo.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.ipartek.formacion.supermercado.modelo.ConnectionManager;
import com.ipartek.formacion.supermercado.modelo.pojo.Categoria;
import com.ipartek.formacion.supermercado.modelo.pojo.Producto;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

public class ProductoDAO implements IProductoDAO {

	private final static Logger LOG = LogManager.getLogger(ProductoDAO.class);






	private static ProductoDAO INSTANCE;

	private static final String SQL_GET_ALL = "{CALL pa_producto_getall()}";
	private static final String SQL_GET_ACTIVOS_FILTER = "{CALL pa_productos_busqueda(?, ?)}";
	private static final String SQL_GET_ALL_FILTER = "{CALL pa_productos_busqueda(?, ?)}";


	private static final String SQL_GET_ALL_BY_USER = "{CALL pa_producto_getall_byuser(?)}";

	private static final String SQL_GET_BY_ID = "{ CALL pa_producto_get_byid(?) }";

	private static final String SQL_GET_BY_ID_BY_USER = "{CALL pa_producto_get_byid_byuser(?,?)}";

	private static final String SQL_INSERT = "{CALL pa_producto_insert(?, ?, ?, ?, ?, ?, ?, ?)}";
	private static final String SQL_UPDATE = "{CALL pa_producto_update(?, ?, ?, ?, ?, ?, ?, ?)}";
	private static final String SQL_UPDATE_BY_USER = "{CALL `pa_producto_update_byuser`(?, ?, ?, ?, ?, ?, ?, ?, ?)}";

	private static final String SQL_DELETE = "{CALL pa_producto_delete_logico(?)}";
	private static final String SQL_DELETE_BY_USER = "{CALL pa_producto_delete_logico_byuser(?,?)}";

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
		LOG.trace("Recuperando todos los productos");

		ArrayList<Producto> lista = new ArrayList<Producto>();

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement pst = con.prepareCall(SQL_GET_ALL)) {

			LOG.trace(pst);

			try (ResultSet rs = pst.executeQuery()) {
				while (rs.next()) {

					lista.add(mapper(rs));

				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return lista;
	}

	@Override
	public List<Producto> getActivesFiltered(int idCategoria, String nombre) {

		LOG.trace("idCategoria=" + idCategoria + " nombre=" + nombre);
		ArrayList<Producto> lista = new ArrayList<Producto>();

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement pst = con.prepareCall(SQL_GET_ACTIVOS_FILTER);) {

			pst.setInt(1, idCategoria);
			pst.setString(2, nombre);
			LOG.debug(pst);

			try (ResultSet rs = pst.executeQuery()) {
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
	public List<Producto> getAllFiltered(int idCategoria, String nombre) {

		LOG.trace("idCategoria=" + idCategoria + " nombre=" + nombre);
		ArrayList<Producto> lista = new ArrayList<Producto>();

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement pst = con.prepareCall(SQL_GET_ALL_FILTER);) {

			pst.setInt(1, idCategoria);
			pst.setString(2, nombre);
			LOG.debug(pst);

			try (ResultSet rs = pst.executeQuery()) {
				while (rs.next()) {
					lista.add(mapper(rs));
				}
			} // executeQuery

		} catch (SQLException e) {
			LOG.error(e);
		}

		return lista;
	}

	public List<Producto> getAllByUser(int idUsuario) {

		ArrayList<Producto> lista = new ArrayList<Producto>();

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement pst = con.prepareCall(SQL_GET_ALL_BY_USER);) {

			pst.setInt(1, idUsuario);
			LOG.debug(pst);

			try (ResultSet rs = pst.executeQuery()) {
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
				CallableStatement pst = con.prepareCall(SQL_GET_BY_ID);) {

			// sustituyo parametros en la SQL, en este caso 1º ? por id
			pst.setInt(1, id);
			LOG.debug(pst);

			// ejecuto la consulta
			try (ResultSet rs = pst.executeQuery()) {

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
				CallableStatement pst = con.prepareCall(SQL_GET_BY_ID_BY_USER);) {

			// sustituyo parametros en la SQL, en este caso 1º ? por id
			pst.setInt(1, idProducto);
			pst.setInt(2, idUsuario);

			LOG.debug(pst);
			// ejecuto la consulta
			try (ResultSet rs = pst.executeQuery()) {

				if (rs.next()) {
					p = mapper(rs);
				} else {
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
				CallableStatement pst = con.prepareCall(SQL_DELETE)) {

			pst.setInt(1, id);

			LOG.debug(pst);

			registro = this.getById(id); // recuperar

			int affectedRows = pst.executeUpdate(); // eliminar
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
				CallableStatement pst = con.prepareCall(SQL_DELETE_BY_USER)) {

			pst.setInt(1, idProducto);
			pst.setInt(2, idUsuario);

			registro = this.getById(idProducto); // recuperar

			LOG.debug(pst);

			int affectedRows = pst.executeUpdate();

			if (affectedRows == 1) {
				LOG.debug("registro eliminado");

			} else {

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
				CallableStatement pst = con.prepareCall(SQL_UPDATE)) {

			pst.setInt(1, id);
			pst.setString(2, pojo.getNombre());
			pst.setInt(3, pojo.getCategoria().getId());
			pst.setInt(4, pojo.getUsuario().getId());
			pst.setFloat(5, pojo.getPrecio());
			pst.setInt(6, pojo.getDescuento());
			pst.setString(7, pojo.getImagen());
			pst.setString(8, pojo.getDescripcion());

			LOG.debug(pst);



			int affectedRows = pst.executeUpdate(); // lanza una excepcion si nombre repetido
			if (affectedRows == 1) {
				pojo.setId(id);
			} else {
				throw new Exception("No se encontro registro para id=" + id);
			}

		}
		return pojo;
	}

	@Override
	public Producto updateByUser(int idProducto, int idUsuario, Producto pojo) throws SQLException, ProductoException {
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement pst = con.prepareCall(SQL_UPDATE_BY_USER)) {

			pst.setInt(1, idProducto);
			pst.setInt(2, idUsuario);
			pst.setString(3, pojo.getNombre());
			pst.setInt(4, pojo.getCategoria().getId());
			pst.setInt(5, pojo.getUsuario().getId());
			pst.setFloat(6, pojo.getPrecio());
			pst.setInt(7, pojo.getDescuento());
			pst.setString(8, pojo.getImagen());
			pst.setString(9, pojo.getDescripcion());

			LOG.debug(pst);

			int affectedRows = pst.executeUpdate(); // lanza una excepcion si nombre repetido
			if (affectedRows == 1) {
				LOG.debug("producto modificado");
				pojo.setId(idProducto);
			} else {
				LOG.warn("No le pertence el producto");
				throw new ProductoException(ProductoException.EXCEPTION_UNAUTORIZED);
			}
		} catch (SQLException e) {

			LOG.debug(e + " ya existe el nombre del producto");
			throw e;
		}
		return pojo;
	}

	@Override
	public Producto create(Producto pojo) throws Exception {

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_INSERT)) {

			cs.setString(1, pojo.getNombre());
			cs.setInt(2, pojo.getCategoria().getId());
			cs.setInt(3, pojo.getUsuario().getId());
			cs.setFloat(4, pojo.getPrecio());
			cs.setInt(5, pojo.getDescuento());
			cs.setString(6, pojo.getImagen());
			cs.setString(7, pojo.getDescripcion());


			// registro el paremetro de salida 2º ?
			cs.registerOutParameter(8, java.sql.Types.INTEGER);

			LOG.debug(cs);
			int affectedRows = cs.executeUpdate();
			if (affectedRows == 1) {
				pojo.setId(cs.getInt(8));
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
		p.setPrecio(rs.getInt("precio_producto"));
		p.setImagen(rs.getString("imagen_producto"));
		p.setDescripcion(rs.getString("descripcion_producto"));
		p.setDescuento(rs.getInt("descuento_producto"));

		Usuario u = new Usuario();
		u.setId(rs.getInt("id_usuario"));
		u.setNombre(rs.getString("nombre_usuario"));
		p.setUsuario(u);

		Categoria c = new Categoria();
		c.setId(rs.getInt("id_categoria"));
		c.setNombre(rs.getString("nombre_categoria"));
		p.setCategoria(c);

		return p;
	}

}
