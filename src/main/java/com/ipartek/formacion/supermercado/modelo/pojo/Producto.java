package com.ipartek.formacion.supermercado.modelo.pojo;

import java.util.Date;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;
import org.hibernate.validator.constraints.Range;

public class Producto {

	
	public static final int DESCUENTO_MIN = 0;
	public static final int DESCUENTO_MAX = 100;
	
	private int id;
	
	@NotNull
	@NotBlank
	@Size( min = 2, max = 50)
	private String nombre;
	private float precio;
	private String imagen;	
	private String descripcion;
	@Range(min = 0, max= 100)
	private int descuento;
	private Date fechaAlta;
	private Date fechaModificada;
	private Date fechabaja;
	private Usuario usuario;
	private Categoria categoria;
	
	public Producto() {
		super();
		this.id = 0;
		this.nombre = "";
		this.precio = 0;
		this.imagen = "https://image.flaticon.com/icons/png/512/372/372627.png";
		this.descripcion = "";
		this.descuento = DESCUENTO_MIN;
		this.fechaAlta = new Date();
		this.fechaModificada = new Date();
		this.fechabaja = new Date();;
		this.usuario = new Usuario();
		this.categoria = new Categoria();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public float getPrecio() {
		return precio;
	}

	public void setPrecio(float precio) {
		this.precio = precio;
	}

	public String getImagen() {
		return imagen;
	}

	public void setImagen(String imagen) {
		this.imagen = imagen;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public int getDescuento() {
		return descuento;
	}

	public void setDescuento(int descuento) {
		this.descuento = descuento;
	}
	
	public float getPrecioDescuento() {
		return (  (this.precio * ( 100 - this.descuento )) / 100  );
	}

	public Date getFechaAlta() {
		return fechaAlta;
	}

	public void setFechaAlta(Date fechaAlta) {
		this.fechaAlta = fechaAlta;
	}

	public Date getFechaModificada() {
		return fechaModificada;
	}

	public void setFechaModificada(Date fechaModificada) {
		this.fechaModificada = fechaModificada;
	}

	public Date getFechabaja() {
		return fechabaja;
	}

	public void setFechabaja(Date fechabaja) {
		this.fechabaja = fechabaja;
	}

	public void setCategoria(Categoria categoria) {
		this.categoria = categoria;
	}
	
	public Categoria getCategoria() {
		return categoria;
	}
	
	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	@Override
	public String toString() {
		return "Producto [id=" + id + ", nombre=" + nombre + ", precio=" + precio + ", imagen=" + imagen
				+ ", descripcion=" + descripcion + ", descuento=" + descuento + ", fechaAlta=" + fechaAlta
				+ ", fechaModificada=" + fechaModificada + ", fechabaja=" + fechabaja + ", usuario=" + usuario
				+ ", categoria=" + categoria + "]";
	}
	

		
}
