<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>
    		<div class="row">
			<div class="col-12 mt-3">
				<form action="seguridad/productos?accion=listar" method="post" class=" form-inline mb-4">
					<label class="mr-2">Filtro categoria : </label>
					<select name="categoriaId" class="custom-select filtroCategori">
						<option value="0" selected>Ninguna categoria</option>
						<c:forEach items="${categorias}" var="c">
							<option ${c.id eq idcategoria?"selected":"" } value="${c.id}">${c.nombre}</option>
						</c:forEach>
					</select>

					<label class="mx-2">Filtro nombre : </label>
					<div class="form-group">
					<input type="text" name="nombre" value="${nombreProducto}" class="form-control" placeholder="mínimo 2 letras, máximo 50">

					<input type="hidden" nombre="accion" value="listar">
					<input type="submit" value="Buscar" class="btn btn-primary ml-3">
				</form>
			</div>
		</div>

<div class="row">
	<div class="col-12">
		<table  class="table display" style="width: 100%">
	        <thead>
	            <tr>
	                <th>id</th>
	                <th>nombre</th>
	                <th>usuario</th>
	                <th>categoria</th>
	                <th>Editar</th>
	            </tr>
	        </thead>
	        <tbody>
	        	<c:forEach items="${productos}" var="p">
	            	<tr>
	                	<td>${p.id}</td>
	                	<td>${p.nombre }</td>
	                	<td>${p.usuario.nombre}</td>
	                	<td>${p.categoria.nombre}</td>
	                	<td><a href="seguridad/productos?accion=formulario&id=${p.id}">Editar</a></td>
	            	</tr>
	            </c:forEach>
	        </tbody>
	    </table>
    </div>
</div>



<%@ include file="/includes/footer.jsp" %>