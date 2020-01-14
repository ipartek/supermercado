<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="includes/header.jsp" %>   
    	
		<div class="row">
			<div class="col-12 mt-3">
				<form action="inicio" method="post" class=" form-inline mb-4">
					<label class="mr-2">Filtro categoria : </label>
					<select name="categoriaId" class="custom-select filtroCategori">
						<option value="0" selected>Ninguna categoria</option>
						<c:forEach items="${categorias}" var="c">
						    <!-- ${(c.id eq producto.usuario.id)?"selected":""} -->
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
        <div class="row contenedor-productos">
        
        	<c:forEach items="${productos}" var="p">

	            <div class="col">
	
	                <!-- producto -->
	                <div class="producto">
	                    <span class="descuento">${p.descuento}%</span>
	                    <img src="${p.imagen}" alt="imagen de ${p.nombre}">
	
	                    <div class="body">
	                        <p>
	                            <span class="precio-descuento">	                            	
	                            	<fmt:formatNumber minFractionDigits="2" type="currency" currencySymbol="€" value="${p.precio}" />	                            
	                            </span>
	                            <span class="precio-original">
	                            	<fmt:formatNumber minFractionDigits="2" type="currency" currencySymbol="€" value="${p.precioDescuento}" />
	                            </span>
	                        </p>
	                        <p class="text-muted precio-unidad ">${p.nombre}</p>
	                        <p class="descripcion text-truncate">${p.descripcion}</p>
	                        <p class="descripcion text-truncate">Usuario : ${p.usuario.nombre}</p>
	                        <p class="descripcion text-truncate">Categoria : ${p.categoria.nombre}</p>
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

<%@ include file="includes/footer.jsp" %> 