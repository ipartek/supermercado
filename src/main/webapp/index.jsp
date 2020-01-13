<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="includes/header.jsp" %>   

		<div class="row container-barra-busqueda"> 	
		
			<form class="col d-flex flex-row" action="inicio?accion=buscar" method="post">
	
					<div class="form-group d-flex flex-row select-busqueda">		
						<select name="categoriaId" class="custom-select">
							<option value="0"> Seleccione una categoria </option>
							<c:forEach items="${categorias}" var="c">
								<option value="${c.id}">${c.nombre}</option>	
							</c:forEach>
						</select>
					</div>
                       
                    <div class="container">
					<div class="input-group">
						<input type="text" 
							   class="form-control" 
							   name="producto"
                               id="producto" 
                               value=""
							   placeholder="Buscar por..."
							   aria-describedby="productoHelp">
					      <span class="input-group-btn">
					        <button class="btn btn-search" type="submit"><i class="fa fa-search fa-fw"></i> Buscar </button>
					      </span>
					</div>
					</div>
					
			</form>
	
		</div>

        <div class="row contenedor-productos">
        
        	<c:forEach items="${productos}" var="producto">
        
        	<div class="col mb-4">

                <!-- Inicio de producto -->
                <div class="producto">
                    <span class="descuento">${producto.descuento}</span>
                    <img src="${producto.imagen}" alt="imagen de ${producto.nombre}">

                    <div class="body">
                        <p>
                            <span class="precio-descuento">	                            	
	                            <fmt:formatNumber minFractionDigits="2" type="currency" currencySymbol="€" value="${producto.precio}" />	                            
	                        </span>
                            <span class="precio-original">
                            	<fmt:formatNumber minFractionDigits="2" type="currency" currencySymbol="€" value="${producto.precioDescuento}" />
                            </span>
                        </p>
                        <p class="text-muted precio-unidad">(<fmt:formatNumber minFractionDigits="2" type="currency" value="${producto.precio}" /> / litro)</p>
                        <p class="nombre">${producto.nombre}</p>
                        <p class="descripcion text-truncate">${producto.descripcion}</p>
                        <p class="nombre text-truncate">Creado por: ${producto.usuario.nombre}</p>
                        <p class="descripcion text-truncate">${producto.categoria.nombre}</p>
                    </div>

                    <div class="botones">
                        <button class="minus">-</button>
                        <input type="text" value="1">
                        <button class="plus">+</button>
                    </div>

                    <button class="carro">Anadir al carro</button>

               </div> <!-- Fin de producto -->

            </div>  <!-- Fin de col de producto -->     
        	
        </c:forEach>
        
        </div> <!-- Fin del contenedor-productos -->

<%@ include file="includes/footer.jsp" %> 