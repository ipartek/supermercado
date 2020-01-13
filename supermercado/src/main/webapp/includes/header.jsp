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
  
    <nav class="site-header sticky-top py-1">
		<div class="container d-flex flex-column flex-md-row justify-content-between">
			<a class="py-2" href="inicio"> 
				<i class="fas fa-home fa-2x"></i>
			</a>

			<c:if test="${empty usuarioLogeado }">
				<a class="py-2 d-none d-md-inline-block" href="login.jsp">Login</a>
			</c:if>

			<c:if test="${not empty usuarioLogeado }">
				<div class="dropdown show">
					
					<a class="btn btn-lg dropdown-toggle" href="#" role="button"
						id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"><i class="fas fa-tag fa-sm"></i> Producto </a>

					<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item" href="seguridad/productos?accion=listar"><i class="fas fa-list fa-sm mr-2"></i>Todos</a> 
						<a	class="dropdown-item" href="seguridad/productos?accion=formulario"><i class="far fa-plus-square mr-2"></i>Nuevo</a> 
					</div>
				</div>
				<div class="dropdown show">
					
					<a class="btn btn-lg  dropdown-toggle" href="#" role="button"
						id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"><i class="fas fa-user fa-sm"></i> Usuario </a>

					<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item" href="seguridad/usuarios?accion=listar"><i class="fas fa-list fa-sm mr-2"></i>Todos</a> 
						<a class="dropdown-item" href="seguridad/usuarios?accion=formulario"><i class="far fa-plus-square mr-2"></i>Nuevo</a>
					</div>
				</div>
				
				<div class="dropdown show">
					
					<a class="btn btn-lg  dropdown-toggle" href="#" role="button"
						id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"><i class="fas fa-user fa-sm"></i> Productos Disponibilidad </a>

					<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item" href="seguridad//visualizarAlta?accion=alta"><i class="fas fa-list fa-sm mr-2"></i>Productos en Alta</a> 
						<a class="dropdown-item" href="seguridad/visualizarAlta?accion=baja"><i class="far fa-plus-square mr-2"></i>Productos en Baja</a>
					</div>
				</div>
				<div class="dropdown show">
					
					<a class="btn btn-lg  dropdown-toggle" href="#" role="button"
						id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
						aria-expanded="false"><i class="far fa-sticky-note fa-sm"></i> Categoría </a>

					<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
						<a class="dropdown-item" href="seguridad/categorias?accion=listar"><i class="fas fa-list fa-sm mr-2"></i>Todas</a> 
						<a class="dropdown-item" href="seguridad/categorias?accion=formulario"><i class="far fa-plus-square mr-2"></i>Nuevo</a>
					</div>
				</div>
				
				<a class="py-2 d-none d-md-inline-block" href="logout">Cerrar
					Sesión</a>
				<a href="seguridad/" class="py-2 d-none d-md-inline-block"><i class="fas fa-user fa-sm bg-secondary"></i>${usuarioLogeado.nombre}</a>
			</c:if>
			<c:if test="${pagina == 'inicio' }">
				<form action="inicio" method="post">
				
					<div class="row">
						<div class="col-5">
							<div class="form-group">
							
								<select class="browser-default custom-select" name="categoria">
									<option value="" disabled selected>Selecciona una categoría</option>
									<c:forEach items="${categorias}" var="c">
										<option value="${c.id}">${c.nombre}</option>
									</c:forEach>
									
								</select>
							</div>
						</div>
						<div class="col-4">
							<div class="form-group">
								<input type="text" name="textoBuscado" class="form-control"placeholder="Introduce lo que deseas buscar">				
							</div>
						</div>
						<div class="col-3">
							<input type="submit" class="btn btn-primary btn-block">
						</div>
					</div>
				</form>
			</c:if><!-- Cierre if -->
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
    
    