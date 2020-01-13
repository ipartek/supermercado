<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>

	<h1> Categorias </h1>
	
	<div class="row flex-row mt-4 mb-4">
		<div class="col-4">
			<h2> Listado de categorias </h2>
		</div>
		<div class="col-3">
			<a href="seguridad/categorias?accion=formulario" class="btn btn-primary"> Añadir nueva categoria </a>
		</div>
	</div>
	
	<table id="tabla" class="table display" style="width:100%">
        <thead class="thead-dark">
            <tr>
	            <th scope="col">#ID</th>
			    <th scope="col">Nombre</th>
			    <th scope="col"></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${categorias}" var="c">
				<tr>
				    <th scope="row">${c.id}</th>
				    <td>${c.nombre}</td>
				    <td><a href="seguridad/categorias?accion=formulario&id=${c.id}"> Editar </a></td>
			  	</tr>
			</c:forEach>
        </tbody>
        <tfoot>
            <tr>
               	<th scope="col">#ID</th>
			    <th scope="col">Nombre</th>
			    <th scope="col"></th>
            </tr>
        </tfoot>
    </table>

<%@ include file="/includes/footer.jsp"%>