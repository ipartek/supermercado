<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>   
    	
	<h1> Formulario de alta de un producto </h1>
	
	  <div class="row justify-content-center mb-5">
            <div class="col-6">

                    <form action="mipanel/productos" method="post">
                    
                 		<input type="hidden" name="accion" value="guardar">
                 		<input type="hidden" id="id" name="id" value="${producto.id}">

                        <div class="form-group">
                            <label for="nombre">Producto</label>
                            <input type="text" 
                                   class="form-control"
                                   name="nombre"
                                   id="nombre" 
                                   value="${producto.nombre}"
                                   placeholder="Mínimo 2 Máximo 150"
                                   aria-describedby="nombreHelp">
                            <small id="nombreHelp" class="form-text text-muted">Nombre del producto</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="descripcion">Descripcion</label>
                            <input type="text" 
                                   class="form-control"
                                   name="descripcion"
                                   id="descripcion" 
                                   value="${producto.descripcion}"     
                                   placeholder="Mínimo 2 Máximo 150"
                                   aria-describedby="nombreHelp">
                            <small id="nombreHelp" class="form-text text-muted">Descripcion del producto</small>
                        </div>

                        
                        <div class="form-group">
                             <label for="precio">Precio</label>
                             <input type="number" 
                                    class="form-control" 
                                    id="precio" 
                                    name="precio"
                                    value="${producto.precio}"
                                    placeholder="0,00€"
                                    step=".01"
                                    aria-describedby="precioHelp">
                             <small id="precioHelp" class="form-text text-muted">Precio en euros sin Iva, ni descuento</small>
                         </div>
                         
                         <div class="form-group">
                             <label for="descuento">Descuento</label>
                             <input type="number" 
                                    class="form-control" 
                                    id="descuento" 
                                    name="descuento"
                                    value="${producto.descuento}"
                                    placeholder="0"
                                    aria-describedby="precioHelp">
                             <small id="precioHelp" class="form-text text-muted">Descuento del producto</small>
                         </div>
                         
                         <div class="form-group">
                            <label for="imagen">Imagen del producto</label>
                            <input type="url" 
                                   class="form-control"
                                   name="imagen"
                                   id="imagen" 
                                   value="${producto.imagen}"
                                   placeholder="URL (.JPG, .JPEG, .PNG)"
                                   aria-describedby="nombreHelp">
                            <small id="nombreHelp" class="form-text text-muted">Imagen del producto</small>
                        </div>
                        
                        <div class="form-group">		
							<label>Categoria</label>
							<select name="categoriaId" class="custom-select">
								<c:forEach items="${categorias}" var="c">
									<option value="${c.id}"  ${(c.id eq producto.categoria.id)?"selected":""} >${c.nombre}</option>	
								</c:forEach>
							</select>
						</div>
                        
                        <c:choose>
                        	<c:when test="${producto.id > 0}">
                        		<button type="submit" class="btn btn-block btn-primary">Modificar producto</button> 
                        		<button type="button" class="btn btn-block btn-danger" data-toggle="modal" data-target="#modalEliminar"> Eliminar producto </button>	            		
                        	</c:when>
                        	<c:otherwise>
                        		<button type="submit" class="btn btn-block btn-outline-primary">Crear producto</button> 
                        	</c:otherwise>
                        </c:choose>
  
                    </form>

            </div>
        </div>  
        <div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Eliminar producto</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        ¿Estas seguro de que deseas eliminar este producto?
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
		        <a href="mipanel/productos?accion=eliminar&id=${producto.id}" class="btn btn-primary">Eliminar</a>
		      </div>
		    </div>
		  </div>
		</div>
	

<%@ include file="/includes/footer.jsp" %> 