<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:setLocale value="es_ES"/>

<%@ page contentType="text/html; charset=UTF-8" %>


<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Ander Uraga">
    <title>Supermercado</title>
    
   <base href="${pageContext.request.contextPath}/" >

   <!-- Bootstrap core CSS -->
   <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">

	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css" rel="stylesheet">

	<!-- datatables -->
	<link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"  rel="stylesheet">

   <!-- nuestro css -->
   <link rel="stylesheet" href="css/custom.css">

  </head>
  <body id="top">
	  
   <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="inicio"><i class="fas fa-store-alt"></i></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		  <span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNavDropdown">
		  <ul class="navbar-nav">
		    <li class="nav-item active">
		      <a class="nav-link" href="inicio">Home </a>
		    </li>
		    
		    <c:if test="${not empty usuarioLogeado}">
		    
		    	<c:if test="${usuarioLogeado.rol.id eq 2}">
		    	
		    		<li class="nav-item dropdown active">
				      <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				        Productos
				      </a>
				      <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				        <a class="dropdown-item" href="seguridad/productos?accion=listar">Listado productos activos</a>
				        <a class="dropdown-item" href="seguridad/productos?accion=listar_inactivos">Listado productos inactivos</a>
				        <a class="dropdown-item" href="seguridad/productos?accion=listar_baja">Listado productos baja</a>
				        <a class="dropdown-item" href="seguridad/productos?accion=formulario">Nuevo producto</a>
				      </div>
				    </li>
				    <li class="nav-item dropdown active">
				      <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				        Usuarios
				      </a>
				      <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				        <a class="dropdown-item" href="seguridad/usuarios?accion=listar_activos">Listado usuarios activos</a>
				        <a class="dropdown-item" href="seguridad/usuarios?accion=listar_sinvalidar">Listado usuarios sin validar</a>
				        <a class="dropdown-item" href="seguridad/usuarios?accion=listar_baja">Listado usuarios baja</a>
				        <a class="dropdown-item" href="seguridad/usuarios?accion=formulario">Nuevo usuario</a>
				      </div>
		    		</li>
		    		<li class="nav-item dropdown active">
				      <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				        Categorias
				      </a>
				      <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				        <a class="dropdown-item" href="seguridad/categorias?accion=listar">Listado categorias</a>
				        <a class="dropdown-item" href="seguridad/categorias?accion=formulario">Nueva categoria</a>
				      </div>
		    		</li>
		        
		   		</c:if> 
		    	
	    		<c:if test="${usuarioLogeado.rol.id eq 1}">
	    	
		    		<li class="nav-item dropdown active">
				      <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				        Mis Productos
				      </a>
				      <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
				        <a class="dropdown-item" href="mipanel/productos?accion=listar">Mis productos</a>
				        <a class="dropdown-item" href="mipanel/productos?accion=formulario">Nuevo producto</a>
				      </div>
					</li>
	        
	   			</c:if> 
		        
		    </c:if> 
		  
		  <c:if test="${empty usuarioLogeado}">
		  
			 <li class="nav-item active ml-2">
			    <a class="nav-link" href="registro"> Registrase </a>
		    </li>
		  	 <li class="nav-item ml-2">
			    <a class="btn btn-outline-primary my-2 my-sm-0" href="login.jsp"><i class="fas fa-user mr-1"></i> Login</a>
		    </li>
		  
		  </c:if>
		  
		  <c:if test="${not empty usuarioLogeado}">
		  
		  	<c:if test="${usuarioLogeado.rol.id eq 2}">
		  	
			  	<li class="nav-item dropdown ml-2">
			      <a class="btn btn-outline-primary my-2 my-sm-0 dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          <i class="fas fa-user mr-1"></i> ${usuarioLogeado.nombre}
			      </a>
			      <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
			        <a class="dropdown-item" href="seguridad/usuarios?accion=formulario&id=${usuarioLogeado.id}">Perfil</a>
			        <div class="dropdown-divider"></div>
	          		<a class="dropdown-item" href="logout">Cerrar sesion</a>
			      </div>
			    </li>
		  	
		  	</c:if>
		  	
		  	<c:if test="${usuarioLogeado.rol.id eq 1}">
		  	
			  	<li class="nav-item dropdown ml-2">
			      <a class="btn btn-outline-primary my-2 my-sm-0 dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			        <i class="fas fa-user mr-1"></i> ${usuarioLogeado.nombre}
			      </a>
			      <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
			        <a class="dropdown-item" href="mipanel/usuarios?accion=formulario&id=${usuarioLogeado.id}">Perfil</a>
			        <div class="dropdown-divider"></div>
	          		<a class="dropdown-item" href="logout">Cerrar sesion</a>
			      </div>
			    </li>
		  	
		  	</c:if>
		  
		  </c:if>
		  
		  </ul>
		</div>
	</nav>

    <main class="container">
    
   
	    <c:if test="${not empty mensajeAlerta }">
	    
		    <div class="alert alert-${mensajeAlerta.tipo} alert-dismissible fade show mt-3" role="alert">
			  ${mensajeAlerta.texto}
			  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
			    <span aria-hidden="true">&times;</span>
			  </button>
			</div>
		
		</c:if>
    
    