package com.ipartek.formacion.supermercado.modelo.dao;

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
	 * Junta el nombre y passwd en un solo string y crea un hash de dicho string
	 * @param nombre
	 * @param passwd
	 * @return Hash del string con el nombre y passwd combinado
	 */
	
	String encriptarContrasenia(String nombre, String passwd);	
}
