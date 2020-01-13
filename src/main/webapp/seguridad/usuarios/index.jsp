<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>

	<h1> Usuarios </h1>
	
	<div class="row flex-row mt-4 mb-4">
		<div class="col-4">
			<h2> Listado de usuarios </h2>
		</div>
		<div class="col-3">
			<a href="seguridad/usuarios?accion=formulario" class="btn btn-primary"> Añadir nuevo usuario </a>
		</div>
	</div>
	
	<table id="tabla" class="table display" style="width:100%">
        <thead class="thead-dark">
            <tr>
	            <th scope="col">#ID</th>
			    <th scope="col">Nombre</th>
			    <th scope="col">Contraseña</th>
			    <th scope="col"></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${usuarios}" var="u">
				<tr>
				    <th scope="row">${u.id}</th>
				    <td>${u.nombre}</td>
				    <td>${u.contrasenia}</td>
				    <td><a href="seguridad/usuarios?accion=formulario&id=${u.id}"> Editar </a></td>
			  	</tr>
			</c:forEach>
        </tbody>
        <tfoot>
            <tr>
                <th scope="col">#ID</th>
			    <th scope="col">Nombre</th>
			    <th scope="col">Contraseña</th>
			    <th scope="col"></th>
            </tr>
        </tfoot>
    </table>

<%@ include file="/includes/footer.jsp"%>