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

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		  <a class="navbar-brand" href="inicio">Inicio</a>
		  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		  </button>

		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		    <ul class="navbar-nav mr-auto ">
		      <li class="nav-item d-none">
		        <a class="nav-link " href="#">Link</a>
		      </li>
		      <c:if test="${usuarioLogeado.rol.id eq 2 }" >
			      <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          Productos
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          <a class="dropdown-item" href="seguridad/productos?accion=listar">Listar</a>
			          <a class="dropdown-item" href="seguridad/productos?accion=formulario">Crear</a>
			        </div>
			      </li>
			      <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          Categorias
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          <a class="dropdown-item" href="seguridad/categorias?accion=listar">Listar</a>
			          <a class="dropdown-item" href="seguridad/categorias?accion=formulario">Crear</a>
			        </div>
			      </li>
			      <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          Usuarios
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          <a class="dropdown-item" href="seguridad/usuarios?accion=listar">Listar</a>
			          <a class="dropdown-item" href="seguridad/usuarios?accion=formulario">Crear</a>
			        </div>
			      </li>
		      </c:if>
		      <c:if test="${usuarioLogeado.rol.id eq 1 }" >
	            	<li class="nav-item ">
	            		<a class="nav-link" href="mipanel/productos?accion=listar">Mis Producto</a>
	            	</li>
	            	<li class="nav-item ">
	            		<a class="nav-link" href="mipanel/productos?accion=formulario">Crear Nuevo</a>
	            	</li>

	          </c:if>
		      <c:if test="${empty usuarioLogeado }" >
			      <li class="nav-item ml-auto">
	            	<a class="nav-link " href="login.jsp">Login</a>
			      </li>
	          </c:if>
			  <c:if test="${not empty usuarioLogeado }" >
				<li class="nav-item ml-auto">
	            	<a class="nav-link" href="logout">Cerrar Sessión</a>
	            </li>
	          </c:if>
		    </ul>
		  </div>
		</nav>



    <nav class="site-header sticky-top py-1 d-none">
        <div class="container d-flex flex-column flex-md-row justify-content-between">
            <a class="py-2" href="inicio">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="d-block mx-auto" role="img" viewBox="0 0 24 24" focusable="false"><title>Product</title><circle cx="12" cy="12" r="10"/><path d="M14.31 8l5.74 9.94M9.69 8h11.48M7.38 12l5.74-9.94M9.69 16L3.95 6.06M14.31 16H2.83m13.79-4l-5.74 9.94"/></svg>
            </a>

            <c:if test="${empty usuarioLogeado }" >
            	<a class="py-2 d-none d-md-inline-block" href="login.jsp">Login</a>
            </c:if>

            <c:if test="${usuarioLogeado.rol.id eq 2 }" >
            	<a class="py-2 d-none d-md-inline-block" href="seguridad/productos?accion=listar">Tabla</a>
            	<a class="py-2 d-none d-md-inline-block" href="seguridad/productos?accion=formulario">Formulario</a>
            </c:if>

            <c:if test="${usuarioLogeado.rol.id eq 1 }" >
            	<a class="py-2 d-none d-md-inline-block" href="mipanel/productos?accion=listar">Mis Producto</a>
            	<a class="py-2 d-none d-md-inline-block" href="mipanel/productos?accion=formulario">Crear Nuevo</a>
            </c:if>

            <c:if test="${not empty usuarioLogeado }" >
            	<a class="py-2 d-none d-md-inline-block" href="logout">Cerrar Sessión</a>
            </c:if>

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

