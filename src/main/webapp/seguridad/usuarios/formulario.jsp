<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="/includes/header.jsp" %>

<h1> Formulario usuario</h1>
	
	  <div class="row justify-content-center mb-5">
            <div class="col-6">

                    <form action="seguridad/usuarios" method="post">
                    
                 		<input type="hidden" name="accion" value="guardar">
                 		<input type="hidden" id="id" name="id" value="${usuario.id}">

                        <div class="form-group">
                            <label for="nombre">Nombre</label>
                            <input type="text" 
                                   class="form-control"
                                   name="nombre"
                                   id="nombre" 
                                   value="${usuario.nombre}"
                                   placeholder="Mínimo 2 Máximo 150"
                                   aria-describedby="nombreHelp">
                            <small id="nombreHelp" class="form-text text-muted">Nombre del producto</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="descripcion">Contraseña</label>
                            <input type="text" 
                                   class="form-control"
                                   name="password"
                                   id="password" 
                                   value="${usuario.contrasenia}"     
                                   placeholder="Mínimo 2 Máximo 150"
                                   aria-describedby="nombreHelp">
                            <small id="nombreHelp" class="form-text text-muted">Contraseña del usuario</small>
                        </div>
                        
                        <div class="form-group">
                            <label for="imagen"> Avatar</label>
                            <input type="url" 
                                   class="form-control"
                                   name="imagen"
                                   id="imagen" 
                                   value="${usuario.imagen}"
                                   placeholder="URL (.JPG, .JPEG, .PNG)"
                                   aria-describedby="nombreHelp">
                            <small id="nombreHelp" class="form-text text-muted">Avatar de usuario</small>
                        </div>
                        
                         <div class="form-group">		
							<label>Rol</label>
							<select name="rolId" class="custom-select">
								<option value="2"  ${(2 eq usuario.rol.id)?"selected":""} >ADMIN</option>
								<option value="1"  ${(1 eq usuario.rol.id)?"selected":""} >USUARIO</option>
							</select>
						</div>
						
						<div class="form-group">		
							<label>Validado</label>
							<select name="validadoId" class="custom-select">
								<option value="0"  ${(usuario.validado eq 0)?"selected":""} >NO</option>
								<option value="1"  ${(usuario.validado eq 1)?"selected":""} >SI</option>
							</select>
						</div>
                        
                        <c:choose>
                        	<c:when test="${usuario.id > 0}">
                        		<button type="submit" class="btn btn-block btn-primary">Modificar usuario</button> 
                        		<button type="button" class="btn btn-block btn-danger" data-toggle="modal" data-target="#modalEliminar"> Eliminar usuario </button>	            		
                        	</c:when>
                        	<c:otherwise>
                        		<button type="submit" class="btn btn-block btn-outline-primary">Crear usuario</button> 
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
		        <a href="seguridad/usuarios?accion=eliminar&id=${usuario.id}" class="btn btn-primary">Eliminar</a>
		      </div>
		    </div>
		  </div>
		</div>

<%@ include file="/includes/footer.jsp"%>