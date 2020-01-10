package com.ipartek.formacion.supermercado.modelo.pojo;

import javax.validation.constraints.Size;

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

	public Usuario() {
		super();
		this.id = 0;
		this.nombre = "";
		this.contrasenia = "";
		this.rol = new Rol();
		this.validado=0;
		this.imagen = "https://www.instamatico.io/wp-content/uploads/2019/11/Icon-Real-Profiles.png";
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

	@Override
	public String toString() {
		return "Usuario [id=" + id + ", nombre=" + nombre + ", contrasenia=" + contrasenia + ", rol=" + rol
				+ ", validado=" + validado + ", imagen=" + imagen + "]";
	}


	
}
