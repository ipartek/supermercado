<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="/includes/header.jsp"%>

<h1>FORMULARIO</h1>

<form action="seguridad/productos" method="post" class="mb-4">

	<div class="form-group">
		<label>Nombre:</label> <input type="text" name="nombre"
			value="${producto.nombre}" class="form-control"
			placeholder="mínimo 2 letras, máximo 50">
	</div>

	<div class="form-group">
		<label>Precio:</label>
		<div class="input-group ">

			<input type="text" name="precio" value="${producto.precio}"
				class="form-control" placeholder="Precio en €"
				aria-describedby="basic-addon2">
			<div class="input-group-append">
				<span class="input-group-text" id="basic-addon2">€</span>
			</div>
		</div>
	</div>

	<div class="form-group">
		<label>Imagen:</label> <input type="text" name="imagen"
			value="${producto.imagen}" placeholder="Enlace de la imagen"
			class="form-control">
	</div>

	<div class="form-group">
		<label>Descuento:</label> <input type="number" min="0" max="100"
			name="descuento" value="${producto.descuento}"
			placeholder="Descuento del producto (0-100)" class="form-control">
	</div>

	<div class="form-group">
		<label>Descripción:</label>
		<textarea name="descripcion" value="${producto.descripcion}"
			placeholder="Descripción del producto" class="form-control"></textarea>
	</div>

	<div class="form-group">
		<label>Usuario</label> <select name="usuarioId" class="custom-select">
			<c:forEach items="${usuarios}" var="u">
				<option value="${u.id}"
					${(u.id eq producto.usuario.id)?"selected":""}>${u.nombre}</option>
			</c:forEach>
		</select>
	</div>
	
	<div class="form-group">
		<label>Categoría</label>
		<select name="categoriaId" class="custom-select">
			<c:forEach items="${categorias}" var="c">
				<option value="${c.id}">${c.nombre}</option>
			</c:forEach>
		</select>
	</div>

	<input type="hidden" name="id" value="${producto.id}"> <input
		type="hidden" name="accion" value="guardar"> <input
		type="submit" value="${(producto.id>0)?"
		Modificar":"Crear" }" class="btn btn-block btn-primary">

</form>

<c:if test="${producto.id > 0}">




	<!-- Button trigger modal -->
	<button type="button" class="btn btn-outline-danger"
		data-toggle="modal" data-target="#exampleModal">Eliminar</button>

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">¿Estás seguro?</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">Se va a eliminar el producto
					${producto.nombre}.</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<a class="btn btn-danger"
						href="seguridad/productos?id=${producto.id}&accion=eliminar">Eliminar</a>
				</div>
			</div>
		</div>
	</div>


</c:if>


<%@ include file="/includes/footer.jsp"%>
