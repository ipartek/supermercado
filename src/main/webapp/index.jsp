<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="includes/header.jsp"%>

		<form action="inicio" method="post" class="mb-5 form-inline">
			<div class="form-group">
				<select name="categoriaIdFiltro"
					class="custom-select mr-2">
					<option value="0">Todas las categorias</option>
					<c:forEach items="${categorias}" var="c">
						<option value="${c.id}" ${(c.id eq categoriaId)?"selected":""}>${c.nombre}</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<input type="text" name="nombreFiltro"
					value="${producto.nombre}" class="form-control mr-2"
					placeholder="Nombre">
			</div>

			<input type="submit" value="Buscar" class="btn btn-dark">

		</form>

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

