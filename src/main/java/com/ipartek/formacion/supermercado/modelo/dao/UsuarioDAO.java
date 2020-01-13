package com.ipartek.formacion.supermercado.modelo.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.ipartek.formacion.supermercado.model.ConnectionManager;
import com.ipartek.formacion.supermercado.modelo.pojo.Rol;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

public class UsuarioDAO implements IUsuarioDAO {

	private final static Logger LOG = LogManager.getLogger(UsuarioDAO.class);

	private static final String SQL_EXIST = "{CALL pa_user_exist(?,?)}";

	private static final String SQL_GET_ALL ="{CALL pa_usuario_getall()}";

	private static final String SQL_GET_BY_ID = "{CALL pa_usuario_get_byid(?)}";

	private static final String SQL_GET_INSERT = "{CALL pa_usuario_insert(? , ? , ? , ?)}";

	private static final String SQL_GET_UPDATE = "{CALL pa_usuario_update(? , ? , ? , ?)}";

	private static final String SQL_GET_DELETE = "{CALL pa_usuario_delete_logico(?)}";




	private static UsuarioDAO INSTANCE;

	private UsuarioDAO() {
		super();
	}

	public static synchronized UsuarioDAO getInstance() {

		if (INSTANCE == null) {
			INSTANCE = new UsuarioDAO();
		}

		return INSTANCE;
	}

	@Override
	public List<Usuario> getAll() {
		ArrayList<Usuario> lista = new ArrayList<Usuario>();

		try (Connection con = ConnectionManager.getConnection();
				PreparedStatement pst = con.prepareStatement(SQL_GET_ALL);) {

			LOG.debug(pst);

			try (ResultSet rs = pst.executeQuery()) {
				while (rs.next()) {
					lista.add(mapper(rs));
				}
			}//executeQuery


		} catch (SQLException e) {
			LOG.error(e);
		}
		return lista;
	}

	@Override
	public Usuario getById(int id) {
		Usuario u = null;

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement pst = con.prepareCall(SQL_GET_BY_ID);) {

			// sustituyo parametros en la SQL, en este caso 1º ? por id
			pst.setInt(1, id);
			LOG.debug(pst);

			// ejecuto la consulta
			try (ResultSet rs = pst.executeQuery()) {

				while (rs.next()) {
					u = mapper(rs);
				}
			}

		} catch (SQLException e) {
			LOG.error(e);
		}

		return u;

	}

	@Override
	public Usuario delete(int id) throws Exception {

		Usuario registro = null;
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement pst = con.prepareCall(SQL_GET_DELETE)) {

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
	public Usuario update(int id, Usuario pojo) throws Exception {
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_GET_UPDATE)) {


			cs.setString(1, pojo.getNombre());
			cs.setString(2, pojo.getContrasenia());
			cs.setInt(3, pojo.getRol().getId());
			cs.setInt(4, id);

			LOG.debug(cs);

			int affectedRows = cs.executeUpdate(); // lanza una excepcion si nombre repetido
			if (affectedRows == 1) {
				pojo.setId(id);
			} else {
				throw new Exception("No se encontro registro o el registro tiene productos relacionados id =" + id);
			}

		}
		return pojo;
	}

	@Override
	public Usuario create(Usuario pojo) throws Exception {
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall(SQL_GET_INSERT)) {

			cs.setString(1, pojo.getNombre());
			cs.setString(2, pojo.getContrasenia());
			cs.setInt(3, pojo.getRol().getId());


			// registro el paremetro de salida 2º ?
			cs.registerOutParameter(8, java.sql.Types.INTEGER);

			LOG.debug(cs);
			int affectedRows = cs.executeUpdate();
			if (affectedRows == 1) {
				pojo.setId(cs.getInt(4));
			}

		}

		return pojo;
	}

	@Override
	public Usuario exist(String nombre, String contrasenia) {
		Usuario resul = null;

		try (Connection con = ConnectionManager.getConnection();
				PreparedStatement pst = con.prepareStatement(SQL_EXIST);) {

			pst.setString(1, nombre);
			pst.setString(2, contrasenia);
			LOG.debug(pst);

			try (ResultSet rs = pst.executeQuery()) {

				if (rs.next()) {
					resul = mapper(rs);
				}
			}

		} catch (Exception e) {
			LOG.error(e);
		}

		return resul;
	}

	private Usuario mapper(ResultSet rs) throws SQLException {

		Usuario u = new Usuario();
		u.setId(rs.getInt("id_usuario"));
		u.setNombre(rs.getString("nombre_usuario"));
		u.setContrasenia(rs.getString("contrasenia"));

		Rol r = new Rol();
		r.setId(rs.getInt("id_rol"));
		r.setNombre(rs.getString("nombre_rol"));

		u.setRol(r);

		return u;
	}

}
