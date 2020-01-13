<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="includes/header.jsp"%>

<div class="row">
	<div class="col-md-3"></div>
	<div class="col-md-6">
		<form action="inicio" method="post" class="mb-5">

<%-- ${(c.id eq producto.categoria.id)?"selected":""} --%>

			<div class="form-group">
				<label>Filtrar por Categoria:</label> <select name="categoriaIdFiltro"
					class="custom-select mb-2">
					<option selected="selected" value="0">Seleccionar</option>
					<c:forEach items="${categorias}" var="c">
						<option value="${c.id}">${c.nombre}</option>
					</c:forEach>
				</select> <label>Filtrar por Nombre:</label> <input type="text" name="nombreFiltro"
					value="${producto.nombre}" class="form-control"
					placeholder="introduce el nombre del producto">
			</div>

			<input type="submit" value="Buscar" class="btn btn-block btn-dark">

		</form>
	</div>

</div>

<hr>

<div class="row contenedor-productos">
	<c:forEach items="${productos}" var="p">
		<div class="col mb-4">
			<!-- producto -->
			<div class="producto">
				<c:if test="${p.descuento!=0}">
					<span class="descuento">${p.descuento}%</span>
				</c:if>
				<img class="" src="${p.imagen}" alt="imagen de ${p.nombre}">

				<div class="body">
					<p>
						<c:if test="${p.descuento!=0}">
							<span class="precio-descuento"><fmt:formatNumber
									type="currency" currencySymbol="€" value="${p.precio}" />
						</c:if>
						</span> <span class="precio-original"><fmt:formatNumber
								type="currency" currencySymbol="€"
								value="${p.getPrecioDescuento()}" /></span>
					</p>
					<p class="precio-unidad">${p.nombre}</p>
					<p class="text-muted descripcion text-truncate">${p.descripcion}</p>
					<p class="text-muted descripcion text-truncate">Categoria:
						${p.categoria.nombre}</p>
					<p class="text-muted descripcion text-truncate">Usuario:
						${p.usuario.nombre}</p>
				</div>

				<div class="botones">
					<button class="minus">-</button>
					<input type="text" value="1">
					<button class="plus">+</button>
				</div>

				<button class="carro">añadir al carro</button>

			</div>
			<!-- /.producto -->

		</div>
	</c:forEach>
</div>

<%@include file="/includes/footer.jsp"%>

