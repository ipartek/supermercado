package com.ipartek.formacion.supermercado.controller;

public class Alerta {
	
	
	//TODO resto de tipos: success, warning,...
	public static final String TIPO_PRIMARY = "primary";
	public static final String TIPO_DANGER = "danger";
	
	private String texto;
	private String tipo;
	
	public Alerta() {
		super();
		this.texto = "ERROR inexperado de la aplicación";
		this.tipo = TIPO_DANGER;
	}
	
	

	public Alerta(String tipo, String texto) {
		super();
		this.tipo = tipo;
		this.texto = texto;		
	}



	public String getTexto() {
		return texto;
	}

	public void setTexto(String texto) {
		this.texto = texto;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	@Override
	public String toString() {
		return "Alerta [texto=" + texto + ", tipo=" + tipo + "]";
	}
	

}
