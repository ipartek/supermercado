<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>

	<h1> Formulario </h1>
	
	  <div class="row justify-content-center mb-5">
            <div class="col-6">

                    <form action="seguridad/categorias" method="post">
                    
                 		<input type="hidden" name="accion" value="guardar">
                 		<input type="hidden" id="id" name="id" value="${categoria.id}">

                        <div class="form-group">
                            <label for="nombre">Categoria</label>
                            <input type="text" 
                                   class="form-control"
                                   name="nombre"
                                   id="nombre" 
                                   value="${categoria.nombre}"
                                   placeholder="Mínimo 2 Máximo 150"
                                   aria-describedby="nombreHelp">
                            <small id="nombreHelp" class="form-text text-muted">Nombre del categoria</small>
                        </div>
                        
                        <c:choose>
                        	<c:when test="${categoria.id > 0}">
                        		<button type="submit" class="btn btn-block btn-primary">Modificar categoria</button> 
                        		<button type="button" class="btn btn-block btn-danger" data-toggle="modal" data-target="#modalEliminar"> Eliminar categoria </button>	            		
                        	</c:when>
                        	<c:otherwise>
                        		<button type="submit" class="btn btn-block btn-outline-primary">Crear categoria</button> 
                        	</c:otherwise>
                        </c:choose>
  
                    </form>

            </div>
        </div>  
        <div class="modal fade" id="modalEliminar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="exampleModalLabel">Eliminar categoria</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		        ¿Estas seguro de que deseas eliminar esta categoria?
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
		        <a href="seguridad/categorias?accion=eliminar&id=${categoria.id}" class="btn btn-primary">Eliminar</a>
		      </div>
		    </div>
		  </div>
		</div>

<%@ include file="/includes/footer.jsp"%>