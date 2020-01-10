<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>   
    	
	<h1>Categoría</h1>
	
	<form action="seguridad/categorias" method="post" class="mb-4">
		<input type="hidden" name="id" value="${categoria.id}">
		<div class="form-group">
			<label>Nombre:</label>
			<input type="text" name="nombre" value="${categoria.nombre}" class="form-control" placeholder="mínimo 2 letras, máximo 50">
		</div>
					
		<div class="form-group">		
			<label>Categorias:</label>
			<select name="usuarioId" class="custom-select">
				<c:forEach items="${categoria}" var="c">
					<option value="${c.id}"  ${(c.id eq categoria.categoria.id)?"selected":""} >${c.nombre}</option>	
				</c:forEach>
			</select>
		</div>
		
		<input type="hidden" name="id" value="${categoria.id}">
		<input type="hidden" name="accion" value="guardar">
		
		<input type="submit" value="${(categoria.id>0)?"Modificar":"Crear" }" class="btn btn-block btn-primary">
	
	</form>
	
	<c:if test="${categoria.id > 0}">
	

		
	
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-outline-danger" data-toggle="modal" data-target="#exampleModal">
			  Eliminar
			</button>
			
			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">Eliminar categoría</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			       ¿Estás seguro de eliminar la categoría ${c.nombre}?
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			        <a class="btn btn-danger" href="seguridad/categorias?id=${categoria.id}&accion=eliminar">Eliminar</a>
			      </div>
			    </div>
			  </div>
			</div>


	</c:if>
	

<%@ include file="/includes/footer.jsp" %> 