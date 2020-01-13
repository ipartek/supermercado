package com.ipartek.formacion.supermercado.modelo.dao;

import java.sql.SQLException;
import java.util.List;

import com.ipartek.formacion.supermercado.modelo.pojo.Usuario;

public interface IUsuarioDAO extends IDAO<Usuario> {

	/**
	 * Comprueba si existe el usuario en la base datos
	 * @param nombre
	 * @param contrasenia
	 * @return Usuario con datos si lo encuentra, <b>null</b> en caso contrario
	 */
	Usuario exist( String nombre, String contrasenia);
	
	/**
	 * Resgitra un nuevo usuario sin validar y con rol de usuario por defecto
	 * @param pojo con los datos el usuario a registrar
	 * @return el usuario registrado
	 * @throws SQLException 
	 */
	
	Usuario registro (Usuario pojo) throws SQLException;
	
	
	/**
	 * Devuelve todos los usuarios inactivos de la base de datos
	 * @return List<Usuario>
	 */
	List<Usuario> getAllInactivos();
	
	/**
	 * Devuelve todos los usuarios dados de baja de la base de datos
	 * @return List<Usuario>
	 */
	List<Usuario> getAllBaja();
	
	/**
	 * Junta el nombre y passwd en un solo string y crea un hash de dicho string
	 * @param nombre
	 * @param passwd
	 * @return Hash del string con el nombre y passwd combinado
	 */
		
	
	String encriptarContrasenia(String nombre, String passwd);	
}
