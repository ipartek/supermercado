<%@ page contentType="text/html; charset=UTF-8"%>

<%@ include file="includes/header.jsp"%>

<div class="row">
	<div class="col-lg-12">
	
		<div class="search-wrapper">
			<form>
				<div class="form-group">
					<label for="category-select">Selecciona una categoría</label>
					<select class="form-control" id="category-select">
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
					</select>
				</div>
			</form>
		</div>
		
	</div>
</div>

${categorias}

<div class="row contenedor-productos">

	<c:forEach items="${productos}" var="p">

		<div class="col">

			<!-- producto -->
			<div class="producto">
				<span class="descuento">${p.descuento}%</span> <img
					src="${p.imagen}" alt="imagen de ${p.nombre}">

				<div class="body">
					<p>
						<span class="precio-descuento"> <fmt:formatNumber
								minFractionDigits="2" type="currency" currencySymbol="€"
								value="${p.precio}" />
						</span> <span class="precio-original"> <fmt:formatNumber
								minFractionDigits="2" type="currency" currencySymbol="€"
								value="${p.precioDescuento}" />
						</span>
					</p>
					<p class="text-muted precio-unidad ">${p.nombre}</p>
					<p class="descripcion text-truncate">${p.descripcion}</p>
					<p class="descripcion">${p.categoria.nombre}</p>
					<p class="descripcion">${p.usuario.nombre}</p>
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
		<!-- /.col -->

	</c:forEach>

</div>
<!-- row contenedor-productos -->

<%@ include file="includes/footer.jsp"%>
