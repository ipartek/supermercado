package com.ipartek.formacion.supermercado.modelo.pojo;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.validation.constraints.Size;
import javax.xml.bind.DatatypeConverter;

import org.hibernate.validator.constraints.NotBlank;

public class Usuario {
	
	private int id;
	
	@NotBlank
	@Size( min = 2, max = 50)
	private String nombre;
	
	@NotBlank
	@Size( min = 2, max = 50)
	private String contrasenia;
		
	private Rol rol;
	
	private int validado;
	
	private String imagen;
	
	private String fechaAlta;
	private String fechaBaja;

	public Usuario() {
		super();
		this.id = 0;
		this.nombre = "";
		this.contrasenia = "";
		this.rol = new Rol();
		this.validado=0;
		this.imagen = "https://www.instamatico.io/wp-content/uploads/2019/11/Icon-Real-Profiles.png";
		this.fechaAlta = "";
		this.fechaBaja = "";
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

	public String getContrasenia() {
		return contrasenia;
	}

	public void setContrasenia(String contrasenia) {
		
		this.contrasenia = contrasenia;
	}

	public Rol getRol() {
		return rol;
	}

	public void setRol(Rol rol) {
		this.rol = rol;
	}	
	
	public int getValidado() {
		return validado;
	}

	public void setValidado(int validado) {
		this.validado = validado;
	}

	public String getImagen() {
		return imagen;
	}

	public void setImagen(String imagen) {
		this.imagen = imagen;
	}	
	
	public String getFechaAlta() {
		return fechaAlta;
	}

	public void setFechaAlta(String fechaAlta) {
		this.fechaAlta = fechaAlta;
	}

	public String getFechaBaja() {
		return fechaBaja;
	}

	public void setFechaBaja(String fechaBaja) {
		this.fechaBaja = fechaBaja;
	}

	public String encriptarContrasenia(String nombre, String passwd) throws NoSuchAlgorithmException {
		
		String combinacion = nombre+passwd;
		
		MessageDigest md = MessageDigest.getInstance("MD5");
	    md.update(combinacion.getBytes());
	    byte[] digest = md.digest();
	    String resul = DatatypeConverter.printHexBinary(digest).toUpperCase();
		
		return resul;
	}

	@Override
	public String toString() {
		return "Usuario [id=" + id + ", nombre=" + nombre + ", contrasenia=" + contrasenia + ", rol=" + rol
				+ ", validado=" + validado + ", imagen=" + imagen + ", fechaAlta=" + fechaAlta + ", fechaBaja="
				+ fechaBaja + "]";
	}


	
}
