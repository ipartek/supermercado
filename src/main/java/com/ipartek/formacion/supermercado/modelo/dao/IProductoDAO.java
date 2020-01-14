package com.ipartek.formacion.supermercado.modelo.dao;

import java.sql.SQLException;
import java.util.List;

import com.ipartek.formacion.supermercado.modelo.pojo.Producto;

public interface IProductoDAO extends IDAO<Producto> {

	/**
	 * Filtra todos los productos por idCategoria o nombre o ambos o ninguno (solo saca los activos)
	 * @param idCategoria
	 * @param nombre
	 * @return productos filtrados por nombre y categoria. Si no le pasa un nombre o categoria devuelve todos los productos
	 */
	List<Producto> getActivesFiltered(int idCategoria, String nombre);


	/**
	 * Filtra todos los productos por idCategoria o nombre o ambos o ninguno
	 * @param idCategoria
	 * @param nombre
	 * @return productos filtrados por nombre y categoria. Si no le pasa un nombre o categoria devuelve todos los productos
	 */
	List<Producto> getAllFiltered(int idCategoria, String nombre);


	/**
	 * Lista los producto de un Usuario
	 * @param idUsuario int identificador del Usuario
	 * @return List<Producto>, lista inicializada en caso de que no tenga productos
	 */
	List<Producto> getAllByUser(int idUsuario);

	/**
	 * Recupera un Producto de un Usuario concreto
	 * @param idProducto int
	 * @param idUsuario int
	 * @return Producto si encuentra, null si no encuentra
	 * @throws ProductoException Cuando intenta recuperar un producto que no pertenece al usuario
	 */
	public Producto getByIdByUser( int idProducto, int idUsuario) throws ProductoException;

	/**
	 * Modificar un producto de un Usuario concreto
	 * @param idProducto
	 * @param idUsuario
	 * @param pojo
	 * @return
	 * @throws SQLException Si el nombre del producto existe
	 * @throws ProductoException Cuando intenta modificar un producto que no pertenece al usuario
	 */
	public Producto updateByUser(int idProducto, int idUsuario, Producto pojo) throws SQLException,  ProductoException;


	/**
	 * Elimina un producto de un @class Usuario concreto
	 * @param idProducto
	 * @param idUsuario
	 * @return el @class Producto Eliminado si lo encuentra, si no lo encuentra lanza ProductoException
	 * @throws ProductoException
	 * 			<ol>
	 * 				<li>Cuando intenta eliminar un producto que no pertenece al usuario</li>
	 * 				<li>Cuando no encuentra producto por su id para idUsuario</li>
	 * 			</ol>
	 */
	public Producto deleteByUser(int idProducto, int idUsuario ) throws SQLException, ProductoException;

}
