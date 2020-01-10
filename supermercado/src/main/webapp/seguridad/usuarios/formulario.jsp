<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>   
    	
	<h1>Usuarios</h1>
	
	<form action="seguridad/usuarios" method="post" class="mb-4">
		<input type="hidden" name="id" value="${usuario.id}">
				
		<div class="form-group">
			<label>Nombre de usuario :</label>
			<input type="text" name="nombre" value="${usuario.nombre}" class="form-control" placeholder="mínimo 2 letras, máximo 50">
		</div>
		
		<div class="form-group">				
			<label>Contraseña:</label>
			<input type="password" name="contrasenia" value="${usuario.contrasenia}" class="form-control" placeholder="Introduce una contraseña segura">
		</div>
		
		<div class="form-group">		
			<label>Usuario</label>
			<select name="usuarioId" class="custom-select">
				<c:forEach items="${usuarios}" var="u">
					<option value="${u.id}"  ${(u.id eq producto.usuario.id)?"selected":""} >${u.nombre}</option>	
				</c:forEach>
			</select>
		</div>
		
		<input type="hidden" name="id" value="${usuario.id}">
		<input type="hidden" name="accion" value="guardar">
		
		<input type="submit" value="${(usuario.id>0)?"Modificar":"Crear" }" class="btn btn-block btn-primary">
	
	</form>
	
	<c:if test="${usuario.id > 0}">
	
			<!-- Button trigger modal -->
			<button type="button" class="btn btn-outline-danger" data-toggle="modal" data-target="#exampleModal">
			  Eliminar
			</button>
			
			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">Eliminar usuario</h5>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			        ¿Estas seguro de eliminar el usuario ${usuario.nombre}?
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
			        <a class="btn btn-danger" href="seguridad/usuarios?id=${usuario.id}&accion=eliminar">Eliminar</a>
			      </div>
			    </div>
			  </div>
			</div>


	</c:if>
	

<%@ include file="/includes/footer.jsp" %>  