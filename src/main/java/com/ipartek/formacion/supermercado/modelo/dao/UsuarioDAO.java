package com.ipartek.formacion.supermercado.modelo.dao;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.DatatypeConverter;

import org.apache.log4j.Logger;

import com.ipartek.formacion.supermercado.model.ConnectionManager;
import com.ipartek.formacion.supermercado.modelo.pojo.Rol;
import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

public class UsuarioDAO implements IUsuarioDAO {

	private final static Logger LOG = Logger.getLogger(UsuarioDAO.class);

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
		LOG.trace("Recuperar todos los Usuarios");
		List<Usuario> registros = new ArrayList<Usuario>();
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_usuario_getallactivos()}");) {

			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
				while (rs.next()) {
					registros.add(mapper(rs));
				}
			}
		} catch (Exception e) {
			LOG.error(e);
		}
		return registros;
	}
	
	@Override
	public List<Usuario> getAllInactivos() {
		LOG.trace("Recuperar todos los Usuarios inactivos");
		List<Usuario> registros = new ArrayList<Usuario>();
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_usuario_getallinactivos()}");) {

			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
				while (rs.next()) {
					registros.add(mapper(rs));
				}
			}
		} catch (Exception e) {
			LOG.error(e);
		}
		return registros;
	}
	

	@Override
	public List<Usuario> getAllBaja() {
		LOG.trace("Recuperar todos los Usuarios dados de baja");
		List<Usuario> registros = new ArrayList<Usuario>();
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_usuario_getallbaja()}");) {

			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
				while (rs.next()) {
					registros.add(mapper(rs));
				}
			}
		} catch (Exception e) {
			LOG.error(e);
		}
		return registros;
	}

	@Override
	public Usuario getById(int id) {
		LOG.trace("Recuperar Usuario por id " + id);
		Usuario registro = new Usuario();

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_usuario_getbyid(?)}");) {

			cs.setInt(1, id);
			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
				if (rs.next()) {
					registro = mapper(rs);
				} else {
					registro = null;
				}
			}

		}catch (Exception e) {
			LOG.error(e);
		}

		return registro;
	}

	@Override
	public Usuario delete(int id) throws Exception {
		LOG.trace("Eliminacion logica de un Usuario por su id " + id);

		// Recuperar el Usuario antes de eliminacion logica
		Usuario registro = getById(id);
		if (registro == null) {
			throw new Exception("Registro no encontrado " + id);
		}

		// Eliminacion Logica
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_usuario_deletelogico(?)}");) {

			cs.setInt(1, id);
			LOG.debug(cs);

			int affectedRows = cs.executeUpdate();
			if (affectedRows != 1) {
				registro = null;
				throw new Exception("No se puede eliminar " + registro);
			}
		} 

		return registro;
	}

	@Override
	public Usuario update(int id, Usuario pojo) throws Exception {
		LOG.trace("Modificar Usuario por id " + id + " " + pojo );
		Usuario registro = pojo;
		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_usuario_update(?,?,?,?,?,?)}");) {

			cs.setInt(1, id);
			cs.setString(2, pojo.getNombre());
			cs.setString(3, pojo.getContrasenia());
			cs.setString(4, pojo.getImagen());
			cs.setInt(5, pojo.getRol().getId());
			cs.setInt(6, pojo.getValidado());
			
			LOG.debug(cs);

			if (cs.executeUpdate() == 1) {
				pojo.setId(id);
			}else {
				throw new Exception("No se puede modificar registro " + pojo + " por id " + id);
			}
		} 

		return registro;
	}

	@Override
	public Usuario create(Usuario pojo) throws Exception {
		LOG.trace("Inserta nuevo Usuario " + pojo);

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_usuario_registrobyadmin(?,?,?,?)}");) { 

			cs.setString(1, pojo.getNombre());
			cs.setString(2, pojo.getContrasenia());
			cs.setString(3, pojo.getImagen());
			cs.setInt(4, pojo.getRol().getId());

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

	@Override
	public Usuario exist(String nombre, String contrasenia) { //TODO Mirar si Funciona
		Usuario resul = null;

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_usuario_exist(?,?)}");) {

			cs.setString(1, nombre);
			cs.setString(2, contrasenia);
			LOG.debug(cs);

			try (ResultSet rs = cs.executeQuery()) {
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
		u.setValidado(rs.getInt("validado"));
		u.setImagen(rs.getString("imagen"));
		
		u.setFechaAlta(rs.getTimestamp("fecha_alta").toString());
		
		if(rs.getTimestamp("fecha_baja") != null) {
			
			u.setFechaBaja(rs.getTimestamp("fecha_baja").toString());
			
		} else {
			
			u.setFechaBaja("");
			
		}

		Rol r = new Rol();
		r.setId(rs.getInt("id_rol"));
		r.setNombre(rs.getString("nombre_rol"));

		u.setRol(r);

		return u;
	}

	@Override
	public String encriptarContrasenia(String nombre, String passwd) {
		String combinacion = nombre+passwd;
		String resul = "";
		
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(combinacion.getBytes());
			byte[] digest = md.digest();
			resul = DatatypeConverter.printHexBinary(digest).toUpperCase();
		} catch (NoSuchAlgorithmException e) {
			LOG.error(e);
		}
		
		return resul;
	}

	@Override
	public Usuario registro(Usuario pojo) throws SQLException {
		LOG.trace("Inserta nuevo Usuario " + pojo);

		try (Connection con = ConnectionManager.getConnection();
				CallableStatement cs = con.prepareCall("{CALL pa_usuario_registro(?,?,?)}");) { 

			cs.setString(1, pojo.getNombre());
			cs.setString(2, pojo.getContrasenia());
			cs.setString(3, pojo.getImagen());

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

}
